Return-Path: <linux-kselftest+bounces-43539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A7BEFCA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD04C3B6A72
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABD2E8B9C;
	Mon, 20 Oct 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RorPQ5ol"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52D3A8F7;
	Mon, 20 Oct 2025 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947554; cv=none; b=LYPapp9jUQgh7YknL+ckFBzLUa/W8BrMkXya1g6RGiPJF1XXeiRLWzXTLCZof6z2X7xVB2LS+dK6ShHaDzR5kM52AIaJdemElGfiQ5I4w5dveZGxY6I2pNptEB1ZnysjxmeohvPFSrKxMjwOi0J6InvKiTs2LUf5ULQEfmtkzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947554; c=relaxed/simple;
	bh=rXda7spHoPBZ+btkYMydEsdxIcZXVOZHXuPQfGL5NOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifbkDghsBYByXmd9gklSTh/lQrbgQEk+z1thEnPOdv1sLdvpaUQ2pi1r+U79XsccMxI9rl2kQpv5h086cc23TalFX045yZgp/DvuRg41aEMGobDA1KDct00Z8GQA0J0sW36yeb8QwzRe6HAzNQ6KoYZpdjLp0osZU+fsu3rBnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RorPQ5ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AC4C4CEF9;
	Mon, 20 Oct 2025 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760947554;
	bh=rXda7spHoPBZ+btkYMydEsdxIcZXVOZHXuPQfGL5NOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RorPQ5olAs/Pyghkzn3Qc8h10zq3G79fwC1hL8SfRWZb9JgJbZWZsx3QyuBAuZhwQ
	 C1pNEdrWswDJ/U1+Ggy6ILEYWd99LIk6R1hdOqrP4sXWYKO9i7qz2dJyUEr1B3lrhf
	 UYJRcNABMc67F7U0tQR/iMO1gUOg4Tci/IGLfMczunIcDga+dIX/gDtgb8+UHrsmsD
	 pkSGFCN7LagnLRbPFB3utcBqN8bA0jptZQSAm9+VdUZx75mWv4I4/dUaPyhrVkPv3w
	 etGxXmQyQ35MZu+MQQAby00aklXEEhMx9yUpIY7rVOE/JEFD3jw9azZUII1W2dJCY+
	 1aZYlWJKxnePg==
Date: Mon, 20 Oct 2025 11:05:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, jasonmiu@google.com,
	dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v6 10/10] liveupdate: kho: allocate metadata directly
 from the buddy allocator
Message-ID: <aPXtWDPGHA2kCg32@kernel.org>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-11-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018171756.1724191-11-pasha.tatashin@soleen.com>

On Sat, Oct 18, 2025 at 01:17:56PM -0400, Pasha Tatashin wrote:
> KHO allocates metadata for its preserved memory map using the slab
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
> allocator instead of slab.
> 
> Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c8e89a6b953..92662739a3a2 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -132,6 +132,8 @@ static struct kho_out kho_out = {
>  	.finalized = false,
>  };
>  
> +DEFINE_FREE(kho_free_page, void *, free_page((unsigned long)_T))
> +

Just drop kho_ prefix and stick it into include/linux/gfp.h:

DEFINE_FREE(free_page, void *, if (_T) free_page((unsigned long)_T))

>  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
>  {
>  	void *res = xa_load(xa, index);
> @@ -139,7 +141,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
>  	if (res)
>  		return res;
>  
> -	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	void *elm __free(kho_free_page) = (void *)get_zeroed_page(GFP_KERNEL);
>  
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);
> @@ -352,9 +354,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
>  static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
>  					  unsigned long order)
>  {
> -	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
> +	struct khoser_mem_chunk *chunk __free(kho_free_page) = NULL;
>  
> -	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	chunk = (void *)get_zeroed_page(GFP_KERNEL);
>  	if (!chunk)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.51.0.915.g61a8936c21-goog
> 

-- 
Sincerely yours,
Mike.

