Return-Path: <linux-kselftest+bounces-36193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D5AEFEA7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58207A7957
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3634327815E;
	Tue,  1 Jul 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckeuEBs3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5A1946AA;
	Tue,  1 Jul 2025 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384961; cv=none; b=IBEXlXcMsUUT3xnfORH6VrbBd1CRmDBRuKok2wJ0LZBAU2Ph3ecy3wEVqWtScZ9AHmyuaAQnYW3PEPDX5oCB73Je9Mi5bhoNGKF/atAjy2CMxnkS1hOgR4tp6qEwQdg/nWBIN69M4uzkJs5ShzospB8GnMsu6AatkMTne050au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384961; c=relaxed/simple;
	bh=G3D82sMsG5UoCCrWfqBE3G+QkuojXnHxAxlbRr9EbmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUiFHRHFDrE9pj64unjQBuJFGjazDPIFhzZisSOkgqXBSWjYPKstgrDnzQnxnp+IXvpI7zFRvMh9h8veKMeyAstwCDGauLlJaURN1XHac/szQDx9CoLJ8llWkIdPyoDPGgEnQLNy55Y5VhLMBo269noLyI8DfyP2CzlFZhORud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckeuEBs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD41C4CEEB;
	Tue,  1 Jul 2025 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751384960;
	bh=G3D82sMsG5UoCCrWfqBE3G+QkuojXnHxAxlbRr9EbmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ckeuEBs3+JdC+t5srxUqZzkwQz4CZhUihLkd8Bx1+Q/KGPkep3wFy++GDTFssJAOP
	 8oSuBMfGWi22WgYKGEaZrtTuAO7E3RSzbuAeD6bWwgLf/OLKmR3pBwebXSB29I5u+H
	 Tvj2pY5Vph+bBx6dcJMKnOq7vp2fD2Z2NXNkcyJBVcq0/8uCgiIW/NZMcmWhEeXnDf
	 luVc0RcbqZiJRSb4sedSykEvB2sK6Llo7GU1iMUJUnJfLl9qoGd5Jr522Gp3aEz0Kg
	 WvkuI6aVK87SIAKJ//c4et86V7kGze8e9h3nxI+734nVyeqYiQiJYBeLxyEQeBnsJc
	 OMeL8e3YP/yIQ==
Message-ID: <3bd1e6ef-cf3d-4ace-85e8-7f98cf92cc1f@kernel.org>
Date: Tue, 1 Jul 2025 17:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20250627200501.1712389-1-almasrymina@google.com>
 <20250627200501.1712389-2-almasrymina@google.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2025 22.04, Mina Almasry wrote:
> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>   .../net/bench/page_pool/bench_page_pool_simple.c     | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> index 1cd3157fb6a9..cb6468adbda4 100644
> --- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> +++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> @@ -16,12 +16,6 @@
>   static int verbose = 1;
>   #define MY_POOL_SIZE 1024
>   
> -static void _page_pool_put_page(struct page_pool *pool, struct page *page,
> -				bool allow_direct)
> -{
> -	page_pool_put_page(pool, page, -1, allow_direct);
> -}
> -
>   /* Makes tests selectable. Useful for perf-record to analyze a single test.
>    * Hint: Bash shells support writing binary number like: $((2#101010)
>    *
> @@ -121,7 +115,7 @@ static void pp_fill_ptr_ring(struct page_pool *pp, int elems)
>   	for (i = 0; i < elems; i++)
>   		array[i] = page_pool_alloc_pages(pp, gfp_mask);
>   	for (i = 0; i < elems; i++)
> -		_page_pool_put_page(pp, array[i], false);
> +		page_pool_put_page(pp, array[i], -1, false);
>   
>   	kfree(array);
>   }
> @@ -180,14 +174,14 @@ static int time_bench_page_pool(struct time_bench_record *rec, void *data,
>   
>   		} else if (type == type_ptr_ring) {
>   			/* Normal return path */
> -			_page_pool_put_page(pp, page, false);
> +			page_pool_put_page(pp, page, -1, false);
>   
>   		} else if (type == type_page_allocator) {
>   			/* Test if not pages are recycled, but instead
>   			 * returned back into systems page allocator
>   			 */
>   			get_page(page); /* cause no-recycling */
> -			_page_pool_put_page(pp, page, false);
> +			page_pool_put_page(pp, page, -1, false);
>   			put_page(page);

The get_page() + put_page() trick is a fairly ugly workaround that I
added when Jakub removed page_pool_release_page() in commit 535b9c61bdef
("net: page_pool: hide page_pool_release_page()").

These extra refcnt increments will make the test slower, but if we are
just aware of this, then we can still compare incremental changes.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

>   		} else {
>   			BUILD_BUG();

