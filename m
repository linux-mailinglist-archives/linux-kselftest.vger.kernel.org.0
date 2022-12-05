Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE5643967
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiLEXXx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiLEXXv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:23:51 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938621835A
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:50 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k7-20020a632407000000b00478c0260975so2734484pgk.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJsitMNrFwlWnkUPP+bzm0yFNlRi9o93p/cQJywTOXc=;
        b=BeFPFGkoIaSJW4OwyhtPykbuDKK8eg9FRG8ZrYy513qt1mteOhpFvR+ZPC6SOxjT0E
         Ee2a1RsDEA/8rV9K6WEagcDYhhMxcc3Yi+B2FRdqowFjfFx0ZExIpmGTZ25uFRzhVLSE
         c9rrECLvcTpVHxi/O5g0MwFLcMlc5qK29gKnctJZIQPcsuR1Wdj2Zb2xBdSKYN5GaCXb
         X9TW7aLUFnXHDIXxbaA8Wq52e/WoFR3oW6XsdtdF00zBsQ3ZSCRV+wyRlC6C2aRSHECH
         BJRtfzsp8EUTLT84jRRMN/9ysYGTzHzE9yuLYCvBVSPlM4qkJZSMPznYV6Eatrb2gZXV
         9qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJsitMNrFwlWnkUPP+bzm0yFNlRi9o93p/cQJywTOXc=;
        b=0hZQ5yD+ZU8AeQnu1K6c2DgJ4JrPOkIKYt3ODQZTcqAlO7daYCO0mhm5HicFKdNvVI
         k4fUo67MGqnaMwJgQPEaWO8JJePpbPPUOexxD5VVAdPL7g43RptMG/2976wIZBWuXcDC
         h43vgFmL5kL+f5C5mD8saomiHIFsSHlGcFyg0X/pfqE9mkya3gyEEEWN0BochkV9n+qG
         qGmHsk90iz/dFJZXZ5+VKTgL2irR4cOOND4Jgu1LyYVKK5ap+WiZeHFFg16FrrGO5h3Y
         lJmaclOOitcbqV5Vcu+ZCMmZXK63xMharJaeASeMTrMTLQsvbxi4dque+3VhJE69Dt/9
         YfrQ==
X-Gm-Message-State: ANoB5pnIhuBz4/U0m3rdaRqyKf2Ia8ovI8mLctFPW1dup5tzJp4s3xE1
        r0CSYZToHILxrZ6k5gTK6kQlxJxWGoa1ULQx
X-Google-Smtp-Source: AA0mqf70IPLrIk8kUk34OCEAZ8JdYwWW/LqbN4So04STHjgiA+SBHYffgYaXuzj2UbySbdE8Lbsi9J5g63+gR9VL
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:2dc8:b0:219:baef:3ba with SMTP
 id q8-20020a17090a2dc800b00219baef03bamr11402807pjm.6.1670282630094; Mon, 05
 Dec 2022 15:23:50 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:36 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-2-vannapurve@google.com>
Subject: [V2 PATCH 1/6] KVM: x86: Add support for testing private memory
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
 arch/x86/kvm/mmu/mmu_internal.h | 6 +++++-
 virt/kvm/Kconfig                | 4 ++++
 virt/kvm/kvm_main.c             | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 5ccf08183b00..e2f508db0b6e 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -263,6 +263,8 @@ enum {
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 					u32 err, bool prefetch)
 {
+	bool is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault);
+
 	struct kvm_page_fault fault = {
 		.addr = cr2_or_gpa,
 		.error_code = err,
@@ -272,13 +274,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.rsvd = err & PFERR_RSVD_MASK,
 		.user = err & PFERR_USER_MASK,
 		.prefetch = prefetch,
-		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
+		.is_tdp = is_tdp,
 		.nx_huge_page_workaround_enabled =
 			is_nx_huge_page_enabled(vcpu->kvm),
 
 		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
 		.req_level = PG_LEVEL_4K,
 		.goal_level = PG_LEVEL_4K,
+		.is_private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
+				kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
 	};
 	int r;
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index d605545d6dd1..1e326367a21c 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -92,3 +92,7 @@ config HAVE_KVM_PM_NOTIFIER
 
 config HAVE_KVM_RESTRICTED_MEM
        bool
+
+config HAVE_KVM_PRIVATE_MEM_TESTING
+       bool "Private memory selftests"
+       depends on HAVE_KVM_MEMORY_ATTRIBUTES && HAVE_KVM_RESTRICTED_MEM
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ac835fc77273..d2d829d23442 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1262,7 +1262,8 @@ int __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
 
 bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
 {
-	return false;
+	return IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING);
+
 }
 
 static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

