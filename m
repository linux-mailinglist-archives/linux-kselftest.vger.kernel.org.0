Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C95A70A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiH3WVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiH3WVK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:21:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B0658B79
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x6-20020a170902ec8600b001754410b6d0so44711plg.10
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=4AF1UYLjwIVXmrQJvzJrIG8LzqFDnrR9FyDZEzZ+cxA=;
        b=BLGMtymfosqoL+BOv1LwQs5tr4NSlaP/SpxDqt3yNRrcO6o4JXX+XCPHk2vXRbtGA+
         sMpkWToV2Anu6hegtbXOwvigD8G9kJSB0KajxojvM+GhZDD/5INbIw8CJobpfr+2cDKe
         +eXhnrrUzrFIsAfYEAHjATunPBBR9lHbGOUe/lmcLCoP+U8QRAxD77rtkBrTXA8UhVnl
         PkI2bPurJZ36XQdElpU130uGvHicr76h4lVL/z+JjQupAG7njNahc89+zt5Gq8Ovx/kF
         EE69PgkbCgl6MCCJWFJM1wewVd4IJqa4H31cm2SXygjTyYZGeZd+ttIZJFymsyQGYwoI
         trJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=4AF1UYLjwIVXmrQJvzJrIG8LzqFDnrR9FyDZEzZ+cxA=;
        b=skmegRul3+eyavVGfHAoXTMk6GiHuO4wZD4Wb3oO476dfkHpMk2bauayXFSQ73s1q6
         +AMvIBXgHSy+WN99NWXfGrNT5wR0HusaiDBqNtV6hxbNPWhnynUmrx/v//OMIjE6Mnqj
         gs/Af1MvaqP9ZZUFDIvhQt/WpsBYKoH+o7lWjRAA20/uUs9bYNYxCvjQS5sc45TBna/j
         HyU5l049wU69y6fEGI/RtaQKpNPwcbrv/LWViEN5vD+7m7ofrbdbFW2v981+/QeQGb+8
         wqJo49AOGSZiiEMtSLrdJEXaaqz7/ycqpLzMvcNL9hyTcFSDqxWQjZFPZGhTzJ0GGFz5
         sjEg==
X-Gm-Message-State: ACgBeo3mlnhS2tL31Lt7lpUvSxGtIeQjI28Ep8MLU8GfXn3fZ3WcCcpN
        XywXGo5ivXukWhAXHC6rGbFyoqfJOFds39TuK+iZQsrgTzIPESbV6IYNJwLyFbRfk5wLReAqrKK
        A5tB05pJSPD2I8JQDfu3ngYxYbGSVNKgvAo7Z6FD8OnvTR8qFC6jpA628skV3ltMRu9OYGGA=
X-Google-Smtp-Source: AA6agR4DW4q/2A9ywSd13iCF+ePp48d1hrUtaMUrw4UtWfNqMySae1IrbHzEezfja+68agZoyw6i28qwyg==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:e5d2:b0:175:fe0:223b with SMTP id
 u18-20020a170902e5d200b001750fe0223bmr6245168plf.92.1661898020660; Tue, 30
 Aug 2022 15:20:20 -0700 (PDT)
Date:   Tue, 30 Aug 2022 22:19:52 +0000
In-Reply-To: <20220830222000.709028-1-sagis@google.com>
Mime-Version: 1.0
References: <20220830222000.709028-1-sagis@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220830222000.709028-10-sagis@google.com>
Subject: [RFC PATCH v2 09/17] KVM: selftest: TDX: Add TDX IO reads test
From:   Sagi Shahar <sagis@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Ryan Afranji <afranji@google.com>,
        Roger Wang <runanwang@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Ben Gardon <bgardon@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Xu <peterx@redhat.com>, Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test verifies IO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index ee60f77fe38e..85b5ab99424e 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include "asm/kvm.h"
+#include <bits/stdint-uintn.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <kvm_util.h>
@@ -573,6 +575,87 @@ void verify_guest_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies IO functionality by reading values of different sizes
+ * from the host.
+ */
+TDX_GUEST_FUNCTION(guest_io_reads)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 1, TDX_IO_READ, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0xAB)
+		tdvmcall_fatal(1);
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 2, TDX_IO_READ, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0xABCD)
+		tdvmcall_fatal(2);
+
+	ret = tdvmcall_io(TDX_TEST_PORT, 4, TDX_IO_READ, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+	if (data != 0xFFABCDEF)
+		tdvmcall_fatal(4);
+
+	// Read an invalid number of bytes.
+	ret = tdvmcall_io(TDX_TEST_PORT, 5, TDX_IO_READ, &data);
+	if (ret)
+		tdvmcall_fatal(ret);
+
+	tdvmcall_success();
+}
+
+void verify_guest_reads(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	printf("Verifying guest reads:\n");
+	/* Create a TD VM with no memory.*/
+	vm = vm_create_tdx();
+
+	/* Allocate TD guest memory and initialize the TD.*/
+	initialize_td(vm);
+
+	/* Initialize the TD vcpu and copy the test code to the guest memory.*/
+	vcpu = vm_vcpu_add_tdx(vm, 0);
+
+	/* Setup and initialize VM memory */
+	prepare_source_image(vm, guest_io_reads,
+			     TDX_FUNCTION_SIZE(guest_io_reads), 0);
+	finalize_td_memory(vm);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 1, TDX_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 2, TDX_IO_READ);
+	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_FAILURE(vcpu);
+	CHECK_IO(vcpu, TDX_TEST_PORT, 4, TDX_IO_READ);
+	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDX_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	CHECK_GUEST_COMPLETION(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	if (!is_tdx_enabled()) {
@@ -586,6 +669,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
+	run_in_new_process(&verify_guest_reads);
 
 	return 0;
 }
-- 
2.37.2.789.g6183377224-goog

