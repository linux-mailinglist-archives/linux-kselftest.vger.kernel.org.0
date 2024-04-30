Return-Path: <linux-kselftest+bounces-9149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1C8B7B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433A228286B
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52244174EF0;
	Tue, 30 Apr 2024 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/lXSTHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BC174EDE;
	Tue, 30 Apr 2024 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490852; cv=none; b=LJ4GGvUmPCooGEn6FCe3hDYClMZBjWLXmpBIrp7zzTnZgdP/FFasAZGiR26NKhxJ4bay4n/Upp6MDh+0mkmQPuU7KvJMNcFvdngpspisXzHjxFheSUgXfQwpSxLwycr+WzSgFjaFxhhXErelcBhyg9/3jXUxORjRx6M7HY8OWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490852; c=relaxed/simple;
	bh=h1ohZ5MpwzM3OL1wbXfEG1SA8exySrUGfXfGDpQtCM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aa7T/fXw7WNcGjFGQtmYdGZE3leaa2pNtYWbk1DwPGNeP+vVCnhlhE+8omekkBchEvrEC7K1gj4ovBaROCw8PcWfG74oYagY2HDndIoLB5TsVbhhNsf6MWbs8TuowxF6/UYXeEKQJlzU5hhAEuTgXayRQUhDUjsf99kZ5xXT9sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/lXSTHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D71C2BBFC;
	Tue, 30 Apr 2024 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714490851;
	bh=h1ohZ5MpwzM3OL1wbXfEG1SA8exySrUGfXfGDpQtCM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l/lXSTHzPQieSzxfZX0pFG2HWdmlTHQSPx2QwVO0Ex12LiCU44afneA5YeeO8Gdam
	 UI82m8r2xrzCyWejOfIvvP4RjL1x9cfv0/vz3GaZUOVzemuy1nZisI4mZMBKVacAt/
	 bwk3Tgk0poJWBnI0ppBNMF3MKfxnQTExPZr7EVrv1oHW3PP60uGhGYs/Ga8MiA7cH0
	 Ojk4D2dZuxQiL4phgIfL0YOg03QrZvXsEenwI7hmGAlFl5lv0UQ1PTKz/d7gMUrb1o
	 ZrHwrcODZeS00DdS9atBoeZrOCluTvaXEjuZwAZjgJ5LzSYUTDORn1ThpEgEUGQdsD
	 hxPDO3VZSqS7A==
Message-ID: <81e7c766-10fd-443c-a03d-0e2d0363e9c3@kernel.org>
Date: Tue, 30 Apr 2024 17:27:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: page_pool: support error injection
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 ilias.apalodimas@linaro.org
References: <20240426232400.624864-1-kuba@kernel.org>
 <20240426232400.624864-2-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20240426232400.624864-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/04/2024 01.23, Jakub Kicinski wrote:
> Because of caching / recycling using the general page allocation
> failures to induce errors in page pool allocation is very hard.
> Add direct error injection support to page_pool_alloc_pages().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>


Sounds good to me :-)

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

> ---
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> ---
>   net/core/page_pool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 273c24429bce..8bcc7014a61a 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -5,6 +5,7 @@
>    *	Copyright (C) 2016 Red Hat, Inc.
>    */
>   
> +#include <linux/error-injection.h>
>   #include <linux/types.h>
>   #include <linux/kernel.h>
>   #include <linux/slab.h>
> @@ -550,6 +551,7 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
>   	return page;
>   }
>   EXPORT_SYMBOL(page_pool_alloc_pages);
> +ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
>   
>   /* Calculate distance between two u32 values, valid if distance is below 2^(31)
>    *  https://en.wikipedia.org/wiki/Serial_number_arithmetic#General_Solution

