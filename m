Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F184676212
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUARh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjAUARa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3BC63BE
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d21-20020a25add5000000b007ff8112e8b8so5532686ybe.17
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GFYGGx0+c/JTGAK76bVwpACnJQuQ5mSfW/fyx26JT0=;
        b=HumOf0ifUS3YfnDJXNhoBdtmg9FJoE6wlCqVa+T161sRt1hq9HViWgqfj58zoHAvEy
         N1gnFBZrQ+eGpdu4uvsajl/JhWzXFRMweDw5B7cLPR2DetJwNStCJNUgHTshrQrqn/vM
         6p1U06lQUhSYRltYVveoaOS4Hm0lQTnA1D6DxIbA+JYpeR8ooszyhN+GlEG6BzICjwNv
         +Ov1qZ1buIRk1iuCpq0nxacfe1z0jB4LFQWwjPz2eS+q/R+IyU6HXcVuSRHKiu66/7N9
         JdQZshBP4SEBmSt+Y+2useYdIsEUupcBJJkbyA1JiDKDDwa+LNl7fHz4T6gjSu5w/J6V
         SNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GFYGGx0+c/JTGAK76bVwpACnJQuQ5mSfW/fyx26JT0=;
        b=p9YyvAIWrWTse7aN3j7QKFPwvLvap63rwj0Zzn+kCZ1dwkYcNuiTpScM/ALbR1/iil
         V4WiCqHZ55fNvSzjmnqhqyy2Q6oncmnElnODoR3v/fIRDRm/F3EeW/VCQS/8nNy7EvK8
         6hJhJZ6VJOL9iAfu2q4CzwQSVLv7TMMzCpYMpL9qWjKOuhzuk+BRDK6Cb6VKES8tb4Rt
         hBR2BXCPAitR/aUOsr9yCwDY94cinUd7y1Pwd16oNd1ha44uaT6XESzNmuurtlkskctd
         chbZXZmn+RbcX9/ThYtsOoq9cbSS/49NVv6LAiwbAESk+JTj+mo1AhMAwddhjzQT5S2T
         LYfg==
X-Gm-Message-State: AFqh2kobea8RqOHQ/YQ8aUIegazbfjLZ4h1lkBU7jIfbURY6xxnpwjDe
        aVnQZOUgSiRkEalD3JhjDUTzUDRUaQMHyHqwtCzr1wMTPcPtTb9S4hzeIUkKTZTUmBE8+KMIRL4
        Mapth22QB39L2uV/OhaUtxlVG28nsOREReTT0zjaXg2rifUYNszSGw7bXlePp5g94ZraD+wmBH1
        Z2MMFntKWp6sQ=
X-Google-Smtp-Source: AMrXdXtzwGmgyX9XH8aXpbr891TmJe7G0QtxHKbFHE3C/5WFHHCdxWQnUZ0bfAsxZqyreJBq9m1qDrFhBr37yEpLuw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:8f:b0:800:748:7d05 with SMTP
 id h15-20020a056902008f00b0080007487d05mr683891ybs.15.1674260215175; Fri, 20
 Jan 2023 16:16:55 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:21 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-11-ackerleytng@google.com>
Subject: [RFC PATCH v3 10/31] KVM: selftests: TDX: Add report_fatal_error test
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test checks report_fatal_error functionality.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 ++
 .../kvm/include/x86_64/tdx/test_util.h        | 19 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 18 ++++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 10 +++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 44 +++++++++++++++++++
 5 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index a7161efe4ee2e..28959bdb07628 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -4,9 +4,12 @@
 
 #include <stdint.h>
 
+#define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
+
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
 
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
+void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index b570b6d978ff1..6d69921136bd2 100644
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
index c2414523487a7..e8c399f2277cf 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
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
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
index 6905d0ca38774..7f3cd8089cea3 100644
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
index a18d1c9d60264..627d60b573bb6 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
 #include "test_util.h"
@@ -30,6 +31,48 @@ void verify_td_lifecycle(void)
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
+	vcpu_run(vcpu);
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
@@ -40,6 +83,7 @@ int main(int argc, char **argv)
 	}
 
 	run_in_new_process(&verify_td_lifecycle);
+	run_in_new_process(&verify_report_fatal_error);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

