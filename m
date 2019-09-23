Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18BE4BBAB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2019 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440199AbfIWRrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Sep 2019 13:47:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33246 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389763AbfIWRrr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Sep 2019 13:47:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NHdNbD090061;
        Mon, 23 Sep 2019 17:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=yDskfBufBcPBjCvniq+DMnbkW78ezLoVWcAK8svPf2o=;
 b=Ql5vbWG+kxg7x8Ups95HkSOCpzWtP7UKlTCD+zxH28gfZGKYH4Yz328gucDUXJT6oPmp
 sE7fD3Qg9ORS/5vusZqCpWBJ8saeGwfEc2Ukl/I3/TKJDNqMl1CR4zZQmvxLgjIxelup
 ueLksD8fC6fJO/x2UB2VAyzOmxIBGP9hVuOnBhqdWMJt2XaKKV/TBPTCcRVtaMquqUcI
 MxmYdbpnJdI7rQHCOVdyEerxDxapTPEklcIX65jlGFbnaoOud9SjKHLp+aOcmPUlFSSj
 GNrFmBAV4Vq7kil71S5KZV+zevmnZfeg8NtJtPc1EaOs39h4aYZiiZ43Qs+PIsEqNjeU AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgqrfg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 17:47:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8NHcuvX179186;
        Mon, 23 Sep 2019 17:47:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2v6yvptysg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 17:47:36 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8NHlW2K007596;
        Mon, 23 Sep 2019 17:47:33 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Sep 2019 10:47:32 -0700
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Mina Almasry <almasrymina@google.com>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     shuah@kernel.org, rientjes@google.com, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, mkoutny@suse.com
References: <20190919222421.27408-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
Date:   Mon, 23 Sep 2019 10:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919222421.27408-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909230157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9389 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909230157
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/19 3:24 PM, Mina Almasry wrote:
> Patch series implements hugetlb_cgroup reservation usage and limits, which
> track hugetlb reservations rather than hugetlb memory faulted in. Details of
> the approach is 1/7.

Thanks for your continued efforts Mina.

One thing that has bothered me with this approach from the beginning is that
hugetlb reservations are related to, but somewhat distinct from hugetlb
allocations.  The original (existing) huegtlb cgroup implementation does not
take reservations into account.  This is an issue you are trying to address
by adding a cgroup support for hugetlb reservations.  However, this new
reservation cgroup ignores hugetlb allocations at fault time.

I 'think' the whole purpose of any hugetlb cgroup is to manage the allocation
of hugetlb pages.  Both the existing cgroup code and the reservation approach
have what I think are some serious flaws.  Consider a system with 100 hugetlb
pages available.  A sysadmin, has two groups A and B and wants to limit hugetlb
usage to 50 pages each.

With the existing implementation, a task in group A could create a mmap of
100 pages in size and reserve all 100 pages.  Since the pages are 'reserved',
nobody in group B can allocate ANY huge pages.  This is true even though
no pages have been allocated in A (or B).

With the reservation implementation, a task in group A could use MAP_NORESERVE
and allocate all 100 pages without taking any reservations.

As mentioned in your documentation, it would be possible to use both the
existing (allocation) and new reservation cgroups together.  Perhaps if both
are setup for the 50/50 split things would work a little better.

However, instead of creating a new reservation crgoup how about adding
reservation support to the existing allocation cgroup support.  One could
even argue that a reservation is an allocation as it sets aside huge pages
that can only be used for a specific purpose.  Here is something that
may work.

Starting with the existing allocation cgroup.
- When hugetlb pages are reserved, the cgroup of the task making the
  reservations is charged.  Tracking for the charged cgroup is done in the
  reservation map in the same way proposed by this patch set.
- At page fault time,
  - If a reservation already exists for that specific area do not charge the
    faulting task.  No tracking in page, just the reservation map.
  - If no reservation exists, charge the group of the faulting task.  Tracking
    of this information is in the page itself as implemented today.
- When the hugetlb object is removed, compare the reservation map with any
  allocated pages.  If cgroup tracking information exists in page, uncharge
  that group.  Otherwise, unharge the group (if any) in the reservation map.

One of the advantages of a separate reservation cgroup is that the existing
code is unmodified.  Combining the two provides a more complete/accurate
solution IMO.  But, it has the potential to break existing users.

I really would like to get feedback from anyone that knows how the existing
hugetlb cgroup controller may be used today.  Comments from Aneesh would
be very welcome to know if reservations were considered in development of the
existing code.
-- 
Mike Kravetz
