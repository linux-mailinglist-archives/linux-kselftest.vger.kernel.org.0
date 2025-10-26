Return-Path: <linux-kselftest+bounces-44068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8532C0AD85
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 17:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D68A3A6DD0
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205AB22A4D5;
	Sun, 26 Oct 2025 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQ4SiShq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC155366;
	Sun, 26 Oct 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496189; cv=none; b=bcWdUlvo52rS215Q+MUcRwBpZ69nnXc7JGa4sM/+mePRdZ3cc+aZIs5l/gZKU4W8bx98Ero3LWWxs10SpuNkELDznmmOva+90vwQwX2stcVIsuagH9r3BeyqeuOFgvCqK3ejPrQzIi6nBvR31Gh8p3neTDR/HNRsyhnSIZbCWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496189; c=relaxed/simple;
	bh=sO0a7q5i7MeIpNSac1aJH83qJF+UpedUXSyygfAYUOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXSDfHWGcCJLhy6qWwELIihQ2yeQnZF0LMQAlGXR41YWtUuZiwfTTmp3XjyGJM0zLftGkAw4x8TzDmtkjYOrqVISnQyJo9vLQb5CRldAxZRsAz4U7WeIpEhREIXpmxbceZ1j+Q786g9hySP74/Y5IiXyolfOpU88RZ0lVbb4ekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQ4SiShq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4175C4CEE7;
	Sun, 26 Oct 2025 16:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761496187;
	bh=sO0a7q5i7MeIpNSac1aJH83qJF+UpedUXSyygfAYUOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQ4SiShqErdQlNweJkeXuQAUrzvImzw7c+n0h00KfYxTBSa2swPH8us/GQ9Rn5P78
	 lPNe18Sld99k1WToJIgKtTs0dEiFgoLMpIlJAvC3zrYjw324NP96DqAXpDuuY4Gnqh
	 WKVUH0J+0DOdhYkMsVBV4biHJ3l17/X7CLW2MkucKYblQ7NAQ3Gv0XjwY2enKqKf1S
	 dZOYhAvqeZ86hPpTD7kbqGhB+QymcmtU24b6VxktHyzZHczsdwZzv0jXojyevYoaQV
	 +ct0siLBpjpEXLY58908awCeduA3BfqsV9BgyXLtrKtF783mOXvfHwug3LVoYRiM1b
	 bjnBa/AgwF4Ew==
Date: Sun, 26 Oct 2025 18:29:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org
Subject: Re: [PATCH v8 8/8] memblock: Unpreserve memory in case of error
Message-ID: <aP5Mcr9WCt5CHon6@kernel.org>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
 <20251024161002.747372-9-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024161002.747372-9-pasha.tatashin@soleen.com>

On Fri, Oct 24, 2025 at 12:10:02PM -0400, Pasha Tatashin wrote:
> If there is an error half way through KHO memory preservation, we should
> rollback and unpreserve everything that is partially preserved.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> ---
>  mm/memblock.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e3bef9b35d63..5ceaa02af7d6 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2447,6 +2447,7 @@ int reserve_mem_release_by_name(const char *name)
>  
>  static int __init prepare_kho_fdt(void)
>  {
> +	bool fdt_folio_preserved = false;

fdt_preserved is enough IMHO.

>  	int err = 0, i;
>  	struct page *fdt_page;
>  	void *fdt;
> @@ -2462,12 +2463,14 @@ static int __init prepare_kho_fdt(void)
>  
>  	err |= fdt_begin_node(fdt, "");
>  	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
> -	for (i = 0; i < reserved_mem_count; i++) {
> +	for (i = 0; !err && i < reserved_mem_count; i++) {
>  		struct reserve_mem_table *map = &reserved_mem_table[i];
>  		struct page *page = phys_to_page(map->start);
>  		unsigned int nr_pages = map->size >> PAGE_SHIFT;
>  
> -		err |= kho_preserve_pages(page, nr_pages);
> +		err = kho_preserve_pages(page, nr_pages);
> +		if (err)
> +			break;

Please

	goto err_unpreserve;

>  		err |= fdt_begin_node(fdt, map->name);
>  		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
>  		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));

	if (err)
		goto err_unpreserve;

and drop !err from the loop condition.

> @@ -2477,12 +2480,27 @@ static int __init prepare_kho_fdt(void)
>  	err |= fdt_end_node(fdt);
>  	err |= fdt_finish(fdt);
>  
> -	err |= kho_preserve_folio(page_folio(fdt_page));
> -
>  	if (!err)
> +		err = kho_preserve_folio(page_folio(fdt_page));
> +
> +	if (!err) {
> +		fdt_folio_preserved = true;
>  		err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
> +	}
>  
>  	if (err) {
> +		int nr_reserve_map_preserved = i;

nr_preserved is clear enough.
Also let's declare it before the preservation loop and count it there. Than
we can make loop variable local which makes it safer against certain side
channel attacks. I.e the loop that preserves the memory would be

	for (unsigned int i = 0; i < reserve_mem_count; i++ nr_preserved++) 

> +
> +		for (i = 0; i < nr_reserve_map_preserved; i++) {
> +			struct reserve_mem_table *map = &reserved_mem_table[i];
> +			struct page *page = phys_to_page(map->start);
> +			unsigned int nr_pages = map->size >> PAGE_SHIFT;
> +
> +			kho_unpreserve_pages(page, nr_pages);
> +		}
> +		if (fdt_folio_preserved)
> +			kho_unpreserve_folio(page_folio(fdt_page));
> +
>  		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
>  		put_page(fdt_page);
>  	}
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 

-- 
Sincerely yours,
Mike.

