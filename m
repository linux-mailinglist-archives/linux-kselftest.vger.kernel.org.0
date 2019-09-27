Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06ACC0E31
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Sep 2019 00:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfI0W7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 18:59:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59496 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0W7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 18:59:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RMs7QG049717;
        Fri, 27 Sep 2019 22:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cn8H1mWLJV2KFmDp+M2Q4jV4DaWXWTqsiRwHZZfFt5Q=;
 b=ofjxNvBaa/a5m8YcntEw69FxNNL9mXkaGQsgrKdXjDzKuq76XP+3j0bMbA98X7XGOfC2
 TmFvEMX9Sb5idd2FmgQfCA9k3bJBiOgIQVQUEirc8ZsxY7FCW3joePEHY5tO/NPNFrGC
 harhOKWtGI3chOFbj9p9ifkTYgQqMpD3ohacQKPOtbtyGG3Kr8rbBULRr12VmCoiEzYJ
 SneNxb03qPFgHiyFYhm4LE8ZF3pzhy4mD8rhKkq/dOijmxJEPVO3gmrNAc+YOjXLHrbN
 Dh0bImOveXFZRIF9Y05odKZwFhfTsVYn/OAagAhVYuv6oAgKscPhYi0+ctHjuVSh7CLT qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgrmsbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 22:58:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8RMruTD056837;
        Fri, 27 Sep 2019 22:56:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v9m3ft9db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Sep 2019 22:56:29 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8RMuSpL010956;
        Fri, 27 Sep 2019 22:56:28 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Sep 2019 15:56:28 -0700
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Mina Almasry <almasrymina@google.com>
Cc:     Tejun Heo <tj@kernel.org>, David Rientjes <rientjes@google.com>,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
 <CAHS8izOj2AT4tX-+Hcb8LB2TOUKJDHScDtJ80u4M6OWpwktq0g@mail.gmail.com>
 <a8e9c533-1593-35ee-e65d-1f2fc2b0fb48@oracle.com>
 <CAHS8izPfKQA8qTndyzWSm9fR_xJ=X-xmE+4P4K+ZFdxrYNuLBA@mail.gmail.com>
 <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com>
 <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com>
 <CAHS8izM3=ZDNukx5xhWmeJT+78Ekfff9J4s5Vqkqpx-DtH=C-A@mail.gmail.com>
 <794398cc-07a4-d235-a0da-0246f5a09f6e@oracle.com>
 <CAHS8izMg4=mJd_d-f3ueiq6Q1AfTFBSjLXeNkkuZO0iV0Dk-iA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1dbe668d-ec16-7f84-5398-472e7b375c4f@oracle.com>
Date:   Fri, 27 Sep 2019 15:56:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izMg4=mJd_d-f3ueiq6Q1AfTFBSjLXeNkkuZO0iV0Dk-iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909270197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9393 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909270197
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/27/19 3:51 PM, Mina Almasry wrote:
> On Fri, Sep 27, 2019 at 2:59 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 9/26/19 5:55 PM, Mina Almasry wrote:
>>> Provided we keep the existing controller untouched, should the new
>>> controller track:
>>>
>>> 1. only reservations, or
>>> 2. both reservations and allocations for which no reservations exist
>>> (such as the MAP_NORESERVE case)?
>>>
>>> I like the 'both' approach. Seems to me a counter like that would work
>>> automatically regardless of whether the application is allocating
>>> hugetlb memory with NORESERVE or not. NORESERVE allocations cannot cut
>>> into reserved hugetlb pages, correct?
>>
>> Correct.  One other easy way to allocate huge pages without reserves
>> (that I know is used today) is via the fallocate system call.
>>
>>>                                       If so, then applications that
>>> allocate with NORESERVE will get sigbused when they hit their limit,
>>> and applications that allocate without NORESERVE may get an error at
>>> mmap time but will always be within their limits while they access the
>>> mmap'd memory, correct?
>>
>> Correct.  At page allocation time we can easily check to see if a reservation
>> exists and not charge.  For any specific page within a hugetlbfs file,
>> a charge would happen at mmap time or allocation time.
>>
>> One exception (that I can think of) to this mmap(RESERVE) will not cause
>> a SIGBUS rule is in the case of hole punch.  If someone punches a hole in
>> a file, not only do they remove pages associated with the file but the
>> reservation information as well.  Therefore, a subsequent fault will be
>> the same as an allocation without reservation.
>>
> 
> I don't think it causes a sigbus. This is the scenario, right:
> 
> 1. Make cgroup with limit X bytes.
> 2. Task in cgroup mmaps a file with X bytes, causing the cgroup to get charged
> 3. A hole of size Y is punched in the file, causing the cgroup to get
> uncharged Y bytes.
> 4. The task faults in memory from the hole, getting charged up to Y
> bytes again. But they will be still within their limits.
> 
> IIUC userspace only gets sigbus'd if the limit is lowered between
> steps 3 and 4, and it's ok if it gets sigbus'd there in my opinion.

You are correct.  That was my mistake.  I was still thinking of behavior
for a reservation only cgroup model.  It would behave as you describe
above (no SIGBUS) for a combined reservation/allocate model.
-- 
Mike Kravetz
