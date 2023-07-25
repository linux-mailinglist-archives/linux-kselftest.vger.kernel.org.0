Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAD76257B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGYWDZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGYWDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9763A30D3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d10792c7582so2710238276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322530; x=1690927330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7vlZD+RUk2FGmTNk7BRuTBX431dlCK831LenR/2EDtE=;
        b=alGLUCOnoKqSiWsrW9zvpPlJgtI0T81njbsib8dWXCTqfeEyUAkoAm0KQygYn7baaT
         LbLLC0Jccyp4U8EMYxjMOK74zlJgG8AnLVH5PVivthTCe/YwKZ7uxE4tkJJ/1WwjJf9n
         s9Yux7ERL+jJbEsKMVw+k+Xv2rPzqzuGbizzUIvaFvWDnRYZwuxInLyko2CXhTRzCWu0
         oSU2kpcd+PQKDFcLyRKBFHOtO6MK2Me1+nfXEDdMEkgtn5JDZLoNB9vKgs/rGTC0hPgC
         VjT9lXZjUmgiDDzjXV9quyVx30PYuHAF2b0lSCD1f7qlpbT3yaUjRVPjuJ/TBhlsDqVK
         92tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322530; x=1690927330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vlZD+RUk2FGmTNk7BRuTBX431dlCK831LenR/2EDtE=;
        b=CtS39NgtAbgeEwEUExEuWTROPPR1Q1Fv1dabcr2ZMi3+2FVCyDQMd9YUPchXaXs1/R
         a0vXRa5iNzeZ9SFanPoRgvkcxDj4zghl3pRrc0qJDYo09lCY26hRdMDLYNltCXjG6/Vt
         KHV+yecLGRg6zL5cMwQ1IZG5FSCN/We5kvMeIJ4cKKJNniqqGPxqvzy8m1qMgG/Cg9GY
         vS1Wr7T4bB0ysu5aqYr7fA8DbBKIpNBTFrPypbD3FuiQ2rsx0bx2EagfkqMPh4FK9W6g
         Xzpv9EOMau/ZoCyandYpcQTMg6Ii5TfwZy1Pn24/A9uEoOWPW5MycUp86jTHejpJjnoJ
         8EuQ==
X-Gm-Message-State: ABy/qLaWJ9uop9iRJ3gCod+20mfCm65ggHAeV/I+Y5io+fPsAOT/bWwZ
        wok5aq1ll+rYFVUXDot3PfiG8oMkh5YGJt7DLByBtTlbfr+1DzVYVfDk5EC3e3wgYjZXAeQ3WZD
        pu/rfw2WVQWNcH23kEtpHcfXQcwdr/l3i6VCgzV/GcwDiqwQQirnDMmoF8BPDpsPeZRRXH7bKCt
        hB
X-Google-Smtp-Source: APBJJlER0hruaGOyUvkJom6G95REkZZ55wFPOzpLZDBX5XHD5rGLd81BdrzTpLajV9nrCE/JWWbLat9Fyujh
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:74d3:0:b0:d09:b19:fe2c with SMTP id
 p202-20020a2574d3000000b00d090b19fe2cmr1452ybc.12.1690322530103; Tue, 25 Jul
 2023 15:02:10 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:05 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-13-afranji@google.com>
Subject: [PATCH v4 12/28] KVM: selftests: TDX: Add basic get_td_vmcall_info test
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Change-Id: I6906de835f20c5f48181b6a0734131fa9b62246d
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  3 +
 .../kvm/include/x86_64/tdx/test_util.h        | 27 +++++++
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 23 ++++++
 .../selftests/kvm/lib/x86_64/tdx/test_util.c  | 46 +++++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 80 +++++++++++++++++++
 5 files changed, 179 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 1340c1070002..63788012bf94 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -5,6 +5,7 @@
 #include <stdint.h>
 #include "kvm_util_base.h"
 
+#define TDG_VP_VMCALL_GET_TD_VM_CALL_INFO 0x10000
 #define TDG_VP_VMCALL_REPORT_FATAL_ERROR 0x10003
 
 #define TDG_VP_VMCALL_INSTRUCTION_IO 30
@@ -12,5 +13,7 @@ void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu);
 uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
 				      uint64_t write, uint64_t *data);
 void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa);
+uint64_t tdg_vp_vmcall_get_td_vmcall_info(uint64_t *r11, uint64_t *r12,
+					uint64_t *r13, uint64_t *r14);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index af0ddbfe8d71..8a9b6a1bec3e 100644
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
index b854c3aa34ff..e5a9e13c62e2 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -64,3 +64,26 @@ void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
 
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
index 36d2647210da..5ef0429fca5d 100644
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
index d68ace3db097..9e9c3ad08a21 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -260,6 +260,85 @@ void verify_td_cpuid(void)
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
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r11 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r12 value */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r12 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r13 value */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r13 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	/* Wait for guest to report r14 value */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	r14 = tdx_test_read_64bit_report_from_guest(vcpu);
+
+	ASSERT_EQ(r11, 0);
+	ASSERT_EQ(r12, 0);
+	ASSERT_EQ(r13, 0);
+	ASSERT_EQ(r14, 0);
+
+	/* Wait for guest to complete execution */
+	td_vcpu_run(vcpu);
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
@@ -273,6 +352,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_report_fatal_error);
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
+	run_in_new_process(&verify_get_td_vmcall_info);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

