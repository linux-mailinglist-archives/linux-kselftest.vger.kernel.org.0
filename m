Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46C4762563
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjGYWCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 18:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjGYWC3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 18:02:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F82125
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c04f5827eso3123663a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690322511; x=1690927311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=amJG0j0ZI/e1O59M3k1Hf7ZdfPU64t6LHG2FDq6Qz+c=;
        b=kOwFz9Tc47inHL5x4aI2CvcCugKOOppAC+F6ppG8zLPcar40HwgiKQwfW1G0hST8Zd
         dchxEdNp0um6DnDCOvZv9QkzT3cwbHrlNpiALiPex2PbUA/Po1dNr2IzqJEQRDgq8cWf
         ZbhqdDUsBRki8L4eSeu47U7ldjec24xSgjDqsk0c0DFZRwyBtQ9asvVjBrYhXbTq6PnM
         MKyU3YttIXVvLaJkE0RV682Yj/HEVwOHQWNSnTcDFYB+8Z4OZbMxLx0SPcO2AbGEn+t2
         FYOH5pn+9ofoa2UFS5mFHbpXEqez9px74klfworKMGkjeh8n/n6sHBYYTunMPGDdyc/e
         O6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322511; x=1690927311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=amJG0j0ZI/e1O59M3k1Hf7ZdfPU64t6LHG2FDq6Qz+c=;
        b=hiWBwhXXojbBcssw2LGekax9haE9hje2Qu/Z9P9VCARUX6XvNGSXsqRLrQWoS2J+/Z
         7pYELHHy9faEeOMd2/DQRqcswYMM8FW+0i8pkqgoOTnBu3DyAcnGrqcU0OOZuM5ldxtW
         AimPKqYDhTFoXP5prUYLVq46s4CFynTaj83/RvmAO9hKkZOksaYaiKX6c/embepCCL9+
         SY53OchbhD2B/8C33oBerwnQ+uipb8kY4baMdkXi2k1vR/kjX8MzdjtWi3GCF1+wLlTF
         4Nvu2dLjzwsH//Ac7Hx8F7vs+u2MCeiOKJh2nRGWq2uVgS+fynvmwPcI7tdDa0xkWO9c
         Mxxg==
X-Gm-Message-State: ABy/qLZwIIXopTY9PNDl/vu6oHoa7uiUMv0B6KR9iuh65/t6U7PGZ90y
        vQgBaKzSPPvAgaZ41e/uis96P7784E1deywUUIBLCuTLgAt1fMM7zivbRRUWRAFY6vUdJfoXatA
        tOc9bUn5lnnrjwfFDglMAYsOEVpuY0iPvlGSjxKCBGYpDmdVC+A8J6o8bEFqOAB6dupqSxe4Mjh
        fE
X-Google-Smtp-Source: APBJJlEaGBxrRuuI7Lo4hpEp27VC0cmXbxF5+mprtAMLnWwBluARs6XVTQYG1I1Bsmi9OYe/V0oR9x6X8qPH
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:6486:0:b0:55b:3391:2293 with SMTP id
 y128-20020a636486000000b0055b33912293mr1868pgb.4.1690322510412; Tue, 25 Jul
 2023 15:01:50 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:00:55 +0000
In-Reply-To: <20230725220132.2310657-1-afranji@google.com>
Mime-Version: 1.0
References: <20230725220132.2310657-1-afranji@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725220132.2310657-3-afranji@google.com>
Subject: [PATCH v4 02/28] KVM: selftests: Expose function that sets up sregs
 based on VM's mode
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

From: Ackerley Tng <ackerleytng@google.com>

This allows initializing sregs without setting vCPU registers in
KVM.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Change-Id: Id20d51ea80aab2e22b8be14e977969aa0bd3cbba
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/lib/x86_64/processor.c      | 39 ++++++++++---------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index a1a9e34746c0..a4923f92460d 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -930,6 +930,8 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
+
 static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
 							      uint32_t function,
 							      uint32_t index)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 2a1dbe4b41c3..e3a9366d4f80 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -534,35 +534,38 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
 	kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
-static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs)
 {
-	struct kvm_sregs sregs;
-
-	/* Set mode specific system register values. */
-	vcpu_sregs_get(vcpu, &sregs);
-
-	sregs.idt.limit = 0;
+	sregs->idt.limit = 0;
 
-	kvm_setup_gdt(vm, &sregs.gdt);
+	kvm_setup_gdt(vm, &sregs->gdt);
 
 	switch (vm->mode) {
 	case VM_MODE_PXXV48_4K:
-		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
-		sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
-		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
-
-		kvm_seg_set_unusable(&sregs.ldt);
-		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs.cs);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.ds);
-		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs.es);
-		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18);
+		sregs->cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
+		sregs->cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
+		sregs->efer |= (EFER_LME | EFER_LMA | EFER_NX);
+
+		kvm_seg_set_unusable(&sregs->ldt);
+		kvm_seg_set_kernel_code_64bit(vm, DEFAULT_CODE_SELECTOR, &sregs->cs);
+		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->ds);
+		kvm_seg_set_kernel_data_64bit(vm, DEFAULT_DATA_SELECTOR, &sregs->es);
+		kvm_setup_tss_64bit(vm, &sregs->tr, 0x18);
 		break;
 
 	default:
 		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
 	}
 
-	sregs.cr3 = vm->pgd;
+	sregs->cr3 = vm->pgd;
+}
+
+static void vcpu_setup(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_setup_mode_sregs(vm, &sregs);
 	vcpu_sregs_set(vcpu, &sregs);
 }
 
-- 
2.41.0.487.g6d72f3e995-goog

