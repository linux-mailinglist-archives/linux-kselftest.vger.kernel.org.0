Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8456379D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Nov 2022 14:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiKXNVv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Nov 2022 08:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiKXNVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Nov 2022 08:21:49 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD87210B;
        Thu, 24 Nov 2022 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669296108; x=1700832108;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=Gbs0pJDzc/tagX8P07oSo6k68mvIwwsUtrxMBVb54fM=;
  b=lKy/8U/EMRlaYlJxAzoTd4FU+D/8exdZDHiXdY8XZgEmbV/eB4KQ2IFq
   EtMWYL8e8fJhQnI1B7eKWApjsRqIg+png+/ZQqeOny9BGVSikIzpqdvwt
   GkuAnOy6+Ud2wjmvJ3+/aBH26ZmY7stzb8cCMKHjz8YojXMFJZ9KwwsQH
   hu58S/mzq0hhty3389k36G+ocifzlR+PwtXQfHuTg5AOXDXwKEmAKV7iN
   6/7Pzn45H0s+IFzyrq2ZbSpxdTSmX+95GHmo77ZzyzW6Xt2PR7X44KOci
   JILWkru37oQh03BMkqZ0I+AGO80p7LXtZDITNeRtntAE5J+xNXKXdTo/5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="376443342"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="376443342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 05:21:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="705760358"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="705760358"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2022 05:21:34 -0800
Date:   Thu, 24 Nov 2022 21:17:12 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <20221124131712.GA689510@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-2-vannapurve@google.com>
 <20221122100705.GA619277@chaop.bj.intel.com>
 <Y30rqWwDRbH7nQaQ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y30rqWwDRbH7nQaQ@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 22, 2022 at 08:06:01PM +0000, Sean Christopherson wrote:
> On Tue, Nov 22, 2022, Chao Peng wrote:
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index 10017a9f26ee..b3118d00b284 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -4280,6 +4280,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
> > >  
> > >  	fault->gfn = fault->addr >> PAGE_SHIFT;
> > >  	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
> > > +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
> > > +	fault->is_private = kvm_slot_can_be_private(fault->slot) &&
> > > +			kvm_mem_is_private(vcpu->kvm, fault->gfn);
> > > +#endif
> > >  
> > >  	if (page_fault_handle_page_track(vcpu, fault))
> > >  		return RET_PF_EMULATE;
> > > diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> > > index 5cdff5ca546c..2e759f39c2c5 100644
> > > --- a/arch/x86/kvm/mmu/mmu_internal.h
> > > +++ b/arch/x86/kvm/mmu/mmu_internal.h
> > > @@ -188,7 +188,6 @@ struct kvm_page_fault {
> > >  
> > >  	/* Derived from mmu and global state.  */
> > >  	const bool is_tdp;
> > > -	const bool is_private;
> > >  	const bool nx_huge_page_workaround_enabled;
> > >  
> > >  	/*
> > > @@ -221,6 +220,9 @@ struct kvm_page_fault {
> > >  	/* The memslot containing gfn. May be NULL. */
> > >  	struct kvm_memory_slot *slot;
> > >  
> > > +	/* Derived from encryption bits of the faulting GPA for CVMs. */
> > > +	bool is_private;
> > 
> > Either we can wrap it with the CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING or if
> > it looks ugly I can remove the "const" in my code.
> 
> Hmm, I think we can keep the const.  Similar to the bug in kvm_faultin_pfn()[*],
> the kvm_slot_can_be_private() is bogus.  A fault should be considered private if
> it's marked as private, whether or not userspace has configured the slot to be
> private is irrelevant.  I.e. the xarray is the single source of truth, memslots
> are just plumbing.

That makes sense to me. Thanks.

> 
> Then kvm_mmu_do_page_fault() can do something like:
> 
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index dbaf6755c5a7..456a9daa36e5 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -260,6 +260,8 @@ enum {
>  static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                                         u32 err, bool prefetch)
>  {
> +       bool is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault);
> +
>         struct kvm_page_fault fault = {
>                 .addr = cr2_or_gpa,
>                 .error_code = err,
> @@ -269,13 +271,15 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                 .rsvd = err & PFERR_RSVD_MASK,
>                 .user = err & PFERR_USER_MASK,
>                 .prefetch = prefetch,
> -               .is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
> +               .is_tdp = is_tdp,
>                 .nx_huge_page_workaround_enabled =
>                         is_nx_huge_page_enabled(vcpu->kvm),
>  
>                 .max_level = KVM_MAX_HUGEPAGE_LEVEL,
>                 .req_level = PG_LEVEL_4K,
>                 .goal_level = PG_LEVEL_4K,
> +               .private = IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING) && is_tdp &&
> +                          kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT),
>         };
>         int r;
> 
> [*] https://lore.kernel.org/all/Y3Vgc5KrNRA8r6vh@google.com
