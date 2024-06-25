Return-Path: <linux-kselftest+bounces-12618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D2915F03
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 08:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95BEF1C21D5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4750146011;
	Tue, 25 Jun 2024 06:41:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440AB145FF6;
	Tue, 25 Jun 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719297662; cv=none; b=iSIssFePyNXx63qhP/Z44h9TWoXr4NM//XhtwEIuAh4/SRQTHjBaMjcAkzny93mGbMaxB6JWNJ/kzo2+WlEJCV8p0fuXAynjUgwzxqQjRmMooZ4bj0dDe/6cJpWfAyskLZt76aD5+NPrFgXUSsmyLmjVQRzLnCKUM5Cb7cqq11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719297662; c=relaxed/simple;
	bh=l5Nv4QIXEYDFVcBlVLs2tfBuehm1+nawmdpIitUlcgo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GyVzF0rsUZ/Wr2epZgpgApW8YmYsImgZdlWgy9cJjaGyjLXkvgNAMSxaNiSAWGT2hpY3H4ybJyMMgvRbIzYVuoErCfK3LUyvlj5hcpxuTgGZyKqGd7YZ07E8QAeSAS4MZbxrKouFQOsXRZsncyrU0Fdo33aYigreAS22BZOZMMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W7ZqW2h1XzxTcR;
	Tue, 25 Jun 2024 14:36:39 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id DA443140360;
	Tue, 25 Jun 2024 14:40:57 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 14:40:54 +0800
Subject: Re: [PATCH v5 1/4] mm/memory-failure: refactor log format in soft
 offline code
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <fvdl@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <ioworker0@gmail.com>
References: <20240624163348.1751454-1-jiaqiyan@google.com>
 <20240624163348.1751454-2-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b669e378-45cb-981e-ba58-1e3c4943577d@huawei.com>
Date: Tue, 25 Jun 2024 14:40:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624163348.1751454-2-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/25 0:33, Jiaqi Yan wrote:
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

Again, it's better to be "%#lx: page" to make log format consistent.
Thanks.
.

