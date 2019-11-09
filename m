Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E297F5C83
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2019 01:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfKIAqf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 19:46:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54308 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfKIAqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 19:46:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA90kQRe141886;
        Sat, 9 Nov 2019 00:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=d5vgX4ykJupcCPWoeO7N2g5XNHHtZKUHjEeytePn09M=;
 b=doyFgwJTXS5f90V2kBEkr305lkTkrJbN+KpnG52w2ZKxQWPbpYR7q1A6CL9EwVyXwPDR
 tQS7/6VdH7l1r8g/e7R2vazwB9atR2jvbZX8n4h19lU5VXRFCit8KP+RBG78jTS94teB
 dUXKXmepYkRR9w3/5PM50/uzF+s2kCJO4voKCBbY0xA87oSW4E36pxejgbEeRN3siUAE
 a8FXJbGS9M/UrzwxJUp6cWH5tiFqleGLkZYRYK1Dc52bIm0zSRpVKvZfxHX4XdCeEhPC
 BFLGLk7bQbiwPedERNd8OuVDOiygH7uj+bwaMP8FJC3WPod8kKQTuFdCmUVYfLIcrOoH TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w5hgwr7dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 00:46:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA90i2eS012238;
        Sat, 9 Nov 2019 00:46:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2w5jkcjk8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Nov 2019 00:46:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA90kPvS009317;
        Sat, 9 Nov 2019 00:46:25 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Nov 2019 16:46:25 -0800
Subject: Re: [PATCH v8 2/9] hugetlb_cgroup: add interface for charge/uncharge
 hugetlb reservations
To:     Mina Almasry <almasrymina@google.com>
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d94501f3-66cf-95b1-1159-e003207e3969@oracle.com>
Date:   Fri, 8 Nov 2019 16:46:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izNgRZxJKgOfAkDAG9j_=TB=2v0hQyYpQQKCf8xb3rQkVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911090003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9435 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911090003
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/8/19 4:40 PM, Mina Almasry wrote:
> On Fri, Nov 8, 2019 at 4:01 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 11/8/19 3:48 PM, Mina Almasry wrote:
>>> On Thu, Nov 7, 2019 at 4:57 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>
>>>> On 10/29/19 6:36 PM, Mina Almasry wrote:
>>>>> @@ -22,27 +22,35 @@ struct hugetlb_cgroup;
>>>>>   * Minimum page order trackable by hugetlb cgroup.
>>>>>   * At least 3 pages are necessary for all the tracking information.
>>>>>   */
>>>>> -#define HUGETLB_CGROUP_MIN_ORDER     2
>>>>> +#define HUGETLB_CGROUP_MIN_ORDER 3
>>>>
>>>> Correct me if misremembering, but I think the reson you changed this was
>>>> so that you could use page[3].private.  Correct?
>>>> In that case isn't page[3] the last page of an order 2 allocation?
>>>> If my understanding is correct, then leave HUGETLB_CGROUP_MIN_ORDER as is
>>>> and update the preceding comment to say that at least 4 pages are necessary.
>>>>
>>>
>>> Yes, I just misunderstood what MIN_ORDER means. I'll revert the code change.
>>
>> But, do update the comment please.
>>
> 
> Will do.
> 
>> <snip>
>>>>> @@ -85,18 +89,32 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
>>>>>       int idx;
>>>>>
>>>>>       for (idx = 0; idx < HUGE_MAX_HSTATE; idx++) {
>>>>> -             struct page_counter *counter = &h_cgroup->hugepage[idx];
>>>>>               struct page_counter *parent = NULL;
>>>>
>>>> Should we perhaps rename 'parent' to 'fault_parent' to be consistent?
>>>
>>> Yes that makes sense; will do.
>>>
>>>> That makes me think if perhaps the naming in the previous patch should
>>>> be more explicit.  Make the existing names explicitly contin 'fault' as
>>>> the new names contain 'reservation'.
>>>> Just a thought.
>>>>
>>>
>>> You mean change the names of the actual user-facing files? I'm all for
>>> better names but that would break existing users that read/write the
>>> hugetlb_cgroup.2MB.usage_in_bytes/limit_in_bytes users, and so I would
>>> assume is a no-go.
>>>
>>
>> I was thinking about internal variables/definitions such as:
>>
>> +enum {
>> + /* Tracks hugetlb memory faulted in. */
>> + HUGETLB_RES_USAGE,
>> + /* Tracks hugetlb memory reserved. */
>> + HUGETLB_RES_RESERVATION_USAGE,
>> + /* Limit for hugetlb memory faulted in. */
>> + HUGETLB_RES_LIMIT,
>> + /* Limit for hugetlb memory reserved. */
>> + HUGETLB_RES_RESERVATION_LIMIT,
>> + /* Max usage for hugetlb memory faulted in. */
>> + HUGETLB_RES_MAX_USAGE,
>> + /* Max usage for hugetlb memory reserved. */
>> + HUGETLB_RES_RESERVATION_MAX_USAGE,
>> + /* Faulted memory accounting fail count. */
>> + HUGETLB_RES_FAILCNT,
>> + /* Reserved memory accounting fail count. */
>> + HUGETLB_RES_RESERVATION_FAILCNT,
>> + HUGETLB_RES_NULL,
>> + HUGETLB_RES_MAX,
>> +};
>>
>> But, I guess the existing definitions (such as HUGETLB_RES_LIMIT) correspond
>> closely to the externally visible name.  In that case, you should leave them
>> as is and ignore my comment.
>>
>> <ship>
>>>>> @@ -126,6 +144,26 @@ static void hugetlb_cgroup_css_free(struct cgroup_subsys_state *css)
>>>>>       kfree(h_cgroup);
>>>>>  }
>>>>>
>>>>> +static void hugetlb_cgroup_move_parent_reservation(int idx,
>>>>> +                                                struct hugetlb_cgroup *h_cg)
>>>>> +{
>>>>> +     struct hugetlb_cgroup *parent = parent_hugetlb_cgroup(h_cg);
>>>>> +
>>>>> +     /* Move the reservation counters. */
>>>>> +     if (!parent_hugetlb_cgroup(h_cg)) {
>>>>> +             parent = root_h_cgroup;
>>>>> +             /* root has no limit */
>>>>> +             page_counter_charge(
>>>>> +                     &root_h_cgroup->reserved_hugepage[idx],
>>>>> +                     page_counter_read(
>>>>> +                             hugetlb_cgroup_get_counter(h_cg, idx, true)));
>>>>> +     }
>>>>> +
>>>>> +     /* Take the pages off the local counter */
>>>>> +     page_counter_cancel(
>>>>> +             hugetlb_cgroup_get_counter(h_cg, idx, true),
>>>>> +             page_counter_read(hugetlb_cgroup_get_counter(h_cg, idx, true)));
>>>>> +}
>>>>
>>>> I know next to nothing about cgroups and am just comparing this to the
>>>> existing hugetlb_cgroup_move_parent() routine.  hugetlb_cgroup_move_parent
>>>> updates the cgroup pointer in each page being moved.  Do we need to do
>>>> something similar for reservations being moved (move pointer in reservation)?
>>>>
>>>
>>> Oh, good catch. Yes I need to be doing that. I should probably
>>> consolidate those routines so the code doesn't miss things like this.
>>
>> This might get a bit ugly/complicated?  Seems like you will need to examine
>> all hugetlbfs inodes and vma's mapping those inodes.
>>
> 
> Hmm yes on closer look it does seem like this is not straightforward.
> I'll write a test that does this reparenting so I can start running
> into the issue and poke for solutions. Off the top of my head, I think
> maybe we can just not reparent the hugetlb reservations - the
> hugetlb_cgroup stays alive until all its memory is uncharged. That
> shouldn't be too bad. Today, I think memcg doesn't reparent memory
> when it gets offlined.
> 
> I'll poke at this a bit and come back with suggestions, you may want
> to hold off reviewing the rest of the patches until then.


Ok, if we start considering what the correct cgroup reparenting semantics
should be it would be good to get input from others with more cgroup
experience.

-- 
Mike Kravetz
