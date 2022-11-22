Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA7363451D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiKVUGI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 15:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVUGI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 15:06:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEAA6A3C
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 12:06:06 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c203so15351784pfc.11
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 12:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Io17PfAc29uMBTDjrTmJ5rXTcrZmlMcBL16ZnrS2meo=;
        b=hHkNHJ/TI/YGsTG53S+HMqoROlVIKOwZsl14RkYHb/axOVov+sxaZzLDJxKTQAicgz
         DnUvDSz/LYvuwpqDypPY5xuCrTyR3FARTgb2OHlJWNzg8glI59NbKWLKKxwFJ7dUrZM2
         vDFAW0JguDNs9DJGj+Pw2NVYlMb8+vBMdAkcmw2nHjjEdbb2CwWrYYseqrvO5lutn2Zz
         phIuOZFEjhKDwiSOkBjbuOu5bXSo2g4QROYSGY6VFLtXuNfp9+hgOSTV3GbDs4xzh/3/
         Cxb9dc6kWgnbtS+mPiwAQlsDNvuGbgy4+a01De97Oe607lp5StdrJWuhQQrRqqXxvYZ2
         IE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io17PfAc29uMBTDjrTmJ5rXTcrZmlMcBL16ZnrS2meo=;
        b=BX6UYACntg0cJLVw7aXD9kH8lMMfa4wZz0kxXxmMfhOyFMfyGfRiA4gkmO1aF0zUCg
         1j6XYFnfMVKyt8NaaggmT/UvfbP04NGpH7FbslNWTk9V1yFSE1mzkEJ9ZhF4Y+bZ89SL
         /fc/UuRznzVzwGXk4E1NhYrAuWfCB7Q24cHc5SCxvh8y6/dlTw9V26TQnZ+U128SykU8
         0qtEAeBYxcbqa6GuZapfga6v2xwry99ge1y6xgne4/tIoAqi0BRR7WTU3upuFc+iYCD/
         1sOC0TULTH24rlb2aESzn0dXLwTs/kVPWrcVJBYW+BVECE3oeZZNIzoQH4B445xnTFfj
         ev8Q==
X-Gm-Message-State: ANoB5pkdb5hCQ4hOhEmSo/qU5CVJfdpLFIr4/9k3hizcPhVvSpRgX78J
        MZ0updV5dgo/dWhZsNBAuID6MQ==
X-Google-Smtp-Source: AA0mqf6Ev2gBqgfT1KuMwfcbFwlKgouzc+D/Ubel+TnlBZCJDAc0UwpNtCkUO1EgvUDhY/hFnR/QWw==
X-Received: by 2002:a63:e547:0:b0:473:e2bb:7fc7 with SMTP id z7-20020a63e547000000b00473e2bb7fc7mr4901625pgj.40.1669147565800;
        Tue, 22 Nov 2022 12:06:05 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i18-20020a056a00005200b0056f0753390csm11376369pfk.96.2022.11.22.12.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:06:05 -0800 (PST)
Date:   Tue, 22 Nov 2022 20:06:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, diviness@google.com,
        maz@kernel.org, dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com
Subject: Re: [V1 PATCH 1/6] KVM: x86: Add support for testing private memory
Message-ID: <Y30rqWwDRbH7nQaQ@google.com>
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-2-vannapurve@google.com>
 <20221122100705.GA619277@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122100705.GA619277@chaop.bj.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 22, 2022, Chao Peng wrote:
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 10017a9f26ee..b3118d00b284 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -4280,6 +4280,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> >  
> >  	fault->gfn = fault->addr >> PAGE_SHIFT;
> >  	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
> > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
> > +	fault->is_private = kvm_slot_can_be_private(fault->slot) &&
> > +			kvm_mem_is_private(vcpu->kvm, fault->gfn);
> > +#endif
> >  
> >  	if (page_fault_handle_page_track(vcpu, fault))
> >  		return RET_PF_EMULATE;
> > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > index 5cdff5ca546c..2e759f39c2c5 100644
> > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > @@ -188,7 +188,6 @@ struct kvm_page_fault {
> >  
> >  	/* Derived from mmu and global state.  */
> >  	const bool is_tdp;
> > -	const bool is_private;
> >  	const bool nx_huge_page_workaround_enabled;
> >  
> >  	/*
> > @@ -221,6 +220,9 @@ struct kvm_page_fault {
> >  	/* The memslot containing gfn. May be NULL. */
> >  	struct kvm_memory_slot *slot;
> >  
> > +	/* Derived from encryption bits of the faulting GPA for CVMs. */
> > +	bool is_private;
> 
> Either we can wrap it with the CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING or if
> it looks ugly I can remove the "const" in my code.

Hmm, I think we can keep the const.  Similar to the bug in kvm_faultin_pfn()[*],
the kvm_slot_can_be_private() is bogus.  A fault should be considered private if
it's marked as private, whether or not userspace has configured the slot to be
private is irrelevant.  I.e. the xarray is the single source of truth, memslots
are just plumbing.

Then kvm_mmu_do_page_fault() can do something like:

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index dbaf6755c5a7..456a9daa36e5 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -260,6 +260,8 @@ enum {
 static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
                                        u32 err, bool prefetch)
 {
+       bool is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault);
+
        struct kvm_page_fault fault = {
                .addr = cr2_or_gpa,
                .error_code = err,
@@ -269,13 +271,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
                .rsvd = err & PFERR_RSVD_MASK,
                .user = err & PFERR_USER_MASK,
                .prefetch = prefetch,
-               .is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
+               .is_tdp = is_tdp,
                .nx_huge_page_workaround_enabled =
                        is_nx_huge_page_enabled(vcpu->kvm),
 
                .max_level = KVM_MAX_HUGEPAGE_LEVEL,
                .req_level = PG_LEVEL_4K,
                .goal_level = PG_LEVEL_4K,
+               .private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
+                          kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
        };
        int r;

[*] https://lore.kernel.org/all/Y3Vgc5KrNRA8r6vh@google.com
