Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0825715392C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgBETgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 14:36:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:35386 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBETgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 14:36:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015JNxin024134;
        Wed, 5 Feb 2020 19:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=5lIfWmCzlu1SYiOdBrJ1JdoDVBv+JbA9Q1rCthzGY1A=;
 b=xmImP+oM1soTl7cXRyV9L5Qgrk5M7aEsUw7a+g1Kr0eSwnkV/Zz75iWR1vWrx6/qHxWa
 sr7lpjYOmfyEcsYjBFMeQjy9TafIvMXoW1WZYUvCIsE0gkW+xs0TtIUnQh3ZJBA6LwFo
 UloZl6+/Jfexakhfpx8XHQ7UwSMnmSIvkwsvk5k8Hv2wRMkq/z/0tuYljZwzjXby/MSM
 YwY8yR9GwDAGwu1erWvAz/JimM/7ZgQP+Mhm4sgVeNuKouUPV9/swQeEIcjUBpYERToL
 VHQvBElBGEiMSE8mVNE75cUtNlGd+Esk3YO2Do0+UEopD6fj/UeqkupHOGr4/p07/Cq3 hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=5lIfWmCzlu1SYiOdBrJ1JdoDVBv+JbA9Q1rCthzGY1A=;
 b=A5DFmSFyoDCf97mX7oJcdjO5Wde6OfFD4YMZrQ41J0fxXf8YiKVtTttgmOa6psy1jSPL
 tWT+j4YbMATS/2247UHrjXmk0wfxgz54jg+J26EgxHfjntR2SxJEEmaDq+dc2L1gSzWv
 PYjv3cGVidmfEnYe8qR55YVeas/OvnK5K0BD3LnDyE4YpqZottv1nsY9wjFSmBWqINj8
 FgD/8PqJzWVnq6nBaOf28yqY65x+QH6aPRmd6LfVuVTcM6YGEvm0Iukko8Ktn/J/cZMs
 qxwMH7z+CTNCMCWzol/QxNQF0pQTNyH/VvYXW8UlJzo1QJRwtEQJAGt7O94fII2WIfhh SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xykbpd834-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 19:36:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015JOPTP194472;
        Wed, 5 Feb 2020 19:36:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xymutfjnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 19:36:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015JaWH2027585;
        Wed, 5 Feb 2020 19:36:33 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Feb 2020 11:36:32 -0800
Subject: Re: [PATCH v11 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
References: <20200203232248.104733-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <74036711-be90-a56c-3c7f-f85c30417e6e@oracle.com>
Date:   Wed, 5 Feb 2020 11:36:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203232248.104733-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9522 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050149
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/3/20 3:22 PM, Mina Almasry wrote:
> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.
> 
> This is patch 1 of an 9 patch series.
> 
> Problem:
> Currently tasks attempting to reserve more hugetlb memory than is available get
> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
> However, if a task attempts to reserve more hugetlb memory than its
> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call, but
> will SIGBUS the task when it attempts to fault in the excess memory.
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
> 'hugetlb.xMB.rsvd.[limit|usage|max_usage]_in_bytes'. This counter has
> slightly different semantics than
> 'hugetlb.xMB.[limit|usage|max_usage]_in_bytes':
> 
> - While usage_in_bytes tracks all *faulted* hugetlb memory,
> rsvd.usage_in_bytes tracks all *reserved* hugetlb memory and
> hugetlb memory faulted in without a prior reservation.
> 
> - If a task attempts to reserve more memory than limit_in_bytes allows,
> the kernel will allow it to do so. But if a task attempts to reserve
> more memory than rsvd.limit_in_bytes, the kernel will fail this
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
>    differently: one via limit_in_bytes, and another via rsvd.limit_in_bytes.
>    This could be very useful if you're transitioning how hugetlb memory is
>    partitioned on your system one cgroup at a time, for example. Also, someone
>    may find usage for both limit_in_bytes and rsvd.limit_in_bytes concurrently,
>    and this approach gives them the option to do so.
> 
> Testing:
> - Added tests passing.
> - Used libhugetlbfs for regression testing.
> 
> [1]: https://www.kernel.org/doc/html/latest/vm/hugetlbfs_reserv.html
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> 
> ---
> Changes in v11:
> - Renamed resv.* or 'reservation' or 'reserved' to rsvd.*
> - Renamed hugetlb_cgroup_get_counter() to

Thanks!
I was mostly concerned about using 'resv' in cgroup file names visible to
users.  Changing variable names is good as well.

Small nit, some lines of commit message wrap.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
