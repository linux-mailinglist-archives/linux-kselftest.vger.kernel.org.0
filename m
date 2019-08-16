Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC36905BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfHPQ3N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Aug 2019 12:29:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfHPQ3N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Aug 2019 12:29:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGDokX165813;
        Fri, 16 Aug 2019 16:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=E4ERDmW0NxqNUigIFvMypfkasM1D5R708xtML04D1bU=;
 b=blt3phxH8TMrzzkFm+MkSzQyc8SbmaO5mtmepGxhT8L7ZxOHL+iDJRa/lw/XowiFYx50
 eNKm1ubAzyBpDGfj8KKxVn2eC3Ig6jNr5tM2bNuda0T5Bzqlxf58WyTjzoxNGV82KM/T
 X31DOg/H1gtz4U3kw4hFoxxk/uy4eiJlrzrdZ3ys3GdwtLOcpmgv7SLmMldK+ptP/i9x
 vTBrVuvCOLUWm8ZoBaX2fuBMzWFXi9FFZepeEF3X6fQBT3uR54KIxpk41R9jp9kRQUeK
 8CWl/q/kXvDjWXopb746nJbrsElvK4yun37qncZ+W7eBBHVca0LR6IvZH3cHPRHEFOxg ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjr1cc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:29:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGEDDF133518;
        Fri, 16 Aug 2019 16:29:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2udgr32huf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:29:05 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7GGT4DE009591;
        Fri, 16 Aug 2019 16:29:04 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 09:29:04 -0700
Subject: Re: [RFC PATCH v2 4/5] hugetlb_cgroup: Add accounting for shared
 mappings
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20190808231340.53601-1-almasrymina@google.com>
 <20190808231340.53601-5-almasrymina@google.com>
 <47cfc50d-bea3-0247-247e-888d2942f134@oracle.com>
 <9872cec9-a0fe-cfe0-0df6-90b6dd909f04@oracle.com>
 <CAHS8izOv3GjKhnzVmksfH0U9xZ6OnC0R-XEZsqVxOvrJ5u_BBw@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bfa1cffd-bceb-6f69-419e-3fa173359701@oracle.com>
Date:   Fri, 16 Aug 2019 09:28:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izOv3GjKhnzVmksfH0U9xZ6OnC0R-XEZsqVxOvrJ5u_BBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160171
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160171
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/19 4:04 PM, Mina Almasry wrote:
> On Wed, Aug 14, 2019 at 9:46 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 8/13/19 4:54 PM, Mike Kravetz wrote:
>>> On 8/8/19 4:13 PM, Mina Almasry wrote:
>>>> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
>>>> in the resv_map entries, in file_region->reservation_counter.
>>>>
>>>> When a file_region entry is added to the resv_map via region_add, we
>>>> also charge the appropriate hugetlb_cgroup and put the pointer to that
>>>> in file_region->reservation_counter. This is slightly delicate since we
>>>> need to not modify the resv_map until we know that charging the
>>>> reservation has succeeded. If charging doesn't succeed, we report the
>>>> error to the caller, so that the kernel fails the reservation.
>>>
>>> I wish we did not need to modify these region_() routines as they are
>>> already difficult to understand.  However, I see no other way with the
>>> desired semantics.
>>>
>>
>> I suspect you have considered this, but what about using the return value
>> from region_chg() in hugetlb_reserve_pages() to charge reservation limits?
>> There is a VERY SMALL race where the value could be too large, but that
>> can be checked and adjusted at region_add time as is done with normal
>> accounting today.
> 
> I have not actually until now; I didn't consider doing stuff with the
> resv_map while not holding onto the resv_map->lock. I guess that's the
> small race you're talking about. Seems fine to me, but I'm more
> worried about hanging off the vma below.

This race is already handled for other 'reservation like' things in
hugetlb_reserve_pages.  So, I don't think the race is much of an issue.

>> If the question is, where would we store the information
>> to uncharge?, then we can hang a structure off the vma.  This would be
>> similar to what is done for private mappings.  In fact, I would suggest
>> making them both use a new cgroup reserve structure hanging off the vma.
>>
> 
> I actually did consider hanging off the info to uncharge off the vma,
> but I didn't for a couple of reasons:
> 
> 1. region_del is called from hugetlb_unreserve_pages, and I don't have
> access to the vma there. Maybe there is a way to query the proper vma
> I don't know about?

I am still thinking about closely tying cgroup revervation limits/usage
to existing reservation accounting.  Of most concern (to me) is handling
shared mappings.  Reservations created for shared mappings are more
associated with the inode/file than individual mappings.  For example,
consider a task which mmaps(MAP_SHARED) a hugetlbfs file.  At mmap time
reservations are created based on the size of the mmap.  Now, if the task
unmaps and/or exits the reservations still exist as they are associated
with the file rather than the mapping.

Honesty, I think this existing reservation bevahior is wrong or at least
not desirable.  Because there are outstanding reservations, the number of
reserved huge pages can not be used for other purposes.  It is also very
difficult for a user or admin to determine the source of the reservations.
No one is currently complaining about this behavior.  This proposal just
made me think about it.

Tying cgroup reservation limits/usage to existing reservation accounting
will introduce the same issues there.  We will need to clearly document the
behavior.

> 2. hugetlb_reserve_pages seems to be able to conduct a reservation
> with a NULL *vma. Not sure what to do in that case.
> 
> Is there a way to get around these that I'm missing here?

You are correct.  The !vma case is there for System V shared memory such
as a call to shmget(SHM_HUGETLB).  In this case, reservations for the
entire shared emmory segment are taken at shmget time.

In your model, the caller of shmget who creates the shared memory segment
would get charged for all the reservations.  Users, (those calling shmat)
would not be charged.

> FWIW I think tracking is better in resv_map since the reservations are
> in resv_map themselves. If I do another structure, then for each
> reservation there will be an entry in resv_map and an entry in the new
> structure and they need to be kept in sync and I need to handle errors
> for when they get out of sync.

I think you may be correct.  However, this implies that we will need to
change the way we do reservation in the resv_map for shared mappings.
I will comment on that in reply to patch 4.

-- 
Mike Kravetz
