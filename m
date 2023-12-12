Return-Path: <linux-kselftest+bounces-1732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917580F82D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 21:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A84B2103E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4123564CEF;
	Tue, 12 Dec 2023 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPRLD/5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ECA130
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db402e6f61dso6604482276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702414034; x=1703018834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oFTGXJSfXzvmAiUKHB1pxE3R2ft6C/AFFmYxuAN1SU=;
        b=BPRLD/5AcaZNr3sl5dDtSeY85u43bWQ4HvzL5a8LoS/M26cJC0NoBQB3bJuXI1hHrI
         fTfroUu0cD/rXpb4/szYY03ZUosEHoWR25fJbybaOZAQ0lXGiWYW0Cq0RUnNq3LvNO0x
         /qcZH+p4QMcMJzea8ADO6g5HmOvhx5YTJudr5H3LTC0nNOiTss44kBXenfpqSaPn6qus
         JIMuTALYeR3MMaQ2dRjNu8JGFCR+z8DAU4TdNtV3ceGKSlM3cGrR3c2jZs8N5At/riZ1
         02gsFBb3vxovO5OP25+69dc744V/HXa90syu/fzveUiukcpeETKVd6l7ohUr+6SJqSpx
         iECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414034; x=1703018834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oFTGXJSfXzvmAiUKHB1pxE3R2ft6C/AFFmYxuAN1SU=;
        b=Ted/AhCPsUJOe8lLag1DnMWyC/yl9uklSJ0BALLX0jOEghyKha2ocsaZR+7qxEEXjs
         PdTpuz5Yut6HQ8IucbUTrzVuD5e2UfS5LCr/b1U5XxK6ukNAgSfNBCmSo1wjO1HOv+1k
         K/LCLLzSV06h17kU6mo2aBRhj3QSs5TDf6QikbNLb88R3UDn+LBeT1rPpwOnXC6aVpXH
         NxE5RyMF7z+A1Y60AF9GC2m8cpG8/jxfEKtRnYgQQmVfSFlJn2pvt9+uZdm1Q9eZk56i
         vsYje/iozrTqemWX3fK5LPljhZ7OlrEBIMAjWYJo6NbcFFxU4DjV1AIGUBMMC2psQucA
         jE6A==
X-Gm-Message-State: AOJu0YwknsXj8mnZhGx6JX/74MhVyGZx0Y/VR4yQ6heEyg0Sy8nhAD/5
	G7fMRLibMD1yIl+8izl7LHZ0pnOk41HoXgz9US25jDP4pWbulOoLSPJUDaHj8sTu5NqlG6I4H+h
	p9DNnDrZq8LzJkMEYRXxG+3D/eXRqQVT5xg3WyTTvZnXGnPNXqfGEMvUrsk+Ye5XlPGyZYWU=
X-Google-Smtp-Source: AGHT+IH1CLpwDkXuT03kJZbZTidbw2/KYLzIyeXPtVSMdlpNxfO/0gpo4qDYnGFJLOXAxqIBuWzxiNFWcQ==
X-Received: from sagi.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:241b])
 (user=sagis job=sendgmr) by 2002:a05:6902:534:b0:db4:6936:48b7 with SMTP id
 y20-20020a056902053400b00db4693648b7mr58935ybs.2.1702414033563; Tue, 12 Dec
 2023 12:47:13 -0800 (PST)
Date: Tue, 12 Dec 2023 12:46:24 -0800
In-Reply-To: <20231212204647.2170650-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231212204647.2170650-10-sagis@google.com>
Subject: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error test
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

The test checks report_fatal_error functionality.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  6 ++-
 .../kvm/include/x86_64/tdx/tdx_util.h         |  1 +
 .../kvm/include/x86_64/tdx/test_util.h        | 19 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 39 ++++++++++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   | 12 +++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 10 +++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 45 +++++++++++++++++++
 7 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index a7161efe4ee2..1340c1070002 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -3,10 +3,14 @@
 #define SELFTEST_TDX_TDX_H
 
 #include <stdint.h>
+#include "kvm_util_base.h"
 
-#define TDG_VP_VMCALL_INSTRUCTION_IO 30
+#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
+#define TDG_VP_VMCALL_INSTRUCTION_IO 30
+void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
+void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
index 274b245f200b..32dd6b8fda46 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx_util.h
@@ -12,5 +12,6 @@ struct kvm_vm *td_create(void);
 void td_initialize(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		   uint64_t attributes);
 void td_finalize(struct kvm_vm *vm);
+void td_vcpu_run(struct kvm_vcpu *vcpu);
 
 #endif // SELFTESTS_TDX_KVM_UTIL_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index b570b6d978ff..6d69921136bd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
  */
 void tdx_test_success(void);
 
+/**
+ * Report an error with @error_code to userspace.
+ *
+ * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
+ * is not expected to continue beyond this point.
+ */
+void tdx_test_fatal(uint64_t error_code);
+
+/**
+ * Report an error with @error_code to userspace.
+ *
+ * @data_gpa may point to an optional shared guest memory holding the error
+ * string.
+ *
+ * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
+ * is not expected to continue beyond this point.
+ */
+void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index c2414523487a..b854c3aa34ff 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -1,8 +1,31 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <string.h>
+
 #include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 
+void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
+	uint64_t vmcall_subfunction = vmcall_info->subfunction;
+
+	switch (vmcall_subfunction) {
+	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
+		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+		vcpu->run->system_event.ndata = 3;
+		vcpu->run->system_event.data[0] =
+			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
+		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
+		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
+		vmcall_info->status_code = 0;
+		break;
+	default:
+		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
+			  vmcall_subfunction);
+	}
+}
+
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data)
 {
@@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 
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
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
index b302060049d5..d745bb6287c1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -10,6 +10,7 @@
 
 #include "kvm_util.h"
 #include "test_util.h"
+#include "tdx/tdx.h"
 #include "tdx/td_boot.h"
 #include "kvm_util_base.h"
 #include "processor.h"
@@ -519,3 +520,14 @@ void td_finalize(struct kvm_vm *vm)
 
 	tdx_td_finalizemr(vm);
 }
+
+void td_vcpu_run(struct kvm_vcpu *vcpu)
+{
+	vcpu_run(vcpu);
+
+	/* Handle TD VMCALLs that require userspace handling. */
+	if (vcpu->run->exit_reason == KVM_EXIT_TDX &&
+	    vcpu->run->tdx.type == KVM_EXIT_TDX_VMCALL) {
+		handle_userspace_tdg_vp_vmcall_exit(vcpu);
+	}
+}
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
index 6905d0ca3877..7f3cd8089cea 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
@@ -32,3 +32,13 @@ void tdx_test_success(void)
 				     TDX_TEST_SUCCESS_SIZE,
 				     TDG_VP_VMCALL_INSTRUCTION_IO_WRITE, &code);
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
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index a18d1c9d6026..8638c7bbedaa 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 #include "test_util.h"
@@ -30,6 +31,49 @@ void verify_td_lifecycle(void)
 	printf("\t ... PASSED\n");
 }
 
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
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+void verify_report_fatal_error(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
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
+	TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 3);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[0], TDG_VP_VMCALL_REPORT_FATAL_ERROR);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD00000000);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[2], 0);
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
@@ -40,6 +84,7 @@ int main(int argc, char **argv)
 	}
 
 	run_in_new_process(&verify_td_lifecycle);
+	run_in_new_process(&verify_report_fatal_error);
 
 	return 0;
 }
-- 
2.43.0.472.g3155946c3a-goog


