Return-Path: <linux-kselftest+bounces-1739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE880F841
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14EAEB21333
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47A65A9B;
	Tue, 12 Dec 2023 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMnmrFlK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8B1733
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:34 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d30efd624fso11816165ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414050; x=1703018850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MyTn48cv4nrVxvqRuS9eNhhEY7jSVIhffkw0y0uC7o=;
        b=ZMnmrFlKN0nOxPWh+G9czX5giSeuDU53mDPgHLo1veqglyQnu2OIzGL1sNhN4Rjh4l
         XCOs+O/4LFeWVRbhrQYMoBdz9SxxXWkL2TwXWfNK7fkXUBcz6d4l4duLi6JMB4xSNE4A
         /ZS1HBHn2fGynqHbh1ASGm0peyPlKEwk9IUhCqPjt6ZqRHs4w7UPdK5LXfJeeoyWv/4d
         6diPMlfr4gEpjFtPvMmhAtGFptBfMHXT9Nrp/T6sY2pirAJXhtEVr8E3kwEy3I47UDEQ
         SSkhHnWmk9jFg7l9/4C0oMMj0rf0UX6D5opc4+mjDHjCYZDD16Ba1tF36J2Gkhjow32k
         4BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414050; x=1703018850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MyTn48cv4nrVxvqRuS9eNhhEY7jSVIhffkw0y0uC7o=;
        b=HqBKc654Z3kd0NsRI6jZGpbU/6+6HmHQ2UOVNWgESeAm20kjvoRiAsTEa5D+4WK6p5
         t2RktNDu48GKK8BBZnO/Mvs1GWwvvo2T2ZGYH9HEPIi1tn5XiZk9bR+vRrUSYhItx2jg
         gZBYsW1NmyYhr2hZF0/kQUgReLvTT0sl3TjHb+oppHipGmWUSGWxgilqMO9F+vUbDeL6
         ohFCsN+4eZCnFQ4jGCp3EBLwWL+7+tsm0A3lHTiL4H7nNdsPiIg1VIrBUlglBjbTCHDQ
         pEZShBLVt9rZNibUvlXA/6KJCqjv8LakvNOsVXxLJDDTFHpKBezdXSFGdCZSTFLkV4a4
         eQOg==
X-Gm-Message-State: AOJu0YznvbVeHKYO7Zo49BRLyIUl8F9RXIyDcWVptkIHH7EDfb/cD1Oc
	dCN1ocdVYuxzNtn8jRHqi13aVk73YJ7cDDgMclfNV/R91e08o9j9fg+1ceo4QYo/QqzSch/C7QQ
	e/t6kVGj4jPc8vXXYVI9xpmPwPqU/TugFUELSCoOjLD+fS3rj9L8ENP4bod42VzBwzUvuNjA=
X-Google-Smtp-Source: AGHT+IE9o+wdgszQKxFurkrd+52+etYgtANUMY5B0TZYNuLPkxvic743zdGOu2K00BhDWe6POn2aNb7G6Q==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a17:902:b712:b0:1d3:46f4:7f1e with SMTP id
 d18-20020a170902b71200b001d346f47f1emr4989pls.1.1702414047966; Tue, 12 Dec
 2023 12:47:27 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:31 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-17-sagis@google.com>
Subject: [RFC PATCH v5 16/29] KVM: selftests: TDX: Add TDX HLT exit test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>, 
	Ryan Afranji <afranji@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	Sagi Shahar <sagis@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Roger Wang <runanwang@google.com>, Vipin Sharma <vipinsh@google.com>, jmattson@google.com, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
guest vCPU enters to the halted state.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 10 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 78 +++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 85ba6aab79a7..b18e39d20498 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -8,6 +8,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
@@ -20,5 +21,6 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					uint64_t *r13, uint64_t *r14);
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
+uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index 88ea6f2a6469..9485bafedc38 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -114,3 +114,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
 
 	return __tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_INSTRUCTION_HLT,
+		.r12 = interrupt_blocked_flag,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 5db3701cc6d9..5fae4c6e5f95 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -721,6 +721,83 @@ void verify_guest_msr_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies HLT functionality.
+ */
+void guest_hlt(void)
+{
+	uint64_t ret;
+	uint64_t interrupt_blocked_flag;
+
+	interrupt_blocked_flag = 0;
+	ret = tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void _verify_guest_hlt(int signum);
+
+void wake_me(int interval)
+{
+	struct sigaction action;
+
+	action.sa_handler = _verify_guest_hlt;
+	sigemptyset(&action.sa_mask);
+	action.sa_flags = 0;
+
+	TEST_ASSERT(sigaction(SIGALRM, &action, NULL) == 0,
+		    "Could not set the alarm handler!");
+
+	alarm(interval);
+}
+
+void _verify_guest_hlt(int signum)
+{
+	struct kvm_vm *vm;
+	static struct kvm_vcpu *vcpu;
+
+	/*
+	 * This function will also be called by SIGALRM handler to check the
+	 * vCPU MP State. If vm has been initialized, then we are in the signal
+	 * handler. Check the MP state and let the guest run again.
+	 */
+	if (vcpu != NULL) {
+		struct kvm_mp_state mp_state;
+
+		vcpu_mp_state_get(vcpu, &mp_state);
+		TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_HALTED);
+
+		/* Let the guest to run and finish the test.*/
+		mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+		vcpu_mp_state_set(vcpu, &mp_state);
+		return;
+	}
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_hlt);
+	td_finalize(vm);
+
+	printf("Verifying HLT:\n");
+
+	printf("\t ... Running guest\n");
+
+	/* Wait 1 second for guest to execute HLT */
+	wake_me(1);
+	td_vcpu_run(vcpu);
+
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+void verify_guest_hlt(void)
+{
+	_verify_guest_hlt(0);
+}
 
 int main(int argc, char **argv)
 {
@@ -740,6 +817,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_reads);
 	run_in_new_process(&verify_guest_msr_writes);
 	run_in_new_process(&verify_guest_msr_reads);
+	run_in_new_process(&verify_guest_hlt);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


