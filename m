Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9467621C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjAUASF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjAUARw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A4195196
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k204-20020a256fd5000000b007b8b040bc50so7397078ybc.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjO5rBwLb0cHzWThJNyOsO1URxlYZa7SL0LoJaae1iY=;
        b=DbRKdnP4x88VQmpI73F5HtgUxWbJ2hsDEBYdUyvS8NBGoTwSGWDKbPvp6spCy61JKa
         d8sCFnczxbj7XTIgC5qmDASbZuQUm4JaxsHKPw5mgwOTcf+5C7fOEgl8kKDjBaA5vDiL
         BzUxepdz3NOVVwzTyUgqjRDacw06zOUCEiAMbmYtayKjQ0EKf8XNVzpsKuRHJcd9LAcB
         0lu7xGF0zPGrHg+/e0vv+lW6RaM488sqw/EJEPXs421fhv5UocYR+waxt3sO+VYZy3tH
         td827j6Sc07EQNlG9HbMRF7AN9NBjz6hjBomANw6zqJWyuma2V9QYMTIBwBpkZ12gUI3
         a14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjO5rBwLb0cHzWThJNyOsO1URxlYZa7SL0LoJaae1iY=;
        b=A2mUUiqGKzRZyIXQKHLiUEkYScxePH6D+dDMD92fdUvjbvlDU9zl1sgID94MeR/nzt
         +wqprjOqIf6nS7v+XQIfNc3+ORApzyHiqApvIim8FbEgp7E02Lcuz00o7KuCFpndFg5J
         9MzdODotXDBgdVTxdkOm5dvAFwOBdgT02lU8E/8zylzp2P6itht44r5XqUycem9s4ITA
         CSqsoeWTLm1LTOkooPDiRdPEUsnKvS9+r+mnWnOM0RRZa8gaj0cXLLwVtslC3fvekrSG
         escrMo/qjPHki4nER2VyWOmeUhARrb2KRyq5fy6xVGaNmQkVvj++BtoqwDfwIRB/ksVo
         kQmA==
X-Gm-Message-State: AFqh2krPgojuJ5MVjxPL1BptaC817r6zeAmanzryFC68nynDl3imSeyx
        79zyitA18AwuSMyK8ZrZ47fksn9EQweyTiYoXJd3nCwEsxZgrIb7gopncyhm65Vf9ttf7wCftJu
        Pn5eT7RAKp/2pIA9dDwvoESH5qfcW0IUWDLxNQKStHMeba6ufEdD7Tb22aXofvyf/5XjjRyE8mY
        Na6YlPyOVvHCY=
X-Google-Smtp-Source: AMrXdXs2Azizp8MgH3Huhhpq7IBWql1lWkjMllTIOkYSDytuaEr6jOkniKY65Y0teNdl7wi3iWIuU9V4MUkSE2rpow==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:648:0:b0:4ee:30ce:15e1 with SMTP
 id 69-20020a810648000000b004ee30ce15e1mr2152793ywg.53.1674260249914; Fri, 20
 Jan 2023 16:17:29 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:29 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-19-ackerleytng@google.com>
Subject: [RFC PATCH v3 18/31] KVM: selftests: TDX: Add TDX MMIO reads test
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test verifies MMIO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  2 +
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
 .../kvm/include/x86_64/tdx/test_util.h        | 23 +++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 19 ++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 5 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index b5e94b7c48fa5..95fcdbd8404e9 100644
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
index 7eba9d80b3681..8dd6a65485260 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -11,6 +11,7 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO 48
 
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
@@ -21,5 +22,7 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
+uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
+					uint64_t *data_out);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 8a9b6a1bec3eb..af412b7646049 100644
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
index 1af0626c2a4ad..dcdacf08bcd60 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -103,3 +103,22 @@ uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
 
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
index 346c1e07af9c0..88f0429db0176 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -806,6 +806,92 @@ void verify_guest_hlt(void)
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
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint8_t *)vcpu->run->mmio.data = 0x12;
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint16_t *)vcpu->run->mmio.data = 0x1234;
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint32_t *)vcpu->run->mmio.data = 0x12345678;
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_READ);
+	*(uint64_t *)vcpu->run->mmio.data = 0x1234567890ABCDEF;
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -825,6 +911,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
+	run_in_new_process(&verify_mmio_reads);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

