Return-Path: <linux-kselftest+bounces-44616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B6C28A1D
	for <lists+linux-kselftest@lfdr.de>; Sun, 02 Nov 2025 07:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D640C3B76CC
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Nov 2025 06:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1616C126C17;
	Sun,  2 Nov 2025 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vco4K2eV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20815D1;
	Sun,  2 Nov 2025 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762066294; cv=none; b=BfZdThAK6/tNkqRTU3419hseL3NLTbOgIbdYx6rmq9iGjhjP838zzCu1jnOTLCa0c7UW7GD+1w/0TnxQ9EnwGaQWDxdvNnJEVw8uflqG5h5kw8YnuSyWC1Nr+1SmDR8UcduJF5iJ8pKg+Lsnzpg9hYdftprO6t2YIyAkIk+eaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762066294; c=relaxed/simple;
	bh=LiEsqySHdTNYoNAeeFwBBm/8FtkxDtaFLj1JlFEIwUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMJVHIUr0wGEOgoQlf/QJn/Mu+CVKGvYzzatRE6+GRdNqYkurxgAsZe24cJpUPkjbgkdyaMRMiXlrarHXPN0KZM5z8ZnWv3NLPh7bIb6cpVw1KvAJDdnMkvk/g3pcxFo7Hl8jsOLLqHasnmkET04cpGNmYGjGtfy3HIeZgSsMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vco4K2eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC90C4CEF7;
	Sun,  2 Nov 2025 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762066293;
	bh=LiEsqySHdTNYoNAeeFwBBm/8FtkxDtaFLj1JlFEIwUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vco4K2eVYGfYGyg5YaHsmWN+3k6nNiSCNBYy6ngq88ATZov79V6nUDRzIi5gwzstW
	 Xe7q49t6AGV0dD46I6vdQAJAcYLbbMv3RM6KVHqgIHtILpg4//ZwtHtO2eM64ocX/u
	 waAtNhTJ6/rZKk9j1bXufCWyDqAlo2vSH5JRjOVPC5m5FhVh3YZ2CCeUyKe6CR2WPC
	 H6pViBJAdyPUW24cVSC2qToLalSQRX9J6o0/2Dex+E9Bw3upHJxQzt0exEnHFECSUN
	 oWp8B654jSXWaDNW7NlNhsKGOuTWNqowQUgT3P23de8tG70lFk+sAVQcQlkvs8q8xl
	 udORXqwFbHOkw==
Date: Sun, 2 Nov 2025 08:51:24 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 4/9] memblock: Unpreserve memory in case of error
Message-ID: <aQb_bJ2et5rO0k5q@kernel.org>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-5-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101142325.1326536-5-pasha.tatashin@soleen.com>

On Sat, Nov 01, 2025 at 10:23:20AM -0400, Pasha Tatashin wrote:
> If there is an error half way through KHO memory preservation, we should
> rollback and unpreserve everything that is partially preserved.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

with a small nit below.

> ---
>  mm/memblock.c | 73 ++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index e3bef9b35d63..f527ad1ca682 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2445,29 +2445,60 @@ int reserve_mem_release_by_name(const char *name)

...

>  static int __init prepare_kho_fdt(void)
>  {
> -	int err = 0, i;
>  	struct page *fdt_page;
>  	void *fdt;
> +	int err;
>  
>  	fdt_page = alloc_page(GFP_KERNEL);
> -	if (!fdt_page)
> -		return -ENOMEM;
> +	if (!fdt_page) {
> +		err = -ENOMEM;
> +		goto err_no_fdt_page;

Please rename the label to describe what the goto does, say, err_report.
I believe it can be a fixup on top after Andrew merges these.

...

> +err_remove_subtree:
> +	kho_remove_subtree(fdt);
> +err_unpreserve_fdt:
> +	kho_unpreserve_pages(fdt_page, 1);
> +err_free_fdt:
> +	put_page(fdt_page);
> +err_no_fdt_page:
> +	pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
>  
>  	return err;
>  }
> -- 
> 2.51.1.930.gacf6e81ea2-goog
> 

-- 
Sincerely yours,
Mike.

