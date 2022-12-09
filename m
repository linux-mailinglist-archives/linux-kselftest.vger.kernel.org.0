Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A68647BA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Dec 2022 02:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLIBxb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 20:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLIBxa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 20:53:30 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995CD941A4
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 17:53:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Jones <andrew.jones@linux.dev>,
        Ricardo Koller <ricarkol@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] KVM: selftests: Fix build due to ucall_uninit() removal
Date:   Fri,  9 Dec 2022 01:53:00 +0000
Message-Id: <20221209015307.1781352-2-oliver.upton@linux.dev>
In-Reply-To: <20221209015307.1781352-1-oliver.upton@linux.dev>
References: <20221209015307.1781352-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

Today's -next fails to build on arm64 due to:

In file included from include/kvm_util.h:11,
                 from aarch64/page_fault_test.c:15:
include/ucall_common.h:36:47: note: expected ‘vm_paddr_t’ {aka ‘long unsigned int’} but argument is of type ‘void *’
   36 | void ucall_init(struct kvm_vm *vm, vm_paddr_t mmio_gpa);
      |                                    ~~~~~~~~~~~^~~~~~~~
aarch64/page_fault_test.c:725:2: warning: implicit declaration of function ‘ucall_uninit’; did you mean ‘ucall_init’? [-Wimplicit-function-declaration]
  725 |  ucall_uninit(vm);
      |  ^~~~~~~~~~~~
      |  ucall_init

which is caused by commit

interacting poorly with commit

   28a65567acb5 ("KVM: selftests: Drop now-unnecessary ucall_uninit()")

As is done for other ucall_uninit() users remove the call in the newly added
page_fault_test.c.

Fixes: 28a65567acb5 ("KVM: selftests: Drop now-unnecessary ucall_uninit()")
Fixes: 35c581015712 ("KVM: selftests: aarch64: Add aarch64/page_fault_test")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Ricardo Koller <ricarkol@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/page_fault_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/aarch64/page_fault_test.c b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
index 0cda70bef5d5..92d3a91153b6 100644
--- a/tools/testing/selftests/kvm/aarch64/page_fault_test.c
+++ b/tools/testing/selftests/kvm/aarch64/page_fault_test.c
@@ -722,7 +722,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	vcpu_run_loop(vm, vcpu, test);
 
-	ucall_uninit(vm);
 	kvm_vm_free(vm);
 	free_uffd(test, pt_uffd, data_uffd);
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

