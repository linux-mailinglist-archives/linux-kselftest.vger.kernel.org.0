Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196F9762582
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGYWDa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGYWDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E591FE6
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso4351071276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322541; x=1690927341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPFuAgaUeyfCUlhfm4+JcD7Xea+OTV+W8Q5kgeNxjUM=;
        b=N895Zjr/ffiBSakdUIt4SaM/XXZ58cfhyQnTzYoYIpFgiW36zF99HwafzlVEUe8nK5
         2MjFwZFMpeIfr6HthxzpKo2HLgVsSvE0MfQKDXMX/Q8XUPwi0RybcpeEMLxO7sDTfnKX
         hRFX36WaH4HHzFPmokgxutmQyoMm1KbL3nr1l9o/SfstiDPXzUZ0NG9e2dypNyJLItLC
         RVFkOxDjaqrELDpvh17JzxVkV28f2MO9PCfIrhZljpIegXN4LiLEnM1e8BzvP8Tl3EwK
         ux95xWwtiEbk/VpnrdqNhSTEvzl8MXzQAEuH12oiLhE3xBjiPnOwOng9mIWco41WwhmM
         GGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322541; x=1690927341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPFuAgaUeyfCUlhfm4+JcD7Xea+OTV+W8Q5kgeNxjUM=;
        b=SWUhLQd7ctB3xyJKTdZi6njGUu4Feh3Eck/Tf5Jz5LcnsZUMyykojBSSKrycobpCAn
         tJjd5QveNoOT1B/UmOgxqsvjDzBKCuSdkqC2I8xXGp4gFlUGMlr+W1G1p1oCa566h5eO
         WXyAL8D1+q+OL8f+MF4tntD2oD6EKAgkM7B7aC02Z578mxVT1IQ0WsGyfYB+u435wOVD
         uXZJ72oEwsQ+fwu0cHYBxmCGVV/xVDevDXo7cgsYyx6uCcHnhbYLal332XhtXVHo9EPd
         B2jyKABdSNvwd76GSnhcyzL8u6cRYmpRuUpgeqcZDCbb7LGhor1AcdZmMv0PQ2iP7J+c
         YPWA==
X-Gm-Message-State: ABy/qLbwcyIIjehOOl3g6Mr6G1tFc/Pn+CR7MgnGDh1BFzcUnV2rkQ2N
        nKTtoQHf0/mLUdOZUQAUCizok1he1olnIScXGZu5ojJea5H+AjX0jrAbC0X4EjE4B1oYPBmED0N
        rx9+XQAHL5J52mHTNS+NrSnZ/rcjB+EnDewdAk4KjSF/u5L++uqdIGUtuwM5wy4ZYbCw+dGgPUt
        xK
X-Google-Smtp-Source: APBJJlEKEJamMSCvyZgsf5vjfgY9M4JqPaDO2MjU30VnTlQAyFEVHEKWjeWaBTumzuWYAdSAB9c/hXRZOpqm
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:324e:0:b0:d0f:dec4:87a0 with SMTP id
 y75-20020a25324e000000b00d0fdec487a0mr1696yby.2.1690322540616; Tue, 25 Jul
 2023 15:02:20 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:10 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-18-afranji@google.com>
Subject: [PATCH v4 17/28] KVM: selftests: TDX: Add TDX MMIO reads test
From:   Ryan Afranji <afranji@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, eesposit@redhat.com,
        borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies MMIO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I64fc74b41b5efb14be8e098b95b6bd66ab8e52d7
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  2 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
 .../kvm/include/x86_64/tdx/test_util.h        | 23 +++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index b5e94b7c48fa..95fcdbd8404e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -9,6 +9,8 @@
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
 #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO_READ 0
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE 1
 
 #define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
 #define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index b18e39d20498..13ce60df5684 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -12,6 +12,7 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
 void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
@@ -22,5 +23,7 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 8a9b6a1bec3e..af412b764604 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -35,6 +35,29 @@
 			(VCPU)->run->io.direction);			\
 	} while (0)
 
+
+/**
+ * Assert that some MMIO operation involving TDG.VP.VMCALL <#VERequestMMIO> was
+ * called in the guest.
+ */
+#define TDX_TEST_ASSERT_MMIO(VCPU, ADDR, SIZE, DIR)			\
+	do {								\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_MMIO,	\
+			"Got exit_reason other than KVM_EXIT_MMIO: %u (%s)\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason));	\
+									\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_MMIO) && \
+			((VCPU)->run->mmio.phys_addr == (ADDR)) &&	\
+			((VCPU)->run->mmio.len == (SIZE)) &&		\
+			((VCPU)->run->mmio.is_write == (DIR)),		\
+			"Got an unexpected MMIO exit values: %u (%s) %llu %d %d\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason),	\
+			(VCPU)->run->mmio.phys_addr, (VCPU)->run->mmio.len, \
+			(VCPU)->run->mmio.is_write);			\
+	} while (0)
+
 /**
  * Check and report if there was some failure in the guest, either an exception
  * like a triple fault, or if a tdx_test_fatal() was hit.
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 9485bafedc38..b19f07ebc0e7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -124,3 +124,22 @@ uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					uint64_t *data_out)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_READ,
+		.r14 = address,
+	};
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (data_out)
+		*data_out = args.r11;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index f77caf262f84..88cb219ae9b4 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -799,6 +799,92 @@ void verify_guest_hlt(void)
 	_verify_guest_hlt(0);
 }
 
+/* Pick any address that was not mapped into the guest to test MMIO */
+#define TDX_MMIO_TEST_ADDR 0x200000000
+
+void guest_mmio_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 1, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x12)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 2, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x1234)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 4, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x12345678)
+		tdx_test_fatal(4);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 8, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0x1234567890ABCDEF)
+		tdx_test_fatal(8);
+
+	// Read an invalid number of bytes.
+	ret = tdg_vp_vmcall_ve_request_mmio_read(TDX_MMIO_TEST_ADDR, 10, &data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Varifies guest MMIO reads.
+ */
+void verify_mmio_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_reads);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO reads:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint8_t *)vcpu->run->mmio.data = 0x12;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
+
+	td_vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -818,6 +904,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
+	run_in_new_process(&verify_mmio_reads);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

