Return-Path: <linux-kselftest+bounces-12529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E89140C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 05:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C4BB211DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD94C96;
	Mon, 24 Jun 2024 03:08:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46054525E;
	Mon, 24 Jun 2024 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198516; cv=none; b=XWkLZWjebFRgHsZJ3kQrf0ho7WgU6OTpTnhv6wcSsuAv52KMmuDt7vbokTkGfQIxOGdp/lFXsyfpiV5apmfamXbEp59mAJWQZqkxX6bLB5BgOrwLFvo3NbM67AzM97AkNOH7p+z6ZDIrdoi24tM55pHhUjT8Y96xR2Oo2clC9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198516; c=relaxed/simple;
	bh=hB/2JJVFKccxpSdRv7G1VOcUWLpP0hPeZdiHv6t0cyY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uqMP0xEjceJ19UFK6VHRMtK53Geddf17V8Csku3+GBWqtJrz9xt1KxOCd6pyge46QJT2nUlwBrIPcdkOmEG/L4zVG4y1ElGMhdU7iEYTRfq6oGok5XP9jXjt1WXlflOCEB5YOczyxjBWhDbFUYmwCMLJ2UtJfK+fcQjG2wRqGrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W6tD15ZLWzddQm;
	Mon, 24 Jun 2024 11:06:57 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9667418009B;
	Mon, 24 Jun 2024 11:08:30 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 11:08:29 +0800
Subject: Re: [PATCH v4 1/4] mm/memory-failure: refactor log format in soft
 offline code
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <rientjes@google.com>, <duenwen@google.com>,
	<fvdl@google.com>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nao.horiguchi@gmail.com>,
	<jane.chu@oracle.com>, <osalvador@suse.de>
References: <20240620184856.600717-1-jiaqiyan@google.com>
 <20240620184856.600717-2-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2ebeb4bd-d173-2690-cb66-2d3db20c4648@huawei.com>
Date: Mon, 24 Jun 2024 11:08:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620184856.600717-2-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/21 2:48, Jiaqi Yan wrote:
> Logs from soft_offline_page and soft_offline_in_use_page have
> different formats than majority of the memory failure code:
> 
>   "Memory failure: 0x${pfn}: ${lower_case_message}"
> 
> Convert them to the following format:
> 
>   "Soft offline: 0x${pfn}: ${lower_case_message}"
> 
> No functional change in this commit.

Thanks for your patch.

> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  mm/memory-failure.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d3c830e817e3..2a097af7da0e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2631,6 +2631,9 @@ int unpoison_memory(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(unpoison_memory);
>  
> +#undef pr_fmt
> +#define pr_fmt(fmt) "Soft offline: " fmt
> +
>  static bool mf_isolate_folio(struct folio *folio, struct list_head *pagelist)
>  {
>  	bool isolated = false;
> @@ -2686,7 +2689,7 @@ static int soft_offline_in_use_page(struct page *page)
>  
>  	if (!huge && folio_test_large(folio)) {
>  		if (try_to_split_thp_page(page)) {
> -			pr_info("soft offline: %#lx: thp split failed\n", pfn);
> +			pr_info("%#lx: thp split failed\n", pfn);
>  			return -EBUSY;
>  		}
>  		folio = page_folio(page);
> @@ -2698,7 +2701,7 @@ static int soft_offline_in_use_page(struct page *page)
>  	if (PageHWPoison(page)) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> -		pr_info("soft offline: %#lx page already poisoned\n", pfn);
> +		pr_info("%#lx page already poisoned\n", pfn);

s/%#lx /%#lx: /g, i.e. ':' is missing.

>  		return 0;
>  	}
>  

Other than above possible one nit, this patch looks good to me.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.



