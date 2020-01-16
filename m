Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EEF13FC5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 23:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbgAPWo7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 17:44:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbgAPWo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 17:44:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GMcQbe059559;
        Thu, 16 Jan 2020 22:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=jlzdnATHqqaoRnZjE+SFSnSnRkAzXmaHY4RqPn2GR14=;
 b=Hb3TDPh83eiTfrX6Rmpx/FtUaekfBHuaXEkqSQU3gyu4w+ATUwFA9Z6N8AdSNh/mfyJ/
 XKSNvGJ6mOHHCrwI9Dq0fHCsLbg6Z/guPvZlAqt+Q+1p6BY8Wz7cGuDiAr9kmmG19tss
 kDzNdcWehvTlQ53be0RNk1ZxEYvVo03BQeCQ7dAnA+JEGfMxSv+PAffV1eQTcbZ8ADSQ
 hbET9KgS1x/+fDtnS+JxuXAlcEVwgp3UvQv/B7JMW7l8ItY+FJDHzdleu3E57tozfGGE
 hYDS+uA3y6Y20pq/21gAeMm477K7JJkwgEGgQnZqJTxANQjOda6Rq3dLaSugaf+c0qDa gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xf73ywhy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 22:44:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GMdQt8015176;
        Thu, 16 Jan 2020 22:44:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xj61nc4gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 22:44:48 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00GMili4017672;
        Thu, 16 Jan 2020 22:44:47 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 14:44:47 -0800
Subject: Re: [PATCH v10 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Mina Almasry <almasrymina@google.com>, rientjes@google.com,
        shakeelb@google.com
Cc:     shuah@kernel.org, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
References: <20200115012651.228058-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bbc968ae-b379-c207-268e-16004d9cff96@oracle.com>
Date:   Thu, 16 Jan 2020 14:44:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160181
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/14/20 5:26 PM, Mina Almasry wrote:
> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.
> 
> This is patch 1 of an 8 patch series.
> 
> Problem:
> Currently tasks attempting to reserve more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to reserve hugetlb memory only more than its

*reword*
However, if a task attempts to reserve more hugetlb memory than its

> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
> but will SIGBUS the task when it attempts to fault the memory in.

*reword*
but will SIGBUS the task when it attempts to fault in the  excess memory.

> 
> We have users hitting their hugetlb_cgroup limits and thus we've been
> looking at this failure mode. We'd like to improve this behavior such that users
> violating the hugetlb_cgroup limits get an error on mmap/shmget time, rather
> than getting SIGBUS'd when they try to fault the excess memory in. This
> gives the user an opportunity to fallback more gracefully to
> non-hugetlbfs memory for example.
> 
> The underlying problem is that today's hugetlb_cgroup accounting happens
> at hugetlb memory *fault* time, rather than at *reservation* time.
> Thus, enforcing the hugetlb_cgroup limit only happens at fault time, and
> the offending task gets SIGBUS'd.
> 
> Proposed Solution:
> A new page counter named
> 'hugetlb.xMB.reservation_[limit|usage|max_usage]_in_bytes'. This counter has
> slightly different semantics than

You changed the name to 'hugetlb.xMB.resv_[limit|usage|max_usage]_in_bytes'
in the code, but left this description.

Also, David suggested 'rsvd' as the abbreviation to use here.  I would also
prefer that name to be consistent with other hugetlb interfaces.

> 'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':
> 
> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> reservation_usage_in_bytes tracks all *reserved* hugetlb memory and
> hugetlb memory faulted in without a prior reservation.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than reservation_limit_in_bytes, the kernel will fail this
> reservation.
> 
> This proposal is implemented in this patch series, with tests to verify
> functionality and show the usage.
> 
> Alternatives considered:
> 1. A new cgroup, instead of only a new page_counter attached to
>    the existing hugetlb_cgroup. Adding a new cgroup seemed like a lot of code
>    duplication with hugetlb_cgroup. Keeping hugetlb related page counters under
>    hugetlb_cgroup seemed cleaner as well.
> 
> 2. Instead of adding a new counter, we considered adding a sysctl that modifies
>    the behavior of hugetlb.xMB.[limit|usage]_in_bytes, to do accounting at
>    reservation time rather than fault time. Adding a new page_counter seems
>    better as userspace could, if it wants, choose to enforce different cgroups
>    differently: one via limit_in_bytes, and another via
>    reservation_limit_in_bytes. This could be very useful if you're
>    transitioning how hugetlb memory is partitioned on your system one
>    cgroup at a time, for example. Also, someone may find usage for both
>    limit_in_bytes and reservation_limit_in_bytes concurrently, and this
>    approach gives them the option to do so.
> 
> Testing:
> - Added tests passing.
> - Used libhugetlbfs for regression testing.
> 
> [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> Changes in v10:
> - Renamed reservation_* to resv.*
> 
> ---
>  include/linux/hugetlb.h |   4 +-
>  mm/hugetlb_cgroup.c     | 115 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 104 insertions(+), 15 deletions(-)

The code looks fine to me.

With the commit message and naming updates, I will add a Reviewed-by:

Please do wait a few/several days before sending a revised edition to
make sure we get all feedback.  I really would like to get comments from
people more familiar with cgroups.

-- 
Mike Kravetz
