Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48AF762578
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGYWDX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGYWDC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:03:02 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91830E3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1114945a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322535; x=1690927335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYb2UntJCk/zn4c108HA9yrg8j3dAHpcDzElziN7WIY=;
        b=KzKHxwjX+E711xxfib442CgoVSiGsSdHc/CUQSTUEXKSPKkgRbSHvLd91MHGwgh54M
         RfFdvSZ4IGgDHWno+btuSz3JsfVM7lIvc2MTvg7TlvMctrWM6jQuysdAM53lIzOrgEpV
         PRNOwDJf7gl3z0zAcYY98BfV1PaJtFGmf56GPlyNt8Ol7kBWEpyrvXWonSvP1TZeX9qK
         Kn1qEJCfOV/CETbMnx80pRU/1CSOJdyJigheERQMG7Mcemmm404KaOcbe1C5T5+N8pCf
         ZozM49I5dHHl5cJzIZIgx1WlayzOn1U/BQYg09UqCxcvlHzw1vMWtnxcLuTy0jt1RZQH
         cc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322535; x=1690927335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYb2UntJCk/zn4c108HA9yrg8j3dAHpcDzElziN7WIY=;
        b=Hc4uV/a+cwHZDn/EipwPVfGkU3PZ8FJ5UyCzFAuZNkPGmV1ss2hT7mk5o8DlaHftsM
         KHtb05dm/2w9OlcQjJAWDvicHUkw5FmjIZLXUdJBLLVLZQr2dSo3IeKg4S67pHKy1tLB
         K4a5TsmqLiAiI6t19fWokiSfAUemk43erlP9WGlzf8ZjISDOMXSGEUcSlfSow1g+6hih
         AddK86s3xafv0896i/wkius3dzB7gOMzrV7Rh6ipYaNPls7y97LN9EawaTy58xh5fCxf
         5lr8SkgVXn4lfF5asgBnWGsaZ9UP8eZ71w9Du7qSebPa604jPaziDhYSCIjA5+t644EW
         oAoA==
X-Gm-Message-State: ABy/qLbRkHpDxcLlCNvKUKaLuw9YRQdaIoa3/1do3IVI9L7/6EVr8jaJ
        ORidBLN5vIRcDvLhjpKarB4mukrdy3DtERFuPVgqpiGharKdcKEWBsdNnKw1JF8VCu7TM5vlscs
        AI1Av7GrTPNW68DycLk5vG3nIapKgkWl2oyk3XtTBHyzk2f8g917E+DOO91t43gfTSvMeUNa/kj
        /h
X-Google-Smtp-Source: APBJJlFrxhyN0gYmcU9m+L2b/2sDxek5BxJMk4MKZdCLwIXYEIL1JgCEJq+CGpMKSuItzkE4tA0pTqPKqjQY
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:8c54:0:b0:55b:5c9b:671e with SMTP id
 q20-20020a638c54000000b0055b5c9b671emr2339pgn.5.1690322534554; Tue, 25 Jul
 2023 15:02:14 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:01:07 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-15-afranji@google.com>
Subject: [PATCH v4 14/28] KVM: selftests: TDX: Add TDX IO reads test
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

The test verifies IO reads of various sizes from the host to the guest.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: If5b43a7b084823707b5b4a546c16800d5c61daaf
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/x86_64/tdx_vm_tests.c       | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
index ca0136930775..9ac0b793f8c5 100644
--- a/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
+++ b/tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
@@ -429,6 +429,92 @@ void verify_guest_writes(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_READS_TEST_PORT 0x52
+
+/*
+ * Verifies IO functionality by reading values of different sizes
+ * from the host.
+ */
+void guest_io_reads(void)
+{
+	uint64_t data;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 1,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xAB)
+		tdx_test_fatal(1);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 2,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xABCD)
+		tdx_test_fatal(2);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 4,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+	if (data != 0xFFABCDEF)
+		tdx_test_fatal(4);
+
+	// Read an invalid number of bytes.
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_READS_TEST_PORT, 5,
+					TDG_VP_VMCALL_INSTRUCTION_IO_READ,
+					&data);
+	if (ret)
+		tdx_test_fatal(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_reads(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_reads);
+	td_finalize(vm);
+
+	printf("Verifying guest reads:\n");
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 1,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xAB;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 2,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xABCD;
+
+	td_vcpu_run(vcpu);
+	TDX_TEST_CHECK_GUEST_FAILURE(vcpu);
+	TDX_TEST_ASSERT_IO(vcpu, TDX_IO_READS_TEST_PORT, 4,
+			TDG_VP_VMCALL_INSTRUCTION_IO_READ);
+	*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset) = 0xFFABCDEF;
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
@@ -444,6 +530,7 @@ int main(int argc, char **argv)
 	run_in_new_process(&verify_td_cpuid);
 	run_in_new_process(&verify_get_td_vmcall_info);
 	run_in_new_process(&verify_guest_writes);
+	run_in_new_process(&verify_guest_reads);
 
 	return 0;
 }
-- 
2.41.0.487.g6d72f3e995-goog

