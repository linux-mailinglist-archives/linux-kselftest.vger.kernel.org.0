Return-Path: <linux-kselftest+bounces-34946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C0DAD953A
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515ED16745E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13D42E2F02;
	Fri, 13 Jun 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IapJo8iI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B62D9EF7
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842081; cv=none; b=uMtAAaBg3Um5309Z4PmO23mXOd9ziGl9oh+K8m1pL5mZ5Yo9EgXH4Ospp15MuJal2mk7LnmeqV9oskfoiD0Y5prgHgIjvPSX6mNyisY9J1X6kcAboLljZPLgbjfe23tA8WuQZQFm6L4cHJp/Jz8vXcK6HeDdMgfDLXpjhrt/Wfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842081; c=relaxed/simple;
	bh=PsBeeG1A8OYyGWHuc0HL/Ka0JLodkH2zEOxDGzqAs1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KDE91qYmFqD9jbMG0XX4uy+moDMJnYopw7xOCpnw91NeEjQtakJ+9CJuw06NdOXS8meGl8Lxdd2gfB5kQ7aAFDjM1n4NBf5R883cksV2B20BHlhLMN2H7UutWQvgKLM1r9Fb5dnrC75wJwgAbog7uweROIBMlzSOsaeYUbv57QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IapJo8iI; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1582816a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842079; x=1750446879; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qo77ALWGLlS5a+AOG+Up/vemw+ZwJwTl4/AAZ4FInCc=;
        b=IapJo8iIMbjPnsYEwd41dWXeJ+Uvztd1PMOfUN6J3KJ8gfzyzJ4HkZW7adbkYwQMMH
         vzql5eCxXbgaMGC+a+SIHMUqVDYqVXZVleb5ZPmV9okFeWIObYnbAPOw4oegF+ld7usc
         +v+wgXkgSspwTSZg9CBH5umTznMCJsC9mYETrGj6vnvb1xgTXLRFfbICdzhtAFTuQZz+
         KhbpsZYJeZN42FOWB+czStTY04XbKViifPCyVn1IiQ+eicD4VvnVTUBLJMUcti7PXrcX
         LzwetwEXAFPBSQr24RR/DXiSoIA9FXWEC7BAc61cozWtgadLl6fmGyMjAKtA+yssHPCI
         f50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842079; x=1750446879;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo77ALWGLlS5a+AOG+Up/vemw+ZwJwTl4/AAZ4FInCc=;
        b=nZ/C9pC5tgcJ14we2QNIN6AaqRFeCjqZdn2BYtBNRXcZVupPhF2u70llQ+IjaWx4A4
         CDRvNWf843vMHnn3oc730lnLU9KwDwP9bB4eeT0jRPsKrn//t4fvnJ1hLL775AZGNyK4
         gSy3bcT29juYp0I1xTC5DkROoLAPS9O5C3X4MtzkFdbHJxYOivkyxzMU1z5ortna7uSV
         VpHmH1Ed9+dBqqaHSBVASCxkk1MchRrvjLUHXweTUPJPHjv+nQLp4Ame9jG/4vj9UVsn
         wn36uWZXrgRa1lhMXMRU8iXll5BcaKw4XtEkyqUO9AAfnsqf0KhH3FbMFpnaRipa9UUZ
         NTPQ==
X-Gm-Message-State: AOJu0YwuTLRdfCBKVt9wg64JSAT+LxdpJlFG7S4GUVbFZpbZXheO1Q7W
	mbYaPeSrvQitpkYEiNgKPpopinViMpFyui/pWOpsZHxnz7Oj4IeYEE56W67pK4DW/08niEkBtED
	cToxuKSe0BA+QO43lIFDGwCxHdTORAmf8CpkaT55nbVus8ovfe0vTDIv9mnnohapszbrutd/VV/
	cDRkC0olwy1AwHq182AJaszt1RMQT/yWrOnBqGlBzOXg4=
X-Google-Smtp-Source: AGHT+IHR6daDRKqgwWFjUv4/DXnqJF6kWP1sxIAhGWkf65LPPiBa8mIm2R1Jsf1XRbI1J3eb6vctzbTfHQ==
X-Received: from pfug15.prod.google.com ([2002:a05:6a00:78f:b0:748:34d:6d5a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a90:b0:21a:e751:e048
 with SMTP id adf61e73a8af0-21fbd666e30mr640030637.35.1749842078776; Fri, 13
 Jun 2025 12:14:38 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:44 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-18-sagis@google.com>
Subject: [PATCH v7 17/30] KVM: selftests: TDX: Add TDX HLT exit test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

The test verifies that the guest runs TDVMCALL<INSTRUCTION.HLT> and the
guest vCPU enters to the halted state.

Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 10 +++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 81 ++++++++++++++++++-
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 56359a8c4c19..b5831919a215 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -9,6 +9,7 @@
 #define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_HLT 12
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 #define TDG_VP_VMCALL_INSTRUCTION_RDMSR 31
 #define TDG_VP_VMCALL_INSTRUCTION_WRMSR 32
@@ -20,4 +21,5 @@ uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
 					  uint64_t *r13, uint64_t *r14);
 uint64_t tdg_vp_vmcall_instruction_rdmsr(uint64_t index, uint64_t *ret_value);
 uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
+uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index 99ec45a5a657..e89ca727286e 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -93,3 +93,13 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value)
 
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
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 079ac266a44e..720ef5e87071 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -642,6 +642,83 @@ void verify_guest_msr_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies HLT functionality.
+ */
+void guest_hlt(void)
+{
+	uint64_t interrupt_blocked_flag;
+	uint64_t ret;
+
+	interrupt_blocked_flag = 0;
+	ret = tdg_vp_vmcall_instruction_hlt(interrupt_blocked_flag);
+	tdx_assert_error(ret);
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
+	static struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	/*
+	 * This function will also be called by SIGALRM handler to check the
+	 * vCPU MP State. If vm has been initialized, then we are in the signal
+	 * handler. Check the MP state and let the guest run again.
+	 */
+	if (vcpu) {
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
+	tdx_run(vcpu);
+
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+void verify_guest_hlt(void)
+{
+	_verify_guest_hlt(0);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -649,7 +726,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(9);
+	ksft_set_plan(10);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -668,6 +745,8 @@ int main(int argc, char **argv)
 			 "verify_guest_msr_writes\n");
 	ksft_test_result(!run_in_new_process(&verify_guest_msr_reads),
 			 "verify_guest_msr_reads\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_hlt),
+			 "verify_guest_hlt\n");
 
 	ksft_finished();
 	return 0;
-- 
2.50.0.rc2.692.g299adb8693-goog


