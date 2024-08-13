Return-Path: <linux-kselftest+bounces-15197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1694FEB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703181F24929
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283E136E28;
	Tue, 13 Aug 2024 07:23:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9F456766;
	Tue, 13 Aug 2024 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533792; cv=none; b=VnWpwLdPx82UJuYZqEYJoCjtKHpukMqwoOnzxU076tr4KTUnCLc8hQo7muU5wMjd93cXweuYNhLv88BcZ5Up25BJrBQ+vGHgSIwouJ8Kt4HHDUhIW2wEQw12K5PCNd3Hrt6mb/5gCiioMToYdADIUul6WBXUBeQy7fbpOiBV0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533792; c=relaxed/simple;
	bh=YkFQ0qeZ4M2xM5pBwIn4Vbo7/77B7H67YNc9x7MHUw4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SADi8+gycxpRcaKP8/yEfut6DFI0M6ulrRxRFt4goW1g6XQ5/93ApD1qTzpXtMlME4oIm9AAjnrs8QnXZnnkQN0NH4/evW2uLMB3U1sZsOzFrcN3LJI3XfFoc78Lx2jrMZZiD2Tk94tn3xu7ebMtBBu7kYVq4e03s7u84bOlPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA5612FC;
	Tue, 13 Aug 2024 00:23:34 -0700 (PDT)
Received: from [10.162.42.21] (e116581.arm.com [10.162.42.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A88463F40C;
	Tue, 13 Aug 2024 00:22:58 -0700 (PDT)
Message-ID: <391d4f4f-e642-4c11-a36b-190874963f8a@arm.com>
Date: Tue, 13 Aug 2024 12:52:55 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
From: Dev Jain <dev.jain@arm.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, david@redhat.com,
 willy@infradead.org, ryan.roberts@arm.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com,
 apopple@nvidia.com, osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <87frrauwwv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <15dbe4ac-a036-4029-ba08-e12a236f448a@arm.com>
 <87bk1yuuzu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <95b72817-5444-4ced-998a-1cb90f42bf49@arm.com>
 <8734naurhm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <9d84e4e8-ac54-4eb1-a113-3f32aea864c9@arm.com>
 <fe76204d-4cef-4f06-a5bc-e016a513f783@arm.com>
Content-Language: en-US
In-Reply-To: <fe76204d-4cef-4f06-a5bc-e016a513f783@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/13/24 10:30, Dev Jain wrote:
>
> On 8/12/24 17:38, Dev Jain wrote:
>>
>> On 8/12/24 13:01, Huang, Ying wrote:
>>> Dev Jain <dev.jain@arm.com> writes:
>>>
>>>> On 8/12/24 11:45, Huang, Ying wrote:
>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>
>>>>>> On 8/12/24 11:04, Huang, Ying wrote:
>>>>>>> Hi, Dev,
>>>>>>>
>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>
>>>>>>>> As already being done in __migrate_folio(), wherein we backoff 
>>>>>>>> if the
>>>>>>>> folio refcount is wrong, make this check during the unmapping 
>>>>>>>> phase, upon
>>>>>>>> the failure of which, the original state of the PTEs will be 
>>>>>>>> restored and
>>>>>>>> the folio lock will be dropped via migrate_folio_undo_src(), 
>>>>>>>> any racing
>>>>>>>> thread will make progress and migration will be retried.
>>>>>>>>
>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>> ---
>>>>>>>>     mm/migrate.c | 9 +++++++++
>>>>>>>>     1 file changed, 9 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>>>>> --- a/mm/migrate.c
>>>>>>>> +++ b/mm/migrate.c
>>>>>>>> @@ -1250,6 +1250,15 @@ static int 
>>>>>>>> migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>         }
>>>>>>>>           if (!folio_mapped(src)) {
>>>>>>>> +        /*
>>>>>>>> +         * Someone may have changed the refcount and maybe 
>>>>>>>> sleeping
>>>>>>>> +         * on the folio lock. In case of refcount mismatch, 
>>>>>>>> bail out,
>>>>>>>> +         * let the system make progress and retry.
>>>>>>>> +         */
>>>>>>>> +        struct address_space *mapping = folio_mapping(src);
>>>>>>>> +
>>>>>>>> +        if (folio_ref_count(src) != 
>>>>>>>> folio_expected_refs(mapping, src))
>>>>>>>> +            goto out;
>>>>>>>>             __migrate_folio_record(dst, old_page_state, anon_vma);
>>>>>>>>             return MIGRATEPAGE_UNMAP;
>>>>>>>>         }
>>>>>>> Do you have some test results for this?  For example, after 
>>>>>>> applying the
>>>>>>> patch, the migration success rate increased XX%, etc.
>>>>>> I'll get back to you on this.
>>>>>>
>>>>>>> My understanding for this issue is that the migration success 
>>>>>>> rate can
>>>>>>> increase if we undo all changes before retrying.  This is the 
>>>>>>> current
>>>>>>> behavior for sync migration, but not for async migration.  If 
>>>>>>> so, we can
>>>>>>> use migrate_pages_sync() for async migration too to increase 
>>>>>>> success
>>>>>>> rate?  Of course, we need to change the function name and comments.
>>>>>> As per my understanding, this is not the current behaviour for sync
>>>>>> migration. After successful unmapping, we fail in 
>>>>>> migrate_folio_move()
>>>>>> with -EAGAIN, we do not call undo src+dst (rendering the loop around
>>>>>> migrate_folio_move() futile), we do not push the failed folio 
>>>>>> onto the
>>>>>> ret_folios list, therefore, in _sync(), _batch() is never tried 
>>>>>> again.
>>>>> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
>>>>> called first, if failed, the folio will be restored to the original
>>>>> state (unlocked).  Then migrate_pages_batch(,_SYNC*) is called again.
>>>>> So, we unlock once.  If it's necessary, we can unlock more times via
>>>>> another level of loop.
>>>> Yes, that's my point. We need to undo src+dst and retry.
>>> For sync migration, we undo src+dst and retry now, but only once.  You
>>> have shown that more retrying increases success rate.
>>>
>>>> We will have
>>>> to decide where we want this retrying to be; do we want to change the
>>>> return value, end up in the while loop wrapped around _sync(), and 
>>>> retry
>>>> there by adding another level of loop, or do we want to make use of 
>>>> the
>>>> existing retry loops, one of which is wrapped around _unmap(); the 
>>>> latter
>>>> is my approach. The utility I see for the former approach is that, 
>>>> in case
>>>> of a large number of page migrations (which should usually be the 
>>>> case),
>>>> we are giving more time for the folio to get retried. The latter 
>>>> does not
>>>> give much time and discards the folio if it did not succeed under 7 
>>>> times.
>>> Because it's a race, I guess that most folios will be migrated
>>> successfully in the first pass.
>>>
>>> My concerns of your method are that it deal with just one case
>>> specially.  While retrying after undoing all appears more general.
>>
>>
>> Makes sense. Also, please ignore my "change the return value"
>> thing, I got confused between unmap_folios, ret_folios, etc.
>> Now I think I understood what the lists are doing :)
>>
>>>
>>> If it's really important to retry after undoing all, we can either
>>> convert two retying loops of migrate_pages_batch() into one loop, or
>>> remove retry loop in migrate_pages_batch() and retry in its caller
>>> instead.
>>
>> And if I implemented this correctly, the following makes the test
>> pass always:
>> https://www.codedump.xyz/diff/Zrn7EdxzNXmXyNXe
>
>
> Okay, I did mess up with the implementation, leading to a false
> positive. Let me try again :)


Hopefully this should do the job:
https://www.codedump.xyz/diff/ZrsIV8JSOPYx5V_u

But the result is worse than the patch proposed; I rarely hit
a 3 digit number of successes of move_pages(). But, on a
base kernel without any changes, when I apply David's
suggestion to change the test, if I choose 7 as the number
of retries (= NR_MAX_MIGRATE_SYNC_RETRY) in the test, I
can touch even 4 digits. I am puzzled.
We can also try merging the for loops of unmap and move...

>
>>
>>
>>
>>>
>>> -- 
>>> Best Regards,
>>> Huang, Ying
>>
>

