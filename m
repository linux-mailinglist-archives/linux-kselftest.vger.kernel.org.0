Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461ED676217
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjAUARw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjAUARe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:17:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2BCC5FD
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso7516396ybe.21
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC2eVAKw5chE0JhJXlD1+MmiDErdw2lzMwJWsfEJffs=;
        b=X/BTnHPRI0KSxecnxIVHmWDH6w6f+DxWnjjSrMtMe2JlJrUKWmKU1ub1lVQuTb4GUy
         WqE6l0j/QytLan9Ix3EXZ9Gxbd9gZ0kkNwPysoMtmBq8n+lforCzB5DlEneN7VjDx43z
         Hfdk7kbMenghMMrSWfS1S1PHUwdSfv4fl8uCKKZ4eT4n5GNnzLri4jpCvbCJQKrfAgJz
         LscvoW9GDaRYlOFM2DU9J9XqYw6vCt0DytT2V6/0DC66CnDbhom9eLhsJnK7aMe2ayBa
         lGsYo07CWm6lLnw2AekdvE+dIO3AY3tqLqnG5HMTEgNZjA6X/rorMfltBuVCVyB9/iSj
         HtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EC2eVAKw5chE0JhJXlD1+MmiDErdw2lzMwJWsfEJffs=;
        b=psx1YS5k9viivwSGq5ZctRbGY68bjVZAv48Xlq5RH0U5eBC0iJfwUHT6GvUIegt2Hm
         KrPrqQyqOLWu4ZtHG8YATXDmkeSCZ8jnuyxf6kFMkdIsrJNw2TzzU2mjZLEw14HSc79A
         uHeGyjVbh5R5FW/x1SevCJcCdOmlImRXrBwkicOBLS4tuo/gPU/t9ygn3Y5IGda8TDlh
         j+G06lgC+Iv60akLSGhkhCHbREBpp6Hb4Kl+FUVZrS9XN7+XCDv/udW6k6obAkw+mQrF
         /aqIbgB340TaK2xYnN2fwKWBN5UzmUHiyZk9DLPQ/90iT/XkdMBfRuHaaGA6DudPK8b3
         Evrg==
X-Gm-Message-State: AFqh2koJYffeVFI6rF09B6ZsL3klBYWtHG5dTOlkCS5u/Ve2OvTsZb20
        QtcUmGX8HF0ro6GXnJsqm2p+yOWpN18vGQ0h0NXwTCYx2Y4MBGL0TsIlfFBPsy1f2Q4oX8KZ8VC
        a2Uqle/GJJzZLLPDw1FkazfdMqyN+gKiHKhFzFcczjb5el+teP/f2WIxo/86vB0i3TbRoRuno2L
        FfwodHkE5RanE=
X-Google-Smtp-Source: AMrXdXvECtv2OVE4yH2VV4gatly+5G5v4fXTnNgN4aEsp+twouX6j1MXGn/5UpxGAcY1UnIT25ptBjaye89JecjzIg==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:1990:0:b0:3c7:edf8:6eb with SMTP
 id 138-20020a811990000000b003c7edf806ebmr1896073ywz.9.1674260219981; Fri, 20
 Jan 2023 16:16:59 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:22 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-12-ackerleytng@google.com>
Subject: [RFC PATCH v3 11/31] KVM: selftests: TDX: Adding test case for TDX
 port IO
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

From: Erdem Aktas <erdemaktas@google.com>

Verifies TDVMCALL<INSTRUCTION.IO> READ and WRITE operations.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/include/x86_64/tdx/test_util.h        | 34 ++++++++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 82 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
index 6d69921136bd2..95a5d5be7f0bf 100644
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
index 627d60b573bb6..885c2b6bb1b96 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -2,6 +2,7 @@
 
 #include <signal.h>
 #include "kvm_util_base.h"
+#include "tdx/tdcall.h"
 #include "tdx/tdx.h"
 #include "tdx/tdx_util.h"
 #include "tdx/test_util.h"
@@ -73,6 +74,86 @@ void verify_report_fatal_error(void)
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
+	vcpu_run(vcpu);
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
+	vcpu_run(vcpu);
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
+	vcpu_run(vcpu);
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
@@ -84,6 +165,7 @@ int main(int argc, char **argv)
 
 	run_in_new_process(&verify_td_lifecycle);
 	run_in_new_process(&verify_report_fatal_error);
+	run_in_new_process(&verify_td_ioexit);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

