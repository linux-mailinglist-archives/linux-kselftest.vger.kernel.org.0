Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90904624FC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiKKBm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKKBm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:42:56 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FF63CC3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:55 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id h16-20020a170902f55000b001871b770a83so2512676plf.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICPUEkvZED2a6y3O08u4jS51b4sDHquP+b6CyeTgK60=;
        b=Po+B6TPu2lrVnybNXAiqDvhpQCVRuhqR8U6MzQPzoEhL3zHzlLB853eMltrQPYOG4x
         srbAOyf9uQM9B40jEI08EtOwmeRkfdgN/3qMtHDYwkyPkWZmPIy+SlVrgfiSJIGvjspM
         4jrNIx5Bnh0jSfGeHpRK+6moj6y/QB/O+XLyYfbH/3MMy2mrwJZ52VsAVLymvt4QbYMN
         mzmidyyUSqloFTO2AymnHYj4fqI23/oV2tdnx3dqKCvb3dKiDoFj/78L+XG0tFH37342
         htQ1uhw1f8Qvuzt4iDN/KFH/DiFD8Py/hI0nGXEdgvsNsqO+ia4f+pr2bAquCEvwVgf2
         SQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICPUEkvZED2a6y3O08u4jS51b4sDHquP+b6CyeTgK60=;
        b=yfziioJIgWeECmDOsK+E5g97kerQyDgHHebPfcNP57jq0HJPzztP1J6p0vKq4QQVKW
         0vOWVM0MAkVDmMx9Pfoddf220JplbYuUUZsY4MdszCPBimlMuDD9BJCjj2QTJ6NxzF0P
         6b+FmCsu/GH+2fxAtnJCZEsjNrYduRd30kR3ZXvw4PZiUZFYrTnLWuToOGoBNzd0oojl
         kySu9WBUekaEbZ+ekd52/R0PEMlaU8MFqYkhd2v9XSuWQa0NSebLsofp3F38x3HWNgJH
         Gb0pTU9l68oVITihJHQjIPURKbWjD0nL5cgjb72T8Wwusv9Z4yv+cZD1TLeUL4RuDDgt
         9g2g==
X-Gm-Message-State: ANoB5pmdMN2bI/QPbsrynKgsIOqONK9+8FQw17ziAOKOGP2wHtpDd9eN
        yPTeMjTTl46zgQNA+8cvhyZBOj/o0Q7oWxG5
X-Google-Smtp-Source: AA0mqf473aYDKC7Ae5CRuYu7Z65qsFzdE85vPlWihPbw2fuebWuEkwUwhbIysIQ+cvSLlcz+OOA3yPUaXKWigZ1J
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:e82:b0:20a:fee1:8f69 with SMTP
 id fv2-20020a17090b0e8200b0020afee18f69mr13844pjb.0.1668130974505; Thu, 10
 Nov 2022 17:42:54 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:39 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-2-vannapurve@google.com>
Subject: [V1 PATCH 1/6] KVM: x86: Add support for testing private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Introduce HAVE_KVM_PRIVATE_MEM_TESTING config to be able to test fd based
approach to support private memory with non-confidential selftest VMs.
To support this testing few important aspects need to be considered from
the perspective of selftests -
* KVM needs to know whether the access from guest VM is private or shared.
Confidential VMs (SNP/TDX) carry a dedicated bit in gpa that can be used by
KVM to deduce the nature of the access.
Non-confidential VMs don't have mechanism to carry/convey such an
information to KVM. So KVM just relies on what attributes are set by
userspace VMM keeping the userspace VMM in the TCB for the testing
purposes.
* arch_private_mem_supported is updated to allow private memory logic to
work with non-confidential vm selftests.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 4 ++++
 arch/x86/kvm/mmu/mmu_internal.h | 4 +++-
 virt/kvm/Kconfig                | 4 ++++
 virt/kvm/kvm_main.c             | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 10017a9f26ee..b3118d00b284 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4280,6 +4280,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	fault->gfn = fault->addr >> PAGE_SHIFT;
 	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+	fault->is_private = kvm_slot_can_be_private(fault->slot) &&
+			kvm_mem_is_private(vcpu->kvm, fault->gfn);
+#endif
 
 	if (page_fault_handle_page_track(vcpu, fault))
 		return RET_PF_EMULATE;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 5cdff5ca546c..2e759f39c2c5 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -188,7 +188,6 @@ struct kvm_page_fault {
 
 	/* Derived from mmu and global state.  */
 	const bool is_tdp;
-	const bool is_private;
 	const bool nx_huge_page_workaround_enabled;
 
 	/*
@@ -221,6 +220,9 @@ struct kvm_page_fault {
 	/* The memslot containing gfn. May be NULL. */
 	struct kvm_memory_slot *slot;
 
+	/* Derived from encryption bits of the faulting GPA for CVMs. */
+	bool is_private;
+
 	/* Outputs of kvm_faultin_pfn.  */
 	kvm_pfn_t pfn;
 	hva_t hva;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 69ca59e82149..300876afb0ca 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -93,3 +93,7 @@ config HAVE_KVM_RESTRICTED_MEM
 config KVM_GENERIC_PRIVATE_MEM
        bool
        depends on HAVE_KVM_RESTRICTED_MEM
+
+config HAVE_KVM_PRIVATE_MEM_TESTING
+       bool
+       depends on KVM_GENERIC_PRIVATE_MEM
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dae6a2c196ad..54e57b7f1c15 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1750,7 +1750,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
 
 bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
 {
-	return false;
+	return IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING);
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
-- 
2.38.1.431.g37b22c650d-goog

