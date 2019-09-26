Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC370BFAE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 23:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfIZVYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 17:24:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58160 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfIZVYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 17:24:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QL4HC0039082;
        Thu, 26 Sep 2019 21:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=syopFZsTRWZBj4sXSwoJAEoUMjpR96jvonKPhXPYCVs=;
 b=ibdeojAfgag/vLd8lHEGcLnLfZGWZOWADHynTevcl+ApHSbVF/wJ3KA42zqlnbkFfgkk
 Gqf/1OV/bEll03AVEZjKfMavJhfyAQaW3RMpCC3MeFMpqRNoqed7npMfTBg34TyEXDYq
 KFoSfY5MZQ1IODYdAYQKpCzIopfNoAKgkZXvZH5RF3Ya+GVnWQQgRa2rp1cRTzZO3IwP
 Aq17lJ8F5bXtXJrs53cu3Av5TMGhwfuEphjLb3jJDdrk84HrXP7XD1wyaMtmwxh1N8tr
 pcAbe2F6i+ooo7zaLjBpY6kFU7GH/QPzZ8/6pJE6gIF6wsfNgRC/h7aj1FLKRynFjdJe Hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2v5b9u6fw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 21:23:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8QL9Rac196343;
        Thu, 26 Sep 2019 21:23:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2v8yjx8230-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Sep 2019 21:23:52 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8QLNo9m020342;
        Thu, 26 Sep 2019 21:23:50 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Sep 2019 14:23:37 -0700
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8f7db4f1-9c16-def5-79dc-d38d6b9d150e@oracle.com>
Date:   Thu, 26 Sep 2019 14:23:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909261220150.39830@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9392 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260165
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/26/19 12:28 PM, David Rientjes wrote:
> On Tue, 24 Sep 2019, Mina Almasry wrote:
> 
>>> I personally prefer the one counter approach only for the reason that it
>>> exposes less information about hugetlb reservations.  I was not around
>>> for the introduction of hugetlb reservations, but I have fixed several
>>> issues having to do with reservations.  IMO, reservations should be hidden
>>> from users as much as possible.  Others may disagree.
>>>
>>> I really hope that Aneesh will comment.  He added the existing hugetlb
>>> cgroup code.  I was not involved in that effort, but it looks like there
>>> might have been some thought given to reservations in early versions of
>>> that code.  It would be interesting to get his perspective.
>>>
>>> Changes included in patch 4 (disable region_add file_region coalescing)
>>> would be needed in a one counter approach as well, so I do plan to
>>> review those changes.
>>
>> OK, FWIW, the 1 counter approach should be sufficient for us, so I'm
>> not really opposed. David, maybe chime in if you see a problem here?
>> From the perspective of hiding reservations from the user as much as
>> possible, it is an improvement.
>>
>> I'm only wary about changing the behavior of the current and having
>> that regress applications. I'm hoping you and Aneesh can shed light on
>> this.
>>
> 
> I think neither Aneesh nor myself are going to be able to provide a 
> complete answer on the use of hugetlb cgroup today, anybody could be using 
> it without our knowledge and that opens up the possibility that combining 
> the limits would adversely affect a real system configuration.

I agree that nobody can provide complete information on hugetlb cgroup usage
today.  My interest was in anything Aneesh could remember about development
of the current cgroup code.  It 'appears' that the idea of including
reservations or mmap ranges was considered or at least discussed.  But, those
discussions happened more than 7 years old and my searches are not providing
a complete picture.  My hope was that Aneesh may remember those discussions.

> If that is a possibility, I think we need to do some due diligence and try 
> to deprecate allocation limits if possible.  One of the benefits to 
> separate limits is that we can make reasonable steps to deprecating the 
> actual allocation limits, if possible: we could add warnings about the 
> deprecation of allocation limits and see if anybody complains.
> 
> That could take the form of two separate limits or a tunable in the root 
> hugetlb cgroup that defines whether the limits are for allocation or 
> reservation.
> 
> Combining them in the first pass seems to be very risky and could cause 
> pain for users that will not detect this during an rc cycle and will 
> report the issue only when their distro gets it.  Then we are left with no 
> alternative other than stable backports and the separation of the limits 
> anyway.

I agree that changing behavior of the existing controller is too risky.
Such a change is likely to break someone.  The more I think about it, the
best way forward will be to retain the existing controller and create a
new controller that satisfies the new use cases.  The question remains as
to what that new controller will be.  Does it control reservations only?
Is it a combination of reservations and allocations?  If a combined
controller will work for new use cases, that would be my preference.  Of
course, I have not prototyped such a controller so there may be issues when
we get into the details.  For a reservation only or combined controller,
the region_* changes proposed by Mina would be used.
-- 
Mike Kravetz
