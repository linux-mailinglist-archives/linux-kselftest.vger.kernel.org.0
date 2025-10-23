Return-Path: <linux-kselftest+bounces-43847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44620BFF7D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 09:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265B84E9E76
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21092D0C7D;
	Thu, 23 Oct 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+22Ya4t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A912D0628;
	Thu, 23 Oct 2025 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203833; cv=none; b=c/EN0STH4ZuW5zUhuEi7qm5cX7iLvjweXsErWxOWgoE6P2Axf+jQ8n7YiX0Hrq0/DEFcnDbdmuFdDPLYFdChrCNpFnD0gD43gtuZlZ8UKBg2t3Kf+S4ggifvX0FJ85y4CXOvzAYKNb80CLo5Z5tQ8u4atqkKPYgtgKuixl+7Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203833; c=relaxed/simple;
	bh=aJYcehfYwCvCUDaOKLROIKDPOq2/3yfyKeSUDbsb094=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWcf4y/zIAxx0f3wlisx/PuWkEj5oGeWBD+ZK8WGFuaCCO2ZCizoyBPGUfL3FW6DfcMxPT+JQ/E6NfCErO30NiTk5QYKnf0gK8NXXohAPJ8xFTzwUomqAY0iE7KVCg1eWOoOkUCeSCG0r+WfoN06SB0EMEPG6vzWXVHX3nRXgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+22Ya4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0099C4CEE7;
	Thu, 23 Oct 2025 07:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761203832;
	bh=aJYcehfYwCvCUDaOKLROIKDPOq2/3yfyKeSUDbsb094=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+22Ya4tF4cs0PyG5qMCz9ZDJ5xI4RUMHO2k5YjnMwo/ncjwP3h8Lelvmdag4gBJx
	 0qlqSyk4jej73GsN0F96Jenh90MjO8BJReLdJ9j65POtT/4LB8Ve/s4vVumK3pXaCb
	 red9qoBGMqbSmvv/PfsJT2KkzkbDrlF7CNAn22IGKhrVAsVLz6cUWJgUbfcu865P+V
	 WDt6cdkd+Tl9nArdND+mKUCLV6eHE1sGb/tizDO69lcG00W1d6O08UtPJhJlaqsapL
	 jJWxp/LTkIKLfmArPg4Og52A9sEGFygDdVEdFqQ7oNxc5nTLALOh/GQ3UGdkPRFH0N
	 ZQnAgxyiGHL3g==
Date: Thu, 23 Oct 2025 10:17:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page
 ranges
Message-ID: <aPnWbzytZ3I0heDb@kernel.org>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
 <20251022005719.3670224-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022005719.3670224-5-pasha.tatashin@soleen.com>

On Tue, Oct 21, 2025 at 08:57:16PM -0400, Pasha Tatashin wrote:
> Allow users of KHO to cancel the previous preservation by adding the
> necessary interfaces to unpreserve folio and pages.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kexec_handover.h | 12 +++++
>  kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
>  2 files changed, 84 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 2faf290803ce..4ba145713838 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -43,7 +43,9 @@ bool kho_is_enabled(void);
>  bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
> +int kho_unpreserve_folio(struct folio *folio);
>  int kho_preserve_pages(struct page *page, unsigned int nr_pages);
> +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
> @@ -76,11 +78,21 @@ static inline int kho_preserve_folio(struct folio *folio)
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_unpreserve_folio(struct folio *folio)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int kho_preserve_vmalloc(void *ptr,
>  				       struct kho_vmalloc *preservation)
>  {
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 0a4234269fe5..8412897385ad 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -157,26 +157,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
>  	return no_free_ptr(elm);
>  }
>  
> -static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> -			     unsigned long end_pfn)
> +static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
> +				   unsigned int order)
>  {
>  	struct kho_mem_phys_bits *bits;
>  	struct kho_mem_phys *physxa;
> +	const unsigned long pfn_high = pfn >> order;
>  
> -	while (pfn < end_pfn) {
> -		const unsigned int order =
> -			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> -		const unsigned long pfn_high = pfn >> order;
> +	physxa = xa_load(&track->orders, order);
> +	if (!physxa)
> +		return;
> +
> +	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> +	if (!bits)
> +		return;
>  
> -		physxa = xa_load(&track->orders, order);
> -		if (!physxa)
> -			continue;
> +	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +}
> +
> +static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
> +			     unsigned long end_pfn)
> +{
> +	unsigned int order;
>  
> -		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
> -		if (!bits)
> -			continue;
> +	while (pfn < end_pfn) {
> +		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>  
> -		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
> +		__kho_unpreserve_order(track, pfn, order);
>  
>  		pfn += 1 << order;
>  	}
> @@ -749,6 +756,30 @@ int kho_preserve_folio(struct folio *folio)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
> +/**
> + * kho_unpreserve_folio - unpreserve a folio.
> + * @folio: folio to unpreserve.
> + *
> + * Instructs KHO to unpreserve a folio that was preserved by
> + * kho_preserve_folio() before. The provided @folio (pfn and order)
> + * must exactly match a previously preserved folio.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_folio(struct folio *folio)
> +{
> +	const unsigned long pfn = folio_pfn(folio);
> +	const unsigned int order = folio_order(folio);
> +	struct kho_mem_track *track = &kho_out.track;
> +
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	__kho_unpreserve_order(track, pfn, order);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
> +
>  /**
>   * kho_preserve_pages - preserve contiguous pages across kexec
>   * @page: first page in the list.
> @@ -793,6 +824,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_pages);
>  
> +/**
> + * kho_unpreserve_pages - unpreserve contiguous pages.
> + * @page: first page in the list.
> + * @nr_pages: number of pages.
> + *
> + * Instructs KHO to unpreserve @nr_pages contigious  pages starting from @page.
> + * This call must exactly match a granularity at which memory was originally
> + * preserved by kho_preserve_pages, call with the same @page and
> + * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved blocks is
> + * not supported.
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
> +{
> +	struct kho_mem_track *track = &kho_out.track;
> +	const unsigned long start_pfn = page_to_pfn(page);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +
> +	if (kho_out.finalized)
> +		return -EBUSY;
> +
> +	__kho_unpreserve(track, start_pfn, end_pfn);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
> +
>  struct kho_vmalloc_hdr {
>  	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
>  };
> -- 
> 2.51.0.915.g61a8936c21-goog
> 

-- 
Sincerely yours,
Mike.

