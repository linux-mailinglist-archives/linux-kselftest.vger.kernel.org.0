Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 601B18845C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 23:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfHIVAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 17:00:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIVAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 17:00:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79KxT2t044817;
        Fri, 9 Aug 2019 21:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=9sLztaDMB8aeSX3WL8ufO6Qlj+pu4SLKowKGxHUAYS8=;
 b=pcYp9yfI3GuKYjG0G1hZnUZ4mlVzJhMn8SDnFIAzHBL80YDKrjzKOIYK5jCrJnoZCC7T
 RRO8mCE2iaWu46snuI9l0EoYMXANzjdEMQ57i1CRXiO6XGPmABWxu2DmDbWlcq7LKuyz
 yNF6hBnc83a66hJimNA6UgiMfpJe0JRVQWDKBFil0LYD8mLzdiOg2n96TIJwiX282nbH
 c9Pjrfahh0u7DRAhZHcOitDBo33YQph1lvHMNnfypeliX/9mlv6NZyaXOU7uSuk/Yyl5
 5vi7kruxTckNH64kZyDfpogI8yEcQJ7JtVKRpFpngUgaLve2gShL6D1Z25RDCpAIQ70n Cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9sLztaDMB8aeSX3WL8ufO6Qlj+pu4SLKowKGxHUAYS8=;
 b=UefUInbUUZVRUhWHdFjDeVmYihsfyeb61d47cAMjPnlxeMdTTxQ76xdZCw2SPU++rVKt
 bG0sK1hFkwkSCJS/zxMt/pdcl0734OhVrIAp8qyhNAOUQkwXW/GeHY8WNyXFIgRV/pV7
 86uwKsYH94fY2QX0WVToNPbbsBB1VL+XOdq9/mjdldNniAKHzPrIzYiec+dKe36ZfSW7
 15CKaLG/oZyet44aTb2NcVFdZ7b934CoDlRI8j4hKxohV9Hh6dP84fv3f65XPbtYhZq7
 PCFCjFg8zoSvpYzoXE4PerYHA7HB53JMytkkEs8emfM8PAk1NNjTa1dy7pcK1wejnL69 hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u8hpsa0jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 21:00:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x79KvYJo172016;
        Fri, 9 Aug 2019 21:00:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u8pj9jvyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 21:00:24 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x79L0NTc027268;
        Fri, 9 Aug 2019 21:00:23 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Aug 2019 14:00:23 -0700
Subject: Re: [RFC PATCH] hugetlbfs: Add hugetlb_cgroup reservation limits
To:     Mina Almasry <almasrymina@google.com>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
References: <20190808194002.226688-1-almasrymina@google.com>
 <20190809112738.GB13061@blackbody.suse.cz>
 <CAHS8izNM3jYFWHY5UJ7cmJ402f-RKXzQ=JFHpD7EkvpAdC2_SA@mail.gmail.com>
 <fc420531-f0fe-8df5-57fe-71a686bf2a71@oracle.com>
 <CAHS8izN9BFASse_pjLEhQzWwofjRv+JQ5Z=ZiR6Wywn2USLELA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <af6a8c43-e286-5360-61f3-6d306d8f1951@oracle.com>
Date:   Fri, 9 Aug 2019 14:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izN9BFASse_pjLEhQzWwofjRv+JQ5Z=ZiR6Wywn2USLELA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=509
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090205
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9344 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=533 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090205
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/19 1:57 PM, Mina Almasry wrote:
> On Fri, Aug 9, 2019 at 1:39 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 8/9/19 11:05 AM, Mina Almasry wrote:
>>> On Fri, Aug 9, 2019 at 4:27 AM Michal Koutný <mkoutny@suse.com> wrote:
>>>>> Alternatives considered:
>>>>> [...]
>>>> (I did not try that but) have you considered:
>>>> 3) MAP_POPULATE while you're making the reservation,
>>>
>>> I have tried this, and the behaviour is not great. Basically if
>>> userspace mmaps more memory than its cgroup limit allows with
>>> MAP_POPULATE, the kernel will reserve the total amount requested by
>>> the userspace, it will fault in up to the cgroup limit, and then it
>>> will SIGBUS the task when it tries to access the rest of its
>>> 'reserved' memory.
>>>
>>> So for example:
>>> - if /proc/sys/vm/nr_hugepages == 10, and
>>> - your cgroup limit is 5 pages, and
>>> - you mmap(MAP_POPULATE) 7 pages.
>>>
>>> Then the kernel will reserve 7 pages, and will fault in 5 of those 7
>>> pages, and will SIGBUS you when you try to access the remaining 2
>>> pages. So the problem persists. Folks would still like to know they
>>> are crossing the limits on mmap time.
>>
>> If you got the failure at mmap time in the MAP_POPULATE case would this
>> be useful?
>>
>> Just thinking that would be a relatively simple change.
> 
> Not quite, unfortunately. A subset of the folks that want to use
> hugetlb memory, don't want to use MAP_POPULATE (IIRC, something about
> mmaping a huge amount of hugetlb memory at their jobs' startup, and
> doing that with MAP_POPULATE adds so much to their startup time that
> it is prohibitively expensive - but that's just what I vaguely recall
> offhand. I can get you the details if you're interested).

Yes, MAP_POPULATE can get expensive as you will need to zero all those
huge pages.

-- 
Mike Kravetz
