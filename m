Return-Path: <linux-kselftest+bounces-43179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB664BDE688
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A539D4E70DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF70324B30;
	Wed, 15 Oct 2025 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sd5Ito2z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D161E5205;
	Wed, 15 Oct 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530247; cv=none; b=imnB6vyjVhK9wjPuCDxWAC8YTKGm2mRg5fhoWa2o6yFSFL0JaStyJgQHyGO2Mgfa7Ryt3xmG2XtcDw8eghyryhGbgA6mvWUZYgR5DIlhasI3vJ67Sp4bKkPWoD0H484wFq3+SypHqtvADHj+PZExO/2xs222hlGFEqcyAH6OuUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530247; c=relaxed/simple;
	bh=FRp2nP/cabZWIQTDCFbnZuskgerA1RB/tXfMpaKNBeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjrngBa+zB5ih52D+LxZpy6VuXQjfI5FFUdNtri189CZJR/L2IZGWgkeRhaA/0ncbQ9CUe+5li5SWanOfCbVqIKK2xAkdw6/PAqBrPNB3R8p8eY7s07J07JphXNz6HBfrOO0DzxHA9R3rj8VZ8ZoBzrsgpgwvTtyBpEQMFhTsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sd5Ito2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75197C4CEF8;
	Wed, 15 Oct 2025 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530246;
	bh=FRp2nP/cabZWIQTDCFbnZuskgerA1RB/tXfMpaKNBeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sd5Ito2zl8yQO/MD6izBpbkQAVgwascCvAqBfIQR3xW8OA7rngdhvt9B6dIBGQnnd
	 bhQHJQIOObOA3A/qMXGlxL1uE5OhQ6OelV16v1EhWvOFiEnhTIvBdA7rogW4hJJzag
	 r9Y0enGq8mLUUp52YEJw6qQdUjCMN/LISe8He4d3+Ea30IeQSwxMBXFw0i3lhKeWYH
	 PPph2OZ2gtJCSO07L4BDV/0R6heC92LTIgWUNnjOHm3jOHxgd2y0bUQbiQnlKCMYes
	 5ByZB9EfQNHq1KKSeyzRb7pFFa6CxqjpNUSz6W5kUTxdKPfdJnIoncFtSo/9ETOtbp
	 9PKuHLBk3ADAQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  jasonmiu@google.com,  dmatlack@google.com,  skhawaja@google.com
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
In-Reply-To: <20251015053121.3978358-2-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 15 Oct 2025 01:31:20 -0400")
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
	<20251015053121.3978358-2-pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 14:10:43 +0200
Message-ID: <mafs0zf9sjrgc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 15 2025, Pasha Tatashin wrote:

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

Why the dependency on debugfs? Why can't the debug checks be enabled
independently?

> +	help
> +	  This option enables extra sanity checks for the Kexec Handover
> +	  subsystem.
> +
> +	  These checks verify that neither preserved memory regions nor KHO's
> +	  internal metadata are allocated from within a KHO scratch area.
> +	  An overlap can lead to memory corruption during a subsequent kexec
> +	  operation.

I don't think the checks that are done should be listed here since as
soon as another check is added this list will become out of date.

> +
> +	  If an overlap is detected, the kernel will print a warning and the
> +	  offending operation will fail. This should only be enabled for

This also describes the behaviour of the checks, which might change
later. Maybe for some checks the operation won't fail? I suppose just
leave it at "the kernel will print a warning"?

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
> +
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
>  			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
> diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
> index eb47f000887d..294d1d290142 100644
> --- a/kernel/liveupdate/kexec_handover_debug.c
> +++ b/kernel/liveupdate/kexec_handover_debug.c
> @@ -214,3 +214,21 @@ __init int kho_debugfs_init(void)
>  		return -ENOENT;
>  	return 0;
>  }
> +
> +#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
> +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> +{
> +	phys_addr_t scratch_start, scratch_end;
> +	unsigned int i;
> +
> +	for (i = 0; i < kho_scratch_cnt; i++) {
> +		scratch_start = kho_scratch[i].addr;
> +		scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;

Nit: wouldn't it be a tad bit simpler to do

		scratch_end = kho_scratch[i].addr + kho_scratch[i].size;

> +
> +		if (phys <= scratch_end && (phys + size) > scratch_start)

and here

		if (phys < scratch_end && (phys + size) > scratch_start)

At least I find it slightly easier to understand, though I don't think
it makes too much of a difference so either way is fine.

> +			return true;
> +	}
> +
> +	return false;
> +}
> +#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
> diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
> index b3fc1957affa..92798346fa5a 100644
> --- a/kernel/liveupdate/kexec_handover_internal.h
> +++ b/kernel/liveupdate/kexec_handover_internal.h
> @@ -44,4 +44,13 @@ static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
>  					  void *fdt) { }
>  #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
>  
> +#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
> +bool kho_scratch_overlap(phys_addr_t phys, size_t size);
> +#else
> +static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
> +
>  #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */

-- 
Regards,
Pratyush Yadav

