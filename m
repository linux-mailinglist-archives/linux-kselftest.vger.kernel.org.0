Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92E8110972C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2019 01:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZAFQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Nov 2019 19:05:16 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfKZAFQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Nov 2019 19:05:16 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ04t2S098452;
        Tue, 26 Nov 2019 00:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mHXanxHdP89INCbUw8YABR16c/whANpUfRsLAPuh01A=;
 b=m5xHGr4g40ZJdiTPttDJBElLhud2J2DhoU1Ixt/I8KETzr0Dy3UBnO+yFzOygDoXtuRy
 YPxAiCoG3nGJfj8q7P+njVUsI42z/iHXthO8REKiLUtS7Ly0aScuvnzGeBvlZBQ+AKjV
 IhoX/l/j9XJiJUIb9/awfG5kN8RkT2JJERpBup8RR7qIAL32Da+M6la7Lw4bRY4JrBOr
 iYWVXWBOqZGQMsLqPSIS0vz91cUNLV0pYBEVjeLiCV/e/4h/ei+3Eho4cOtl+YVnpcZW
 7W/opzCZQgmgt+f1qjYa4f8oW/tPZFoV4KGuw/Bpm/OQnzJrBp8IT5tEEh4vrrSb/TCe lA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wewdr2vus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 00:05:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQ03Vuf020608;
        Tue, 26 Nov 2019 00:05:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wfewbbd8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 00:05:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQ057Dq005014;
        Tue, 26 Nov 2019 00:05:07 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 16:05:07 -0800
Subject: Re: [PATCH v8 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-2-almasrymina@google.com>
 <9e10c273-f0ab-4173-570e-26c314b989fb@oracle.com>
 <CAHS8izMMK2cQMSmnteXA7YTFp2ZoZEm5kUwf8=+6nA+BC49XAQ@mail.gmail.com>
 <3f30658c-0e3d-7d5c-4de9-1526b9bac3ce@oracle.com>
 <CAHS8izNgRZxJKgOfAkDAG9j_=TB=2v0hQyYpQQKCf8xb3rQkVg@mail.gmail.com>
 <d94501f3-66cf-95b1-1159-e003207e3969@oracle.com>
 <CAHS8izMFAYTgxym-Hzb_JmkTK1N_S9tGN71uS6MFV+R7swYu5A@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3b65b0ac-54ed-6e0d-706c-358d85057403@oracle.com>
Date:   Mon, 25 Nov 2019 16:05:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHS8izMFAYTgxym-Hzb_JmkTK1N_S9tGN71uS6MFV+R7swYu5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250187
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/25/19 12:26 PM, Mina Almasry wrote:
> On Fri, Nov 8, 2019 at 4:46 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 11/8/19 4:40 PM, Mina Almasry wrote:
>>> On Fri, Nov 8, 2019 at 4:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> On 11/8/19 3:48 PM, Mina Almasry wrote:
>>>>> On Thu, Nov 7, 2019 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>>>
>>>>>> On 10/29/19 6:36 PM, Mina Almasry wrote:
>>>>>>>
>>>>>>> +static void hugetlb_cgroup_move_parent_reservation(int idx,
>>>>>>> +                                                struct hugetlb_cgroup *h_cg)
>>>>>>> +{
>>>>>>> +     struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
>>>>>>> +
>>>>>>> +     /* Move the reservation counters. */
>>>>>>> +     if (!parent_hugetlb_cgroup(h_cg)) {
>>>>>>> +             parent = root_h_cgroup;
>>>>>>> +             /* root has no limit */
>>>>>>> +             page_counter_charge(
>>>>>>> +                     &root_h_cgroup->reserved_hugepage[idx],
>>>>>>> +                     page_counter_read(
>>>>>>> +                             hugetlb_cgroup_get_counter(h_cg, idx, true)));
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     /* Take the pages off the local counter */
>>>>>>> +     page_counter_cancel(
>>>>>>> +             hugetlb_cgroup_get_counter(h_cg, idx, true),
>>>>>>> +             page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
>>>>>>> +}
>>>>>>
>>>>>> I know next to nothing about cgroups and am just comparing this to the
>>>>>> existing hugetlb_cgroup_move_parent() routine.  hugetlb_cgroup_move_parent
>>>>>> updates the cgroup pointer in each page being moved.  Do we need to do
>>>>>> something similar for reservations being moved (move pointer in reservation)?
>>>>>>
>>>>>
>>>>> Oh, good catch. Yes I need to be doing that. I should probably
>>>>> consolidate those routines so the code doesn't miss things like this.
>>>>
>>>> This might get a bit ugly/complicated?  Seems like you will need to examine
>>>> all hugetlbfs inodes and vma's mapping those inodes.
>>>>
>>>
>>> Hmm yes on closer look it does seem like this is not straightforward.
>>> I'll write a test that does this reparenting so I can start running
>>> into the issue and poke for solutions. Off the top of my head, I think
>>> maybe we can just not reparent the hugetlb reservations - the
>>> hugetlb_cgroup stays alive until all its memory is uncharged. That
>>> shouldn't be too bad. Today, I think memcg doesn't reparent memory
>>> when it gets offlined.
>>>
>>> I'll poke at this a bit and come back with suggestions, you may want
>>> to hold off reviewing the rest of the patches until then.
>>
>>
>> Ok, if we start considering what the correct cgroup reparenting semantics
>> should be it would be good to get input from others with more cgroup
>> experience.
>>
> 
> So I looked into this and prototyped a couple of solutions:
> 
> 1. We could repartent the hugetlb reservation using the same approach
> that today we repartent hugetlb faults. Basically today faulted
> hugetlb pages live on hstate->hugepage_activelist. When a hugetlb
> cgroup gets offlined, this list is transversed and any pages on it
> that point to the cgroup being offlined and reparented. hugetlb_lock
> is used to make sure cgroup offlining doesn't race with a page being
> freed. I can add another list, but one that has pointers to the
> reservations made. When the cgroup is being offlined, it transverses
> this list, and reparents any reservations (which will need to acquire
> the proper resv_map->lock to do the parenting). hugetlb_lock needs
> also to be acquired here to make sure that resv_map release doesn't
> race with another thread reparenting the memory in that resv map.
> 
> Pros: Maintains current parenting behavior, and makes sure that
> reparenting of reservations works exactly the same way as reparenting
> of hugetlb faults.
> Cons: Code is a bit complex. There may be subtle object lifetime bugs,
> since I'm not 100% sure acquiring hugetlb_lock removes all races.
> 
> 2. We could just not reparent hugetlb reservations. I.e. on hugetlb
> cgroup offlining, the hugetlb faults get reparented (which maintains
> current user facing behavior), but hugetlb reservation charges remain
> charged to the hugetlb cgroup. The cgroup lives as a zombie until all
> the reservations are uncharged.
> 
> Pros: Much easier implementation. Converges behavior of memcg and
> hugetlb cgroup, since memcg also doesn't reparent memory charged to
> it.
> Cons: Behavior change as hugetlb cgroups will become zombies if there
> are reservations charged to them. I've discussed offlist with Shakeel,
> and AFAICT there are absolutely no user facing behavior change to
> zombie cgroups. Only if the user is specifically detecting for
> zombies.
> 
> I'm torn between these 2 options right now, but leaning towards #2. I
> think I will propose #2 in a patch for review, and if anyone is broken
> by that (again, my understanding is that is very unlikely), then I
> propose a patch that reverts the changes in #2 and implements the
> changes in #1.

I of course like option #2 because it introduces fewer (if any) additional
changes to the hugetlb reservation code for non-cgroup users. :)

> Any feedback from Shakeel or other people with cgroup expertise
> (especially for hugetlb cgroup or memcg)  is very useful here.

Yes, that would be very helpful.

-- 
Mike Kravetz
