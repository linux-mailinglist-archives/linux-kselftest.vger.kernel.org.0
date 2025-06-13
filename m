Return-Path: <linux-kselftest+bounces-34942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08FAAD9530
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D621BC2A98
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5E92D1316;
	Fri, 13 Jun 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kJLkAW6V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474E82C08DE
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842075; cv=none; b=BQzg92jjoYqJIgnjvaZHgnQNTDX3PHhJeSmPN8vnFVDz/u1S0XkXdCJm8JVXIPtgXG6TmGU+W6vBFl2H3AyStP3tvQQDN8W5W4dW6HbpdFoRQ8UWbHpDCwsO8aL6G6XpEfjDchOinwVoJZ4Ik1Kt5mqnKrcqP/9XdpL+0Izppxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842075; c=relaxed/simple;
	bh=pj/qOMhLK6l40aZOMbM3JNGNF/LrqZmEzRrypyE+ELo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1bllx6s1hWzt4IL3C80DPW3kjurgJW2612NteHwAtF8OE3av8eUr4A7dgJCENrSk/Wfn3edDEEV11gCfFWNgLqTBM8EjbStErqYB+SOoht3IKiwTM0BGgRXosxILeqzOZXbVNl2oh53EFcKaDaMXBcABR2wi6wch11uJELKaes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kJLkAW6V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3183193374so70405a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749842073; x=1750446873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWsrJ5FcIz144D7jrLSABWJGVcBqxCeDWRTmiRMA030=;
        b=kJLkAW6VbFebg3k5pi8JdbgI29Q3rw02zJLjghNnVrk8Kn+YUGy5d5f35qmEWGUphl
         wR11VGblPPywuITUE0y7wkKqJgSN2cqtFrHKfVo2a7mV5+KyQaoIZjyGAJrrYDpAvr6H
         3IX2BIgVFc3I3si7ZCtn6k0TkxOs+yr5tagyIjAUioA26pXmu4MYsY5ZUy+NP/11eSPl
         aW0PzvmExQjtz1EQL1X5E5GfsaSLJkuBZVgQR6vSYTNSp9Usa6Tw8IxHiNUeOiJMgBC1
         eiUGMZG83eWziE3ZzFrGLcVpQWwA2q3bC9y5d7vrzH9h6mFIQ1g987Ct+AzQQfglzPKV
         tKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749842073; x=1750446873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWsrJ5FcIz144D7jrLSABWJGVcBqxCeDWRTmiRMA030=;
        b=HGXQtKpfCJxr2tDfErwZLuVxqCreXLmGR10Qr5WN8a3t0vB4uM1qJ71ELG0tDbi1+G
         WzWFYQ8SLz1oaYXBWnGni7neFGuGA+49pE2n84SStAEEVRGiDeCh2QSTCk+GCgDVQwi2
         A3zHp3hZnSJUH8Y01ZjqbORwuxEj5hm10LwNohvjAVP8p9TV+QskM52keeAHxJuu1xt1
         iwWfRE6pUH5maDw2UAeSp/EGuZ7S+dQEo3oNkBO9mzctRsmlBy/09kYyKIYjp+5Gb594
         Nf7bX2x97vLL2adMVuY8Hx4b/Jb8yExyqRif4yUXAy55PayLwoJN2PxzmWhlbTCpDlIj
         dsMQ==
X-Gm-Message-State: AOJu0YyJ5zGrQTVttVIXHYLjN5HZTBRujDR22txeSl66adqrqFgiY0R5
	UA5XaUJcknkGdCgR5HR7G10s8rz2dOSsuaoiQn6l7+jMmRhuS3fUOlzsulyKClDFQrjkoaJ/MD1
	efclDtIl+qkdHDbOFwmTxsdv2haKgwXOVI5Xvt44iUPjFQeZOdSq0SDK2P3nREcPgbjDF6z41mK
	d/hHfn76PX6qiGbV0M2Yzx5oyCtQa9G+vhUy2YullD23M=
X-Google-Smtp-Source: AGHT+IFrd+aIzVsaf5qkQIyyvxXN1hhsyIxmhctqZKZqFajXzX9NhDWDI6pk99SuAT7cgE/hn98xDe6CXQ==
X-Received: from pjbsl11.prod.google.com ([2002:a17:90b:2e0b:b0:312:e5dd:9248])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d88:b0:311:ea13:2e63
 with SMTP id 98e67ed59e1d1-313f1ca12e2mr1094019a91.13.1749842072421; Fri, 13
 Jun 2025 12:14:32 -0700 (PDT)
Date: Fri, 13 Jun 2025 12:13:40 -0700
In-Reply-To: <20250613191359.35078-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250613191359.35078-1-sagis@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613191359.35078-14-sagis@google.com>
Subject: [PATCH v7 13/30] KVM: selftests: TDX: Add basic TDG.VP.VMCALL<GetTdVmCallInfo>
 test
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
2.50.0.rc2.692.g299adb8693-goog


