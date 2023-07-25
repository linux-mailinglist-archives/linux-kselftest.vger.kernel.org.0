Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01329762589
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGYWDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjGYWDH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF1C3581
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5834d9ec5f7so5052627b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322543; x=1690927343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrItVFfOA+QxaSM3H7aj2euV9UftrIgRmfyaO4sOoo=;
        b=rO25oG3lbfVl4oeiRBggtT59tm4gnz62ixnb4rzxZE84dPoIW9GbmbNOMZZ482EEaB
         vTGqKr+99wL9xXUEsw0fFfUN51Jxbebwgdqa/wCaUWYJLoF/M0CrtCd8TwFxQn4+hDlR
         3EAxLIccUk8uf7F1+3/rIG/7Moa/u+seu6yRc6Lkf1QGDoVNuckv6WRIGfNsMIv68JUT
         NwTNJdhR3UdkEopKg/b7jKV5tejQyf2uBdJbIiagMVen4DcyuQKbaaNhMhTXpGiHl81p
         7W30wDIRLUV8z/J6kT6+KFUYpA/xSRvFLrZMFrfb0gYTJai0f5P1knOyeEtzswAy3BRz
         EqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322543; x=1690927343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPrItVFfOA+QxaSM3H7aj2euV9UftrIgRmfyaO4sOoo=;
        b=MKHPs8aHSTkwwwqnA5u5lzpQn0XQ8fjE6qowYTfyV5GyZ7JGx3ZFHKOhrnFO9Eoo/E
         os2Zkm3oiLWrMRJVaXTuGR94zFCwTZWqNiyP9DwepTDgIvX9/2J5TDm62NI10+g+mcFf
         f71pa8kiGS9JeNRCxq3m+AKLcO37x1eBEEg8/UvehJEhU5M4sDlq/oJQHijFVsEAJmL8
         gzFfVsNTRku6zhpT3MYxv1YS4lj6KouAFZIqg4IMZiyPoYJDTHnsc3glU2+t+W/vSMG6
         wc98IpOIVEML0OLEdXJ0aQWj/K+AJ5Ds5yBDKJAnPuhv1ljypS6jZlB2wjdBxJBheOSR
         SGwQ==
X-Gm-Message-State: ABy/qLbUELXK0jc8uiKkfCNUBt9SG3XThtHhKJRioiFMrx+ESbQZdFB5
        9DC/TWDj2Ov6/zhzbaqfbrOv/9k7aOL0qUDbJL4bqozf2Wzjvuhku0TIqpW+l+mU1Pqn5ehQQJa
        jotD5dfcLiI953z1TrV/n90tbXNlfiqHtwq5+Mq2ciLP2efXT2Z46D09aFZW+YKJWEy6QOciITM
        0i
X-Google-Smtp-Source: APBJJlFxgYiETJSP+DJ3KysP+/mDXMsnWB2PiOVU7SwOZQuKYNDMR4VH4UlPiliVQnHQj5BNTqsiXaxmkyOC
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a25:482:0:b0:d08:95:76d with SMTP id
 124-20020a250482000000b00d080095076dmr3767ybe.6.1690322542481; Tue, 25 Jul
 2023 15:02:22 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:11 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-19-afranji@google.com>
Subject: [PATCH v4 18/28] KVM: selftests: TDX: Add TDX MMIO writes test
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

The test verifies MMIO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: I6586906e279ef896649a77be81c688e4832629cb
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 13ce60df5684..502b670ea699 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -25,5 +25,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					uint64_t *data_out);
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					uint64_t data_in);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index b19f07ebc0e7..f4afa09f7e3d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -143,3 +143,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 
 	return ret;
 }
+
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					uint64_t data_in)
+{
+	struct tdx_hypercall_args args = {
+		.r11 = TDG_VP_VMCALL_VE_REQUEST_MMIO,
+		.r12 = size,
+		.r13 = TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE,
+		.r14 = address,
+		.r15 = data_in,
+	};
+
+	return __tdx_hypercall(&args, 0);
+}
diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index 88cb219ae9b4..79fe56c1052d 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -885,6 +885,90 @@ void verify_mmio_reads(void)
 	printf("\t ... PASSED\n");
 }
 
+void guest_mmio_writes(void)
+{
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 1, 0x12);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 2, 0x1234);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 4, 0x12345678);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	ret = tdg_vp_vmcall_ve_request_mmio_write(TDX_MMIO_TEST_ADDR, 8, 0x1234567890ABCDEF);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	// Write across page boundary.
+	ret = tdg_vp_vmcall_ve_request_mmio_write(PAGE_SIZE - 1, 8, 0);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+/*
+ * Varifies guest MMIO writes.
+ */
+void verify_mmio_writes(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	uint8_t byte_1;
+	uint16_t byte_2;
+	uint32_t byte_4;
+	uint64_t byte_8;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_mmio_writes);
+	td_finalize(vm);
+
+	printf("Verifying TD MMIO writes:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
+
+	ASSERT_EQ(byte_1, 0x12);
+	ASSERT_EQ(byte_2, 0x1234);
+	ASSERT_EQ(byte_4, 0x12345678);
+	ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
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
@@ -905,6 +989,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
+	run_in_new_process(&verify_mmio_writes);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

