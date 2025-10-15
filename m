Return-Path: <linux-kselftest+bounces-43170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB1BDD73A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 10:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60A919C037A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 08:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91860306489;
	Wed, 15 Oct 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFjGFU8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1E22A4DA;
	Wed, 15 Oct 2025 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517459; cv=none; b=iUtPlPzYTKqc4FznphM+OMFubdm41fLTqPJn5KIsT9QnHAqnM7ATzV3cn5bmi6spnJWX4J7oDGbkQUjNMWkx+1D0uLDzK0CYK+aml5jTpGdO1hLsdhTlj0zRdYNXp7RiV7XxxPtc8sBSEf1Nj6cUP0sr3Icj7cQnwQIJdu2n7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517459; c=relaxed/simple;
	bh=gdYDtGzxadCRywoKsNND96qlV2l3VYovlotLaMP+lMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAo4f+c/xBDjdI0llleUDmvDpwaQuwrRjJLADqRFqXeDQxY4vMJlsFRRj5VUTqTwK6DZniVvP7gJOio15nYhWfNdCm8t9hYzmxdtRQVYbfJ5y6oqyVL4vc0CA13P2s7xjS85Vic4wzVmZL4uTw77Ho4bkwExci2dx9IA/34bG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFjGFU8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126B1C4CEF8;
	Wed, 15 Oct 2025 08:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760517459;
	bh=gdYDtGzxadCRywoKsNND96qlV2l3VYovlotLaMP+lMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFjGFU8ohMjiYW6cjmOLcobwbSKk44/bYESuCJCcbLXt5sAFPb/hStV94AooI+6Mt
	 +fKKoCiAKqVBSKJvDpNwYs59gKqdDNvXz/boQ6Vv9pu5vhAGnklQolhan/yVmnHVNY
	 /8uAV7aQ5dIhh2x2wJXfSnGp4Ltf1YXsvNvQk53/bS1sMY+0AeWDkwJwobY9ZxBYzV
	 y2hU2hxoL9IoHhV+2PN6hkdlFJ3QPPXKTjW9ubCtx7/DefVgbZ+0OLK1hQmYH9tWr+
	 x7/1o6lvTVTCdiMUWIvNEmTk0zqQWjhe8IsJravYG0L2DeZmrvItK8zzuGSh6Q2vcg
	 jJ9O811wcKFZA==
Date: Wed, 15 Oct 2025 11:37:30 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <aO9dSizvhyTznMHZ@kernel.org>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015053121.3978358-3-pasha.tatashin@soleen.com>

On Wed, Oct 15, 2025 at 01:31:21AM -0400, Pasha Tatashin wrote:
> KHO allocates metadata for its preserved memory map using the SLUB
> allocator via kzalloc(). This metadata is temporary and is used by the
> next kernel during early boot to find preserved memory.
> 
> A problem arises when KFENCE is enabled. kzalloc() calls can be
> randomly intercepted by kfence_alloc(), which services the allocation
> from a dedicated KFENCE memory pool. This pool is allocated early in
> boot via memblock.
> 
> When booting via KHO, the memblock allocator is restricted to a "scratch
> area", forcing the KFENCE pool to be allocated within it. This creates a
> conflict, as the scratch area is expected to be ephemeral and
> overwriteable by a subsequent kexec. If KHO metadata is placed in this
> KFENCE pool, it leads to memory corruption when the next kernel is
> loaded.
> 
> To fix this, modify KHO to allocate its metadata directly from the buddy
> allocator instead of SLUB.
> 
> As part of this change, the metadata bitmap size is increased from 512
> bytes to PAGE_SIZE to align with the page-based allocations from the
> buddy system.
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index ef1e6f7a234b..519de6d68b27 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -66,10 +66,10 @@ early_param("kho", kho_parse_enable);
>   * Keep track of memory that is to be preserved across KHO.
>   *
>   * The serializing side uses two levels of xarrays to manage chunks of per-order
> - * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
> - * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
> - * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
> - * 512K of bitmap memory will be needed for order 0.
> + * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
> + * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
> + * allocations each bitmap will cover 128M of address space. Thus, for 16G of
> + * memory at most 512K of bitmap memory will be needed for order 0.
>   *
>   * This approach is fully incremental, as the serialization progresses folios
>   * can continue be aggregated to the tracker. The final step, immediately prior
> @@ -77,7 +77,7 @@ early_param("kho", kho_parse_enable);
>   * successor kernel to parse.
>   */
>  
> -#define PRESERVE_BITS (512 * 8)
> +#define PRESERVE_BITS (PAGE_SIZE * 8)
>  
>  struct kho_mem_phys_bits {
>  	DECLARE_BITMAP(preserve, PRESERVE_BITS);
> @@ -131,18 +131,21 @@ static struct kho_out kho_out = {
>  
>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)

The name 'xa_load_or_alloc' is confusing now that we only use this function
to allocate bitmaps. I think it should be renamed to reflect that and it's
return type should be 'struct kho_mem_phys_bits'. Then it wouldn't need sz
parameter and the size calculations below become redundant.

>  {
> +	unsigned int order;
>  	void *elm, *res;
>  
>  	elm = xa_load(xa, index);
>  	if (elm)
>  		return elm;
>  
> -	elm = kzalloc(sz, GFP_KERNEL);
> +	order = get_order(sz);
> +	elm = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> -		kfree(elm);
> +	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm),
> +					PAGE_SIZE << order))) {
> +		free_pages((unsigned long)elm, order);
>  		return ERR_PTR(-EINVAL);
>  	}
>  

-- 
Sincerely yours,
Mike.

