Return-Path: <linux-kselftest+bounces-2249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3228196E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 03:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F298B24F48
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 02:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094A1857;
	Wed, 20 Dec 2023 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2UuTASm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E5BA5E;
	Wed, 20 Dec 2023 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703040191; x=1734576191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5KZpWRhE02/YKJt8pKhmik0cSB79JwRv8nivSCwdSvg=;
  b=K2UuTASmFz/090q/SS3Y2lcmDVPP3EfKnDQAc9Wx5Cr6jIRpl669csVA
   zsZLg6DcabvUdDwrzHzJxqInxyQdhuoLAeH+qQDmYMqUdjRmt8qa1dxKK
   sxrioiaaWmJoJh8mYakW6wZag4tiWcvdE0X2HMfmEZl5PorNw4RTk/Xv+
   878T35KfShlPMW1pKZgrs0TF+GUS9m6FHZCZ3vRtBjzsB7dAgaakbMUTZ
   e1MV7Hl+Eky8ThTfUvdocKJr9eYZ/U5Cc4Lp8tLxtjn2SGVxjIJBMLiQj
   LXMWmwaPPKztUD6hcY912RTeMDHQnEGG7y7kW3XuLFnLpGMdDaNEGP0Pp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="17307952"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="17307952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:43:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="776178874"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="776178874"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 19 Dec 2023 18:43:05 -0800
Date: Wed, 20 Dec 2023 10:40:34 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 08/19] KVM: pfncache: allow a cache to be activated
 with a fixed (userspace) HVA
Message-ID: <ZYJUIsQM06mhzOTY@yilunxu-OptiPlex-7050>
References: <20231219161109.1318-1-paul@xen.org>
 <20231219161109.1318-9-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219161109.1318-9-paul@xen.org>

On Tue, Dec 19, 2023 at 04:10:58PM +0000, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Some pfncache pages may actually be overlays on guest memory that have a
> fixed HVA within the VMM. It's pointless to invalidate such cached
> mappings if the overlay is moved so allow a cache to be activated directly
> with the HVA to cater for such cases. A subsequent patch will make use
> of this facility.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> 
> v11:
>  - Fixed kvm_gpc_check() to ignore memslot generation if the cache is not
>    activated with a GPA. (This breakage occured during the re-work for v8).
> 
> v9:
>  - Pass both GPA and HVA into __kvm_gpc_refresh() rather than overloading
>    the address paraneter and using a bool flag to indicated what it is.
> 
> v8:
>  - Re-worked to avoid messing with struct gfn_to_pfn_cache.
> ---
>  include/linux/kvm_host.h | 20 +++++++++++++++++++-
>  virt/kvm/pfncache.c      | 40 +++++++++++++++++++++++++++++++---------
>  2 files changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6097f076a7b0..8120674b87b0 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1345,6 +1345,22 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
>   */
>  int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len);
>  
> +/**
> + * kvm_gpc_activate_hva - prepare a cached kernel mapping and HPA for a given HVA.
> + *
> + * @gpc:          struct gfn_to_pfn_cache object.
> + * @hva:          userspace virtual address to map.
> + * @len:          sanity check; the range being access must fit a single page.
> + *
> + * @return:       0 for success.
> + *                -EINVAL for a mapping which would cross a page boundary.
> + *                -EFAULT for an untranslatable guest physical address.
> + *
> + * The semantics of this function are the same as those of kvm_gpc_activate(). It
> + * merely bypasses a layer of address translation.
> + */
> +int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long hva, unsigned long len);
> +
>  /**
>   * kvm_gpc_check - check validity of a gfn_to_pfn_cache.
>   *
> @@ -1399,7 +1415,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc);
>  static inline void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>  {
>  	lockdep_assert_held(&gpc->lock);
> -	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> +
> +	if (gpc->gpa != KVM_XEN_INVALID_GPA)
> +		mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
>  }
>  
>  void kvm_sigset_activate(struct kvm_vcpu *vcpu);
> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 97eec8ee3449..ae822bff812f 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -48,7 +48,10 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsigned long len)
>  	if (!gpc->active)
>  		return false;
>  
> -	if (gpc->generation != slots->generation || kvm_is_error_hva(gpc->uhva))
> +	if (gpc->gpa != KVM_XEN_INVALID_GPA && gpc->generation != slots->generation)
> +		return false;
> +
> +	if (kvm_is_error_hva(gpc->uhva))
>  		return false;
>  
>  	if (offset_in_page(gpc->uhva) + len > PAGE_SIZE)
> @@ -209,11 +212,13 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
>  	return -EFAULT;
>  }
>  
> -static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
> +static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
>  			     unsigned long len)
>  {
>  	struct kvm_memslots *slots = kvm_memslots(gpc->kvm);
> -	unsigned long page_offset = offset_in_page(gpa);
> +	unsigned long page_offset = (gpa != KVM_XEN_INVALID_GPA) ?
> +		offset_in_page(gpa) :
> +		offset_in_page(uhva);
>  	bool unmap_old = false;
>  	unsigned long old_uhva;
>  	kvm_pfn_t old_pfn;
> @@ -246,9 +251,15 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>  	old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
>  	old_uhva = PAGE_ALIGN_DOWN(gpc->uhva);
>  
> -	/* Refresh the userspace HVA if necessary */
> -	if (gpc->gpa != gpa || gpc->generation != slots->generation ||
> -	    kvm_is_error_hva(gpc->uhva)) {
> +	if (gpa == KVM_XEN_INVALID_GPA) {
> +		gpc->gpa = KVM_XEN_INVALID_GPA;
> +		gpc->uhva = PAGE_ALIGN_DOWN(uhva);
> +
> +		if (gpc->uhva != old_uhva)
> +			hva_change = true;
> +	} else if (gpc->gpa != gpa ||
> +		   gpc->generation != slots->generation ||
> +		   kvm_is_error_hva(gpc->uhva)) {
>  		gfn_t gfn = gpa_to_gfn(gpa);
>  
>  		gpc->gpa = gpa;
> @@ -319,7 +330,7 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa,
>  
>  int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
>  {
> -	return __kvm_gpc_refresh(gpc, gpc->gpa, len);
> +	return __kvm_gpc_refresh(gpc, gpc->gpa, gpc->uhva, len);
>  }
>  
>  void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
> @@ -332,7 +343,8 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
>  	gpc->uhva = KVM_HVA_ERR_BAD;
>  }
>  
> -int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
> +static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
> +			      unsigned long len)
>  {
>  	struct kvm *kvm = gpc->kvm;
>  
> @@ -353,7 +365,17 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
>  		gpc->active = true;
>  		write_unlock_irq(&gpc->lock);
>  	}
> -	return __kvm_gpc_refresh(gpc, gpa, len);
> +	return __kvm_gpc_refresh(gpc, gpa, uhva, len);
> +}
> +
> +int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
> +{
> +	return __kvm_gpc_activate(gpc, gpa, KVM_HVA_ERR_BAD, len);
> +}
> +
> +int kvm_gpc_activate_hva(struct gfn_to_pfn_cache *gpc, unsigned long uhva, unsigned long len)
> +{
> +	return __kvm_gpc_activate(gpc, KVM_XEN_INVALID_GPA, uhva, len);
>  }
>  
>  void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)

The code looks good to me, but I feel odd that a *gfn*_to_pfn_cache is
used, but gfn is not taken into account.

I think if it is possible we introduce an hva_to_pfn_cache(hpc) that
actually does most of the job in this file. Xen could directly use hpc,
and gfn_to_pfn_cache works on top of hpc.


BTW: I also see there is a gfn_to_hva_cache which does pretty much the
same as gpc's first half job. Is it possible to unify them like:

struct gfn_to_pfn_cache {
	struct gfn_to_hva_cache ghc;
	struct hva_to_pfn_cache hpc;
	...
}

Just my two cents.

Thanks,
Yilun

> -- 
> 2.39.2
> 
> 

