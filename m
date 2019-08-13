Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C138C4DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfHMXky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 19:40:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49408 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMXkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 19:40:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DNcgnI160249;
        Tue, 13 Aug 2019 23:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=4sbmczonSDq7hMSzD5d9nB/WEujCYY2Kbl0OVowZy30=;
 b=Mg48PWRCx/UGmdQ+LhxE0ApUMA7usmcn1IT6wfUB5oESpjaJU95lAFUuOP+lrXza5i2O
 nGjnhjYB1nLdwSAsLGfRqAq8GrzokGXFZs0QyU0dvnO25FfoQSwyRbC4yZj4Kj+btcxY
 iFDLLUdN0+FyulEzyuGWuf/4Uk5OVbkO/OgUfapiZZCyLFvHEWCP27leFn22m0y+gsTe
 1hFbzXXR0oHlRKmZRbIywzASgEONv5aerYMH2thpsejQ1zdhiSlWJQB2LohBqfS86SNE
 QXvMxHJGlBGyz/09dAR9paxjdwWJIj/k0n0MNZ74YFw8ZhDH2Ypm0s/vFLr6h48ARUUz XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2u9pjqh721-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 23:40:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7DNcbpL140772;
        Tue, 13 Aug 2019 23:40:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2ubwrgk14p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 23:40:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7DNeeLZ018940;
        Tue, 13 Aug 2019 23:40:41 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Aug 2019 16:40:40 -0700
Subject: Re: [RFC PATCH v2 0/5] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org
References: <20190808231340.53601-1-almasrymina@google.com>
 <f0a5afe9-2586-38c9-9a6d-8a2b7b288b50@oracle.com>
 <CAHS8izOKmaOETBd_545Zex=KFNjYOvf3dCzcMRUEXnnhYCK5bw@mail.gmail.com>
 <71a29844-7367-44c4-23be-eff26ac80467@oracle.com>
 <CAHS8izPGhHS+=qnf7Vy=C8kXQ=7v7XH3uEVitrW6ARRYU6iDdg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ce087279-7235-e579-4aec-bc3792b6c09c@oracle.com>
Date:   Tue, 13 Aug 2019 16:40:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izPGhHS+=qnf7Vy=C8kXQ=7v7XH3uEVitrW6ARRYU6iDdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908130224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9348 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908130224
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/19 3:01 PM, Mina Almasry wrote:
> On Sat, Aug 10, 2019 at 11:58 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 8/9/19 12:42 PM, Mina Almasry wrote:
>>> On Fri, Aug 9, 2019 at 10:54 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>> On 8/8/19 4:13 PM, Mina Almasry wrote:
>>>>> Problem:
>>>>> Currently tasks attempting to allocate more hugetlb memory than is available get
>>>>> a failure at mmap/shmget time. This is thanks to Hugetlbfs Reservations [1].
>>>>> However, if a task attempts to allocate hugetlb memory only more than its
>>>>> hugetlb_cgroup limit allows, the kernel will allow the mmap/shmget call,
>>>>> but will SIGBUS the task when it attempts to fault the memory in.
>> <snip>
>>>> I believe tracking reservations for shared mappings can get quite complicated.
>>>> The hugetlbfs reservation code around shared mappings 'works' on the basis
>>>> that shared mapping reservations are global.  As a result, reservations are
>>>> more associated with the inode than with the task making the reservation.
>>>
>>> FWIW, I found it not too bad. And my tests at least don't detect an
>>> anomaly around shared mappings. The key I think is that I'm tracking
>>> cgroup to uncharge on the file_region entry inside the resv_map, so we
>>> know who allocated each file_region entry exactly and we can uncharge
>>> them when the entry is region_del'd.
>>>
>>>> For example, consider a file of size 4 hugetlb pages.
>>>> Task A maps the first 2 pages, and 2 reservations are taken.  Task B maps
>>>> all 4 pages, and 2 additional reservations are taken.  I am not really sure
>>>> of the desired semantics here for reservation limits if A and B are in separate
>>>> cgroups.  Should B be charged for 4 or 2 reservations?
>>>
>>> Task A's cgroup is charged 2 pages to its reservation usage.
>>> Task B's cgroup is charged 2 pages to its reservation usage.
>>
>> OK,
>> Suppose Task B's cgroup allowed 2 huge pages reservation and 2 huge pages
>> allocation.  The mmap would succeed, but Task B could potentially need to
>> allocate more than 2 huge pages.  So, when faulting in more than 2 huge
>> pages B would get a SIGBUS.  Correct?  Or, am I missing something?
>>
>> Perhaps reservation charge should always be the same as map size/maximum
>> allocation size?
> 
> I'm thinking this would work similar to how other shared memory like
> tmpfs is accounted for right now. I.e. if a task conducts an operation
> that causes memory to be allocated then that task is charged for that
> memory, and if another task uses memory that has already been
> allocated and charged by another task, then it can use the memory
> without being charged.
> 
> So in case of hugetlb memory, if a task is mmaping memory that causes
> a new reservation to be made, and new entries to be created in the
> resv_map for the shared mapping, then that task gets charged. If the
> task is mmaping memory that is already reserved or faulted, then it
> reserves or faults it without getting charged.
> 
> In the example above, in chronological order:
> - Task A mmaps 2 hugetlb pages, gets charged 2 hugetlb reservations.
> - Task B mmaps 4 hugetlb pages, gets charged only 2 hugetlb
> reservations because the first 2 are charged already and can be used
> without incurring a charge.
> - Task B accesses 4 hugetlb pages, gets charged *4* hugetlb faults,
> since none of the 4 pages are faulted in yet. If the task is only
> allowed 2 hugetlb page faults then it will actually get a SIGBUS.
> - Task A accesses 4 hugetlb pages, gets charged no faults, since all
> the hugetlb faults is charged to Task B.
> 
> So, yes, I can see a scenario where userspace still gets SIGBUS'd, but
> I think that's fine because:
> 1. Notice that the SIGBUS is due to the faulting limit, and not the
> reservation limit, so we're not regressing the status quo per say.
> Folks using the fault limit today understand the SIGBUS risk.
> 2. the way I expect folks to use this is to use 'reservation limits'
> to partition the available hugetlb memory on the machine using it and
> forgo using the existing fault limits. Using both at the same time I
> think would be a superuser feature for folks that really know what
> they are doing, and understand the risk of SIGBUS that comes with
> using the existing fault limits.
> 3. I expect userspace to in general handle this correctly because
> there are similar challenges with all shared memory and accounting of
> it, even in tmpfs, I think.

Ok, that helps explain your use case.  I agree that it would be difficult
to use both fault and reservation limits together.  Especially in the case
of shared mappings.
-- 
Mike Kravetz
