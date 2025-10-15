Return-Path: <linux-kselftest+bounces-43169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2CCBDD5B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 10:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 949BE1893F38
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9862D876F;
	Wed, 15 Oct 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u55Z+EvM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDC2D24AD;
	Wed, 15 Oct 2025 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516498; cv=none; b=H0xm2gRpsc0faFSGihzoKN5Rj2otCP2m1O0VDzmFswlKWnpQLgJiaGWBQvqIgDlcB0+51tMYEQsc9ylYIaheXnzSgp2g8wH8UZIZRrWSbKaI/4mlrydjgPxEQRD0boeI7OT3v0iZx3vwUamTEbIgZAFgWCemo7MIMX5Dp3EYxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516498; c=relaxed/simple;
	bh=aUyMg0r5Z6Pu1f8HinELT/IZMgwDZyyKT77Cbz9ISjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1RG09Jz4wPCjYpzTO1U06Py0nRipXz40vsDM5SgI/yVbI0oSqhZW+PuBAZxzLvIAart9y1Xj6ae7Vf7Fwi4FtnF03LaYTz96BEdLenXujhDZajoAHz/NbRMpk5tiOYzc3DJjoLSpd0OMSAtYpe+0X2n/OtwYXSvLzZ4faM/Z3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u55Z+EvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A175C4CEF8;
	Wed, 15 Oct 2025 08:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760516497;
	bh=aUyMg0r5Z6Pu1f8HinELT/IZMgwDZyyKT77Cbz9ISjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u55Z+EvMBzgWN6PmzJ4w2jPQk1OmAHY1Ltm98ZKLlILP6qsjXVlaDW1JPSjk/l4cC
	 6nixNt1kHAFbAioY7wPrDSkwrhzt0GQmM/RXf1fCLhyH9cJTQ7pNX5XTAdgTe/0KOS
	 UxccDGFrzDbf4ZakLZzrChf2iY+dxH4YZvQ+z2J8gq5kPm5XTJ14u0Cu7X9RvKVQgb
	 8mlcAQ802+06rdeKIocL1dphngXtsBd3GY3WqXYilMNlzD40b1bovdZJXNqmIYlESW
	 k/r0kWitA+2DjeieTpbzTW3MM4CvAG/K9slCPttLCvLO2CYRU3ictLCDx54x65PU1y
	 HCuaTguYdZYgg==
Date: Wed, 15 Oct 2025 11:21:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <aO9ZiERHff7vQiBL@kernel.org>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015053121.3978358-2-pasha.tatashin@soleen.com>

Hi Pasha,

On Wed, Oct 15, 2025 at 01:31:20AM -0400, Pasha Tatashin wrote:
>
> Subject: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area

Hmm, can't say I like liveupdate: kho: prefix. KHO: on it's own is shorter
and reflects that this is a KHO change rather than liveupdate.

> It is invalid for KHO metadata or preserved memory regions to be located
> within the KHO scratch area, as this area is overwritten when the next
> kernel is loaded, and used early in boot by the next kernel. This can
> lead to memory corruption.
> 
> Adds checks to kho_preserve_* and KHO's internal metadata allocators
> (xa_load_or_alloc, new_chunk) to verify that the physical address of the
> memory does not overlap with any defined scratch region. If an overlap
> is detected, the operation will fail and a WARN_ON is triggered. To
> avoid performance overhead in production kernels, these checks are
> enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/Kconfig                   | 15 ++++++++++

Feels like kernel/liveupdate/Makefile change is missing

>  kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
>  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
>  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
>  4 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index 522b9f74d605..d119f4f3f4b1 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
>  	  Also, enables inspecting the KHO fdt trees with the debugfs binary
>  	  blobs.
>  
> +config KEXEC_HANDOVER_DEBUG
> +	bool "Enable Kexec Handover debug checks"
> +	depends on KEXEC_HANDOVER_DEBUGFS
> +	help
> +	  This option enables extra sanity checks for the Kexec Handover
> +	  subsystem.
> +
> +	  These checks verify that neither preserved memory regions nor KHO's
> +	  internal metadata are allocated from within a KHO scratch area.
> +	  An overlap can lead to memory corruption during a subsequent kexec
> +	  operation.
> +
> +	  If an overlap is detected, the kernel will print a warning and the
> +	  offending operation will fail. This should only be enabled for
> +	  debugging purposes due to runtime overhead.
>  endmenu
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 5da21f1510cc..ef1e6f7a234b 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> +		kfree(elm);

I think __free() cleanup would be better than this.

> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
>  	if (xa_is_err(res))
>  		res = ERR_PTR(xa_err(res));
> @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
>  
>  	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!chunk)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);

I don't think it's important to return -errno here, it's not that it's
called from a syscall and we need to set errno for the userspace.
BTW, the same applies to xa_load_or_alloc() IMO.

> +
> +	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
> +		kfree(chunk);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>  	chunk->hdr.order = order;
>  	if (cur_chunk)
>  		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
> @@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  	struct khoser_mem_chunk *chunk = NULL;
>  	struct kho_mem_phys *physxa;
>  	unsigned long order;
> +	int ret = -ENOMEM;
>  
>  	xa_for_each(&kho_out->track.orders, order, physxa) {
>  		struct kho_mem_phys_bits *bits;
>  		unsigned long phys;
>  
>  		chunk = new_chunk(chunk, order);
> -		if (!chunk)
> +		if (IS_ERR(chunk)) {
> +			ret = PTR_ERR(chunk);

... and indeed, -errno from new_chunk() juts makes things more complex :(

>  			goto err_free;
> +		}
>  
>  		if (!first_chunk)
>  			first_chunk = chunk;
> @@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  
>  			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
>  				chunk = new_chunk(chunk, order);
> -				if (!chunk)
> +				if (IS_ERR(chunk)) {
> +					ret = PTR_ERR(chunk);
>  					goto err_free;
> +				}
>  			}
>  
>  			elm = &chunk->bitmaps[chunk->hdr.num_elms];
> @@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
>  
>  err_free:
>  	kho_mem_ser_free(first_chunk);
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  static void __init deserialize_bitmap(unsigned int order,
> @@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
>  	const unsigned int order = folio_order(folio);
>  	struct kho_mem_track *track = &kho_out.track;
>  
> +	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
> +		return -EINVAL;
> +
>  	return __kho_preserve_order(track, pfn, order);
>  }
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
> @@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  	unsigned long failed_pfn = 0;
>  	int err = 0;
>  
> +	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
> +					nr_pages << PAGE_SHIFT))) {
> +		return -EINVAL;
> +	}

Can't we check this in __kho_preseve_order() and not duplicate the code?

> +
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));

-- 
Sincerely yours,
Mike.

