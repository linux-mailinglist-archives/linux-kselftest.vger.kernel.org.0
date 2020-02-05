Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1E153AB4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 23:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBEWI4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 17:08:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:43500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBEWI4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 17:08:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015M8799150097;
        Wed, 5 Feb 2020 22:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=UI5rcdJyqYY+DTVX9PvejzMOeqMSnFQuRyuUoAASGRc=;
 b=amq1bDa2j2jr0FdogaTIiBaUkmJs12vblBWkfjEZ3yvBoAM6o1IfmTIWYYmYr4HCkqRn
 BqoSMNEX0mw329ZDgIutoFzFPSuMafaPpkJrIA9DfDmiYgJFyMX7IqhHjRCxgHzEtr3v
 bsLVgSGt7l2KMBOuUbuxM9RIH/m8jIr7LqygRGfT0NxwLR5jG8XT0l4hYyvKkIrM2ikv
 Ofqsnv6dnJth+H6QmDgTkUle6N/q9SeHbcSS7dJCTHomvGqjAtB072owaFJIajDOX5xa
 h8rGTOPCDJ808FdEnQF2Qu51oswqREnDd7scBYKeAHQhSCYUS4JiZPCQ4r7kaAqEx43X aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=UI5rcdJyqYY+DTVX9PvejzMOeqMSnFQuRyuUoAASGRc=;
 b=jNa8oHnompyhuHvnOSs87JodhwiPsd+wjoF6vNTBx4IbJXIAJi6aNHfFAAJO2n1rg2XS
 RC0SHxmMmb33K+LTvxLYXT1H28ds7MVGClgTQ81ViKDTny8BKXY3DzqCREfOIystbodz
 j4z2z1CRw6KKlh5CVQ4RgnrEEH8FJDqM3v3tEAg6gSRpUi4DzuCQNivGuJrXENkOyLCP
 YDO8IOi8pV1ZMv3iaoHSWwbizMHr/o9tiNiu7Eq5iHALNxRV8w6kqWyv8R2ACr2Cq+fk
 d8xaQ33EQWJbPXCVyuJJKuQPqLZutK9jyV2vWC8xkU7gLb6IsEIQI6RG8fWADbQ+uvbr ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xykbp61au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 22:08:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015M4YMk182470;
        Wed, 5 Feb 2020 22:08:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xykbsxv16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 22:08:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 015M8naT017362;
        Wed, 5 Feb 2020 22:08:49 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 14:08:48 -0800
Subject: Re: [PATCH v11 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
 <20200203232248.104733-2-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a48fbdd1-fc0e-f17d-09c2-1492c8466254@oracle.com>
Date:   Wed, 5 Feb 2020 14:08:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050169
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/20 3:22 PM, Mina Almasry wrote:
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
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: David Rientjes <rientjes@google.com>
> 
> ---
> 
> Changes in v11:
> - Changed all 'reserved' or 'reservation' to 'rsvd' to reflect the user
> interface.

Thanks.

Small nit,

> @@ -450,8 +496,7 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
>  	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(of_css(of));
> 
>  	counter = &h_cg->hugepage[MEMFILE_IDX(of_cft(of)->private)];
> -	rsvd_counter =
> -		&h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
> +	rsvd_counter = &h_cg->rsvd_hugepage[MEMFILE_IDX(of_cft(of)->private)];
> 

That looks like a change just to reformat a line added in the first patch?

>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>  	case RES_MAX_USAGE:

-- 
Mike Kravetz
