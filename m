Return-Path: <linux-kselftest+bounces-38508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E46FB1DDF6
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B5F585457
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909A2797AC;
	Thu,  7 Aug 2025 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB76iWGx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C372277C87
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597821; cv=none; b=j2XVK2hmzNt5zYT5xgxwxIVkGOSEXoR/M1OmBAKqtD2Aa2VX4NwJjwU5FYfuY0ibCYVJiJDYqe7Pf3o/aDlm5d4kgPl4VvZiGcmbusnEOuLK97Zark2co5iBVQeFrOgc+k3TsKzeb0uXPMUEErYEmjX5ZIzAO9lz89hIriy6X60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597821; c=relaxed/simple;
	bh=mGbx7ziQJOwyU5DksuV+htsFBGLstu5vkoVMf0ClHvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EfydpQbPg3/oWFN860M3LDoddeVq/ozdNbBem60HLecsLaO96ScacB09dP6O2cGY8noWJj5ydDVaihjVYg51VU2J6ougvyZEuHZISHkxPx6bD+jBs4kupZ+liaJSs4xUyJukvq8ZcbnDhvlV/I0q1aQb4Pch1AYk5f7RA+RcQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB76iWGx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-242a1390e9eso27734465ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597818; x=1755202618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1nyrOuLk05O6GNAKLishkQlt5G5F0xL/CtyJP3+mTQ=;
        b=fB76iWGxmnzp4SmjGZMVNDvDExux5Dg4hxcg5irVRZVeMfFzGkZ6soXW9t4I6h93b3
         fvI8KTNSmzNzsG/2ObbMA60ZEfEB0n3z2iG6NkbwqlX5iNhgyK5+4zBvngqycTvyNCZX
         RWaCz9BeBGo4dCUSQ/tM/K6N6ZyDkD59rYQ7wb0mBqQIThAniwfBfmn5QWBcGQr0RgPn
         pQNgWuduvuHCiDYPTzW4EHiIukrlwGrCu3nlGmjedXJ39b95Ib8s30HLsCY+YrENCYQf
         8mS5yyZMx8otRAo/1gcCgBx6Z0ZeTxaZdy84B2EmqhOrsmhxZEcN7bRBgvPIMCH9JuwN
         /cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597818; x=1755202618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1nyrOuLk05O6GNAKLishkQlt5G5F0xL/CtyJP3+mTQ=;
        b=NzOQRYWgCO0l/EUCYqX3Z8INEALwn6sL4px7mQu/JERppyyMEbSoEkyj1CWzHatmgP
         7ILIKLJr7zJIXxek2XBNsiBAd+nCkYJ1klPnf2CV3gpNj9MeZAG4S0apfe7A1k20z/Gs
         pW3D9iNVgqXqRNUeeSpeUNGCggbkdye79oIdxPOKCMfcjC7iYFs+jY4cctR8P4lrMQB+
         tD2JTJCDvLqANkFlO7ab2+TFdDdJFFQRBQghJuhFqaE09/7kHro83ZeEIcF/k9mPyi07
         oK8YjzvJFoOnlHhoD33FXX0NdNXPlOik0Fzl9KlLxdnHfCeoCegVUAfNqUU7uM22AU2Z
         JDvg==
X-Gm-Message-State: AOJu0Yz5PDVzIbs47FuDcVEIBquU3xTKOm+AP3KWMPrxj1GESfi2eETm
	ICudVKcunkq/Y+Anh/O2IXikdCw6kehuVDG0PpswBGHcapsmObtV7mP+IS/V45Nr4J30kwzzy6C
	hLAFcKmDmOuqVayjYe9aEl/AGR0PSWV6h2DxQ/C75EKIGNWcwOU8jxIi00o3DSSDFF6XT7N5poh
	viTFRJS/EZwDgWtIX4Xj4ojMBbmcebRat4Tg8dw0rfpv4=
X-Google-Smtp-Source: AGHT+IFkx9VRn9WrtpwgFH8Korjpu/Pc/cbeI94UMhnq4S2UnuNwb22nTJrWWM/C0AG5MD6MlcRS0NYoFQ==
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:31e:a49a:f4dd])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f605:b0:240:38f8:ed05
 with SMTP id d9443c01a7336-242c21dce69mr4372965ad.36.1754597817513; Thu, 07
 Aug 2025 13:16:57 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:09 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-14-sagis@google.com>
Subject: [PATCH v8 13/30] KVM: selftests: TDX: Add basic TDG.VP.VMCALL<GetTdVmCallInfo>
 test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test calls TDG.VP.VMCALL<GetTdVmCallInfo> hypercall from the guest
and verifies the expected returned values.

TDG.VP.VMCALL<GetTdVmCallInfo> hypercall is a subleaf of TDG.VP.VMCALL to
enumerate which TDG.VP.VMCALL sub leaves are supported.  This hypercall is
for future enhancement of the Guest-Host-Communication Interface (GHCI)
specification. The GHCI version of 344426-001US defines it to require
input R12 to be zero and to return zero in output registers, R11, R12, R13,
and R14 so that guest TD enumerates no enhancement.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  3 +
 .../selftests/kvm/include/x86/tdx/test_util.h | 27 +++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 23 ++++++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 42 +++++++++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 72 ++++++++++++++++++-
 5 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index 2acccc9dccf9..97ceb90c8792 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -6,6 +6,7 @@
 
 #include "kvm_util.h"
 
+#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
@@ -13,4 +14,6 @@
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
+uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+					  uint64_t *r13, uint64_t *r14);
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index 2af6e810ef78..91031e956462 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 
+#include "kvm_util.h"
 #include "tdcall.h"
 
 #define TDX_TEST_SUCCESS_PORT 0x30
@@ -92,4 +93,30 @@ uint64_t tdx_test_report_to_user_space(uint32_t data);
  */
 uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu);
 
+/*
+ * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call.
+ *
+ * Data is sent to host in 2 calls. LSB is sent (and needs to be read) first.
+ */
+uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data);
+
+/*
+ * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
+ */
+uint64_t tdx_test_report_64bit_to_user_space(uint64_t data);
+
+/*
+ * Read a 64 bit value from the guest in user space, sent using
+ * tdx_test_send_64bit().
+ */
+uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port);
+
+/*
+ * Read a 64 bit value from the guest in user space, sent using
+ * tdx_test_report_64bit_to_user_space().
+ */
+uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index ba088bfc1e62..5105dfae0e9e 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -43,3 +43,26 @@ void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
 
 	__tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+					  uint64_t *r13, uint64_t *r14)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_GET_TD_VM_CALL_INFO,
+		.r12 = 0,
+	};
+	uint64_t ret;
+
+	ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	if (r11)
+		*r11 = args.r11;
+	if (r12)
+		*r12 = args.r12;
+	if (r13)
+		*r13 = args.r13;
+	if (r14)
+		*r14 = args.r14;
+
+	return ret;
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index f9bde114a8bc..8c3b6802c37e 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 
 #include "kvm_util.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
@@ -124,3 +125,44 @@ uint32_t tdx_test_read_report_from_guest(struct kvm_vcpu *vcpu)
 
 	return res;
 }
+
+uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data)
+{
+	uint64_t data_hi = (data >> 32) & 0xFFFFFFFF;
+	uint64_t data_lo = data & 0xFFFFFFFF;
+	uint64_t err;
+
+	err = tdg_vp_vmcall_instruction_io(port, 4, PORT_WRITE, &data_lo);
+	if (err)
+		return err;
+
+	return tdg_vp_vmcall_instruction_io(port, 4, PORT_WRITE, &data_hi);
+}
+
+uint64_t tdx_test_report_64bit_to_user_space(uint64_t data)
+{
+	return tdx_test_send_64bit(TDX_TEST_REPORT_PORT, data);
+}
+
+uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port)
+{
+	uint32_t lo, hi;
+	uint64_t res;
+
+	tdx_test_assert_io(vcpu, port, 4, PORT_WRITE);
+	lo = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+
+	tdx_test_assert_io(vcpu, port, 4, PORT_WRITE);
+	hi = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	res = hi;
+	res = (res << 32) | lo;
+	return res;
+}
+
+uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu)
+{
+	return tdx_test_read_64bit(vcpu, TDX_TEST_REPORT_PORT);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index bbdcca358d71..22143d16e0d1 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -240,6 +240,74 @@ void verify_td_cpuid(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies TDG.VP.VMCALL<GetTdVmCallInfo> hypercall functionality.
+ */
+void guest_code_get_td_vmcall_info(void)
+{
+	uint64_t r11, r12, r13, r14;
+	uint64_t err;
+
+	err = tdg_vp_vmcall_get_td_vmcall_info(&r11, &r12, &r13, &r14);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r11);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r12);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r13);
+	tdx_assert_error(err);
+
+	err = tdx_test_report_64bit_to_user_space(r14);
+	tdx_assert_error(err);
+
+	tdx_test_success();
+}
+
+void verify_get_td_vmcall_info(void)
+{
+	uint64_t r11, r12, r13, r14;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_get_td_vmcall_info);
+	td_finalize(vm);
+
+	printf("Verifying TD get vmcall info:\n");
+
+	/* Wait for guest to report r11 value */
+	tdx_run(vcpu);
+	r11 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r12 value */
+	tdx_run(vcpu);
+	r12 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r13 value */
+	tdx_run(vcpu);
+	r13 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r14 value */
+	tdx_run(vcpu);
+	r14 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	TEST_ASSERT_EQ(r11, 0);
+	TEST_ASSERT_EQ(r12, 0);
+	TEST_ASSERT_EQ(r13, 0);
+	TEST_ASSERT_EQ(r14, 0);
+
+	/* Wait for guest to complete execution */
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -247,7 +315,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(4);
+	ksft_set_plan(5);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -256,6 +324,8 @@ int main(int argc, char **argv)
 			 "verify_td_ioexit\n");
 	ksft_test_result(!run_in_new_process(&verify_td_cpuid),
 			 "verify_td_cpuid\n");
+	ksft_test_result(!run_in_new_process(&verify_get_td_vmcall_info),
+			 "verify_get_td_vmcall_info\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


