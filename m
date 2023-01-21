Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7646761FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjAUAQj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjAUAQg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:16:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF7AC41E6
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso7401392ybq.4
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BLjdusZm+xjhNzljGhXw4f9568iWucER7Te8w8OqhFs=;
        b=TDIaCVqYeIkQPZRKMJoacHO6RWwqZ2saZD80hqMq+dsF0MaeVOmsLzBudmhT2LAPx6
         zXDGZGPegVLI4pfT2pxUSy2kD77TugYTngV83uqsZH0JbgQjUo3PECb0APIQb47XYCU9
         FqwQQ0drC8OvMGcqLF17TkJ2k0eZfsT1Zrg/5meqhIngWjQD5BqlijWlRxExc0y3Uu4d
         IIJ6t3o1ybuEgQVMCJCJG2Jxzi/FF9RYYuTrxEZU/uPetZKthsFlpDy6vDTBeTw+dVz5
         xnBH5JLrC3+jM+Bgx5gy7skPT/bfFSb6GNucSPJw/48hiZ7D2UOe1g//87WZ714vK9yr
         5zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLjdusZm+xjhNzljGhXw4f9568iWucER7Te8w8OqhFs=;
        b=Z4C7yMi7YCYvxOnkBVnHiQkYCi4xMd1ODfCY4HApYWoIxAd2Q7vHMeQPN9YOLvR1lH
         aE01kf07LQVKnFDmXXntW5NplfwqjGY0EjGQ9aysPVryfSNNV2q4T+LnIDR4AiPVhY+N
         gRilARjjvEA0AHACs0J8YJ5zJz5fTDS46DxyBOGfSqEUrMagosVxZYYqTGWFtmOXE4Lf
         Vn/Ru//XtSN+L4r5DOQs3XJ7MYgz4XC4iebzWOlqu+zkVYgrlZXmGE3UGPa6JsCVLj4O
         yhiP1Ccu27FLOtWegPjUL5T+/MR2pP2SdPScuvJrgeMSrBNuQCmYLDGesV2qGnNdDz7t
         NeNw==
X-Gm-Message-State: AFqh2kpfVaCmSZgBCkcWMkuaxate0Or6G/j3Lf/BnumpvQvK94qJh9zi
        oOvvMLo1HUaVSSlRhJf22UtV+Bvf5l58FOIcYWfYtxSX2w2moZEGjkbaAMkceQ++PbWCbW2eKmB
        fKrrWJP4vX+Q4phhfNyKO7cq1tgKE+XvybU8tDsbwQB0kbPD3YOC95cYUtxOByhoMPBq7nCoIFh
        SFiaVJYRpqUcg=
X-Google-Smtp-Source: AMrXdXsHP5+f2fpfYzE99STHEa4P9O08B98yUTieK273C17++g9izQw4HiDu7GbrwsdBFOcun4exBxIBpIXN2zIitg==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a25:dc8f:0:b0:768:2e4c:9799 with SMTP
 id y137-20020a25dc8f000000b007682e4c9799mr2014885ybe.481.1674260183238; Fri,
 20 Jan 2023 16:16:23 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:14 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-4-ackerleytng@google.com>
Subject: [RFC PATCH v3 03/31] KVM: selftests: Expose function that sets up
 sregs based on VM's mode
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

This allows initializing sregs without setting vCPU registers in
KVM.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  2 +
 .../selftests/kvm/lib/x86_64/processor.c      | 39 ++++++++++---------
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e8ca0d8a6a7e0..74e0d3698f30c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -644,6 +644,8 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
+void vcpu_setup_mode_sregs(struct kvm_vm *vm, struct kvm_sregs *sregs);
+
 static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
 							      uint32_t function,
 							      uint32_t index)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ed811181320de..1bb07d3c025b0 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -589,35 +589,38 @@ static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
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
2.39.0.246.g2a6d74b583-goog

