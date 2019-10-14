Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF24D6881
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2019 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbfJNRdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 13:33:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfJNRdW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 13:33:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EHTRm2055532;
        Mon, 14 Oct 2019 17:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=SgoPaXtNxXkqZxvIC3mKHam0uE1SQovKYmuch0B2NlQ=;
 b=DhDyMkuZYE70IGS8w2tWI14yqTSd4ojJOq8VBEmTIOAJckSPdzfnWPzc4flTyhibnsbF
 Rjov5ug2GK6wQbwJRzkbk96SrugA2pLFHHgikNI74GFogfeUGnRoJsjr2OpsfiL39PTs
 YHE5N/R+9T8QXIHDz6J6mzga6yKxYFW/Wj5AoSZB8hb8NYNJ+cZ6soIWfsQeZHGBxYWe
 +rQ10X6ZL0Xl4Hzg76Zr3JVwnU6U8fkj5UxdGTLf6dlw9y0Edj+NJLvngXroOE0viV/m
 6zS26bvgQFnbAvQ7YTkS8KBV+0hH2FhbtJKKxlSTSfzwqZ+WSSSXkTJoRxpMk2Z8fGER qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fr2as5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 17:33:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9EHRtTl009294;
        Mon, 14 Oct 2019 17:33:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vkry6shsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 17:33:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9EHX9WA026469;
        Mon, 14 Oct 2019 17:33:09 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 17:33:09 +0000
Subject: Re: [PATCH v5 0/7] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
To:     Mina Almasry <almasrymina@google.com>
Cc:     Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20190919222421.27408-1-almasrymina@google.com>
 <3c73d2b7-f8d0-16bf-b0f0-86673c3e9ce3@oracle.com>
 <CAHS8izN1Q7XH84Srem_McB+Jz67-fu6KPCMQjzbnPDTPzgwC2A@mail.gmail.com>
 <CAHS8izNhZc8zsdf=eXU5L_ouKwk9s00S-Q21P=QA+vAF3BsXcg@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f042aba0-7e0f-80c5-1285-6b6fd2b3cbac@oracle.com>
Date:   Mon, 14 Oct 2019 10:33:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izNhZc8zsdf=eXU5L_ouKwk9s00S-Q21P=QA+vAF3BsXcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9410 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140146
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/11/19 1:41 PM, Mina Almasry wrote:
> On Fri, Oct 11, 2019 at 12:10 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Mon, Sep 23, 2019 at 10:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>
>>> On 9/19/19 3:24 PM, Mina Almasry wrote:
>>
>> Mike, note your suggestion above to check if the page hugetlb_cgroup
>> is null doesn't work if we want to keep the current counter working
>> the same: the page will always have a hugetlb_cgroup that points that
>> contains the old counter. Any ideas how to apply this new counter
>> behavior to a private NORESERVE mappings? Is there maybe a flag I can
>> set on the pages at allocation time that I can read on free time to
>> know whether to uncharge the hugetlb_cgroup or not?
> 
> Reading the code and asking around a bit, it seems the pointer to the
> hugetlb_cgroup is in page[2].private. Is it reasonable to use
> page[3].private to store the hugetlb_cgroup to uncharge for the new
> counter and increment HUGETLB_CGROUP_MIN_ORDER to 3? I think that
> would solve my problem. When allocating a private NORESERVE page, set
> page[3].private to the hugetlb_cgroup to uncharge, then on
> free_huge_page, check page[3].private, if it is non-NULL, uncharge the
> new counter on it.

Sorry for not responding sooner.  This approach should work, and it looks like
you have a v6 of the series.  I'll take a look.

-- 
Mike Kravetz
