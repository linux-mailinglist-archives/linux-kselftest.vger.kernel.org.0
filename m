Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F35EEAD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2019 22:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfKDVPO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Nov 2019 16:15:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33824 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Nov 2019 16:15:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4Kx87k156243;
        Mon, 4 Nov 2019 21:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Gx9KwExmMMzjVr3YxjcHGknRiK3FRatTEn7SFiCRVlo=;
 b=TM2hXBvBRL2mJ1WqhIcE9gohEfsiVsssaD0IqYV6WNyJ//+yc3LZsjXkHjiiPkAbPufX
 xtm39fbNG4ySxAmUEteThrRIB5XoxGNWIZg4r274Wr4jzdIMDIE69cMPcLjAmEbIvv9b
 j27Jok6QfXHPRZ5nwnTentwZ3wie8PDuU68+7NpHywDIDHd7oyKhB5SU1Xc7aY9G+OAf
 6pQX3kcMb4mWfmwU5zbzYm62juOPyGqzJS9gS5pQC9EluewTF0HY/w8T4d9RTzJc7TsL
 gneOdJzwwKICikiPjEOoRwBcyqWKt+uXwpeyxRZyo0bpE9UbuH5cPOu8YS7yc8uqRIEx Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w117tt6du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 21:15:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4L3ioJ148578;
        Mon, 4 Nov 2019 21:15:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w1k8vh5tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 21:15:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA4LF3CE029403;
        Mon, 4 Nov 2019 21:15:03 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 13:15:03 -0800
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com>
 <1c060bde-8d44-146c-6d67-a7b145aa1b59@oracle.com>
 <CAHS8izPTvybLq9Y9Fn6Z+hSc7gLP+goQ-ixzjxa1XJ-qhWM8ow@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a5f991c8-3f74-6000-cbd3-09fb8626e3f5@oracle.com>
Date:   Mon, 4 Nov 2019 13:15:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izPTvybLq9Y9Fn6Z+hSc7gLP+goQ-ixzjxa1XJ-qhWM8ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040203
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/4/19 1:04 PM, Mina Almasry wrote:
> On Fri, Nov 1, 2019 at 4:23 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 10/29/19 6:36 PM, Mina Almasry wrote:
>>>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>>> -                                  bool count_only)
>>> +                                  long *regions_needed, bool count_only)
>>>  {
>>> -     long chg = 0;
>>> +     long add = 0;
>>>       struct list_head *head = &resv->regions;
>>> +     long last_accounted_offset = f;
>>>       struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
>>>
>>> -     /* Locate the region we are before or in. */
>>> -     list_for_each_entry (rg, head, link)
>>> -             if (f <= rg->to)
>>> -                     break;
>>> +     if (regions_needed)
>>> +             *regions_needed = 0;
>>>
>>> -     /* Round our left edge to the current segment if it encloses us. */
>>> -     if (f > rg->from)
>>> -             f = rg->from;
>>> -
>>> -     chg = t - f;
>>> +     /* In this loop, we essentially handle an entry for the range
>>> +      * [last_accounted_offset, rg->from), at every iteration, with some
>>> +      * bounds checking.
>>> +      */
>>> +     list_for_each_entry_safe(rg, trg, head, link) {
>>> +             /* Skip irrelevant regions that start before our range. */
>>> +             if (rg->from < f) {
>>> +                     /* If this region ends after the last accounted offset,
>>> +                      * then we need to update last_accounted_offset.
>>> +                      */
>>> +                     if (rg->to > last_accounted_offset)
>>> +                             last_accounted_offset = rg->to;
>>> +                     continue;
>>> +             }
>>>
>>> -     /* Check for and consume any regions we now overlap with. */
>>> -     nrg = rg;
>>> -     list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
>>> -             if (&rg->link == head)
>>> -                     break;
>>> +             /* When we find a region that starts beyond our range, we've
>>> +              * finished.
>>> +              */
>>>               if (rg->from > t)
>>>                       break;
>>>
>>> -             /* We overlap with this area, if it extends further than
>>> -              * us then we must extend ourselves.  Account for its
>>> -              * existing reservation.
>>> +             /* Add an entry for last_accounted_offset -> rg->from, and
>>> +              * update last_accounted_offset.
>>>                */
>>> -             if (rg->to > t) {
>>> -                     chg += rg->to - t;
>>> -                     t = rg->to;
>>> +             if (rg->from > last_accounted_offset) {
>>> +                     add += rg->from - last_accounted_offset;
>>> +                     if (!count_only) {
>>> +                             nrg = get_file_region_entry_from_cache(
>>> +                                     resv, last_accounted_offset, rg->from);
>>> +                             list_add(&nrg->link, rg->link.prev);
>>> +                     } else if (regions_needed)
>>> +                             *regions_needed += 1;
>>>               }
>>> -             chg -= rg->to - rg->from;
>>>
>>> -             if (!count_only && rg != nrg) {
>>> -                     list_del(&rg->link);
>>> -                     kfree(rg);
>>> -             }
>>> +             last_accounted_offset = rg->to;
>>
>> That last assignment is unneeded.  Correct?
>>
> 
> Not to make you nervous, but this assignment is needed.
> 
> The basic idea is that there are 2 loop invariants here:
> 1. Everything before last_accounted_offset is filled in with file_regions.
> 2. rg points to the first region past last_account_offset.
> 
> Each loop iteration compares rg->from to last_accounted_offset, and if
> there is a gap, it creates a new region to fill this gap. Then this
> assignment restores loop invariant #2 by assigning
> last_accounted_offset to rg->to, since now everything before rg->to is
> filled in with file_regions.
> 

My apologies!

>>>       }
>>>
>>> -     if (!count_only) {
>>> -             nrg->from = f;
>>> -             nrg->to = t;
>>> +     /* Handle the case where our range extends beyond
>>> +      * last_accounted_offset.
>>> +      */
>>> +     if (last_accounted_offset < t) {
>>> +             add += t - last_accounted_offset;
>>> +             if (!count_only) {
>>> +                     nrg = get_file_region_entry_from_cache(
>>> +                             resv, last_accounted_offset, t);
>>> +                     list_add(&nrg->link, rg->link.prev);
>>> +             } else if (regions_needed)
>>> +                     *regions_needed += 1;
>>> +             last_accounted_offset = t;

The question about an unnecessary assignment was supposed to be
directed at the above line.

-- 
Mike Kravetz


>>>       }
>>>
>>> -     return chg;
>>> +     return add;
>>>  }
