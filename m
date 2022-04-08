Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDFB4F9EB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 23:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239683AbiDHVIB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiDHVIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 17:08:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F11403D9
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 14:05:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b18-20020a63d812000000b0037e1aa59c0bso5351279pgh.12
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rlJkFcNcYd6mPNnge4ujHl+5hUg478jozPBxCeiplcU=;
        b=kD8vKqNMy0pBGS7eymZaRDQYbCNZT+UEHGxZV9YZX4Xm8SiuB0c/ypoS9pSwv0tLYB
         HpcVD4HioKpNuQKaD3c4terg5FTGEDvP/LrN0nbTKAdGOUmsHVYS8Ei92SqUAd/2Ye6+
         Ic+jODJNU3xgl9cTfgGDuAalpa70HzKMZ+mmGOu+SHcXOO3ONMt6qujDh28WdL0wn89X
         HgUxOQHBTtaDJ+Skf4i3LxR2zpMF3o/infccnKr16BKp1eI81jsXJLeFnnKMa8VRDD5C
         2RiTV0MygW7LyqGZ+RxlAnFjspv1Jm/3O9QZCKEvxpdvVG2CujC8yCUJy8+HeeE3Lf/L
         4/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rlJkFcNcYd6mPNnge4ujHl+5hUg478jozPBxCeiplcU=;
        b=Pbb2O90pmgwKFwYkQmVSvF+MPQER/V3X4TCuPVOH3iQpXKqC5LbR8r8uaDZk6nYykT
         rwriVrSXszcFTkZJE7NTmica8FCoBQpRGV3MhIccMMCRhD2kwI//d+jazYbDj+p+Fp9W
         eHtgTdO1FhU0CKfPuzFSNzRnnDd+UUngLaaxMJCs9brpQ2lFmUa/TvZ3hf8hRgX23rdr
         uBGmlo/Dzl+pgkJfkZm/Y9pvKxOqp6HoIJDAdNpJMuqgikhkHwcY+XI82F2dQK8u5r6u
         JH7V4R+LMkXhQsfpvLEPRtnp95OG+GmaDd/uR8xxErD4EdnYDgyekOcbYCu+aVCFZrRa
         5HxQ==
X-Gm-Message-State: AOAM531F9yr3LNFBWrg0h1KG+aMF4npS3dFWu9uYWhKTFzq3J51qKZpN
        NigD5zHpqaHdY2wStc3v8JnyeFGuiJRwa14+
X-Google-Smtp-Source: ABdhPJxlvfncBAZX5WHOx5BNkCJlbFqniaKc+b2JesTBq+VaT+G3FdaPBqWx9JKhyKVqo/FZpF/gO6FixnKe/EqS
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:2384:b0:1cb:5223:9dc4 with SMTP
 id mr4-20020a17090b238400b001cb52239dc4mr313643pjb.1.1649451954536; Fri, 08
 Apr 2022 14:05:54 -0700 (PDT)
Date:   Fri,  8 Apr 2022 21:05:41 +0000
In-Reply-To: <20220408210545.3915712-1-vannapurve@google.com>
Message-Id: <20220408210545.3915712-2-vannapurve@google.com>
Mime-Version: 1.0
References: <20220408210545.3915712-1-vannapurve@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [RFC V1 PATCH 1/5] x86: kvm: HACK: Allow testing of priv memfd approach
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, seanjc@google.com, diviness@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Add plumbing in KVM logic to allow private memfd series:
https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
to be tested with non-confidential VMs.

1) Existing hypercall KVM_HC_MAP_GPA_RANGE is modified to support
marking pages of the guest memory as privately accessed or
accessed in a shared fashion.

2) kvm_vcpu_is_private_gfn is defined to allow guest accesses to
be categorized as shared or private based on the values set by
KVM_HC_MAP_GPA_RANGE hypercall.

3) KVM_MEM_PRIVATE flag for memslots is marked as always supported.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kvm/mmu/mmu.c               |  9 +++++----
 arch/x86/kvm/x86.c                   | 16 ++++++++++++++--
 include/linux/kvm_host.h             |  3 +++
 virt/kvm/kvm_main.c                  |  2 +-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6e64b27b2c1e..3bc9add4095d 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -102,6 +102,7 @@ struct kvm_clock_pairing {
 #define KVM_MAP_GPA_RANGE_PAGE_SZ_2M	(1 << 0)
 #define KVM_MAP_GPA_RANGE_PAGE_SZ_1G	(1 << 1)
 #define KVM_MAP_GPA_RANGE_ENC_STAT(n)	(n << 4)
+#define KVM_MARK_GPA_RANGE_ENC_ACCESS	(1 << 8)
 #define KVM_MAP_GPA_RANGE_ENCRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(1)
 #define KVM_MAP_GPA_RANGE_DECRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(0)
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b1a30a751db0..ee9bc36011de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3895,10 +3895,11 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 
 static bool kvm_vcpu_is_private_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
-	/*
-	 * At this time private gfn has not been supported yet. Other patch
-	 * that enables it should change this.
-	 */
+	gpa_t priv_gfn_end = vcpu->priv_gfn + vcpu->priv_pages;
+
+	if ((gfn >= vcpu->priv_gfn) && (gfn < priv_gfn_end))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 11a949928a85..3b17fa7f2192 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9186,8 +9186,20 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		if (!(vcpu->kvm->arch.hypercall_exit_enabled & (1 << KVM_HC_MAP_GPA_RANGE)))
 			break;
 
-		if (!PAGE_ALIGNED(gpa) || !npages ||
-		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
+		if (!PAGE_ALIGNED(gpa) ||
+			gpa_to_gfn(gpa) + npages < gpa_to_gfn(gpa)) {
+			ret = -KVM_EINVAL;
+			break;
+		}
+
+		if (attrs & KVM_MARK_GPA_RANGE_ENC_ACCESS) {
+			vcpu->priv_gfn = gpa_to_gfn(gpa);
+			vcpu->priv_pages = npages;
+			ret = 0;
+			break;
+		}
+
+		if (!npages) {
 			ret = -KVM_EINVAL;
 			break;
 		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0150e952a131..7c12a0bdb495 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -311,6 +311,9 @@ struct kvm_vcpu {
 	u64 requests;
 	unsigned long guest_debug;
 
+	uint64_t priv_gfn;
+	uint64_t priv_pages;
+
 	struct mutex mutex;
 	struct kvm_run *run;
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index df5311755a40..a31a58aa1b79 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1487,7 +1487,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
 
 bool __weak kvm_arch_private_memory_supported(struct kvm *kvm)
 {
-	return false;
+	return true;
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
-- 
2.35.1.1178.g4f1659d476-goog

