Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2FE64636B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 22:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLGVsf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 16:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLGVsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 16:48:30 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BF770621;
        Wed,  7 Dec 2022 13:48:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670449708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MEqt5cwx0S15sf2YghjqjZFjTELYz7+UvtRN6GGMw7I=;
        b=cQONTD5LZyqBsrtyfAIp6nhc/p6dWCYdUqkUQwQscaRAqQtFUeKmqYCwMi5pNhGkO185OJ
        z7W0qhvRCaBG3DpfD+7TImes/kV6AH/VeDa0FniNFFhBY1IllL9mFb4rei5w+klHTmRdH+
        OxJ5Rrx1dJtNznZVukhm+TFkPPxdLFw=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Ricardo Koller <ricarkol@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] KVM: selftests: Setup ucall after loading program into guest memory
Date:   Wed,  7 Dec 2022 21:48:06 +0000
Message-Id: <20221207214809.489070-3-oliver.upton@linux.dev>
In-Reply-To: <20221207214809.489070-1-oliver.upton@linux.dev>
References: <20221207214809.489070-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new ucall infrastructure needs to update a couple of guest globals
to pass through the ucall MMIO addr and pool of ucall structs. A
precondition of this actually working is to have the program image
already loaded into guest memory.

Call ucall_init() after kvm_vm_elf_load(). Continue to park the ucall
MMIO addr after MEM_REGION_TEST_DATA.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/page_fault_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 92d3a91153b6..95d22cfb7b41 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -609,8 +609,13 @@ static void setup_memslots(struct kvm_vm *vm, struct test_params *p)
 				    data_size / guest_page_size,
 				    p->test_desc->data_memslot_flags);
 	vm->memslots[MEM_REGION_TEST_DATA] = TEST_DATA_MEMSLOT;
+}
+
+static void setup_ucall(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region = vm_get_mem_region(vm, MEM_REGION_TEST_DATA);
 
-	ucall_init(vm, data_gpa + data_size);
+	ucall_init(vm, region->region.guest_phys_addr + region->region.memory_size);
 }
 
 static void setup_default_handlers(struct test_desc *test)
@@ -702,6 +707,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vm = ____vm_create(mode);
 	setup_memslots(vm, p);
 	kvm_vm_elf_load(vm, program_invocation_name);
+	setup_ucall(vm);
 	vcpu = vm_vcpu_add(vm, 0, guest_code);
 
 	setup_gva_maps(vm);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

