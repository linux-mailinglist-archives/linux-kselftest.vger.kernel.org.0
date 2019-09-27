Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB7C0D79
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 23:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfI0Vou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 17:44:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42374 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfI0Vou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 17:44:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RLdUcN001264;
        Fri, 27 Sep 2019 21:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Hk4zBrC4ftfxAK0GhvkCyWFjYJFlQ+AvZq80XV4tPQs=;
 b=Q7xnwh8VBKvYk0s/2s9ZAa4695mEN9M9MFwzaIRE3OKTzVqDb/gKe5JsdrJEjYCyYcOB
 9glF6Fck3L5gO7KleN7dlcWAKToYfpDiY10+ks7JdU3VVd6LVyBQ44JfpqHus0l5UEis
 rbzmMH/8oXwt9HXCMgMmLoFsT+9fgfao1zIzjimBRvxSp7F+VeZm4+ZNhK2CAsJENQ1+
 qQsMd7+ISG+IlEywedVmRTIQLuLQMbRucqvrkeDawVtfFe6m3qyBU0Op1ybCRsxPXDUw
 ikoDYUFB4IQBM9+7w6xZKKBuPvmeCzR+BU964W41P/frBjsuXq+njNF490CeAI5smCry Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgrmm6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 21:44:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RLiEWt129975;
        Fri, 27 Sep 2019 21:44:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v9m3fq4v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 21:44:36 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8RLiZX0004387;
        Fri, 27 Sep 2019 21:44:35 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Sep 2019 14:44:35 -0700
Subject: Re: [PATCH v5 4/7] hugetlb: disable region_add file_region coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
References: <20190919222421.27408-1-almasrymina@google.com>
 <20190919222421.27408-5-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <62a2a742-1735-7272-3c6c-213efc7adb9f@oracle.com>
Date:   Fri, 27 Sep 2019 14:44:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919222421.27408-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270183
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270183
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/19 3:24 PM, Mina Almasry wrote:
> A follow up patch in this series adds hugetlb cgroup uncharge info the
> file_region entries in resv->regions. The cgroup uncharge info may
> differ for different regions, so they can no longer be coalesced at
> region_add time. So, disable region coalescing in region_add in this
> patch.
> 
> Behavior change:
> 
> Say a resv_map exists like this [0->1], [2->3], and [5->6].
> 
> Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> 
> Old code would generate resv->regions: [0->5], [5->6].
> New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> [5->6].
> 
> Special care needs to be taken to handle the resv->adds_in_progress
> variable correctly. In the past, only 1 region would be added for every
> region_chg and region_add call. But now, each call may add multiple
> regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> region_chg calls add_reservation_in_range() to count the number of regions
> needed and allocates those, and that info is passed to region_add and
> region_abort to decrement adds_in_progress correctly.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  mm/hugetlb.c | 273 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 158 insertions(+), 115 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index bac1cbdd027c..d03b048084a3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -244,6 +244,12 @@ struct file_region {
>  	long to;
>  };
> 
> +/* Helper that removes a struct file_region from the resv_map cache and returns
> + * it for use.
> + */
> +static struct file_region *
> +get_file_region_entry_from_cache(struct resv_map *resv, long from, long to);
> +

Instead of the forward declaration, just put the function here.

>  /* Must be called with resv->lock held. Calling this with count_only == true
>   * will count the number of pages to be added but will not modify the linked
>   * list.
> @@ -251,51 +257,61 @@ struct file_region {
>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  				     bool count_only)
>  {
> -	long chg = 0;
> +	long add = 0;
>  	struct list_head *head = &resv->regions;
> +	long last_accounted_offset = f;
>  	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> 
> -	/* Locate the region we are before or in. */
> -	list_for_each_entry (rg, head, link)
> -		if (f <= rg->to)
> -			break;
> -
> -	/* Round our left edge to the current segment if it encloses us. */
> -	if (f > rg->from)
> -		f = rg->from;
> -
> -	chg = t - f;
> +	/* In this loop, we essentially handle an entry for the range
> +	 * last_accounted_offset -> rg->from, at every iteration, with some
> +	 * bounds checking.
> +	 */
> +	list_for_each_entry_safe(rg, trg, head, link) {
> +		/* Skip irrelevant regions that start before our range. */
> +		if (rg->from < f) {
> +			/* If this region ends after the last accounted offset,
> +			 * then we need to update last_accounted_offset.
> +			 */
> +			if (rg->to > last_accounted_offset)
> +				last_accounted_offset = rg->to;
> +			continue;
> +		}
> 
> -	/* Check for and consume any regions we now overlap with. */
> -	nrg = rg;
> -	list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
> -		if (&rg->link == head)
> -			break;
> +		/* When we find a region that starts beyond our range, we've
> +		 * finished.
> +		 */
>  		if (rg->from > t)
>  			break;
> 
> -		/* We overlap with this area, if it extends further than
> -		 * us then we must extend ourselves.  Account for its
> -		 * existing reservation.
> +		/* Add an entry for last_accounted_offset -> rg->from, and
> +		 * update last_accounted_offset.
>  		 */
> -		if (rg->to > t) {
> -			chg += rg->to - t;
> -			t = rg->to;
> +		if (rg->from > last_accounted_offset) {
> +			add += rg->from - last_accounted_offset;
> +			if (!count_only) {
> +				nrg = get_file_region_entry_from_cache(
> +					resv, last_accounted_offset, rg->from);
> +				list_add(&nrg->link, rg->link.prev);
> +			}
>  		}
> -		chg -= rg->to - rg->from;
> 
> -		if (!count_only && rg != nrg) {
> -			list_del(&rg->link);
> -			kfree(rg);
> -		}
> +		last_accounted_offset = rg->to;
>  	}
> 
> -	if (!count_only) {
> -		nrg->from = f;
> -		nrg->to = t;
> +	/* Handle the case where our range extends beyond
> +	 * last_accounted_offset.
> +	 */
> +	if (last_accounted_offset < t) {
> +		add += t - last_accounted_offset;
> +		if (!count_only) {
> +			nrg = get_file_region_entry_from_cache(
> +				resv, last_accounted_offset, t);
> +			list_add(&nrg->link, rg->link.prev);
> +		}
> +		last_accounted_offset = t;
>  	}
> 
> -	return chg;
> +	return add;
>  }
> 
>  /*
> @@ -305,46 +321,24 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,

The start of this comment block says,

/*
 * Add the huge page range represented by [f, t) to the reserve
 * map.  Existing regions will be expanded to accommodate the specified
 * range, or a region will be taken from the cache.

We are no longer expanding existing regions.  Correct?
As an optimization, I guess we could coalesce/combine reion entries as
long as they are for the same cgroup.  However, it may not be worth the
effort.

>   * must exist in the cache due to the previous call to region_chg with
>   * the same range.
>   *
> + * regions_needed is the out value provided by a previous
> + * call to region_chg.
> + *
>   * Return the number of new huge pages added to the map.  This
>   * number is greater than or equal to zero.
>   */
> -static long region_add(struct resv_map *resv, long f, long t)
> +static long region_add(struct resv_map *resv, long f, long t,
> +		       long regions_needed)
>  {
> -	struct list_head *head = &resv->regions;
> -	struct file_region *rg, *nrg;
>  	long add = 0;
> 
>  	spin_lock(&resv->lock);
> -	/* Locate the region we are either in or before. */
> -	list_for_each_entry(rg, head, link)
> -		if (f <= rg->to)
> -			break;
> 
> -	/*
> -	 * If no region exists which can be expanded to include the
> -	 * specified range, pull a region descriptor from the cache
> -	 * and use it for this range.
> -	 */
> -	if (&rg->link == head || t < rg->from) {
> -		VM_BUG_ON(resv->region_cache_count <= 0);
> -
> -		resv->region_cache_count--;
> -		nrg = list_first_entry(&resv->region_cache, struct file_region,
> -					link);
> -		list_del(&nrg->link);
> -
> -		nrg->from = f;
> -		nrg->to = t;
> -		list_add(&nrg->link, rg->link.prev);
> -
> -		add += t - f;
> -		goto out_locked;
> -	}
> +	VM_BUG_ON(resv->region_cache_count < regions_needed);
> 
>  	add = add_reservation_in_range(resv, f, t, false);
> +	resv->adds_in_progress -= regions_needed;

Consider this example,

- region_chg(1,2)
	adds_in_progress = 1
	cache entries 1
- region_chg(3,4)
	adds_in_progress = 2
	cache entries 2
- region_chg(5,6)
	adds_in_progress = 3
	cache entries 3

At this point, no region descriptors are in the map because only
region_chg has been called.

- region_chg(0,6)
	adds_in_progress = 4
	cache entries 4

Is that correct so far?

Then the following sequence happens,

- region_add(1,2)
	adds_in_progress = 3
	cache entries 3
- region_add(3,4)
	adds_in_progress = 2
	cache entries 2
- region_add(5,6)
	adds_in_progress = 1
	cache entries 1

list of region descriptors is:
[1->2] [3->4] [5->6]

- region_add(0,6)
This is going to require 3 cache entries but only one is in the cache.
I think we are going to BUG in get_file_region_entry_from_cache() the
second time it is called from add_reservation_in_range().

I stopped looking at the code here as things will need to change if this
is a real issue.
-- 
Mike Kravetz
