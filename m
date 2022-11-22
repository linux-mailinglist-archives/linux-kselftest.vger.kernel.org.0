Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CD0633970
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiKVKMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 05:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiKVKLr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 05:11:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918954B3C;
        Tue, 22 Nov 2022 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669111904; x=1700647904;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=usjdVgC5nTrsMPk+N8fokwP8pD99HC8BUV8bc4gHSuA=;
  b=HfctUD3QggyPX6zsCVtLICrnp+4l6+zBAxUgUW+joSiPYur6A/8YyUfA
   LbkyemKdOvF6fezsw1CdCzRm4V4wxqxKEG+o8OxCyPjQXWkvBpUp//CLn
   tAAe8Yuujo1pXALer2qrYmWbgSNwNzy9prgeigUgNhOxOZ90uExSDWF/0
   hCYGlxcZmhvy+6T8Q3lgUOEB2jwAyC/NqILlLsfWIE9B/8gEdfQhvBmWW
   nWlops7Wyoc9NQFW7FiAbgLd1I4rjHBkeLN7tX1Mi2ak6ztGss4bysTof
   APsf1PZSb4sLGTl9WrXUlrhht7SqDvkchaHna8t0ixC1lOP4vKh3jcfRk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="400071024"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="400071024"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 02:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="704914294"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="704914294"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.193.75])
  by fmsmga008.fm.intel.com with ESMTP; 22 Nov 2022 02:11:28 -0800
Date:   Tue, 22 Nov 2022 18:07:05 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Subject: Re: [V1 PATCH 1/6] KVM: x86: Add support for testing private memory
Message-ID: <20221122100705.GA619277@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221111014244.1714148-1-vannapurve@google.com>
 <20221111014244.1714148-2-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111014244.1714148-2-vannapurve@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 01:42:39AM +0000, Vishal Annapurve wrote:
> Introduce HAVE_KVM_PRIVATE_MEM_TESTING config to be able to test fd based
> approach to support private memory with non-confidential selftest VMs.
> To support this testing few important aspects need to be considered from
> the perspective of selftests -
> * KVM needs to know whether the access from guest VM is private or shared.
> Confidential VMs (SNP/TDX) carry a dedicated bit in gpa that can be used by
> KVM to deduce the nature of the access.
> Non-confidential VMs don't have mechanism to carry/convey such an
> information to KVM. So KVM just relies on what attributes are set by
> userspace VMM keeping the userspace VMM in the TCB for the testing
> purposes.
> * arch_private_mem_supported is updated to allow private memory logic to
> work with non-confidential vm selftests.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 4 ++++
>  arch/x86/kvm/mmu/mmu_internal.h | 4 +++-
>  virt/kvm/Kconfig                | 4 ++++
>  virt/kvm/kvm_main.c             | 2 +-
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 10017a9f26ee..b3118d00b284 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4280,6 +4280,10 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  
>  	fault->gfn = fault->addr >> PAGE_SHIFT;
>  	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
> +#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
> +	fault->is_private = kvm_slot_can_be_private(fault->slot) &&
> +			kvm_mem_is_private(vcpu->kvm, fault->gfn);
> +#endif
>  
>  	if (page_fault_handle_page_track(vcpu, fault))
>  		return RET_PF_EMULATE;
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 5cdff5ca546c..2e759f39c2c5 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -188,7 +188,6 @@ struct kvm_page_fault {
>  
>  	/* Derived from mmu and global state.  */
>  	const bool is_tdp;
> -	const bool is_private;
>  	const bool nx_huge_page_workaround_enabled;
>  
>  	/*
> @@ -221,6 +220,9 @@ struct kvm_page_fault {
>  	/* The memslot containing gfn. May be NULL. */
>  	struct kvm_memory_slot *slot;
>  
> +	/* Derived from encryption bits of the faulting GPA for CVMs. */
> +	bool is_private;

Either we can wrap it with the CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING or if
it looks ugly I can remove the "const" in my code.

Chao
> +
>  	/* Outputs of kvm_faultin_pfn.  */
>  	kvm_pfn_t pfn;
>  	hva_t hva;
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 69ca59e82149..300876afb0ca 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -93,3 +93,7 @@ config HAVE_KVM_RESTRICTED_MEM
>  config KVM_GENERIC_PRIVATE_MEM
>         bool
>         depends on HAVE_KVM_RESTRICTED_MEM
> +
> +config HAVE_KVM_PRIVATE_MEM_TESTING
> +       bool
> +       depends on KVM_GENERIC_PRIVATE_MEM
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index dae6a2c196ad..54e57b7f1c15 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1750,7 +1750,7 @@ static void kvm_replace_memslot(struct kvm *kvm,
>  
>  bool __weak kvm_arch_has_private_mem(struct kvm *kvm)
>  {
> -	return false;
> +	return IS_ENABLED(CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING);
>  }
>  
>  static int check_memory_region_flags(struct kvm *kvm,
> -- 
> 2.38.1.431.g37b22c650d-goog
