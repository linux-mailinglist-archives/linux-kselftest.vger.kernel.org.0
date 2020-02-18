Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC72163397
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 21:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgBRU5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 15:57:51 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38284 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRU5v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 15:57:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IKrxQ9031284;
        Tue, 18 Feb 2020 20:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BtjGqj+3jNiQRHCMij91pFpkChLnYumQhRXFWLWiTKc=;
 b=knIApa8S39JVJ40ICW9Cl3OBBL1pEfta3YUmcensHG8JUob3YXeVTh1ez5jwgX1DJxuo
 NfRZzI+s6OCctl4tK3wKYdBs9Qg7LK0q+c6gqxLpSou+OAF0vln2dzJfe0XIkiaOqyVY
 UyT1wzT1lyLD2OfL4SEjXPqLla0h7Bu9x03zzlxkI9Sl5juEyNY8ylHykH+CnKGuauJO
 kNp95zuJo+0Ax0cCEwc/bK1nKtxEynhTgSEBxUSnlKJrcW5tHTrk+0AxyDfhrKtYseHC
 pJ6XkBuyBTNXMgOK6PWbMbdKZ/nRwWxszM3ci0gKeV7q70iFFs66ad30d7J+hDSijhzC lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y699rruy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 20:57:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01IKvitU076426;
        Tue, 18 Feb 2020 20:57:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y6tc32v3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Feb 2020 20:57:44 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01IKvcXk001708;
        Tue, 18 Feb 2020 20:57:38 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 12:57:37 -0800
Subject: Re: [PATCH v12 6/9] hugetlb_cgroup: support noreserve mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211213128.73302-6-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ace490c3-03b3-da85-bbdf-00959a71ff2f@oracle.com>
Date:   Tue, 18 Feb 2020 12:57:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211213128.73302-6-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=2
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=2
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002180137
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/20 1:31 PM, Mina Almasry wrote:
> Support MAP_NORESERVE accounting as part of the new counter.
> 
> For each hugepage allocation, at allocation time we check if there is
> a reservation for this allocation or not. If there is a reservation for
> this allocation, then this allocation was charged at reservation time,
> and we don't re-account it. If there is no reserevation for this
> allocation, we charge the appropriate hugetlb_cgroup.
> 
> The hugetlb_cgroup to uncharge for this allocation is stored in
> page[3].private. We use new APIs added in an earlier patch to set this
> pointer.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> Changes in v12:
> - Minor rebase to new interface for readability.
> 
> Changes in v10:
> - Refactored deferred_reserve check.
> 
> ---
>  mm/hugetlb.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a9171c3cbed6b..2d62dd35399db 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1342,6 +1342,8 @@ static void __free_huge_page(struct page *page)
>  	clear_page_huge_active(page);
>  	hugetlb_cgroup_uncharge_page(hstate_index(h),
>  				     pages_per_huge_page(h), page);
> +	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
> +					  pages_per_huge_page(h), page);
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> 
> @@ -2175,6 +2177,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	long gbl_chg;
>  	int ret, idx;
>  	struct hugetlb_cgroup *h_cg;
> +	bool deferred_reserve;
> 
>  	idx = hstate_index(h);
>  	/*
> @@ -2212,9 +2215,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			gbl_chg = 1;
>  	}
> 
> +	/* If this allocation is not consuming a reservation, charge it now.
> +	 */
> +	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
> +	if (deferred_reserve) {
> +		ret = hugetlb_cgroup_charge_cgroup_rsvd(
> +			idx, pages_per_huge_page(h), &h_cg);
> +		if (ret)
> +			goto out_subpool_put;
> +	}
> +
>  	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
>  	if (ret)
> -		goto out_subpool_put;
> +		goto out_uncharge_cgroup_reservation;
> 
>  	spin_lock(&hugetlb_lock);
>  	/*
> @@ -2237,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  		/* Fall through */
>  	}
>  	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> +	/* If allocation is not consuming a reservation, also store the
> +	 * hugetlb_cgroup pointer on the page.
> +	 */
> +	if (deferred_reserve) {
> +		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
> +						  h_cg, page);
> +	}
> +

This started before your new code, but those two cgroup_commit_charge calls
could/should be done outside the hugetlb_lock.  No need to change as it is
not a big deal.  Those calls only set fields in the page structs.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

>  	spin_unlock(&hugetlb_lock);
> 
>  	set_page_private(page, (unsigned long)spool);
> @@ -2261,6 +2282,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> 
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
> +out_uncharge_cgroup_reservation:
> +	if (deferred_reserve)
> +		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
> +						    h_cg);
>  out_subpool_put:
>  	if (map_chg || avoid_reserve)
>  		hugepage_subpool_put_pages(spool, 1);
> --
> 2.25.0.225.g125e21ebc7-goog
> 
