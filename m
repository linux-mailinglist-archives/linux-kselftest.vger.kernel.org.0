Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6C22B1107
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Nov 2020 23:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgKLWJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Nov 2020 17:09:02 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6626 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgKLWJB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Nov 2020 17:09:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fadb2850001>; Thu, 12 Nov 2020 14:09:09 -0800
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 22:08:56 +0000
Subject: Re: [RFC PATCH 5/6] mm: truncate: split thp to a non-zero order if
 possible.
To:     Zi Yan <ziy@nvidia.com>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
References: <20201111204008.21332-1-zi.yan@sent.com>
 <20201111204008.21332-6-zi.yan@sent.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <fb468c74-7da3-8b2c-e98e-ebb12793846e@nvidia.com>
Date:   Thu, 12 Nov 2020 14:08:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201111204008.21332-6-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605218949; bh=NDadN03xqNXrvsneHUexyQUsnW4XqQpKoZq/QqGvCrw=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ONeUNh4lG4o9qWXiR88CyF1ZxcdWwee7RTtb/uWeGAnlrf8wXC2ARsJLpNsGVBdxN
         aEc4mC8Myjj1a9DfqvM8o2404w4c+7crPIpIo5lXWsM5MkgLSjQ1wPWUet0SqC2sFs
         Dvr8aEbpecCyV9qrXet+AdZHAuLskwjJW+hjxpuL33VtEOZM9drs9dR52IkqGxS+nb
         z09Pb8R81cxJBpS0KwNr5p1KoTnIYzHU557XdAecMGuerjhwH7uqLn2Fiqp1PuGYt3
         lgWfsPUWOboleiRMcdJH54EXXOxFCyOxLWzVKYD2oab5cOP4qNsZdaNlCopPgZt36m
         A025KYcb7B57A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/11/20 12:40 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> To minimize the number of pages after a truncation, when truncating a
> THP, we do not need to split it all the way down to order-0. The THP has
> at most three parts, the part before offset, the part to be truncated,
> the part left at the end. Use the non-zero minimum of them to decide
> what order we split the THP to.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/truncate.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 20bd17538ec2..6d8e3c6115bc 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -237,7 +237,7 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
>   bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
>   {
>   	loff_t pos = page_offset(page);
> -	unsigned int offset, length;
> +	unsigned int offset, length, left, min_subpage_size = PAGE_SIZE;

Maybe use "remaining" instead of "left" since I think of the latter as the length of the
left side (offset).
  
>   	if (pos < start)
>   		offset = start - pos;
> @@ -248,6 +248,7 @@ bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
>   		length = length - offset;
>   	else
>   		length = end + 1 - pos - offset;
> +	left = thp_size(page) - offset - length;
>   
>   	wait_on_page_writeback(page);
>   	if (length == thp_size(page)) {
> @@ -267,7 +268,24 @@ bool truncate_inode_partial_page(struct page *page, loff_t start, loff_t end)
>   		do_invalidatepage(page, offset, length);
>   	if (!PageTransHuge(page))
>   		return true;
> -	return split_huge_page(page) == 0;
> +
> +	/*
> +	 * find the non-zero minimum of offset, length, and left and use it to
> +	 * decide the new order of the page after split
> +	 */
> +	if (offset && left)
> +		min_subpage_size = min_t(unsigned int,
> +					 min_t(unsigned int, offset, length),
> +					 left);
> +	else if (!offset)
> +		min_subpage_size = min_t(unsigned int, length, left);
> +	else /* !left */
> +		min_subpage_size = min_t(unsigned int, length, offset);
> +
> +	min_subpage_size = max_t(unsigned int, PAGE_SIZE, min_subpage_size);
> +
> +	return split_huge_page_to_list_to_order(page, NULL,
> +				ilog2(min_subpage_size/PAGE_SIZE)) == 0;
>   }

What if "min_subpage_size" is 1/2 the THP but offset isn't aligned to 1/2?
Splitting the page in half wouldn't result in a page that could be freed
but maybe splitting to 1/4 would (assuming the THP is at least 8x PAGE_SIZE).
