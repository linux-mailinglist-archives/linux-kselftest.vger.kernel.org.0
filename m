Return-Path: <linux-kselftest+bounces-25389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2AAA2237D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0BD3A050C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A99190661;
	Wed, 29 Jan 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fvw5lDbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B51DFE16
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173437; cv=none; b=Zg74XK5zd9efi4OoppPaXgN2mJLGCea4EKpnQGzr+2Bnetb9CAm4tmUXlrXvWB05lNbaU0Ing78X7Q6Rly0JzyesP0X/P/+0EN2y86ai8Ps/Cbx9vnX8ueHIKgt/DgSkUSEswUl48BzzCF0KI/qysjiHY6AOOhUbrmVJCBMf6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173437; c=relaxed/simple;
	bh=g0qHhinbAuekqoMM8MjsmxR2CbpDV4myvSNK9A9pBcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAeSE04DkrQn5L5hmdC5b2raQRt/uX6xrvJ63CS/kGM3P3z6Pz1lz0DPG5xZJJ4pCeH5Wu4D7IAikOSQBwk8fLAlIs1vOYadWrm6oz1BGc47GGUOMHj2tfU+/PWeVyTrRRgUiolz9Qo50eI20OoGbxlduHINNaoYCcVv55fx9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fvw5lDbw; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738173431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b6z2wRjg4iihkYHrVPwS8/g0eZUqmsmMeqfurwwIxus=;
	b=fvw5lDbwUfruS0aD3dIIeSbVrIUhn6Htxz2gYazQ3BK5Ylg4hueev/k2mIPUOx4amE2U8N
	2tzaVwvD3vNBpPx+TOzTZ5I3jAQSe1TpT1dKRuSKBsz8ZarOxj8EwPqT/5tDhDetPiUAuU
	xABfB3S6XebEM0ciJ0+tVwDbtTDFkNg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-bcachefs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 20/21] bcachefs: convert eytzinger sort to be 1-based (2)
Message-ID: <j34hki5wgugqrw4ug6rmxvacpb47usmraoetv5qmtqvmubclvh@2f4gb3sndhvc>
References: <20250128163859.1883260-1-agruenba@redhat.com>
 <20250128163859.1883260-21-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128163859.1883260-21-agruenba@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 28, 2025 at 05:38:57PM +0100, Andreas Gruenbacher wrote:
> In this second step, transform the eytzinger indexes i, j, and k in
> eytzinger1_sort_r() from 0-based to 1-based.  This step looks a bit
> messy, but the resulting code is slightly better.

I really hate the cute and paste of lib/sort.c, I wonder if we could get
rid of that by adding a more generic sort that takes an option
"index/access element" helper.

I've come across situations where we want to sort radix trees as well,
so - maybe?

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/bcachefs/eytzinger.c | 42 ++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/bcachefs/eytzinger.c b/fs/bcachefs/eytzinger.c
> index 93a5819a6878..00cc5f0826e3 100644
> --- a/fs/bcachefs/eytzinger.c
> +++ b/fs/bcachefs/eytzinger.c
> @@ -170,7 +170,7 @@ static void eytzinger1_sort_r(void *base1, size_t n, size_t size,
>  			      swap_r_func_t swap_func,
>  			      const void *priv)
>  {
> -	int i, j, k;
> +	unsigned i, j, k;
>  
>  	/* called from 'sort' without swap function, let's pick the default */
>  	if (swap_func == SWAP_WRAPPER && !((struct wrapper *)priv)->swap_func)
> @@ -186,46 +186,46 @@ static void eytzinger1_sort_r(void *base1, size_t n, size_t size,
>  	}
>  
>  	/* heapify */
> -	for (i = n / 2 - 1; i >= 0; --i) {
> +	for (i = n / 2; i >= 1; --i) {
>  		/* Find the sift-down path all the way to the leaves. */
> -		for (j = i; k = j * 2 + 1, k + 1 < n;)
> -			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
> +		for (j = i; k = j * 2, k < n;)
> +			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
>  
>  		/* Special case for the last leaf with no sibling. */
> -		if (j * 2 + 2 == n)
> -			j = j * 2 + 1;
> +		if (j * 2 == n)
> +			j *= 2;
>  
>  		/* Backtrack to the correct location. */
> -		while (j != i && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, i + 1, j + 1) >= 0)
> -			j = (j - 1) / 2;
> +		while (j != i && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, i, j) >= 0)
> +			j /= 2;
>  
>  		/* Shift the element into its correct place. */
>  		for (k = j; j != i;) {
> -			j = (j - 1) / 2;
> -			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
> +			j /= 2;
> +			eytzinger1_do_swap(base1, n, size, swap_func, priv, j, k);
>  		}
>  	}
>  
>  	/* sort */
> -	for (i = n - 1; i > 0; --i) {
> -		eytzinger1_do_swap(base1, n, size, swap_func, priv, 1, i + 1);
> +	for (i = n; i > 1; --i) {
> +		eytzinger1_do_swap(base1, n, size, swap_func, priv, 1, i);
>  
>  		/* Find the sift-down path all the way to the leaves. */
> -		for (j = 0; k = j * 2 + 1, k + 1 < i;)
> -			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k + 1, k + 2) > 0 ? k : k + 1;
> +		for (j = 1; k = j * 2, k + 1 < i;)
> +			j = eytzinger1_do_cmp(base1, n, size, cmp_func, priv, k, k + 1) > 0 ? k : k + 1;
>  
>  		/* Special case for the last leaf with no sibling. */
> -		if (j * 2 + 2 == i)
> -			j = j * 2 + 1;
> +		if (j * 2 + 1 == i)
> +			j *= 2;
>  
>  		/* Backtrack to the correct location. */
> -		while (j && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, 1, j + 1) >= 0)
> -			j = (j - 1) / 2;
> +		while (j >= 1 && eytzinger1_do_cmp(base1, n, size, cmp_func, priv, 1, j) >= 0)
> +			j /= 2;
>  
>  		/* Shift the element into its correct place. */
> -		for (k = j; j;) {
> -			j = (j - 1) / 2;
> -			eytzinger1_do_swap(base1, n, size, swap_func, priv, j + 1, k + 1);
> +		for (k = j; j > 1;) {
> +			j /= 2;
> +			eytzinger1_do_swap(base1, n, size, swap_func, priv, j, k);
>  		}
>  	}
>  }
> -- 
> 2.48.1
> 

