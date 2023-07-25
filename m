Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F90762573
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGYWDU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGYWCz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A8026A2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:27 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-563396c1299so5285102a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322526; x=1690927326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYoHm0187aVmMw5EiDV+/p+2G+Xcv8nQ5x5t2ykYALE=;
        b=o9opizQ/zFXQRV698u1ycbrvblnr5KccskgEOwKZQlXXsWJ1w6iUyEudiYlYoQajbS
         CHQ+vAlzO5mCwMES0DP46gbtmmpkTzGj3VGX4qqNr/zJLdX4EfRwCMnKAz4dUt37qmAQ
         cY0pRMohOpsgFPn1kMssCyV9XOAHsvOD6duXPWOIqRPF14HHR/bEfglENkfK0fQj9zXn
         DqzXTQCxHCzYcTYvR+36DC2InogaTYFR39Oct6lRsyt18FWUkt7k+n8cml+DCIs01TFP
         DiyCHp/a4y4tMLjRm3sA19nOMVWY+1uhemHpkY1dG9rNqWGwn64MUs2Bpg6UoEcR00m1
         qraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322526; x=1690927326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYoHm0187aVmMw5EiDV+/p+2G+Xcv8nQ5x5t2ykYALE=;
        b=L4UWZGyPhBcqbePW9kr3Wtdb9B+L+xIyme5aJ93pLIsVdHfAyrgfHenOQpP9+GJAfo
         VZWfGw5ngxiT8ex/fTAkKI0z/ObmalOlSC43Px9y5idi57XpYEMuEr8QHjqnl2nyhfI+
         XONddZe/VFA3tCbYVRNesW/bM6jDfrJkbetmTOwWEsbQgplVUG+V8BVBkTkA5ziWVVN4
         4hhezxU7UHuLRj5T8FHIL7KmH5HlWTH087UrQiyEuvHarh7cgrg34JbR/JdiBSNmpost
         rLrIxoMWvxSTzx4FXJKgLBCHz1yYryOXVF0Cciv63LVRQt52BXROFogMtygDZktaZsZx
         vkqw==
X-Gm-Message-State: ABy/qLZuODJwgLnRGqIJEwo6gej1sjQu+pqJpf5YzWDpIeux/gjJMTsF
        Ekz63H9UDBhiMpKS/CZDpeKNNDUAqgBDar0ZWFvRrfLDQTd8swyNgmDHXvmmR6PSqPJD8hvuv4L
        K+81FVRgPbcjtw15nEgnpMbC1Q+KhDFbsbZx6OWD4/ZZUb9FWb+EHmB20Vxj7qQZdqnYlZqqZIV
        /V
X-Google-Smtp-Source: APBJJlEsog4CFBvvxPJK0n0TDEbg1vP3bg49dw8C2QIvi1Dc5wqkX3+cnEuJWlG5G4cD3gyJicbkuLBqAk/p
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:7548:0:b0:563:d407:55d1 with SMTP id
 f8-20020a637548000000b00563d40755d1mr2407pgn.11.1690322526162; Tue, 25 Jul
 2023 15:02:06 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:03 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-11-afranji@google.com>
Subject: [PATCH v4 10/28] KVM: selftests: TDX: Adding test case for TDX port IO
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

From: Erdem Aktas <erdemaktas@google.com>

Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I03efbb2fc69fd9de08d537a26a980792de79c72b
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 6d69921136bd..95a5d5be7f0b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
@@ -9,6 +9,40 @@
 #define TDX_TEST_SUCCESS_PORT 0x30
 #define TDX_TEST_SUCCESS_SIZE 4
 
+/**
+ * Assert that some IO operation involving tdg_vp_vmcall_instruction_io() was
+ * called in the guest.
+ */
+#define TDX_TEST_ASSERT_IO(VCPU, PORT, SIZE, DIR)			\
+	do {								\
+		TEST_ASSERT((VCPU)->run->exit_reason == KVM_EXIT_IO,	\
+			"Got exit_reason other than KVM_EXIT_IO: %u (%s)\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason));	\
+									\
+		TEST_ASSERT(((VCPU)->run->exit_reason == KVM_EXIT_IO) && \
+			((VCPU)->run->io.port == (PORT)) &&		\
+			((VCPU)->run->io.size == (SIZE)) &&		\
+			((VCPU)->run->io.direction == (DIR)),		\
+			"Got unexpected IO exit values: %u (%s) %d %d %d\n", \
+			(VCPU)->run->exit_reason,			\
+			exit_reason_str((VCPU)->run->exit_reason),	\
+			(VCPU)->run->io.port, (VCPU)->run->io.size,	\
+			(VCPU)->run->io.direction);			\
+	} while (0)
+
+/**
+ * Check and report if there was some failure in the guest, either an exception
+ * like a triple fault, or if a tdx_test_fatal() was hit.
+ */
+#define TDX_TEST_CHECK_GUEST_FAILURE(VCPU)				\
+	do {								\
+		if ((VCPU)->run->exit_reason == KVM_EXIT_SYSTEM_EVENT)	\
+			TEST_FAIL("Guest reported error. error code: %lld (0x%llx)\n", \
+				(VCPU)->run->system_event.data[1],	\
+				(VCPU)->run->system_event.data[1]);	\
+	} while (0)
+
 /**
  * Assert that tdx_test_success() was called in the guest.
  */
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 7741c6f585c0..cde4b171446f 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
@@ -74,6 +75,86 @@ void verify_report_fatal_error(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IOEXIT_TEST_PORT 0x50
+
+/*
+ * Verifies IO functionality by writing a |value| to a predefined port.
+ * Verifies that the read value is |value| + 1 from the same port.
+ * If all the tests are passed then write a value to port TDX_TEST_PORT
+ */
+void guest_ioexit(void)
+{
+	uint64_t data_out, data_in, delta;
+	uint64_t ret;
+
+	data_out = 0xAB;
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&data_out);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IOEXIT_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data_in);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	delta = data_in - data_out;
+	if (delta != 1)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_td_ioexit(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint32_t port_data;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_ioexit);
+	td_finalize(vm);
+
+	printf("Verifying TD IO Exit:\n");
+
+	/* Wait for guest to do a IO write */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	port_data = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	printf("\t ... IO WRITE: OK\n");
+
+	/*
+	 * Wait for the guest to do a IO read. Provide the previous written data
+	 * + 1 back to the guest
+	 */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IOEXIT_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = port_data + 1;
+
+	printf("\t ... IO READ: OK\n");
+
+	/*
+	 * Wait for the guest to complete execution successfully. The read
+	 * value is checked within the guest.
+	 */
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	printf("\t ... IO verify read/write values: OK\n");
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -85,6 +166,7 @@ int main(int argc, char **argv)
 
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
+	run_in_new_process(&verify_td_ioexit);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

