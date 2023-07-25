Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDA762570
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGYWDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjGYWCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:54 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CB62D69
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:25 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56336f5dc6cso2586737a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322525; x=1690927325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aE9RwmKCgL9c46YOClXa+30MDuO7TC9exkJBbLFwsuI=;
        b=tQLeYWOiPGX9SrjWyL1zjuPn06Nx0s4hysuv7ndAw8sNy0K7NFZ8fY1MgntwtOaCg+
         cCuKcEDVFD6h4hX11PnmP8Ariga0L47qQgUyB6jdBEQh7/zsFsw0JEF9tly02imcV9FQ
         ShChn+TsPeWVHlSY3OZP3gQbeQ/8bOh1QEOxG2B8ccIUw/oo5j80OhUzgeUixvLtF9w3
         Fj01R+QFXmvgb4zy8bEVsDT0iCop8sET/OpbRTf1fSrSiBoGvzLvZMS6LqMB0XwnxvHJ
         tEQZ3716fBh6WpKVuetkzmJYplO2slBqqrleKTIbhLIZcVlnewijo41twpuA1qeO7uKG
         zYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322525; x=1690927325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE9RwmKCgL9c46YOClXa+30MDuO7TC9exkJBbLFwsuI=;
        b=Y3zvqvVCkl6zADQHRVmcwr15MxWXnMQ86LndDXbH50j5tPcxgKt8j4xVvFu4sPAgLm
         5H/wv4iW8thm67VlyufV71ACAAWP0q5pGzNVJ0IxmeLwBXN5PPsBmqLjl7DdD/YC2k8M
         Y8esHEBrD5v6nZI2ojwPszbwYDxA+YdDnsYHxtPIfO9RkcMNVuk06JUvLyxnSpAw8r7W
         UfifvEef9A5wQayZfdiMKj67X+D8V+kyLD4j8HB1+QCGv06ZR52oL8gi1FT2a0LvREoV
         KUU/wEeu93OXuy2K6eq9n7MMV5eHuDkz/xmhvSnqb+RUrweH18hd7OrPJFUDa+DDWDXm
         hd5Q==
X-Gm-Message-State: ABy/qLa8lnUQEGKZNJ2Zdw4OL+ExZ0x8Dq8E7T7/2jrB/ZGmYicFwZ2N
        mv8hBYSFnIfPwtKXR+lWpgPUPsDh3uycxVWIlws8765Rlm28p8QD+OBSvJL/SZMYoTVEoVJ3d9l
        L7FHm8TDgUFx3s1RV9WnDRwDwAqIUqUg13Eh78+zNF1wgn4DXlx7SKHpa28nbpDdCQbEatVmnWP
        Sc
X-Google-Smtp-Source: APBJJlEFWmwDPhkA68gUjCd6V5BUg42wkYkyYry5aZyJDuPHQ9pl1MWoyD4MM5B3zywYqR3yLQe5al5/3pzu
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:7e1a:0:b0:55a:e746:31ef with SMTP id
 z26-20020a637e1a000000b0055ae74631efmr2402pgc.1.1690322524316; Tue, 25 Jul
 2023 15:02:04 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:02 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-10-afranji@google.com>
Subject: [PATCH v4 09/28] KVM: selftests: TDX: Add report_fatal_error test
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test checks report_fatal_error functionality.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I1bf45c42ac23aa81bb7d52f05273786d5832e377
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
index 4ebb8ddb2a93..c8591480b412 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util.c
@@ -10,6 +10,7 @@
 
 #include "kvm_util.h"
 #include "test_util.h"
+#include "tdx/tdx.h"
 #include "tdx/td_boot.h"
 #include "kvm_util_base.h"
 #include "processor.h"
@@ -526,3 +527,14 @@ void td_finalize(struct kvm_vm *vm)
 
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
index f63d90898a6a..0419c3c54341 100644
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
index a18d1c9d6026..7741c6f585c0 100644
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
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.ndata, 3);
+	ASSERT_EQ(vcpu->run->system_event.data[0], TDG_VP_VMCALL_REPORT_FATAL_ERROR);
+	ASSERT_EQ(vcpu->run->system_event.data[1], 0x0BAAAAAD00000000);
+	ASSERT_EQ(vcpu->run->system_event.data[2], 0);
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
2.41.0.487.g6d72f3e995-goog

