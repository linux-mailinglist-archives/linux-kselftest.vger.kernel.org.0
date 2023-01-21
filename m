Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7253167622E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjAUASy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjAUASe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:18:34 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B815C79F6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:01 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z10-20020a170902ccca00b001898329db72so3850032ple.21
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDRb3hUK3KL7DjIqYNoerTWOItA0XH5RYK6H+82j2oo=;
        b=XKdLbiTjQhc9QJq14SPOY4oxXeT+HysgYBLtbPoSyINx26ic5GcWQYVBXakE2mIlKz
         3OrvzXQoJQ8F1SBQxDJ8tcSajMpWk1WvEXySGVZz5WMgpy9VIWczLuL5s+e2/u5Eqalp
         mNTWZliS4ITyJscyB4p3S0iuaQ7Wh9c2iLF2ASd2RtXUOf5/mG0b4/wF7eQtRovXL1L6
         fuLxuYfQ2YAn9AlXtF14its/YFWf+KMNN4Zd3hlFp6ossx8R4A+zs23HvvI3tXLBMAAl
         xXSNsTdW7suXb/hQ17/sYvsVmr33WQjnbxMlkNHI4XhNAeM36E3fKtxgX9ErrxPZMtw8
         Ai0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDRb3hUK3KL7DjIqYNoerTWOItA0XH5RYK6H+82j2oo=;
        b=vgUIAI0OEAW6QIsTuzYcEGsq2kq426PgifM6TddaQDH2lOvoXK5oS44uJ3l+R8tRO6
         dH8Chyzz2719vyY+KvJDVlFK7QeBFU+wIf6//H8wNXMQrDaI12WTNKnFlKBxQceGt6LZ
         TIcdL8jrgqVG02XSxo9SbopiGJJl5f+jRPCUCg32nxM2VC6qT0wjPH+xfWF58WW/oVL+
         yg1C2zJtLadPAwLOymDbDf9Mlwo/UzErcRkIcIVHFqgMipRrxhR2D28tCo9J3hVy9K4+
         DLxti6a4AIj2UgDtoAYeKTZ8AHgLDPYKiJWVzNWdAvrtfJEiReUj2FJ8lKWnD3dO3vTG
         zArQ==
X-Gm-Message-State: AFqh2kpnRvNw7X/6GEfqZSOkp2rGeEeIgEL1CkXG9+tQguzB0VtVkyXb
        v4dbihcZKS1hQ8HX+6yoD7AEp0rthtn06W7tKu8j8SuVgUnMUub/bCByoyltTD/WmCGkRWic/Fs
        O2SeaTKtPsiiAk+jjIsTTWV3eOCeTJd4ie//wlQLkkWyzvZJ2X+83jRzIkftlP0b4vGxyRu0jas
        MCJWAopC2jP+A=
X-Google-Smtp-Source: AMrXdXt1XhMvepnOd4PkQEnRmj4etZEsfLhZH3dY0GE9wFptQNK6vFci+DDTmZgluotiO55Qn6Oa6u3+G7bcLHPvkw==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:7595:b0:193:3b70:e9a0 with
 SMTP id j21-20020a170902759500b001933b70e9a0mr1730374pll.6.1674260254883;
 Fri, 20 Jan 2023 16:17:34 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:30 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-20-ackerleytng@google.com>
Subject: [RFC PATCH v3 19/31] KVM: selftests: TDX: Add TDX MMIO writes test
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

The test verifies MMIO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/tdx/tdx.h    |  2 +
 .../selftests/kvm/lib/x86_64/tdx/tdx.c        | 14 +++
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 85 +++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
index 8dd6a65485260..f2a90ad8a55c6 100644
--- a/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/tdx/tdx.h
@@ -24,5 +24,7 @@ uint64_t tdg_vp_vmcall_instruction_wrmsr(uint64_t index, uint64_t value);
 uint64_t tdg_vp_vmcall_instruction_hlt(uint64_t interrupt_blocked_flag);
 uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 					uint64_t *data_out);
+uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,
+					uint64_t data_in);
 
 #endif // SELFTEST_TDX_TDX_H
diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
index dcdacf08bcd60..8b12ac7049572 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
@@ -122,3 +122,17 @@ uint64_t tdg_vp_vmcall_ve_request_mmio_read(uint64_t address, uint64_t size,
 
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
index 88f0429db0176..dcc0940a74e92 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -892,6 +892,90 @@ void verify_mmio_reads(void)
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
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 1, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_1 = *(uint8_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 2, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_2 = *(uint16_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 4, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_4 = *(uint32_t *)(vcpu->run->mmio.data);
+
+	vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_MMIO(vcpu, TDX_MMIO_TEST_ADDR, 8, TDG_VP_VMCALL_VE_REQUEST_MMIO_WRITE);
+	byte_8 = *(uint64_t *)(vcpu->run->mmio.data);
+
+	ASSERT_EQ(byte_1, 0x12);
+	ASSERT_EQ(byte_2, 0x1234);
+	ASSERT_EQ(byte_4, 0x12345678);
+	ASSERT_EQ(byte_8, 0x1234567890ABCDEF);
+
+	vcpu_run(vcpu);
+	ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	ASSERT_EQ(vcpu->run->system_event.data[1], TDG_VP_VMCALL_INVALID_OPERAND);
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
@@ -912,6 +996,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_guest_msr_reads);
 	run_in_new_process(&verify_guest_hlt);
 	run_in_new_process(&verify_mmio_reads);
+	run_in_new_process(&verify_mmio_writes);
 
 	return 0;
 }
-- 
2.39.0.246.g2a6d74b583-goog

