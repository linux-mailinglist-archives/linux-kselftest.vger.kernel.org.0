Return-Path: <linux-kselftest+bounces-38505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD97B1DDED
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 22:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C7958626A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAEF275AF9;
	Thu,  7 Aug 2025 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/6jO7qh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDE237163
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Aug 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597815; cv=none; b=qPvz9f7ZlFP/JSQbzGtnSE96TWObvqrlrWGuJ56IfD2gwnYHiDiPrdQHMdbotUuOA0aAEbnvEZS1V/I6w/hhvBbeJiMEySChqTM9C8GVC4BqOwSaYokKOX14Gi44i1gHLPoGUIDje/MXHi7It47EzXLmUvFQGnOLUa3bKL67kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597815; c=relaxed/simple;
	bh=z+7gLlyWxfDul6oet1RXQIJyLgetpcrN7AHbzIzqphA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NABZ1xRNiV314dI4050lcyt5P7nLHngHzV2twKIgDLpjTTT9b2FpXdqdbyL/0so5W2Rx8oOo6I+WFCvveNfvWgHBFbC0CkM39k2VkH1IeQiJHJ+rJ8Y+E6Whk/0k3Sa9Z3qWaOW1I//QyBB2orplKbfmY9Qh98mg5uRjwbfIjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/6jO7qh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so2827474a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Aug 2025 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597813; x=1755202613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyNlNlLPqLW2teTGCuUaRtpJSFI4nGCnRDvpuq+iYmU=;
        b=h/6jO7qhg+DYLtwKq8bHfN4opyFYwcJfoSMVQkYnk8ILkayKBOMwAcg/aYkFWwwe7M
         BZCSvsOUkH567hH1ZMwrsYBqV20QWSO84FXjymms+vDIUIvj8p9nMR1hynWzlwVd1x1H
         ujLMtdEv6gVMEo1iTaUv5iuhHbI5A580Gxn5kK/DSFRHg/b2AkuvEm1dZc1Iyq0HExO3
         RyU3gpkdIcwJf4Ga/djS8HWPMAV4TvGwjItjQzTKg8wzC7WXtboIWtbXew0+wZK9VTOY
         qgdlLWVZJ/zoQAZEIft+ERBradW4clBNPxYzEb0jD5/mhLRuzCehbHrz4CSPFOU7TDFk
         kjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597813; x=1755202613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyNlNlLPqLW2teTGCuUaRtpJSFI4nGCnRDvpuq+iYmU=;
        b=U7Nbi2VeUAFK+jLMaUVB/PjO7hp3H5huG10cYH87nwJGhIu0/AqmEIhVR55NKNXbDn
         reyr8zPIUnDt+WDofJ91TrsFR8k7jarSwyLvFgvUZ7EqVhj50K4SGpAbmOnkuo4C1eNV
         kpOr7I1tzVIp5F0E0KHTVWNg9qUbO7J+DjmFSOwjGBHbLptFMSzdikegTAyTUhjXMsYC
         1u8M3UvOVNRXZvTbT7qHOsKppJ6g5J4ooCzyOz5BTG5SHPlkT9IUgpEGiBcEcqfaENee
         RQgOnrDsVdveto44MYClwBU/yN/48xa42O8Zvhoazb6Zt+WAqPRCXgzNV7NR4Mj1ysvd
         +tZA==
X-Gm-Message-State: AOJu0YymcU5ESaRzuYdLO67fI4JfuACuy68SEq6ncmtMm8SETTCEn8SA
	LtqvsCgNfqaPc0foNExLBbkwgbBHzxZKYclhc3nKKgas3vETCHOoGfbKf4POMOLZicOrL7chn1r
	PFblasE0NhuA758JWigV7oZkQWPsdfVyePq27Be4q5c5v2iC1wuhjCxND1zrVktE8nuRZPYpqC4
	5QVX+HLhxMl2iKBuL22N80pUMnBwHa3G/EiPLmqgqtxP4=
X-Google-Smtp-Source: AGHT+IFbjTzekAW0h8elEcH8qUjQZXjaXe1tt597Yy/VuMojgGTibZDORFJjs7AVlVU/OY02NfmLuCUR6Q==
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:31c:32f8:3f88])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c4:b0:312:1ac5:c7c7
 with SMTP id 98e67ed59e1d1-321839d5845mr539026a91.2.1754597812731; Thu, 07
 Aug 2025 13:16:52 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:06 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-11-sagis@google.com>
Subject: [PATCH v8 10/30] KVM: selftests: TDX: Add report_fatal_error test
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

The test checks report_fatal_error functionality.

TD guest can use TDG.VP.VMCALL<ReportFatalError> to report the fatal error
it has experienced. TD guest is requesting a termination with the error
information that include 16 general-purpose registers.

Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx.h       |  6 ++-
 .../selftests/kvm/include/x86/tdx/tdx_util.h  |  1 +
 .../selftests/kvm/include/x86/tdx/test_util.h | 19 +++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.c | 18 +++++++
 .../selftests/kvm/lib/x86/tdx/tdx_util.c      |  6 +++
 .../selftests/kvm/lib/x86/tdx/test_util.c     | 10 ++++
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 51 ++++++++++++++++++-
 7 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
index a7161efe4ee2..2acccc9dccf9 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -4,9 +4,13 @@
 
 #include <stdint.h>
 
+#include "kvm_util.h"
+
+#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
+
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
-
+void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 57a2f5893ffe..d66cf17f03ea 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -15,5 +15,6 @@ struct kvm_vm *td_create(void);
 void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
+void td_vcpu_run(struct kvm_vcpu *vcpu);
 
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
index 07d63bf1ffe1..dafeee9af1dc 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/test_util.h
@@ -38,4 +38,23 @@ bool is_tdx_enabled(void);
 void tdx_test_success(void);
 void tdx_test_assert_success(struct kvm_vcpu *vcpu);
 
+/*
+ * Report an error with @error_code to userspace.
+ *
+ * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
+ * execution is not expected to continue beyond this point.
+ */
+void tdx_test_fatal(uint64_t error_code);
+
+/*
+ * Report an error with @error_code to userspace.
+ *
+ * @data_gpa may point to an optional shared guest memory holding the error
+ * string.
+ *
+ * Return value from tdg_vp_vmcall_report_fatal_error() is ignored since
+ * execution is not expected to continue beyond this point.
+ */
+void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
index f417ee75bee2..ba088bfc1e62 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <string.h>
+
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 
@@ -25,3 +27,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 
 	return ret;
 }
+
+void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
+{
+	struct tdx_hypercall_args args;
+
+	memset(&args, 0, sizeof(struct tdx_hypercall_args));
+
+	if (data_gpa)
+		error_code |= 0x8000000000000000;
+
+	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
+	args.r12 = error_code;
+	args.r13 = data_gpa;
+
+	__tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index e2bf9766dc03..5e4455be828a 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -9,6 +9,7 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "tdx/td_boot.h"
+#include "tdx/tdx.h"
 #include "test_util.h"
 
 uint64_t tdx_s_bit;
@@ -603,3 +604,8 @@ void td_finalize(struct kvm_vm *vm)
 
 	tdx_td_finalize_mr(vm);
 }
+
+void td_vcpu_run(struct kvm_vcpu *vcpu)
+{
+	vcpu_run(vcpu);
+}
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
index 7355b213c344..6c82a0c3bd37 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/test_util.c
@@ -59,3 +59,13 @@ void tdx_test_assert_success(struct kvm_vcpu *vcpu)
 		    vcpu->run->io.port, vcpu->run->io.size,
 		    vcpu->run->io.direction);
 }
+
+void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa)
+{
+	tdg_vp_vmcall_report_fatal_error(error_code, data_gpa);
+}
+
+void tdx_test_fatal(uint64_t error_code)
+{
+	tdx_test_fatal_with_data(error_code, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index fdb7c40065a6..7d6d71602761 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -3,6 +3,7 @@
 #include <signal.h>
 
 #include "kvm_util.h"
+#include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 #include "test_util.h"
@@ -24,7 +25,51 @@ static void verify_td_lifecycle(void)
 
 	printf("Verifying TD lifecycle:\n");
 
-	vcpu_run(vcpu);
+	td_vcpu_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
+void guest_code_report_fatal_error(void)
+{
+	uint64_t err;
+
+	/*
+	 * Note: err should follow the GHCI spec definition:
+	 * bits 31:0 should be set to 0.
+	 * bits 62:32 are used for TD-specific extended error code.
+	 * bit 63 is used to mark additional information in shared memory.
+	 */
+	err = 0x0BAAAAAD00000000;
+	tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_report_fatal_error(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_report_fatal_error);
+	td_finalize(vm);
+
+	printf("Verifying report_fatal_error:\n");
+
+	td_vcpu_run(vcpu);
+
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_TDX_FATAL);
+	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 16);
+
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], 0x0BAAAAAD00000000);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[13], 0);
+
+	td_vcpu_run(vcpu);
 	tdx_test_assert_success(vcpu);
 
 	kvm_vm_free(vm);
@@ -38,9 +83,11 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(1);
+	ksft_set_plan(2);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
+	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
+			 "verify_report_fatal_error\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


