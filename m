Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1298FF3D1F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 01:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKHA6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 19:58:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42454 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfKHA6M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 19:58:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA80sKEu184199;
        Fri, 8 Nov 2019 00:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UU/Dfag6KnBuka9R3Da62S1MTnA6vn9ewnZDvX6Jrt0=;
 b=OqsjO7mTsZBbPN3n1/xp8QstMECqGHGq5/YT/0Tvoiks3vVB6PrmuX2gt0aNhCItogVI
 1hknAdCqdoM1DWkucVp9J5Rjx+kJpQENfOZWH1JcQYtznWMW4T3SKjytzZrs8jg5EC/e
 rWlxLtGixdZ7FLeWIndKagAioMwa02YctnIZA7tPSvnm72QHdGIYl6lHHEjNnivFtmBm
 edSeI0IdazlNA8kPwYfbgQUbUKKgtG9dfIRJ17rYjMXgx6TWXyvZ9gsof8thUjeAAkxx
 wFYKyhbFt00PgyXhi7ogLzujVy9dok/FNvDB/AthQR8rwbxEQ0tS9sF1+Dpl4ydSdZbi jA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w41w19ynj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 00:57:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA80s5qe033511;
        Fri, 8 Nov 2019 00:57:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w4k2xxvkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Nov 2019 00:57:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA80vrRm020394;
        Fri, 8 Nov 2019 00:57:53 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 16:57:52 -0800
Subject: Re: [PATCH v8 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9e10c273-f0ab-4173-570e-26c314b989fb@oracle.com>
Date:   Thu, 7 Nov 2019 16:57:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030013701.39647-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911080006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9434 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911080006
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/29/19 6:36 PM, Mina Almasry wrote:
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
>  include/linux/hugetlb_cgroup.h |  67 +++++++++++++---------
>  mm/hugetlb.c                   |  17 +++---
>  mm/hugetlb_cgroup.c            | 100 +++++++++++++++++++++++++--------
>  3 files changed, 130 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 063962f6dfc6a..1bb58a63af586 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -22,27 +22,35 @@ struct hugetlb_cgroup;
>   * Minimum page order trackable by hugetlb cgroup.
>   * At least 3 pages are necessary for all the tracking information.
>   */
> -#define HUGETLB_CGROUP_MIN_ORDER	2
> +#define HUGETLB_CGROUP_MIN_ORDER 3

Correct me if misremembering, but I think the reson you changed this was
so that you could use page[3].private.  Correct?
In that case isn't page[3] the last page of an order 2 allocation?
If my understanding is correct, then leave HUGETLB_CGROUP_MIN_ORDER as is
and update the preceding comment to say that at least 4 pages are necessary.

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
> @@ -52,26 +60,33 @@ static inline bool hugetlb_cgroup_disabled(void)
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
> +					    unsigned long nr_pages);
> +
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
> @@ -81,28 +96,30 @@ static inline bool hugetlb_cgroup_disabled(void)
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
> index 37195cd60a345..325d5454bf168 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1140,7 +1140,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);

Shouldn't we add a VM_BUG_ON_PAGE for reserved as well?
Oh, I see it is done in a later patch.
I guess it is not here as there are no users of reserved yet?
Same observation in other places in hugetlb.c below.
Since you add the API changes for reserved here, as well as define
page[3].private to store info, I don't think it would hurt to add
the initialization and checking and cleanup here as well.
Thoughts?

>  	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
>  	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
> @@ -1250,8 +1250,8 @@ void free_huge_page(struct page *page)
> 
>  	spin_lock(&hugetlb_lock);
>  	clear_page_huge_active(page);
> -	hugetlb_cgroup_uncharge_page(hstate_index(h),
> -				     pages_per_huge_page(h), page);
> +	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
> +				     page, false);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> 
> @@ -1277,7 +1277,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
>  	INIT_LIST_HEAD(&page->lru);
>  	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
>  	spin_lock(&hugetlb_lock);
> -	set_hugetlb_cgroup(page, NULL);
> +	set_hugetlb_cgroup(page, NULL, false);
>  	h->nr_huge_pages++;
>  	h->nr_huge_pages_node[nid]++;
>  	spin_unlock(&hugetlb_lock);
> @@ -2063,7 +2063,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			gbl_chg = 1;
>  	}
> 
> -	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
> +	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
> +					   false);
>  	if (ret)
>  		goto out_subpool_put;
> 
> @@ -2087,7 +2088,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  		list_move(&page->lru, &h->hugepage_activelist);
>  		/* Fall through */
>  	}
> -	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> +	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
> +				     false);
>  	spin_unlock(&hugetlb_lock);
> 
>  	set_page_private(page, (unsigned long)spool);
> @@ -2111,7 +2113,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
> index 1ed4448ca41d3..854117513979b 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -73,8 +73,12 @@ static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
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
> @@ -85,18 +89,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>  	int idx;
> 
>  	for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
> -		struct page_counter *counter = &h_cgroup->hugepage[idx];
>  		struct page_counter *parent = NULL;

Should we perhaps rename 'parent' to 'fault_parent' to be consistent?
That makes me think if perhaps the naming in the previous patch should
be more explicit.  Make the existing names explicitly contin 'fault' as
the new names contain 'reservation'.
Just a thought.

> +		struct page_counter *reserved_parent = NULL;
>  		unsigned long limit;
>  		int ret;
> 
> -		if (parent_h_cgroup)
> -			parent = &parent_h_cgroup->hugepage[idx];
> -		page_counter_init(counter, parent);
> +		if (parent_h_cgroup) {
> +			parent = hugetlb_cgroup_get_counter(parent_h_cgroup,
> +							    idx, false);
> +			reserved_parent = hugetlb_cgroup_get_counter(
> +				parent_h_cgroup, idx, true);
> +		}
> +		page_counter_init(hugetlb_cgroup_get_counter(h_cgroup, idx,
> +							     false),
> +				  parent);
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
>  	}
>  }
> @@ -126,6 +144,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
>  	kfree(h_cgroup);
>  }
> 
> +static void hugetlb_cgroup_move_parent_reservation(int idx,
> +						   struct hugetlb_cgroup *h_cg)
> +{
> +	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> +
> +	/* Move the reservation counters. */
> +	if (!parent_hugetlb_cgroup(h_cg)) {
> +		parent = root_h_cgroup;
> +		/* root has no limit */
> +		page_counter_charge(
> +			&root_h_cgroup->reserved_hugepage[idx],
> +			page_counter_read(
> +				hugetlb_cgroup_get_counter(h_cg, idx, true)));
> +	}
> +
> +	/* Take the pages off the local counter */
> +	page_counter_cancel(
> +		hugetlb_cgroup_get_counter(h_cg, idx, true),
> +		page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
> +}

I know next to nothing about cgroups and am just comparing this to the
existing hugetlb_cgroup_move_parent() routine.  hugetlb_cgroup_move_parent
updates the cgroup pointer in each page being moved.  Do we need to do
something similar for reservations being moved (move pointer in reservation)?

-- 
Mike Kravetz

> 
>  /*
>   * Should be called with hugetlb_lock held.
> @@ -142,7 +180,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
>  	struct hugetlb_cgroup *page_hcg;
>  	struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
> 
> -	page_hcg = hugetlb_cgroup_from_page(page);
> +	page_hcg = hugetlb_cgroup_from_page(page, false);
>  	/*
>  	 * We can have pages in active list without any cgroup
>  	 * ie, hugepage with less than 3 pages. We can safely
> @@ -161,7 +199,7 @@ static void hugetlb_cgroup_move_parent(int idx, struct hugetlb_cgroup *h_cg,
>  	/* Take the pages off the local counter */
>  	page_counter_cancel(counter, nr_pages);
> 
> -	set_hugetlb_cgroup(page, parent);
> +	set_hugetlb_cgroup(page, parent, false);
>  out:
>  	return;
>  }
> @@ -180,6 +218,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
>  	do {
>  		for_each_hstate(h) {
>  			spin_lock(&hugetlb_lock);
> +			hugetlb_cgroup_move_parent_reservation(idx, h_cg);
>  			list_for_each_entry(page, &h->hugepage_activelist, lru)
>  				hugetlb_cgroup_move_parent(idx, h_cg, page);
> 
> @@ -191,7 +230,7 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
>  }
> 
>  int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
> -				 struct hugetlb_cgroup **ptr)
> +				 struct hugetlb_cgroup **ptr, bool reserved)
>  {
>  	int ret = 0;
>  	struct page_counter *counter;
> @@ -214,8 +253,11 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  	}
>  	rcu_read_unlock();
> 
> -	if (!page_counter_try_charge(&h_cg->hugepage[idx], nr_pages, &counter))
> +	if (!page_counter_try_charge(hugetlb_cgroup_get_counter(h_cg, idx,
> +								reserved),
> +				     nr_pages, &counter)) {
>  		ret = -ENOMEM;
> +	}
>  	css_put(&h_cg->css);
>  done:
>  	*ptr = h_cg;
> @@ -225,12 +267,12 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
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
> @@ -238,23 +280,26 @@ void hugetlb_cgroup_commit_charge(int idx, unsigned long nr_pages,
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
>  	return;
>  }
> 
>  void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
> -				    struct hugetlb_cgroup *h_cg)
> +				    struct hugetlb_cgroup *h_cg, bool reserved)
>  {
>  	if (hugetlb_cgroup_disabled() || !h_cg)
>  		return;
> @@ -262,8 +307,17 @@ void hugetlb_cgroup_uncharge_cgroup(int idx, unsigned long nr_pages,
>  	if (huge_page_order(&hstates[idx]) < HUGETLB_CGROUP_MIN_ORDER)
>  		return;
> 
> -	page_counter_uncharge(&h_cg->hugepage[idx], nr_pages);
> -	return;
> +	page_counter_uncharge(hugetlb_cgroup_get_counter(h_cg, idx, reserved),
> +			      nr_pages);
> +}
> +
> +void hugetlb_cgroup_uncharge_counter(struct page_counter *p,
> +				     unsigned long nr_pages)
> +{
> +	if (hugetlb_cgroup_disabled() || !p)
> +		return;
> +
> +	page_counter_uncharge(p, nr_pages);
>  }
> 
>  static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
> @@ -475,6 +529,7 @@ void __init hugetlb_cgroup_file_init(void)
>  void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
>  {
>  	struct hugetlb_cgroup *h_cg;
> +	struct hugetlb_cgroup *h_cg_reservation;
>  	struct hstate *h = page_hstate(oldhpage);
> 
>  	if (hugetlb_cgroup_disabled())
> @@ -482,11 +537,12 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
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
> 2.24.0.rc1.363.gb1bccd3e3d-goog
> 
