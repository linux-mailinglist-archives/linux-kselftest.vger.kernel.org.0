Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32119154C4F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 20:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgBFTeM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 14:34:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43944 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgBFTeM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 14:34:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016JSAGI189719;
        Thu, 6 Feb 2020 19:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CrH9bmcn6uxBFYAvwB9CFM38eb9W7O+hbvOjLi1XY1w=;
 b=vocljonORmgNesNX8cXsMVlcIenO7n8z6yz51USo08O5Dqcet9I2u5p/khgL7BofwG9f
 l4BDBxZhK/C/4OCgFoeuzlDBCuw+siK9zg0CwjxAXrKy0IQcE5dQs4ZqKxdjVhi4vi0R
 7a5k1du8yKcR4j0+TarmuEyOugyspABQgZhTCy+LH+T6LV9aalOcC6KGZeedN5Rro8Jf
 TAaG8UtlstFy15kF4/sg9ljhna5pV+lCvw7NDDVsiBqKFcnkHTEQOocpRviIjvBRLY+s
 ZC6Hi5P3jlMaLq4q+mb7jXEknahwsA3cN5BCRJ+zDWOwE+lNS12Wd8zgLJW706V6pbnC xQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=CrH9bmcn6uxBFYAvwB9CFM38eb9W7O+hbvOjLi1XY1w=;
 b=b6CnPpyX/ZO60huYnGZG5meZEFSUXz3sVWRDVaD6ZKPreqOi3SDCY2Z2ufHikYpZXf0u
 SJkVGVkoPTj6p/vjtVZV/ceccQB4yJ7b7e1Kkq0MC6jVF3PFRHv9gJWhMksN+Lo0Yisz
 gBpQgPz1txaOh1IRGXDfAOIBYpnlmfYg1nhLMKKEDJOITskNaBQqu6Yr0Qx2ZKXvqalU
 G8Q54BvxLoTyGbD4pbz3zhKIRk05XdY7J2tldYVbOvQSjuRt1Q2qldIXiMM62kBUj/sj
 ZzyGrDdJJRxIa9Nhwgu1kCo6kaFVOscb4qTKfFVg7GaLc/zugJ2r0DPIMx8ocZY8rom3 TQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xykbpkwvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 19:34:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 016JSmCQ164764;
        Thu, 6 Feb 2020 19:34:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2y0mjv9m3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Feb 2020 19:34:02 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 016JXxKd011897;
        Thu, 6 Feb 2020 19:34:00 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Feb 2020 11:33:59 -0800
Subject: Re: [PATCH v11 5/9] hugetlb_cgroup: add accounting for shared
 mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-5-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <263e4326-2540-4bb6-cca9-e53c014eb3a6@oracle.com>
Date:   Thu, 6 Feb 2020 11:33:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-5-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002060143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002060143
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/20 3:22 PM, Mina Almasry wrote:
> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> in the resv_map entries, in file_region->reservation_counter.
> 
> After a call to region_chg, we charge the approprate hugetlb_cgroup, and if
> successful, we pass on the hugetlb_cgroup info to a follow up region_add call.
> When a file_region entry is added to the resv_map via region_add, we put the
> pointer to that cgroup in file_region->reservation_counter. If charging doesn't
> succeed, we report the error to the caller, so that the kernel fails the
> reservation.
> 
> On region_del, which is when the hugetlb memory is unreserved, we also uncharge

Lines of commit message wrap.

> the file_region->reservation_counter.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in v11:
> - Created new function, hugetlb_cgroup_uncharge_file_region to clean up
> some #ifdefs.
> - Moved file_region definition to hugetlb.h.
> - Added copy_hugetlb_cgroup_uncharge_info function to clean up more
>  #ifdefs in the middle of hugetlb code.
> 
> Changes in v10:
> - Deleted duplicated code snippet.
> 
> Changes in V9:
> - Updated for hugetlb reservation repareting.
> 
> ---
>  include/linux/hugetlb.h        |  36 ++++++++
>  include/linux/hugetlb_cgroup.h |  10 +++
>  mm/hugetlb.c                   | 147 +++++++++++++++++++++------------
>  mm/hugetlb_cgroup.c            |  15 ++++
>  4 files changed, 155 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5491932ea5758..395f5b1fad416 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -57,6 +57,42 @@ struct resv_map {
>  	struct cgroup_subsys_state *css;
>  #endif
>  };
> +
> +/*
> + * Region tracking -- allows tracking of reservations and instantiated pages
> + *                    across the pages in a mapping.
> + *
> + * The region data structures are embedded into a resv_map and protected
> + * by a resv_map's lock.  The set of regions within the resv_map represent
> + * reservations for huge pages, or huge pages that have already been
> + * instantiated within the map.  The from and to elements are huge page
> + * indicies into the associated mapping.  from indicates the starting index
> + * of the region.  to represents the first index past the end of  the region.
> + *
> + * For example, a file region structure with from == 0 and to == 4 represents
> + * four huge pages in a mapping.  It is important to note that the to element
> + * represents the first element past the end of the region. This is used in
> + * arithmetic as 4(to) - 0(from) = 4 huge pages in the region.
> + *
> + * Interval notation of the form [from, to) will be used to indicate that
> + * the endpoint from is inclusive and to is exclusive.
> + */
> +struct file_region {
> +	struct list_head link;
> +	long from;
> +	long to;
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	/*
> +	 * On shared mappings, each reserved region appears as a struct
> +	 * file_region in resv_map. These fields hold the info needed to
> +	 * uncharge each reservation.
> +	 */
> +	struct page_counter *reservation_counter;
> +	unsigned long pages_per_hpage;

Can we get rid of pages_per_hpage here?  It seems redundant as it will be
the same for each file region.  The same field/information is in the resv_map
but only used for private mappings.  Perhaps, we should use it for both
shared and private?

> +	struct cgroup_subsys_state *css;
> +#endif
> +};
> +
>  extern struct resv_map *resv_map_alloc(void);
>  void resv_map_release(struct kref *ref);
> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 6a6c80df95ae3..c3fd417c268c5 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -102,11 +102,21 @@ extern void hugetlb_cgroup_uncharge_counter(struct resv_map *resv,
>  					    unsigned long start,
>  					    unsigned long end);
> 
> +extern void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
> +						struct file_region *rg,
> +						unsigned long nr_pages);
> +
>  extern void hugetlb_cgroup_file_init(void) __init;
>  extern void hugetlb_cgroup_migrate(struct page *oldhpage,
>  				   struct page *newhpage);
> 
>  #else
> +
> +static inline void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
> +						       struct file_region *rg,
> +						       unsigned long nr_pages)
> +{
> +}
>  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
>  							      bool rsvd)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 986e9a9cc6fbe..33818ccaf7e89 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -220,31 +220,6 @@ static inline struct hugepage_subpool *subpool_vma(struct vm_area_struct *vma)
>  	return subpool_inode(file_inode(vma->vm_file));
>  }
> 
> -/*
> - * Region tracking -- allows tracking of reservations and instantiated pages
> - *                    across the pages in a mapping.
> - *
> - * The region data structures are embedded into a resv_map and protected
> - * by a resv_map's lock.  The set of regions within the resv_map represent
> - * reservations for huge pages, or huge pages that have already been
> - * instantiated within the map.  The from and to elements are huge page
> - * indicies into the associated mapping.  from indicates the starting index
> - * of the region.  to represents the first index past the end of  the region.
> - *
> - * For example, a file region structure with from == 0 and to == 4 represents
> - * four huge pages in a mapping.  It is important to note that the to element
> - * represents the first element past the end of the region. This is used in
> - * arithmetic as 4(to) - 0(from) = 4 huge pages in the region.
> - *
> - * Interval notation of the form [from, to) will be used to indicate that
> - * the endpoint from is inclusive and to is exclusive.
> - */
> -struct file_region {
> -	struct list_head link;
> -	long from;
> -	long to;
> -};
> -
>  /* Helper that removes a struct file_region from the resv_map cache and returns
>   * it for use.
>   */
> @@ -266,6 +241,37 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>  	return nrg;
>  }
> 
> +static void copy_hugetlb_cgroup_uncharge_info(struct file_region *nrg,
> +					      struct file_region *rg)
> +{
> +#ifdef CONFIG_CGROUP_HUGETLB
> +
> +	nrg->reservation_counter = rg->reservation_counter;
> +	nrg->pages_per_hpage = rg->pages_per_hpage;
> +	nrg->css = rg->css;
> +	css_get(rg->css);
> +#endif
> +}
> +
> +/* Helper that records hugetlb_cgroup uncharge info. */
> +static void record_hugetlb_cgroup_uncharge_info(struct hugetlb_cgroup *h_cg,
> +						struct file_region *nrg,
> +						struct hstate *h)

Not necessary, but I would make nrg first (or last) argument.  It seems
a bit odd that it is between two items that are most closely related.

> +{
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	if (h_cg) {
> +		nrg->reservation_counter =
> +			&h_cg->rsvd_hugepage[hstate_index(h)];
> +		nrg->pages_per_hpage = pages_per_huge_page(h);
> +		nrg->css = &h_cg->css;
> +	} else {
> +		nrg->reservation_counter = NULL;
> +		nrg->pages_per_hpage = 0;
> +		nrg->css = NULL;
> +	}
> +#endif
> +}
> +
>  /* Must be called with resv->lock held. Calling this with count_only == true
>   * will count the number of pages to be added but will not modify the linked
>   * list. If regions_needed != NULL and count_only == true, then regions_needed
> @@ -273,7 +279,9 @@ get_file_region_entry_from_cache(struct resv_map *resv, long from, long to)
>   * add the regions for this range.
>   */
>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> -				     long *regions_needed, bool count_only)
> +				     struct hugetlb_cgroup *h_cg,
> +				     struct hstate *h, long *regions_needed,
> +				     bool count_only)

It seems like count_only could be easily determined by value of other
arguments.  However, let's leave it as explicit just to make code easier
to understand.  Not necessary, but I wonder if something like:
#define COUNT_ONLY true
#define PERFORM_ADD false
for arguments to this routine would make the code easier to read/understand.

>  {
>  	long add = 0;
>  	struct list_head *head = &resv->regions;
> @@ -312,6 +320,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  			if (!count_only) {
>  				nrg = get_file_region_entry_from_cache(
>  					resv, last_accounted_offset, rg->from);
> +				record_hugetlb_cgroup_uncharge_info(h_cg, nrg,
> +								    h);
>  				list_add(&nrg->link, rg->link.prev);
>  			} else if (regions_needed)
>  				*regions_needed += 1;
> @@ -328,11 +338,13 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		if (!count_only) {
>  			nrg = get_file_region_entry_from_cache(
>  				resv, last_accounted_offset, t);
> +			record_hugetlb_cgroup_uncharge_info(h_cg, nrg, h);
>  			list_add(&nrg->link, rg->link.prev);
>  		} else if (regions_needed)
>  			*regions_needed += 1;
>  	}
> 
> +	VM_BUG_ON(add < 0);

Curious why that was added.  The computation of 'add' did not change with
these changes.

>  	return add;
>  }
> 
> @@ -353,7 +365,8 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>   * fail; region_chg will always allocate at least 1 entry and a region_add for
>   * 1 page will only require at most 1 entry.
>   */
> -static long region_add(struct resv_map *resv, long f, long t,
> +static long region_add(struct hstate *h, struct hugetlb_cgroup *h_cg,
> +		       struct resv_map *resv, long f, long t,

I would prefer keeping "struct resv_map *resv, long f, long t" as the first
arguments to this routine.  To me that makes most sense as that is the
primary purpose of the operation (to add regions to the reserve map to
cover the range f -> t).

>  		       long in_regions_needed)
>  {
>  	long add = 0, actual_regions_needed = 0, i = 0;
> @@ -366,7 +379,8 @@ static long region_add(struct resv_map *resv, long f, long t,
>  retry:
> 
>  	/* Count how many regions are actually needed to execute this add. */
> -	add_reservation_in_range(resv, f, t, &actual_regions_needed, true);
> +	add_reservation_in_range(resv, f, t, NULL, NULL, &actual_regions_needed,
> +				 true);
> 
>  	/*
>  	 * Check for sufficient descriptors in the cache to accommodate
> @@ -404,7 +418,7 @@ static long region_add(struct resv_map *resv, long f, long t,
>  		goto retry;
>  	}
> 
> -	add = add_reservation_in_range(resv, f, t, NULL, false);
> +	add = add_reservation_in_range(resv, f, t, h_cg, h, NULL, false);
> 
>  	resv->adds_in_progress -= in_regions_needed;
> 
> @@ -452,7 +466,8 @@ static long region_chg(struct resv_map *resv, long f, long t,
>  	spin_lock(&resv->lock);
> 
>  	/* Count how many hugepages in this range are NOT respresented. */
> -	chg = add_reservation_in_range(resv, f, t, out_regions_needed, true);
> +	chg = add_reservation_in_range(resv, f, t, NULL, NULL,
> +				       out_regions_needed, true);
> 
>  	if (*out_regions_needed == 0)
>  		*out_regions_needed = 1;
> @@ -588,11 +603,17 @@ static long region_del(struct resv_map *resv, long f, long t)
>  			/* New entry for end of split region */
>  			nrg->from = t;
>  			nrg->to = rg->to;
> +
> +			copy_hugetlb_cgroup_uncharge_info(nrg, rg);
> +
>  			INIT_LIST_HEAD(&nrg->link);
> 
>  			/* Original entry is trimmed */
>  			rg->to = f;
> 
> +			hugetlb_cgroup_uncharge_file_region(
> +				resv, rg, nrg->to - nrg->from);
> +
>  			list_add(&nrg->link, &rg->link);
>  			nrg = NULL;
>  			break;
> @@ -600,6 +621,8 @@ static long region_del(struct resv_map *resv, long f, long t)
> 
>  		if (f <= rg->from && t >= rg->to) { /* Remove entire region */
>  			del += rg->to - rg->from;
> +			hugetlb_cgroup_uncharge_file_region(resv, rg,
> +							    rg->to - rg->from);
>  			list_del(&rg->link);
>  			kfree(rg);
>  			continue;
> @@ -608,14 +631,21 @@ static long region_del(struct resv_map *resv, long f, long t)
>  		if (f <= rg->from) {	/* Trim beginning of region */
>  			del += t - rg->from;
>  			rg->from = t;
> +
> +			hugetlb_cgroup_uncharge_file_region(resv, rg,
> +							    t - rg->from);
>  		} else {		/* Trim end of region */
>  			del += rg->to - f;
>  			rg->to = f;
> +
> +			hugetlb_cgroup_uncharge_file_region(resv, rg,
> +							    rg->to - f);
>  		}
>  	}
> 
>  	spin_unlock(&resv->lock);
>  	kfree(nrg);
> +
>  	return del;
>  }
> 
> @@ -2017,7 +2047,7 @@ static long __vma_reservation_common(struct hstate *h,
>  		VM_BUG_ON(dummy_out_regions_needed != 1);
>  		break;
>  	case VMA_COMMIT_RESV:
> -		ret = region_add(resv, idx, idx + 1, 1);
> +		ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
>  		/* region_add calls of range 1 should never fail. */
>  		VM_BUG_ON(ret < 0);
>  		break;
> @@ -2027,7 +2057,7 @@ static long __vma_reservation_common(struct hstate *h,
>  		break;
>  	case VMA_ADD_RESV:
>  		if (vma->vm_flags & VM_MAYSHARE) {
> -			ret = region_add(resv, idx, idx + 1, 1);
> +			ret = region_add(NULL, NULL, resv, idx, idx + 1, 1);
>  			/* region_add calls of range 1 should never fail. */
>  			VM_BUG_ON(ret < 0);
>  		} else {
> @@ -4688,7 +4718,7 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	struct hstate *h = hstate_inode(inode);
>  	struct hugepage_subpool *spool = subpool_inode(inode);
>  	struct resv_map *resv_map;
> -	struct hugetlb_cgroup *h_cg;
> +	struct hugetlb_cgroup *h_cg = NULL;
>  	long gbl_reserve, regions_needed = 0;
> 
>  	/* This should never happen */
> @@ -4729,19 +4759,6 @@ int hugetlb_reserve_pages(struct inode *inode,
> 
>  		chg = to - from;
> 
> -		if (hugetlb_cgroup_charge_cgroup(hstate_index(h),
> -						 chg * pages_per_huge_page(h),
> -						 &h_cg, true)) {
> -			kref_put(&resv_map->refs, resv_map_release);
> -			return -ENOMEM;
> -		}
> -
> -		/*
> -		 * Since this branch handles private mappings, we attach the
> -		 * counter to uncharge for this reservation off resv_map.
> -		 */
> -		resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
> -
>  		set_vma_resv_map(vma, resv_map);
>  		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
>  	}
> @@ -4751,6 +4768,21 @@ int hugetlb_reserve_pages(struct inode *inode,
>  		goto out_err;
>  	}
> 
> +	ret = hugetlb_cgroup_charge_cgroup(
> +		hstate_index(h), chg * pages_per_huge_page(h), &h_cg, true);
> +
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
> +		/* For private mappings, the hugetlb_cgroup uncharge info hangs
> +		 * of the resv_map.
> +		 */
> +		resv_map_set_hugetlb_cgroup_uncharge_info(resv_map, h_cg, h);
> +	}
> +
>  	/*
>  	 * There must be enough pages in the subpool for the mapping. If
>  	 * the subpool has a minimum size, there may be some global
> @@ -4759,7 +4791,7 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
>  	if (gbl_reserve < 0) {
>  		ret = -ENOSPC;
> -		goto out_err;
> +		goto out_uncharge_cgroup;
>  	}
> 
>  	/*
> @@ -4768,9 +4800,7 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	 */
>  	ret = hugetlb_acct_memory(h, gbl_reserve);
>  	if (ret < 0) {
> -		/* put back original number of pages, chg */
> -		(void)hugepage_subpool_put_pages(spool, chg);
> -		goto out_err;
> +		goto out_put_pages;
>  	}
> 
>  	/*
> @@ -4785,7 +4815,7 @@ int hugetlb_reserve_pages(struct inode *inode,
>  	 * else has to be done for private mappings here
>  	 */
>  	if (!vma || vma->vm_flags & VM_MAYSHARE) {
> -		add = region_add(resv_map, from, to, regions_needed);
> +		add = region_add(h, h_cg, resv_map, from, to, regions_needed);
> 
>  		if (unlikely(add < 0)) {
>  			hugetlb_acct_memory(h, -gbl_reserve);

Don't we need to call hugetlb_cgroup_uncharge_cgroup() in the case as well?
Also, can you "goto out_put_pages" to avoid hugepage_subpool_put_pages() call?

> @@ -4802,12 +4832,23 @@ int hugetlb_reserve_pages(struct inode *inode,
>  			 */
>  			long rsv_adjust;
> 
> -			rsv_adjust = hugepage_subpool_put_pages(spool,
> -								chg - add);
> +			hugetlb_cgroup_uncharge_cgroup(
> +				hstate_index(h),
> +				(chg - add) * pages_per_huge_page(h), h_cg,
> +				true);
> +
> +			rsv_adjust =
> +				hugepage_subpool_put_pages(spool, chg - add);
>  			hugetlb_acct_memory(h, -rsv_adjust);
>  		}
>  	}
>  	return 0;
> +out_put_pages:
> +	/* put back original number of pages, chg */
> +	(void)hugepage_subpool_put_pages(spool, chg);
> +out_uncharge_cgroup:
> +	hugetlb_cgroup_uncharge_cgroup(
> +		hstate_index(h), chg * pages_per_huge_page(h), h_cg, true);
>  out_err:
>  	if (!vma || vma->vm_flags & VM_MAYSHARE)
>  		/* Only call region_abort if the region_chg succeeded but the
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index e079513c8de0d..916ee24cc50d3 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -326,6 +326,21 @@ void hugetlb_cgroup_uncharge_counter(struct resv_map *resv, unsigned long start,
>  	css_put(resv->css);
>  }
> 
> +void hugetlb_cgroup_uncharge_file_region(struct resv_map *resv,
> +					 struct file_region *rg,
> +					 unsigned long nr_pages)
> +{
> +	if (hugetlb_cgroup_disabled() || !resv || !rg || !nr_pages)
> +		return;
> +
> +	if (rg->reservation_counter && rg->pages_per_hpage && nr_pages > 0 &&
> +	    !resv->reservation_counter) {
> +		page_counter_uncharge(rg->reservation_counter,
> +				      nr_pages * rg->pages_per_hpage);
> +		css_put(rg->css);
> +	}
> +}
> +
>  enum {
>  	RES_USAGE,
>  	RES_RSVD_USAGE,
> --
> 2.25.0.341.g760bfbb309-goog

-- 
Mike Kravetz
