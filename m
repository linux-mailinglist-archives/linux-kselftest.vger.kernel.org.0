Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446E5EB5C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfJaRF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 13:05:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfJaRF4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 13:05:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VH4K7c143756;
        Thu, 31 Oct 2019 17:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=6zeZQCt5KSy9iY879DP3c25YYnvX1B7KZZYOEc5BkVU=;
 b=qUBB/RAxFO/7T6CQHP8JhtlkO1VYLIAxwAHOqa2whguFg10nnjeoXiPilKlSHOmPhb4m
 FTFYiAwxzRyF6tOmIqY2pfAg69j8RUaZl58xSaDBJqbBJCOc3D5TTQfavPhdyTJw2QNa
 s1Fbo94ZeH4OiFdJIwRK4PpdSnBlu/2PMXXq+Tmh3QNGScTRCwLaUocwrt7Lelvlp/Vg
 Jv9hKkigkMBm/HiRg8bALRNub1XBTUpD+U3WlRNttuXxSZzojy+9ATdvtenSyKomCPt/
 k+S5gtHO+k5CMOjszDQ0SZZLREsbdH+n7dzLy9lWcVtceNPe7t2dzAJelycGEAEvVM5O SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vxwhfvq9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 17:05:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9VH4BWK045372;
        Thu, 31 Oct 2019 17:05:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vysburqhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Oct 2019 17:05:29 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9VH5Qt7008367;
        Thu, 31 Oct 2019 17:05:27 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 31 Oct 2019 10:05:26 -0700
Subject: Re: [PATCH v7 5/9] hugetlb: disable region_add file_region coalescing
To:     Mina Almasry <almasrymina@google.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20191024202858.95342-1-almasrymina@google.com>
 <20191024202858.95342-5-almasrymina@google.com>
 <c3d9f0aa-3d9b-f46e-ecb1-bdea99be82c7@oracle.com>
 <CAHS8izM36yfP2jNe=S83MSzo6b1KzHVwWrngVUNh_H1WSHj63w@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d810e0dc-0bcd-9882-b1d6-1d6da112d558@oracle.com>
Date:   Thu, 31 Oct 2019 10:05:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izM36yfP2jNe=S83MSzo6b1KzHVwWrngVUNh_H1WSHj63w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910310168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910310168
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/29/19 6:38 PM, Mina Almasry wrote:
> On Fri, Oct 25, 2019 at 2:37 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> On 10/24/19 1:28 PM, Mina Almasry wrote:
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
>>> -
>>> -     /* Round our left edge to the current segment if it encloses us. */
>>> -     if (f > rg->from)
>>> -             f = rg->from;
>>> +     if (regions_needed)
>>> +             *regions_needed = 0;
>>>
>>> -     chg = t - f;
>>> +     /* In this loop, we essentially handle an entry for the range
>>> +      * last_accounted_offset -> rg->from, at every iteration, with some
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
>>
>> After the above checks, can this condition ever be false?
>>
> 
> rg->from can be == to last_accounted_offset, no? We only want to add a
> region when there is a gap between rg->from and last_accounted_offset.

Yes, you are correct.  I had to write out the logic. :)

<snip>
>>> +      * Check for sufficient descriptors in the cache to accommodate
>>> +      * this add operation.
>>>        */
>>> -     if (&rg->link == head || t < rg->from) {
>>> -             VM_BUG_ON(resv->region_cache_count <= 0);
>>> -
>>> -             resv->region_cache_count--;
>>> -             nrg = list_first_entry(&resv->region_cache, struct file_region,
>>> -                                     link);
>>> -             list_del(&nrg->link);
>>> -
>>> -             nrg->from = f;
>>> -             nrg->to = t;
>>> -             list_add(&nrg->link, rg->link.prev);
>>> +     if (resv->region_cache_count < actual_regions_needed) {
>>> +             /* region_add operation of range 1 should never need to
>>> +              * allocate file_region entries.
>>> +              */
>>> +             VM_BUG_ON(t - f <= 1);
>>
>> Should we instead compare actual_regions_needed to in_regions_needed and
>> allocate if more regions are actually needed?  If not, the loop below only
>> brings the cache up to the number of regions needed for this operation.
>> There could be an operation with range of one in progress and this operation
>> will consume all operation in the cache which will cause us to hit the BUG.
>>
> 
> Great catch, thanks! Fixed in v8!
> 
> I think the correct condition is:
> 
> region_cache_count == (adds_in_progress + (actual_regions_needed -
> in_regions_needed))
> 
> That means the region_cache_count has enough for all the current adds
> in progress plus the ones we discovered are needed extra.
> 

Yes, the idea is that you want to make sure you do niot deplete the
cache beyond the adds in progress.  This is especially important if we
want to guarantee success of region_add for a single page.

>>> +             while (resv->region_cache_count < actual_regions_needed) {
>>> +                     /* Must drop lock to allocate a new descriptor. */
>>
>> It would be better to drop the lock,  try to allocate all the needed
>> descriptors, and then reacquire lock instead of dropping and acquiring
>> lock in a loop.
>>
> 
> Fixed in v8.

I would not expect this to be the common case.  We will only be doing
allocations here in the case of races.  Similiar code in region_chg
would be the more expected place to perform multiple allocations.

>>> +                     spin_unlock(&resv->lock);
>>> +                     trg = kmalloc(sizeof(*trg), GFP_KERNEL);
>>> +                     if (!trg)
>>> +                             return -ENOMEM;
>>> +
>>> +                     spin_lock(&resv->lock);
>>> +                     list_add(&trg->link, &resv->region_cache);
>>> +                     resv->region_cache_count++;
>>> +             }
>>>
>>> -             add += t - f;
>>> -             goto out_locked;
>>> +             goto retry;
>>>       }
>>>
>>> -     add = add_reservation_in_range(resv, f, t, false);
>>> +     add = add_reservation_in_range(resv, f, t, NULL, false);
>>> +
>>> +     resv->adds_in_progress -= in_regions_needed;
>>
>> Ok, so adds_in_progress really becomes regions in the process of being added.
>> I think we would then like to keep number of entries in the cache equal to
>> adds_in_progress?
>>
> 
> Excess cache entries will be re-used by the next region_chg call. Is that ok?
> 
> Deallocating the excess entries so that the next region_chg entry has
> to allocate its own is doable too, but it's quite annoying. Some
> codepaths are made simpler by not worrying about 'cleaning up' excess
> cache entries. For example, region_add doesn't need to handle what if
> the actual_regions_needed is less than the in_regions_needed because
> it can just leave the extra cache entries for later use.

Ok, I agree that we can keep excess entries in the cache.  Just wanted to
make sure we covered the case of depleting the cache such that we could not
provide guarantees for region_add success of single pages.

>>>       /*
>>>        * Check for sufficient descriptors in the cache to accommodate
>>>        * the number of in progress add operations.
>>>        */
>>> -     if (resv->adds_in_progress > resv->region_cache_count) {
>>> -             struct file_region *trg;
>>> -
>>> -             VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
>>> +     while (resv->region_cache_count < resv->adds_in_progress) {
>>
>> I think we always want to add out_regions_needed to the cache?
>>
> 
> Current code adds out_regions_needed to adds_in_progress while holding
> the lock, then brings up region_cache_count to adds_in_prorgess. There
> shouldn't be a race here, since other region_chg/add calls hold the
> lock to modify the adds_in_progress value. The effect here is that we
> re-use excess cache entries.
> 
> What I fixed in v8 is that when region_add finds out it needs more
> entries, it should make sure there is enough for the adds_in_progress
> plus the extra regions that operation needs.

Great.  Will be reviewing V8 shortly.

>>> -static long __vma_reservation_common(struct hstate *h,
>>> -                             struct vm_area_struct *vma, unsigned long addr,
>>> -                             enum vma_resv_mode mode)
>>> +static long
>>> +__vma_reservation_common(struct hstate *h, struct vm_area_struct *vma,
>>> +                      unsigned long addr, enum vma_resv_mode mode,
>>> +                      long *out_regions_needed, long in_regions_needed)
>>
>> All of the vma_*_reservation routines operate on a single page.  As a result,
>> region_chg will always set out_regions_needed to 1 and in_regions_needed
>> will always be 1.  With this in mind, can we just hard code the value 1 in
>> these calls within __vma_reservation_common and avoid any changes to the
>> vma_*_reservation routines?  If yes, let's put a big fat comment in
>> region_chg/region_add about the assumptions and a reminder to change this
>> code if those assumptions change.
>>
> 
> Fixed.

Great.  I am glad this works.

<snip>
> 
> Should be sending out v8 with these fixes shortly.
> 

Thanks, I'll take a look.

-- 
Mike Kravetz
