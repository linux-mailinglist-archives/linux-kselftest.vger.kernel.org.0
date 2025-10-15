Return-Path: <linux-kselftest+bounces-43199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8DBDE9FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 15:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8358D1884391
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 13:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D3308F2E;
	Wed, 15 Oct 2025 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F12SqXdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E3482EB;
	Wed, 15 Oct 2025 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533510; cv=none; b=jksT0qmLbNSidE3c63/cHd4K7D9++bAYCQp8hjdgxHt+WkG/9z8TxtnibP59G2BrPhemnzDnN+adncnJRG4GzDQTlkIUnSIKH9u7opCpc0sSCdMOxzHigoFzVpUQb/xiUdsV8ebHHAKYskpcqSzjkn3OnsNuVha1pzbU7YS9O4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533510; c=relaxed/simple;
	bh=2ad4JdcB1dy+2CtYWky5FKUKrCrxFnEL7ZzpoxjFRAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OhheQh7ok3E2wPDkgu17ef9m/q4WcCGFs3OPMMW5E9qcMYOMIVCMSmZXqAtIt9ugYTQIJcTZ43LCVIpYgAcLBLcc8cRI6xug2/Nn/5aRJoM448nqpgjkYTuGNTs48/rm8WLuaDs/OjGbGl6IS0qHFQqYg2RxbaO6mQCeAmpvAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F12SqXdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4773C4CEF8;
	Wed, 15 Oct 2025 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533509;
	bh=2ad4JdcB1dy+2CtYWky5FKUKrCrxFnEL7ZzpoxjFRAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F12SqXdhbLXz05zwQrekYKF8O2vnJ9nCDTpE5dudRvebGwlmWhKNdsmccdILjpq46
	 L8rSlTNMs5ad4QaNiIwBoPBzLwTsli8z/UmumMaDdjuvTLhP+U99FspQvl2vuSnT5y
	 Nx08AGpCO2HP1B/FEAx+E2Yo3A6G1zH2JNTQNW11R+yhvXZVygEveX3xFnqjoa9c7k
	 RZW0K1fbaNHN+utYQZ33x+V4pjidmSdp0/F0jKS1C5dH5hOv/SbvRqa3N8VCIPAkUH
	 D90O9K2/8Bccg6glBB4fgj3vrIVSAP5OAp7fSu1ywQmErqjxu1b2e72oyfa3p0f8yk
	 zfQvF0IBBrI+w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  brauner@kernel.org,  corbet@lwn.net,
  graf@amazon.com,  jgg@ziepe.ca,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,
  masahiroy@kernel.org,  ojeda@kernel.org,  pratyush@kernel.org,
  rdunlap@infradead.org,  rppt@kernel.org,  tj@kernel.org,
  jasonmiu@google.com,  dmatlack@google.com,  skhawaja@google.com,
 glider@google.com, elver@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from
 the buddy allocator
In-Reply-To: <20251015053121.3978358-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 15 Oct 2025 01:31:21 -0400")
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
	<20251015053121.3978358-3-pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 15:05:05 +0200
Message-ID: <mafs0v7kgjoxq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

+Cc Marco, Alexander

On Wed, Oct 15 2025, Pasha Tatashin wrote:

> KHO allocates metadata for its preserved memory map using the SLUB
> allocator via kzalloc(). This metadata is temporary and is used by the
> next kernel during early boot to find preserved memory.
>
> A problem arises when KFENCE is enabled. kzalloc() calls can be
> randomly intercepted by kfence_alloc(), which services the allocation
> from a dedicated KFENCE memory pool. This pool is allocated early in
> boot via memblock.

At some point, we'd probably want to add support for preserving slab
objects using KHO. That wouldn't work if the objects can land in scratch
memory. Right now, the kfence pools are allocated right before KHO goes
out of scratch-only and memblock frees pages to buddy.

	kfence_alloc_pool_and_metadata();
	report_meminit();
	kmsan_init_shadow();
	stack_depot_early_init();
        [...]
	kho_memory_init();

	memblock_free_all();

Can't kfence allocate its pool right after memblock_free_all()? IIUC at
that point, there shouldn't be much fragmentation and allocations should
still be possible.

Another idea could be to disable scratch-only a bit earlier and add an
option in memblock_alloc() to avoid scratch areas?

Anyway, not something we need to solve right now with this series.
Something to figure out eventually.

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

The implication of this change is that preservation metadata becomes
less memory-efficient when preserved pages are sparse. Mainly because if
only one bit is set in the bitmap, now 4k bytes of memory is used
instead of 512 bytes.

It is hard to say what difference this makes in practice without
sampling real workloads, but perhaps still worth mentioning in the
commit message?

Other than this,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

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
> @@ -151,7 +154,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
>  		res = ERR_PTR(xa_err(res));
>  
>  	if (res) {
> -		kfree(elm);
> +		free_pages((unsigned long)elm, order);
>  		return res;
>  	}
>  
> @@ -357,7 +360,7 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
>  {
>  	struct khoser_mem_chunk *chunk;
>  
> -	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	chunk = (void *)get_zeroed_page(GFP_KERNEL);
>  	if (!chunk)
>  		return ERR_PTR(-ENOMEM);

-- 
Regards,
Pratyush Yadav

