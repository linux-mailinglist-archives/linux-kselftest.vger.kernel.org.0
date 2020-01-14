Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8047139EA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2020 01:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgANAz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 19:55:57 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgANAz5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 19:55:57 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0mLDm084568;
        Tue, 14 Jan 2020 00:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=q3FTAaiioCQb6P8F7A2yzU2HHK8AnqOaXeKXZWEUbn8=;
 b=GtJoGW/HnySJbBfFlHHcSq1BcCPWnf1LCeYIeZQu5rgzU2tkklp58GPG+ohLZTVlCUQF
 6AX5j1J/lhXFMmo6GkNx+bURyFhmBX3HiOCKAekKxe3WcApf8uMgz3N2pn6x4GYPTLsH
 /faHQyUQchUn4e67UfVoqTUSso4X7L32c2TAqnXstOPgZuALn9jjsf6q8mVV+mV+Qb+g
 HuZB1DyEzVGcSKTRaI7PdRWvor1RC4JaG3GYehCVOcK+idThR8f1IuKwX4umhteisI8t
 jmmCzLGstbYCMYhM1ZorT73+aFg2PatPEB5Cygf2xJYKwuYEDrSvcK/uRSl7/ucVx7+5 Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xf73yajks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 00:55:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E0maIA082076;
        Tue, 14 Jan 2020 00:55:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xfrgjmvb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 00:55:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E0tb0D013818;
        Tue, 14 Jan 2020 00:55:37 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 16:55:37 -0800
Subject: Re: [PATCH v9 3/8] hugetlb_cgroup: add reservation accounting for
 private mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-3-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dec1ccd5-5973-c498-f2fe-390c1c51b2d0@oracle.com>
Date:   Mon, 13 Jan 2020 16:55:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191217231615.164161-3-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140005
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/19 3:16 PM, Mina Almasry wrote:
> Normally the pointer to the cgroup to uncharge hangs off the struct
> page, and gets queried when it's time to free the page. With
> hugetlb_cgroup reservations, this is not possible. Because it's possible
> for a page to be reserved by one task and actually faulted in by another
> task.
> 
> The best place to put the hugetlb_cgroup pointer to uncharge for
> reservations is in the resv_map. But, because the resv_map has different
> semantics for private and shared mappings, the code patch to
> charge/uncharge shared and private mappings is different. This patch
> implements charging and uncharging for private mappings.
> 
> For private mappings, the counter to uncharge is in
> resv_map->reservation_counter. On initializing the resv_map this is set
> to NULL. On reservation of a region in private mapping, the tasks
> hugetlb_cgroup is charged and the hugetlb_cgroup is placed is
> resv_map->reservation_counter.
> 
> On hugetlb_vm_op_close, we uncharge resv_map->reservation_counter.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Hillf Danton <hdanton@sina.com>
> 
> ---
> 
> Changes in V9:
> - Updated for reparenting of hugetlb reservation accounting.
> 
> ---
>  include/linux/hugetlb.h        |  9 +++++++
>  include/linux/hugetlb_cgroup.h | 27 +++++++++++++++++++
>  mm/hugetlb.c                   | 47 +++++++++++++++++++++++++++++++++-
>  mm/hugetlb_cgroup.c            | 28 --------------------
>  4 files changed, 82 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index dea6143aa0685..e6ab499ba2086 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -46,6 +46,15 @@ struct resv_map {
>  	long adds_in_progress;
>  	struct list_head region_cache;
>  	long region_cache_count;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * On private mappings, the counter to uncharge reservations is stored
> +	 * here. If these fields are 0, then the mapping is shared.

Will *reservation_counter ALWAYS be non-NULL for private mappings?

More on this below.

> +	 */
> +	struct page_counter *reservation_counter;
> +	unsigned long pages_per_hpage;
> +	struct cgroup_subsys_state *css;
> +#endif
>  };
>  extern struct resv_map *resv_map_alloc(void);
>  void resv_map_release(struct kref *ref);
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index eab8a70d5bcb5..8c320accefe87 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -25,6 +25,33 @@ struct hugetlb_cgroup;
>  #define HUGETLB_CGROUP_MIN_ORDER	2
> 
>  #ifdef CONFIG_CGROUP_HUGETLB
> +enum hugetlb_memory_event {
> +	HUGETLB_MAX,
> +	HUGETLB_NR_MEMORY_EVENTS,
> +};
> +
> +struct hugetlb_cgroup {
> +	struct cgroup_subsys_state css;
> +
> +	/*
> +	 * the counter to account for hugepages from hugetlb.
> +	 */
> +	struct page_counter hugepage[HUGE_MAX_HSTATE];
> +
> +	/*
> +	 * the counter to account for hugepage reservations from hugetlb.
> +	 */
> +	struct page_counter reserved_hugepage[HUGE_MAX_HSTATE];
> +
> +	atomic_long_t events[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> +	atomic_long_t events_local[HUGE_MAX_HSTATE][HUGETLB_NR_MEMORY_EVENTS];
> +
> +	/* Handle for "hugetlb.events" */
> +	struct cgroup_file events_file[HUGE_MAX_HSTATE];
> +
> +	/* Handle for "hugetlb.events.local" */
> +	struct cgroup_file events_local_file[HUGE_MAX_HSTATE];
> +};
> 
>  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
>  							      bool reserved)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e6e8240f1718c..7782977970301 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -665,6 +665,17 @@ struct resv_map *resv_map_alloc(void)
>  	INIT_LIST_HEAD(&resv_map->regions);
> 
>  	resv_map->adds_in_progress = 0;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * Initialize these to 0. On shared mappings, 0's here indicate these
> +	 * fields don't do cgroup accounting. On private mappings, these will be
> +	 * re-initialized to the proper values, to indicate that hugetlb cgroup
> +	 * reservations are to be un-charged from here.
> +	 */
> +	resv_map->reservation_counter = NULL;
> +	resv_map->pages_per_hpage = 0;
> +	resv_map->css = NULL;
> +#endif
> 
>  	INIT_LIST_HEAD(&resv_map->region_cache);
>  	list_add(&rg->link, &resv_map->region_cache);
> @@ -3145,7 +3156,20 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
> 
>  	reserve = (end - start) - region_count(resv, start, end);
> 
> -	kref_put(&resv->refs, resv_map_release);
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * Since we check for HPAGE_RESV_OWNER above, this must a private
> +	 * mapping, and these values should be none-zero, and should point to
> +	 * the hugetlb_cgroup counter to uncharge for this reservation.
> +	 */
> +	WARN_ON(!resv->reservation_counter);
> +	WARN_ON(!resv->pages_per_hpage);
> +	WARN_ON(!resv->css);

I was once again wondering if these were always non-NULL for private mappings.
It seems that reservation_counter (h_gc) would be NULL in these cases from
these early checks in hugetlb_cgroup_charge_cgroup().

int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
                                 struct hugetlb_cgroup **ptr, bool reserved)
{
        int ret = 0;
        struct page_counter *counter;
        struct hugetlb_cgroup *h_cg = NULL;

        if (hugetlb_cgroup_disabled())
                goto done;
        /*
         * We don't charge any cgroup if the compound page have less
         * than 3 pages.
         */
        if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
                goto done;
	...

It seems like the following hugetlb_cgroup_uncharge_counter() guards
against reservation_counter being NULL (for some of the same reasons).

> +
> +	hugetlb_cgroup_uncharge_counter(resv->reservation_counter,
> +					(end - start) * resv->pages_per_hpage,
> +					resv->css);
> +#endif
> 
>  	if (reserve) {
>  		/*
> @@ -3155,6 +3179,8 @@ static void hugetlb_vm_op_close(struct vm_area_struct *vma)
>  		gbl_reserve = hugepage_subpool_put_pages(spool, reserve);
>  		hugetlb_acct_memory(h, -gbl_reserve);
>  	}
> +
> +	kref_put(&resv->refs, resv_map_release);
>  }
> 
>  static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
> @@ -4501,6 +4527,7 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	struct hstate *h = hstate_inode(inode);
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	struct resv_map *resv_map;
> +	struct hugetlb_cgroup *h_cg;
>  	long gbl_reserve;
> 
>  	/* This should never happen */
> @@ -4534,12 +4561,30 @@ int hugetlb_reserve_pages(struct inode *inode,
>  		chg = region_chg(resv_map, from, to);
> 
>  	} else {
> +		/* Private mapping. */
>  		resv_map = resv_map_alloc();
>  		if (!resv_map)
>  			return -ENOMEM;
> 
>  		chg = to - from;
> 
> +		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
> +						 chg * pages_per_huge_page(h),
> +						 &h_cg, true)) {
> +			kref_put(&resv_map->refs, resv_map_release);
> +			return -ENOMEM;
> +		}
> +

Shouldn't this code be in the #ifdef CONFIG_CGROUP_HUGETLB block?
-- 
Mike Kravetz

> +#ifdef CONFIG_CGROUP_HUGETLB
> +		/*
> +		 * Since this branch handles private mappings, we attach the
> +		 * counter to uncharge for this reservation off resv_map.
> +		 */
> +		resv_map->reservation_counter =
> +			&h_cg->reserved_hugepage[hstate_index(h)];
> +		resv_map->pages_per_hpage = pages_per_huge_page(h);
> +#endif
> +
>  		set_vma_resv_map(vma, resv_map);
>  		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
>  	}
