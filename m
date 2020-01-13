Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9369139C3D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 23:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMWPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 17:15:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWPF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 17:15:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DM8RiX151261;
        Mon, 13 Jan 2020 22:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=e1s+RL7OyB59UZqX24mOy/lEpU3PMDdLREn6RfW9CC4=;
 b=nokqI9a84k9oPRxro7ZgxDA1mpykFyFsZhD2YZaXE21cADgGqzKC8iG+StifNefDJW4Y
 TAEloNB+TqI/fEWD/UIwYzp3+vrzYqTGLVxYJ0qslwHoFhESNxefZrm2E4pg2YPB6wxU
 3dIjh5vurWEpnya7yaiXSGGCLcyi2hiq7lMY7uTvMEmr6ZtJexdVl2lXz8h3gi0zVubJ
 Ay0w0h+Z/7MHzO1fOvWFbYjidi0zzcreD6DKZDwaBZJif45Vj5d2Bcp5+0HI+SAM8tur
 ZFHyeaJtaiLz4XoFdT+gz3uR/MJxhvX7HRCzK1MZOADwF3Sz5YCFW6OXIQb1bzlD6uJE GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73thyaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:14:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DM5euh122535;
        Mon, 13 Jan 2020 22:14:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xfrgjfa4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 22:14:53 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DMEq5E005341;
        Mon, 13 Jan 2020 22:14:52 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 14:14:52 -0800
Subject: Re: [PATCH v9 2/8] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191217231615.164161-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0855cae0-872e-0727-aa7c-55051d8f0871@oracle.com>
Date:   Mon, 13 Jan 2020 14:14:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191217231615.164161-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130181
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/17/19 3:16 PM, Mina Almasry wrote:
> Augments hugetlb_cgroup_charge_cgroup to be able to charge hugetlb
> usage or hugetlb reservation counter.
> 
> Adds a new interface to uncharge a hugetlb_cgroup counter via
> hugetlb_cgroup_uncharge_counter.
> 
> Integrates the counter with hugetlb_cgroup, via hugetlb_cgroup_init,
> hugetlb_cgroup_have_usage, and hugetlb_cgroup_css_offline.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in V9:
> - Fixed HUGETLB_CGROUP_MIN_ORDER.
> - Minor variable name update.
> - Moved some init/cleanup code from later patches in the series to this patch.
> - Updated reparenting of reservation accounting.
> 
> ---
>  include/linux/hugetlb_cgroup.h | 68 ++++++++++++++---------
>  mm/hugetlb.c                   | 19 ++++---
>  mm/hugetlb_cgroup.c            | 98 +++++++++++++++++++++++++---------
>  3 files changed, 127 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 063962f6dfc6a..eab8a70d5bcb5 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -20,29 +20,37 @@
>  struct hugetlb_cgroup;
>  /*
>   * Minimum page order trackable by hugetlb cgroup.
> - * At least 3 pages are necessary for all the tracking information.
> + * At least 4 pages are necessary for all the tracking information.
>   */
>  #define HUGETLB_CGROUP_MIN_ORDER	2
> 
>  #ifdef CONFIG_CGROUP_HUGETLB
> 
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> +							      bool reserved)
>  {
>  	VM_BUG_ON_PAGE(!PageHuge(page), page);
> 
>  	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
>  		return NULL;
> -	return (struct hugetlb_cgroup *)page[2].private;
> +	if (reserved)
> +		return (struct hugetlb_cgroup *)page[3].private;
> +	else
> +		return (struct hugetlb_cgroup *)page[2].private;
>  }
> 
> -static inline
> -int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
> +static inline int set_hugetlb_cgroup(struct page *page,
> +				     struct hugetlb_cgroup *h_cg,
> +				     bool reservation)
>  {
>  	VM_BUG_ON_PAGE(!PageHuge(page), page);
> 
>  	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
>  		return -1;
> -	page[2].private	= (unsigned long)h_cg;
> +	if (reservation)
> +		page[3].private = (unsigned long)h_cg;
> +	else
> +		page[2].private = (unsigned long)h_cg;
>  	return 0;
>  }
> 
> @@ -52,26 +60,34 @@ static inline bool hugetlb_cgroup_disabled(void)
>  }
> 
>  extern int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> -					struct hugetlb_cgroup **ptr);
> +					struct hugetlb_cgroup **ptr,
> +					bool reserved);
>  extern void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  					 struct hugetlb_cgroup *h_cg,
> -					 struct page *page);
> +					 struct page *page, bool reserved);
>  extern void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> -					 struct page *page);
> +					 struct page *page, bool reserved);
> +
>  extern void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
> -					   struct hugetlb_cgroup *h_cg);
> +					   struct hugetlb_cgroup *h_cg,
> +					   bool reserved);
> +extern void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
> +					    unsigned long nr_pages,
> +					    struct cgroup_subsys_state *css);
> +

Do we need a corresponding stub for the !CONFIG_CGROUP_HUGETLB case?

>  extern void hugetlb_cgroup_file_init(void) __init;
>  extern void hugetlb_cgroup_migrate(struct page *oldhpage,
>  				   struct page *newhpage);
> 
>  #else
> -static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
> +static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page,
> +							      bool reserved)
>  {
>  	return NULL;
>  }
> 
> -static inline
> -int set_hugetlb_cgroup(struct page *page, struct hugetlb_cgroup *h_cg)
> +static inline int set_hugetlb_cgroup(struct page *page,
> +				     struct hugetlb_cgroup *h_cg, bool reserved)
>  {
>  	return 0;
>  }
> @@ -81,28 +97,30 @@ static inline bool hugetlb_cgroup_disabled(void)
>  	return true;
>  }
> 
> -static inline int
> -hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> -			     struct hugetlb_cgroup **ptr)
> +static inline int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> +					       struct hugetlb_cgroup **ptr,
> +					       bool reserved)
>  {
>  	return 0;
>  }
> 
> -static inline void
> -hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> -			     struct hugetlb_cgroup *h_cg,
> -			     struct page *page)
> +static inline void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
> +						struct hugetlb_cgroup *h_cg,
> +						struct page *page,
> +						bool reserved)
>  {
>  }
> 
> -static inline void
> -hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages, struct page *page)
> +static inline void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> +						struct page *page,
> +						bool reserved)
>  {
>  }
> 
> -static inline void
> -hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
> -			       struct hugetlb_cgroup *h_cg)
> +static inline void hugetlb_cgroup_uncharge_cgroup(int idx,
> +						  unsigned long nr_pages,
> +						  struct hugetlb_cgroup *h_cg,
> +						  bool reserved)
>  {
>  }
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ac65bb5e38ac2..e6e8240f1718c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1067,7 +1067,8 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
>  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
> @@ -1177,8 +1178,8 @@ void free_huge_page(struct page *page)
> 
>  	spin_lock(&hugetlb_lock);
>  	clear_page_huge_active(page);
> -	hugetlb_cgroup_uncharge_page(hstate_index(h),
> -				     pages_per_huge_page(h), page);
> +	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
> +				     page, false);

hugetlb code has been restructured a bit and this now resides in the
function __free_huge_page().

>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> 
> @@ -1204,7 +1205,8 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	spin_lock(&hugetlb_lock);
> -	set_hugetlb_cgroup(page, NULL);
> +	set_hugetlb_cgroup(page, NULL, false);
> +	set_hugetlb_cgroup(page, NULL, true);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
>  	spin_unlock(&hugetlb_lock);
> @@ -1990,7 +1992,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			gbl_chg = 1;
>  	}
> 
> -	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
> +	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
> +					   false);
>  	if (ret)
>  		goto out_subpool_put;
> 
> @@ -2014,7 +2017,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		/* Fall through */
>  	}
> -	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> +	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
> +				     false);
>  	spin_unlock(&hugetlb_lock);
> 
>  	set_page_private(page, (unsigned long)spool);
> @@ -2038,7 +2042,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	return page;
> 
>  out_uncharge_cgroup:
> -	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
> +	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
> +				       false);
>  out_subpool_put:
>  	if (map_chg || avoid_reserve)
>  		hugepage_subpool_put_pages(spool, 1);
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 35415af9ed26f..b03270b0d5833 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -96,8 +96,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
>  	int idx;
> 
>  	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
> -		if (page_counter_read(&h_cg->hugepage[idx]))
> +		if (page_counter_read(
> +			    hugetlb_cgroup_get_counter(h_cg, idx, true)) ||
> +		    page_counter_read(
> +			    hugetlb_cgroup_get_counter(h_cg, idx, false))) {
>  			return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -108,18 +112,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>  	int idx;
> 
>  	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
> -		struct page_counter *counter = &h_cgroup->hugepage[idx];
> -		struct page_counter *parent = NULL;
> +		struct page_counter *fault_parent = NULL;
> +		struct page_counter *reserved_parent = NULL;
>  		unsigned long limit;
>  		int ret;
> 
> -		if (parent_h_cgroup)
> -			parent = &parent_h_cgroup->hugepage[idx];
> -		page_counter_init(counter, parent);
> +		if (parent_h_cgroup) {
> +			fault_parent = hugetlb_cgroup_get_counter(
> +				parent_h_cgroup, idx, false);
> +			reserved_parent = hugetlb_cgroup_get_counter(
> +				parent_h_cgroup, idx, true);
> +		}
> +		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
> +							     false),
> +				  fault_parent);
> +		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
> +							     true),
> +				  reserved_parent);
> 
>  		limit = round_down(PAGE_COUNTER_MAX,
>  				   1 << huge_page_order(&hstates[idx]));
> -		ret = page_counter_set_max(counter, limit);
> +
> +		ret = page_counter_set_max(
> +			hugetlb_cgroup_get_counter(h_cgroup, idx, false),
> +			limit);
> +		ret = page_counter_set_max(
> +			hugetlb_cgroup_get_counter(h_cgroup, idx, true), limit);
>  		VM_BUG_ON(ret);

The second page_counter_set_max() call overwrites ret before the check in
VM_BUG_ON().

>  	}
>  }
> @@ -149,7 +167,6 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
>  	kfree(h_cgroup);
>  }
> 
> -
>  /*
>   * Should be called with hugetlb_lock held.
>   * Since we are holding hugetlb_lock, pages cannot get moved from
> @@ -165,7 +182,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
>  	struct hugetlb_cgroup *page_hcg;
>  	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> 
> -	page_hcg = hugetlb_cgroup_from_page(page);
> +	page_hcg = hugetlb_cgroup_from_page(page, false);
>  	/*
>  	 * We can have pages in active list without any cgroup
>  	 * ie, hugepage with less than 3 pages. We can safely
> @@ -184,7 +201,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
>  	/* Take the pages off the local counter */
>  	page_counter_cancel(counter, nr_pages);
> 
> -	set_hugetlb_cgroup(page, parent);
> +	set_hugetlb_cgroup(page, parent, false);
>  out:
>  	return;
>  }
> @@ -227,7 +244,7 @@ static inline void hugetlb_event(struct hugetlb_cgroup *hugetlb, int idx,
>  }
> 
>  int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> -				 struct hugetlb_cgroup **ptr)
> +				 struct hugetlb_cgroup **ptr, bool reserved)
>  {
>  	int ret = 0;
>  	struct page_counter *counter;
> @@ -250,13 +267,20 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  	}
>  	rcu_read_unlock();
> 
> -	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages,
> -				     &counter)) {
> +	if (!page_counter_try_charge(hugetlb_cgroup_get_counter(h_cg, idx,
> +								reserved),
> +				     nr_pages, &counter)) {
>  		ret = -ENOMEM;
>  		hugetlb_event(hugetlb_cgroup_from_counter(counter, idx), idx,
>  			      HUGETLB_MAX);
> +		css_put(&h_cg->css);
> +		goto done;
>  	}
> -	css_put(&h_cg->css);
> +	/* Reservations take a reference to the css because they do not get
> +	 * reparented.

I'm hoping someone with more cgroup knowledge can comment on this and any
consequences of not reparenting reservations.  We previously talked about
why reparenting would be very difficult/expensive.  I understand why you are
nopt doing it.  Just do not fully understand what needs to be done from the
cgroup side.

Several of the following modifications deal with this.
--
Mike kravetz

> +	 */
> +	if (!reserved)
> +		css_put(&h_cg->css);
>  done:
>  	*ptr = h_cg;
>  	return ret;
> @@ -265,12 +289,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  /* Should be called with hugetlb_lock held */
>  void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>  				  struct hugetlb_cgroup *h_cg,
> -				  struct page *page)
> +				  struct page *page, bool reserved)
>  {
>  	if (hugetlb_cgroup_disabled() || !h_cg)
>  		return;
> 
> -	set_hugetlb_cgroup(page, h_cg);
> +	set_hugetlb_cgroup(page, h_cg, reserved);
>  	return;
>  }
> 
> @@ -278,23 +302,29 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
>   * Should be called with hugetlb_lock held
>   */
>  void hugetlb_cgroup_uncharge_page(int idx, unsigned long nr_pages,
> -				  struct page *page)
> +				  struct page *page, bool reserved)
>  {
>  	struct hugetlb_cgroup *h_cg;
> 
>  	if (hugetlb_cgroup_disabled())
>  		return;
>  	lockdep_assert_held(&hugetlb_lock);
> -	h_cg = hugetlb_cgroup_from_page(page);
> +	h_cg = hugetlb_cgroup_from_page(page, reserved);
>  	if (unlikely(!h_cg))
>  		return;
> -	set_hugetlb_cgroup(page, NULL);
> -	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
> +	set_hugetlb_cgroup(page, NULL, reserved);
> +
> +	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
> +			      nr_pages);
> +
> +	if (reserved)
> +		css_put(&h_cg->css);
> +
>  	return;
>  }
> 
>  void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
> -				    struct hugetlb_cgroup *h_cg)
> +				    struct hugetlb_cgroup *h_cg, bool reserved)
>  {
>  	if (hugetlb_cgroup_disabled() || !h_cg)
>  		return;
> @@ -302,8 +332,22 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
>  	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
>  		return;
> 
> -	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
> -	return;
> +	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
> +			      nr_pages);
> +
> +	if (reserved)
> +		css_put(&h_cg->css);
> +}
> +
> +void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
> +				     unsigned long nr_pages,
> +				     struct cgroup_subsys_state *css)
> +{
> +	if (hugetlb_cgroup_disabled() || !p || !css)
> +		return;
> +
> +	page_counter_uncharge(p, nr_pages);
> +	css_put(css);
>  }
> 
>  enum {
> @@ -678,6 +722,7 @@ void __init hugetlb_cgroup_file_init(void)
>  void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>  {
>  	struct hugetlb_cgroup *h_cg;
> +	struct hugetlb_cgroup *h_cg_reservation;
>  	struct hstate *h = page_hstate(oldhpage);
> 
>  	if (hugetlb_cgroup_disabled())
> @@ -685,11 +730,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
> 
>  	VM_BUG_ON_PAGE(!PageHuge(oldhpage), oldhpage);
>  	spin_lock(&hugetlb_lock);
> -	h_cg = hugetlb_cgroup_from_page(oldhpage);
> -	set_hugetlb_cgroup(oldhpage, NULL);
> +	h_cg = hugetlb_cgroup_from_page(oldhpage, false);
> +	h_cg_reservation = hugetlb_cgroup_from_page(oldhpage, true);
> +	set_hugetlb_cgroup(oldhpage, NULL, false);
> 
>  	/* move the h_cg details to new cgroup */
> -	set_hugetlb_cgroup(newhpage, h_cg);
> +	set_hugetlb_cgroup(newhpage, h_cg_reservation, true);
>  	list_move(&newhpage->lru, &h->hugepage_activelist);
>  	spin_unlock(&hugetlb_lock);
>  	return;
> --
> 2.24.1.735.g03f4e72817-goog
> 
