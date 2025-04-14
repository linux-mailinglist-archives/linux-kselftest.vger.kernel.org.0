Return-Path: <linux-kselftest+bounces-30774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC99A88E47
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 23:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28ABA1897C7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 21:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B5A20E704;
	Mon, 14 Apr 2025 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmcJFIXG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A551F4186
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667335; cv=none; b=raf4L3lnsZCTl6bLmq1tN75P/Fp99PNb/PkhIZfNik7AWCLld1rhLk+3g/IoRoRaZNPdux8sd1bGeNIdU/VfvnM2U414LwudQPndWG3hC+UMHjyv8q6st85g4C1hZAsA5s1aN8ded3+krmrQA1bt9gNhfA7KeXYeg80sm90gkQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667335; c=relaxed/simple;
	bh=NLHWzeAXP8QXcsYRmgvxVYmmcllgyVWW4RiszB6ZZs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WbiaxcRZM5IzrzaPSkp3PfXnqCr9sWfw6zfHfpfPGt3TlR6L4nJ0hCbqAP8PoI2Yp37gXHjXWodNXJQfMs1F/zgdAHTabvUuxbiBCY922AXAF2eVgBuITCN07tNQFFi8tyJUv02heDC163SEypg8R+6Dxa2p9GSuWX7kK/ASWag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QmcJFIXG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso4145345a91.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667333; x=1745272133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rd0rJF2kGHf/7VCvSMZoXCcDskG8U5j6kBDrK+y/LVI=;
        b=QmcJFIXGeC/LT887Ola+XGBRD9QozWjMg2y5aM8xqrOKj1IL0msn09QZuVBbJ5WvyR
         52VvdKiyDagi6vJH/bMlcoVHwLWaBsBTTsl6BT4UFtWxm0rUkts+rsddiNAdZU1QSgYU
         k6mhRSb2XKMfu/pX6pxEdEi003OFL92+iui5+ictn05bQv+Pvh1clRgLWwtFEqobMerG
         b65uIvgFMuBVpRUGvc1iOCCWuoXwVLa0LDqpwTNUxFNlBzieoNfIfnqHyJZA/7ShAhIe
         B7WPzLFRjPbH9JHZsnPueESeFx8APV0jfYpKYISvcoiHLHNv/jJZycL+iIlki2tzuPkG
         0DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667333; x=1745272133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rd0rJF2kGHf/7VCvSMZoXCcDskG8U5j6kBDrK+y/LVI=;
        b=irNkjPfTjAyR/oP8mfN005SZ7bs1Q+sCbDPnDjmUjfPbOsaoHgAvI0wirj28SmbYh4
         o384lth2WOI4SjEtVnWdZ6qlIDxEwwK7GZqt78z574D0plMziY0FmBf1vuN8LMacIPcM
         cTDIWxrPydTJUDYz8/Lg/W/l2DjQva+Ec6b3Twf0BnXMHRf88J5LmWWy40SyBfkJX58p
         NJ/2fkmbsOZGvV1upuRgyZCZUJqiZ4BUKLT0NR1Pljamr7cQyPliURqShz76iqzQQ0yZ
         gliLGP4JuAtb21QCB0sfzndN9KRGkW5y4ei5yy5YMXL1s0SWpYrp+WcraES0tqlJStmz
         U/qg==
X-Gm-Message-State: AOJu0Yy5n6NAV6jYycpLukPabPwMxXp28AyYWjTz8Ldm3jPaXeh3sOmC
	WxRC29cXqQkuXR4j/hGHgyHpOpnKpa7JI+8z0ciSmo3Xw9VghJdzmwvj2DrjB26XTwAe67X1qf+
	TeDmnpSTbjif0qZSwESq7dqoPulbQ5cTxeWogEnEbSDC0x/6+NefxOReCuwAaAjqN04i5pwpYe0
	bcxc3FyQiB8136OAMfio/4AO4k4bAOnOYzfZJyj/U=
X-Google-Smtp-Source: AGHT+IHWw3LhdtSqGKah2VyQJVLgKYm6rOxPgChAAijNnvKbG2IzW6EHYfFjo2SPhh2/G7AzUtkrXRL6rg==
X-Received: from pjbkl8.prod.google.com ([2002:a17:90b:4988:b0:2ff:611c:bae8])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f944:b0:2f2:ab09:c256
 with SMTP id 98e67ed59e1d1-308237cf269mr22290161a91.33.1744667333046; Mon, 14
 Apr 2025 14:48:53 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:39 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-11-sagis@google.com>
Subject: [PATCH v6 10/30] KVM: selftests: TDX: Add report_fatal_error test
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
2.49.0.504.g3bcea36a83-goog


