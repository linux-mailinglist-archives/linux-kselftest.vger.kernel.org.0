Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AD2905EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2019 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHPQdw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Aug 2019 12:33:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPQdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Aug 2019 12:33:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGDkXL165766;
        Fri, 16 Aug 2019 16:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=yE1enNm7gCBzShIHWinhc7VMx7VLR2+YnUK3tfhEdok=;
 b=ohz/lLhcTITj8487swbsx2o5AO11doE7iBcHAfgfuzMrgRI/uPI1ZoKHyDt2VacKjrME
 c9BGo9u6JLcziz2UlhwjOcbgmNtfXyqbEvjezflZ+9Gx7fRvbzYlbwpXQ745uryC3yd4
 TI2QpSLECousW5DWVuzVM7fwXAt9wfzg9FdEpiAH9UK8AgL+cPE+i1InFVy4iWu0/2YI
 C70BZee3ZPVCS5pByj5ciFt4a+HNYJ/CDRFpENb+kCvmV0wdxUkVGKeo649aXQpzGlxb
 WUeLtQ7q0bVrccC8NFkzgclbkfarnMHDo6AV6dbHDGnDX/XN5L1ghL47uxjz7TtZ+STj IA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u9pjr1d2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:33:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7GGXD63186766;
        Fri, 16 Aug 2019 16:33:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2udgr32pyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 16:33:45 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7GGXi9I003706;
        Fri, 16 Aug 2019 16:33:44 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 16 Aug 2019 09:33:44 -0700
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
 <CAHS8izNAZLQnHi6qXiO_efgSs1x2NOXKOKy7rZf+oF-8+hq=YQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4ae131d2-97ba-dac0-e747-48469580401e@oracle.com>
Date:   Fri, 16 Aug 2019 09:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHS8izNAZLQnHi6qXiO_efgSs1x2NOXKOKy7rZf+oF-8+hq=YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908160172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9351 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908160171
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/15/19 4:08 PM, Mina Almasry wrote:
> On Tue, Aug 13, 2019 at 4:54 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>  mm/hugetlb.c | 208 +++++++++++++++++++++++++++++++++++++++++----------
>>>  1 file changed, 170 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 235996aef6618..d76e3137110ab 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -242,8 +242,72 @@ struct file_region {
>>>       struct list_head link;
>>>       long from;
>>>       long to;
>>> +#ifdef CONFIG_CGROUP_HUGETLB
>>> +     /*
>>> +      * On shared mappings, each reserved region appears as a struct
>>> +      * file_region in resv_map. These fields hold the info needed to
>>> +      * uncharge each reservation.
>>> +      */
>>> +     struct page_counter *reservation_counter;
>>> +     unsigned long pages_per_hpage;
>>> +#endif
>>>  };
>>>
>>> +/* Must be called with resv->lock held. Calling this with dry_run == true will
>>> + * count the number of pages added but will not modify the linked list.
>>> + */
>>> +static long consume_regions_we_overlap_with(struct file_region *rg,
>>> +             struct list_head *head, long f, long *t,
>>> +             struct hugetlb_cgroup *h_cg,
>>> +             struct hstate *h,
>>> +             bool dry_run)
>>> +{
>>> +     long add = 0;
>>> +     struct file_region *trg = NULL, *nrg = NULL;
>>> +
>>> +     /* Consume any regions we now overlap with. */
>>> +     nrg = rg;
>>> +     list_for_each_entry_safe(rg, trg, rg->link.prev, link) {
>>> +             if (&rg->link == head)
>>> +                     break;
>>> +             if (rg->from > *t)
>>> +                     break;
>>> +
>>> +             /* If this area reaches higher then extend our area to
>>> +              * include it completely.  If this is not the first area
>>> +              * which we intend to reuse, free it.
>>> +              */
>>> +             if (rg->to > *t)
>>> +                     *t = rg->to;
>>> +             if (rg != nrg) {
>>> +                     /* Decrement return value by the deleted range.
>>> +                      * Another range will span this area so that by
>>> +                      * end of routine add will be >= zero
>>> +                      */
>>> +                     add -= (rg->to - rg->from);
>>> +                     if (!dry_run) {
>>> +                             list_del(&rg->link);
>>> +                             kfree(rg);
>>
>> Is it possible that the region struct we are deleting pointed to
>> a reservation_counter?  Perhaps even for another cgroup?
>> Just concerned with the way regions are coalesced that we may be
>> deleting counters.
>>
> 
> Yep, that needs to be handled I think. Thanks for catching!
> 

I believe that we will no longer be able to coalesce reserv_map entries
for shared mappings.  That is because we need to record who is responsible
for creating reservation entries.

-- 
Mike Kravetz
