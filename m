Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C978C4EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 01:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHMXyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 19:54:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMXyn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 19:54:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DNs0ej159246;
        Tue, 13 Aug 2019 23:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=8uoxkmua1OS2X8xhxw5mu7ScJfwZNdN5PSdmlkbyv8g=;
 b=C/hffB2/CGhrbY+ybbD2RdOJshB9uPQiYKhfH3UFDwszzYTQ66/GGB6XygmPp4PIwbVx
 bwHxOm4r/8KGxtRF8fItyF+Jy3nnc3Y29khBpxZlHY1GpfBLlQBOg85UTcwv1sHj+qSx
 azxMUtwbXSZWoJY/+gqDW5xJVuA04mg/gY2bOqdVedOjwV3swFgnyqGx4q37R476ZRTA
 MSiDd0TjLE39DhY4aQFKpsO988HPK2Nunhrx13KDNSSdYCLR5847XoABJDa4mLMY4atA
 9kN4JZoJ6NtmGzbYtVv7dn79wantwW0ksPQalJ4VxXYiUfkmTum5rtCNjMt7Ula7zTkT lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u9nbthcfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 23:54:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DNqqOF165505;
        Tue, 13 Aug 2019 23:54:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ubwrgk88d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 23:54:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7DNsZpC025046;
        Tue, 13 Aug 2019 23:54:35 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 16:54:35 -0700
Subject: Re: [RFC PATCH v2 4/5] hugetlb_cgroup: Add accounting for shared
 mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20190808231340.53601-1-almasrymina@google.com>
 <20190808231340.53601-5-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
Date:   Tue, 13 Aug 2019 16:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190808231340.53601-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130227
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130227
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/19 4:13 PM, Mina Almasry wrote:
> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> in the resv_map entries, in file_region->reservation_counter.
> 
> When a file_region entry is added to the resv_map via region_add, we
> also charge the appropriate hugetlb_cgroup and put the pointer to that
> in file_region->reservation_counter. This is slightly delicate since we
> need to not modify the resv_map until we know that charging the
> reservation has succeeded. If charging doesn't succeed, we report the
> error to the caller, so that the kernel fails the reservation.

I wish we did not need to modify these region_() routines as they are
already difficult to understand.  However, I see no other way with the
desired semantics.

> On region_del, which is when the hugetlb memory is unreserved, we delete
> the file_region entry in the resv_map, but also uncharge the
> file_region->reservation_counter.
> 
> ---
>  mm/hugetlb.c | 208 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 170 insertions(+), 38 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 235996aef6618..d76e3137110ab 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -242,8 +242,72 @@ struct file_region {
>  	struct list_head link;
>  	long from;
>  	long to;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * On shared mappings, each reserved region appears as a struct
> +	 * file_region in resv_map. These fields hold the info needed to
> +	 * uncharge each reservation.
> +	 */
> +	struct page_counter *reservation_counter;
> +	unsigned long pages_per_hpage;
> +#endif
>  };
> 
> +/* Must be called with resv->lock held. Calling this with dry_run == true will
> + * count the number of pages added but will not modify the linked list.
> + */
> +static long consume_regions_we_overlap_with(struct file_region *rg,
> +		struct list_head *head, long f, long *t,
> +		struct hugetlb_cgroup *h_cg,
> +		struct hstate *h,
> +		bool dry_run)
> +{
> +	long add = 0;
> +	struct file_region *trg = NULL, *nrg = NULL;
> +
> +	/* Consume any regions we now overlap with. */
> +	nrg = rg;
> +	list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
> +		if (&rg->link == head)
> +			break;
> +		if (rg->from > *t)
> +			break;
> +
> +		/* If this area reaches higher then extend our area to
> +		 * include it completely.  If this is not the first area
> +		 * which we intend to reuse, free it.
> +		 */
> +		if (rg->to > *t)
> +			*t = rg->to;
> +		if (rg != nrg) {
> +			/* Decrement return value by the deleted range.
> +			 * Another range will span this area so that by
> +			 * end of routine add will be >= zero
> +			 */
> +			add -= (rg->to - rg->from);
> +			if (!dry_run) {
> +				list_del(&rg->link);
> +				kfree(rg);

Is it possible that the region struct we are deleting pointed to
a reservation_counter?  Perhaps even for another cgroup?
Just concerned with the way regions are coalesced that we may be
deleting counters.

-- 
Mike Kravetz
