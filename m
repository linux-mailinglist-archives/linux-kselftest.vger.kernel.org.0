Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D7567621D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjAUASG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjAUARw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:52 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7148BA92
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:28 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4fa63c84621so64446537b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfDFJ+/iyxAI3PGD3pUrIdU4TyKMDMQ1v8Rnr8gjcS8=;
        b=Ow7xLTNJ7rWpBHPrW8eCRek9b8bCgS2hzG4Hq0bJ5VO+ckVuiDumEDCCpEmhHJ4XHr
         3rpwqyxkvQJMn76f2v+MmT8l2gC5Z7ueLnbbKv8iar3hP82Tppw00KfoZs5K3Pj+6rJA
         ZZmx53VNnB8yqA01NJ1jsRgThA4aw/MRMW/f+xyoyxOQKNPacLBO7ncB/IybPvuroSxi
         z2afvFEE4hCDP3dhztAfsVnrg0qJ+MlrsI0Mw47HmPbRefUb/bkvyj9EB5VSirVgeKsl
         RKFLa+EcCHFo78XkadVcuetutuQO003GEBZc0UIYfoPf2QfzmwNBFldGfFXHTnBKJ24T
         E2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfDFJ+/iyxAI3PGD3pUrIdU4TyKMDMQ1v8Rnr8gjcS8=;
        b=hhQufFv6Tjrt0u0uZJWiF4DjUL1hCaOXSLWp0xMdd50TUmaA/WostN6SGoE8/Ujw+m
         2PAQPMVzxjj6Q+zf+cL/n7FXawmOVf2Ftv7NfcyWcauvF82rFUGvAGRdqs7Tg16iqxh8
         6gYhkgVSFCLlSYSkSYy6QDzT8fEZNrb2LOkGIqhyy3VMmHclBj4H3CLBO4nduRa1eUYT
         WZ9XUlybroAQAI8hJs+HAh04FT3xtXPI+NuKqzUUfGoEbVaeiEwXDhbnfsFhnrXlAHlc
         rG8B46UmeNl0vMTjvSfEksdl5nrApnigzV/ToVGJ/7356K5jYYbmtKFLiRgFfVpSczQJ
         BUGg==
X-Gm-Message-State: AFqh2kpx91TA/cZagwJzpQFMqZKBgCbIVa2nH3wM97vXOvcXZ2Gnme7L
        I72Pfr0+BMZeGiSmJKCZKB0JG2sM0B4h37eajURsSP8plBpfD/ZT2e1krceGMjKAgfscYD7Nrss
        ZpWTbPMOWqxltBpKBqd5b6Xz3bqlum0beoEBCbr4YZgwoOPvDsaVc6vd5A86T1GLn8USnrx3Gd7
        7z100GQhP97JY=
X-Google-Smtp-Source: AMrXdXtHeebCqRs3GM2cU8NHHPkaoFTXq7tzkkWCUQxlXI7dZnOWhcvQvwmKfOZnQB6MDB+5e5ExBanwRiPWIgzekA==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:7189:0:b0:360:7f0a:1620 with SMTP
 id m131-20020a817189000000b003607f0a1620mr2245734ywc.192.1674260228807; Fri,
 20 Jan 2023 16:17:08 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:24 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-14-ackerleytng@google.com>
Subject: [RFC PATCH v3 13/31] KVM: selftests: TDX: Add basic
 get_td_vmcall_info test
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Sagi Shahar <sagis@google.com>

The test calls get_td_vmcall_info from the guest and verifies the
expected returned values.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
 .../kvm/include/x86_64/tdx/test_util.h        | 27 +++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 23 ++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 46 +++++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 80 +++++++++++++++++++
 5 files changed, 179 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 28959bdb07628..37ad16943e299 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -4,6 +4,7 @@
 
 #include <stdint.h>
 
+#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
@@ -11,5 +12,7 @@
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
+uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+					uint64_t *r13, uint64_t *r14);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index af0ddbfe8d71b..8a9b6a1bec3eb 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 
+#include "kvm_util_base.h"
 #include "tdcall.h"
 
 #define TDX_TEST_SUCCESS_PORT 0x30
@@ -111,4 +112,30 @@ void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
  */
 uint64_t tdx_test_report_to_user_space(uint32_t data);
 
+/**
+ * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call.
+ *
+ * Data is sent to host in 2 calls. LSB is sent (and needs to be read) first.
+ */
+uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data);
+
+/**
+ * Report a 64 bit value from the guest to user space using TDG.VP.VMCALL
+ * <Instruction.IO> call. Data is reported on port TDX_TEST_REPORT_PORT.
+ */
+uint64_t tdx_test_report_64bit_to_user_space(uint64_t data);
+
+/**
+ * Read a 64 bit value from the guest in user space, sent using
+ * tdx_test_send_64bit().
+ */
+uint64_t tdx_test_read_64bit(struct kvm_vcpu *vcpu, uint64_t port);
+
+/**
+ * Read a 64 bit value from the guest in user space, sent using
+ * tdx_test_report_64bit_to_user_space.
+ */
+uint64_t tdx_test_read_64bit_report_from_guest(struct kvm_vcpu *vcpu);
+
 #endif // SELFTEST_TDX_TEST_UTIL_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index e8c399f2277cf..7254d61515db2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -43,3 +43,26 @@ void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
 
 	__tdx_hypercall(&args, 0);
 }
+
+uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+					uint64_t *r13, uint64_t *r14)
+{
+	uint64_t ret;
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_GET_TD_VM_CALL_INFO,
+		.r12 = 0,
+	};
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
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
index 55c5a1e634df7..3ae651cd5fac4 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/test_util.c
@@ -7,6 +7,7 @@
 #include <unistd.h>
 
 #include "kvm_util_base.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/test_util.h"
 
@@ -53,3 +54,48 @@ uint64_t tdx_test_report_to_user_space(uint32_t data)
 					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
 					&data_64);
 }
+
+uint64_t tdx_test_send_64bit(uint64_t port, uint64_t data)
+{
+	uint64_t err;
+	uint64_t data_lo = data & 0xFFFFFFFF;
+	uint64_t data_hi = (data >> 32) & 0xFFFFFFFF;
+
+	err = tdg_vp_vmcall_instruction_io(port, 4,
+					   TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					   &data_lo);
+	if (err)
+		return err;
+
+	return tdg_vp_vmcall_instruction_io(port, 4,
+					    TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					    &data_hi);
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
+	TDX_TEST_ASSERT_IO(vcpu, port, 4, TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	lo = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	vcpu_run(vcpu);
+
+	TDX_TEST_ASSERT_IO(vcpu, port, 4, TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
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
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index b6072769967fa..188442a734dca 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -259,6 +259,85 @@ void verify_td_cpuid(void)
 	printf("\t ... PASSED\n");
 }
 
+/*
+ * Verifies get_td_vmcall_info functionality.
+ */
+void guest_code_get_td_vmcall_info(void)
+{
+	uint64_t err;
+	uint64_t r11, r12, r13, r14;
+
+	err = tdg_vp_vmcall_get_td_vmcall_info(&r11, &r12, &r13, &r14);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r11);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r12);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r13);
+	if (err)
+		tdx_test_fatal(err);
+
+	err = tdx_test_report_64bit_to_user_space(r14);
+	if (err)
+		tdx_test_fatal(err);
+
+	tdx_test_success();
+}
+
+void verify_get_td_vmcall_info(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint64_t r11, r12, r13, r14;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_code_get_td_vmcall_info);
+	td_finalize(vm);
+
+	printf("Verifying TD get vmcall info:\n");
+
+	/* Wait for guest to report r11 value */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r11 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r12 value */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r12 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r13 value */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r13 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r14 value */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r14 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	ASSERT_EQ(r11, 0);
+	ASSERT_EQ(r12, 0);
+	ASSERT_EQ(r13, 0);
+	ASSERT_EQ(r14, 0);
+
+	/* Wait for guest to complete execution */
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -272,6 +351,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
+	run_in_new_process(&verify_get_td_vmcall_info);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

