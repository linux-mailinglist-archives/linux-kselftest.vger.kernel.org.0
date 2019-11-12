Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA205F9CE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfKLWVX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 17:21:23 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14448 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfKLWVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 17:21:22 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb30620000>; Tue, 12 Nov 2019 14:21:22 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 14:21:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 14:21:22 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Nov
 2019 22:21:19 +0000
Subject: Re: [PATCH v4 1/2] mm/hmm: make full use of walk_page_range()
To:     Christoph Hellwig <hch@lst.de>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Shuah Khan <shuah@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20191104222141.5173-1-rcampbell@nvidia.com>
 <20191104222141.5173-2-rcampbell@nvidia.com> <20191112151856.GB12550@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <3e2da09f-a305-14b7-c116-77e4d1b9e3f2@nvidia.com>
Date:   Tue, 12 Nov 2019 14:21:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191112151856.GB12550@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573597282; bh=Mjsgzq4tTY1ttPXWj4o1nKG2G54sIpqkFXsKMyN1ai4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=n3+rgoO7Cosk1b8j0LFmjpqfy8vh/1vgXoyo1ZFsHWrDwoNjbxshEcMMFtJooukY+
         T7fDLY+vAopGHZ/4qpGFIhxkA194rJAuMM41B4/euZtC0I/pznU+Ne28KxNiQIcFK3
         Faf6R0IaXpEGuTlifVRQBbuUAKsUmrmUDs7OSQOnPR1KyJI5m+wBQBetYH6lUuXlDa
         nC68T3zwoJ2tzJq6kUVOW/4U2KMqyYcHufw9VRZOIX60Um0xspk9k3555KmBo+KGar
         speu/qs92JpbwFBiJYqP5q+w7GIbTcxVibLgBIOdtJsy1GoVW6I9WqRRBVh/dmnQlV
         bzOKy1bGxsOSQ==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/12/19 7:18 AM, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although we could clean this up a tidbit more by removing the start
> variable:
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index d4984a08ed9b..b5b1ed646c2f 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -667,10 +667,9 @@ static const struct mm_walk_ops hmm_walk_ops = {
>    */
>   long hmm_range_fault(struct hmm_range *range, unsigned int flags)
>   {
> -	unsigned long start = range->start;
>   	struct hmm_vma_walk hmm_vma_walk = {
>   		.range = range,
> -		.last = start,
> +		.last = range->start,
>   		.flags = flags,
>   	};
>   	struct mm_struct *mm = range->notifier->mm;
> @@ -682,9 +681,8 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
>   		/* If range is no longer valid force retry. */
>   		if (mmu_range_check_retry(range->notifier, range->notifier_seq))
>   			return -EBUSY;
> -		ret = walk_page_range(mm, start, range->end, &hmm_walk_ops,
> -				      &hmm_vma_walk);
> -		start = hmm_vma_walk.last;
> +		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
> +				      &hmm_walk_ops, &hmm_vma_walk);
>   	} while (ret == -EBUSY);
>   
>   	if (ret)
> 

Thanks for the review.
I'll add this to patch 1 since I need to send a v5 for patch 2.
