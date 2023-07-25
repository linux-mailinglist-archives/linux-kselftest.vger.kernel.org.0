Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE0762572
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjGYWDT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGYWDC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FF30D8
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5618857518dso58152437b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322532; x=1690927332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BglVD3tTlL86xZX6Z5R3ezR3rNJJfc76ia5n59qv+aM=;
        b=zRhd85iuDOtshGYd/4Jep9VyX/mvBpjj+AMnE5r3esec0fcPCBEQMl/JEtx+EHjMRy
         16c0nCer9NDvD9DmsZ3BrG0itoXxoO+MztpuF71UOBxCyoKNd+C3HOUK7PLIqo9+ZOvH
         xYTSy5ByZJ+0l88FzUodtOjMv2qOeeP75bBMkog7vCXKI3Muyaq+yCse7YYasGyoRbF2
         Hj0G/gK4CE0yib7qHFTLRAMIFGQDVG6EiqdBvggA8DKdvxgvHKXLieeUN7hw50iXqA0F
         GXS0SBosCLT3aEk+lITLGy6tUisSuCL9Q8d78pAZh0Wcxciy/PnPxT9ZmVs+RQ+2rcnV
         WnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322532; x=1690927332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BglVD3tTlL86xZX6Z5R3ezR3rNJJfc76ia5n59qv+aM=;
        b=Yp3m3bshd9RWJPLrDbpgRa0tLe/AkfM5usIjHk/tBz+Hi7n53aiJmaP+oqdJq7woXF
         A1uspwWylJFROU21sfslkjFnFQ8bhzK2PW26+62cjODSCQWVvtigxwdgnPZjH/rJfdU5
         65nOYh3NDPs1E/jPLSv5V7SoqkmqoebWaFu+a8ZtlNtv7f+B34Op2lGeA9Nq9u+quaPf
         EpWGDDjtVkoQaZtmluciQGhfChvFRcO4E4WOAs9YO2Qzfdv3VQoLACtefVelx9HY+jma
         t+z2Id4wDCGZ01SL5rYeMn+3dM3bsaMvEej5+HcH7kHlEfa9jTYhkzU7lAh+qf1GtpH0
         uDxA==
X-Gm-Message-State: ABy/qLZ+Z6ZijNVPvKy6hDt6sfao9S7AJVSAbYFA07mWTigShGr1oFjn
        djlg7ZYLu/T+nBaIdx2m2GMyXZEB7+wwKSy+goJqjYWxAiy5mN1orOIEhFAGwjI/NwvtrL+BH9X
        J7z4b4am8cZHwvDYa0dQlLETxo5L7K7OIqFjp6LWjilQ1TKvRK1qXyVT2k3am0msMVNBm+P8X4D
        My
X-Google-Smtp-Source: APBJJlGboFK0Pwxec1ZjSVCKt+ZgddJR8b1x55c9ByJsSn38G65QwUZX1hQ0ROLg6wiroNNOrrf9rj5p5hMr
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a81:ae49:0:b0:580:e6dc:e2df with SMTP id
 g9-20020a81ae49000000b00580e6dce2dfmr3700ywk.9.1690322532285; Tue, 25 Jul
 2023 15:02:12 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:06 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-14-afranji@google.com>
Subject: [PATCH v4 13/28] KVM: selftests: TDX: Add TDX IO writes test
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

The test verifies IO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I91edb81a93d7bfd881ccde517c95b5728a2ba85e
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdcall.h |  3 +
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 91 +++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
index 78001bfec9c8..b5e94b7c48fa 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdcall.h
@@ -10,6 +10,9 @@
 #define TDG_VP_VMCALL_INSTRUCTION_IO_READ 0
 #define TDG_VP_VMCALL_INSTRUCTION_IO_WRITE 1
 
+#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
+#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_HCALL_HAS_OUTPUT BIT(0)
 
 #define TDX_HYPERCALL_STANDARD 0
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 9e9c3ad08a21..ca0136930775 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -339,6 +339,96 @@ void verify_get_td_vmcall_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_WRITES_TEST_PORT 0x51
+
+/*
+ * Verifies IO functionality by writing values of different sizes
+ * to the host.
+ */
+void guest_io_writes(void)
+{
+	uint64_t byte_1 = 0xAB;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_1);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_2);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	// Write an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_WRITE,
+					&byte_4);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
+	td_finalize(vm);
+
+	printf("Verifying guest writes:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_WRITES_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	ASSERT_EQ(byte_1, 0xAB);
+	ASSERT_EQ(byte_2, 0xABCD);
+	ASSERT_EQ(byte_4, 0xFFABCDEF);
+
+	td_vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_ASSERT_SUCCESS(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	setbuf(stdout, NULL);
@@ -353,6 +443,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_ioexit);
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
+	run_in_new_process(&verify_guest_writes);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

