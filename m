Return-Path: <linux-kselftest+bounces-15768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CA957F35
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 09:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9302817F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64A1BC58;
	Tue, 20 Aug 2024 07:16:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98BE56A;
	Tue, 20 Aug 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138204; cv=none; b=fwNADmG8S1j1koDSB5q21SFXdcK6vuy4zwfHWyhDqJY5IP6ln+GGFAlT1iepzdBShQU9JvoRd2xESW+bc5gnwymRVIwcNxCOMKA/KcrsIZtCfkX+Gu6E0gR05efPNBWxIeeVypMaqmXTBF7vhnYOWE4ZFfPoqLd1BI71Ybm65/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138204; c=relaxed/simple;
	bh=Wy7PeXvS2DkMCINbXnH9uYYNn5l3PC7queX0oiopSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLySipSGB1OsqJAHBXV19BgTezKgzjmyMN+kQONJSnXNjR9zYVAt/PRkUZW4371QTG5KSLSuSlnBVE61+HWerifzpU2qqw9SAosYalKHWUz94dG3ik9/wrPliyKeodeWJK+fEb+tj+Ud2cTUpIrZxTtzKOX7m24q0R/EiTndCZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C60339;
	Tue, 20 Aug 2024 00:17:06 -0700 (PDT)
Received: from [10.163.86.112] (unknown [10.163.86.112])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE643F73B;
	Tue, 20 Aug 2024 00:16:29 -0700 (PDT)
Message-ID: <c2ca1845-7eec-4119-b7b6-f6694e4a7799@arm.com>
Date: Tue, 20 Aug 2024 12:46:22 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
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
 <391d4f4f-e642-4c11-a36b-190874963f8a@arm.com>
 <c40de4d7-e37e-4d2f-bd7a-a2a5497a2419@arm.com>
 <87a5h9hud7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <87a5h9hud7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/19/24 12:28, Huang, Ying wrote:
> Dev Jain <dev.jain@arm.com> writes:
>
>> On 8/13/24 12:52, Dev Jain wrote:
>>> On 8/13/24 10:30, Dev Jain wrote:
>>>> On 8/12/24 17:38, Dev Jain wrote:
>>>>> On 8/12/24 13:01, Huang, Ying wrote:
>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>
>>>>>>> On 8/12/24 11:45, Huang, Ying wrote:
>>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>>
>>>>>>>>> On 8/12/24 11:04, Huang, Ying wrote:
>>>>>>>>>> Hi, Dev,
>>>>>>>>>>
>>>>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>>>>
>>>>>>>>>>> As already being done in __migrate_folio(), wherein we
>>>>>>>>>>> backoff if the
>>>>>>>>>>> folio refcount is wrong, make this check during the
>>>>>>>>>>> unmapping phase, upon
>>>>>>>>>>> the failure of which, the original state of the PTEs will be
>>>>>>>>>>> restored and
>>>>>>>>>>> the folio lock will be dropped via migrate_folio_undo_src(),
>>>>>>>>>>> any racing
>>>>>>>>>>> thread will make progress and migration will be retried.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      mm/migrate.c | 9 +++++++++
>>>>>>>>>>>      1 file changed, 9 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>>> @@ -1250,6 +1250,15 @@ static int
>>>>>>>>>>> migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>>>>          }
>>>>>>>>>>>            if (!folio_mapped(src)) {
>>>>>>>>>>> +        /*
>>>>>>>>>>> +         * Someone may have changed the refcount and maybe
>>>>>>>>>>> sleeping
>>>>>>>>>>> +         * on the folio lock. In case of refcount mismatch,
>>>>>>>>>>> bail out,
>>>>>>>>>>> +         * let the system make progress and retry.
>>>>>>>>>>> +         */
>>>>>>>>>>> +        struct address_space *mapping = folio_mapping(src);
>>>>>>>>>>> +
>>>>>>>>>>> +        if (folio_ref_count(src) !=
>>>>>>>>>>> folio_expected_refs(mapping, src))
>>>>>>>>>>> +            goto out;
>>>>>>>>>>>              __migrate_folio_record(dst, old_page_state,
>>>>>>>>>>> anon_vma);
>>>>>>>>>>>              return MIGRATEPAGE_UNMAP;
>>>>>>>>>>>          }
>>>>>>>>>> Do you have some test results for this?  For example, after
>>>>>>>>>> applying the
>>>>>>>>>> patch, the migration success rate increased XX%, etc.
>>>>>>>>> I'll get back to you on this.
>>>>>>>>>
>>>>>>>>>> My understanding for this issue is that the migration success
>>>>>>>>>> rate can
>>>>>>>>>> increase if we undo all changes before retrying. This is the
>>>>>>>>>> current
>>>>>>>>>> behavior for sync migration, but not for async migration.  If
>>>>>>>>>> so, we can
>>>>>>>>>> use migrate_pages_sync() for async migration too to increase
>>>>>>>>>> success
>>>>>>>>>> rate?  Of course, we need to change the function name and
>>>>>>>>>> comments.
>>>>>>>>> As per my understanding, this is not the current behaviour for sync
>>>>>>>>> migration. After successful unmapping, we fail in
>>>>>>>>> migrate_folio_move()
>>>>>>>>> with -EAGAIN, we do not call undo src+dst (rendering the loop
>>>>>>>>> around
>>>>>>>>> migrate_folio_move() futile), we do not push the failed folio
>>>>>>>>> onto the
>>>>>>>>> ret_folios list, therefore, in _sync(), _batch() is never
>>>>>>>>> tried again.
>>>>>>>> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
>>>>>>>> called first, if failed, the folio will be restored to the original
>>>>>>>> state (unlocked).  Then migrate_pages_batch(,_SYNC*) is called
>>>>>>>> again.
>>>>>>>> So, we unlock once.  If it's necessary, we can unlock more times via
>>>>>>>> another level of loop.
>>>>>>> Yes, that's my point. We need to undo src+dst and retry.
>>>>>> For sync migration, we undo src+dst and retry now, but only once.  You
>>>>>> have shown that more retrying increases success rate.
>>>>>>
>>>>>>> We will have
>>>>>>> to decide where we want this retrying to be; do we want to change the
>>>>>>> return value, end up in the while loop wrapped around _sync(),
>>>>>>> and retry
>>>>>>> there by adding another level of loop, or do we want to make use
>>>>>>> of the
>>>>>>> existing retry loops, one of which is wrapped around _unmap();
>>>>>>> the latter
>>>>>>> is my approach. The utility I see for the former approach is
>>>>>>> that, in case
>>>>>>> of a large number of page migrations (which should usually be
>>>>>>> the case),
>>>>>>> we are giving more time for the folio to get retried. The latter
>>>>>>> does not
>>>>>>> give much time and discards the folio if it did not succeed
>>>>>>> under 7 times.
>>>>>> Because it's a race, I guess that most folios will be migrated
>>>>>> successfully in the first pass.
>>>>>>
>>>>>> My concerns of your method are that it deal with just one case
>>>>>> specially.  While retrying after undoing all appears more general.
>>>>>
>>>>> Makes sense. Also, please ignore my "change the return value"
>>>>> thing, I got confused between unmap_folios, ret_folios, etc.
>>>>> Now I think I understood what the lists are doing :)
>>>>>
>>>>>> If it's really important to retry after undoing all, we can either
>>>>>> convert two retying loops of migrate_pages_batch() into one loop, or
>>>>>> remove retry loop in migrate_pages_batch() and retry in its caller
>>>>>> instead.
>>>>> And if I implemented this correctly, the following makes the test
>>>>> pass always:
>>>>> https://www.codedump.xyz/diff/Zrn7EdxzNXmXyNXe
>>>>
>>>> Okay, I did mess up with the implementation, leading to a false
>>>> positive. Let me try again :)
>>>
>>> Hopefully this should do the job:
>>> https://www.codedump.xyz/diff/ZrsIV8JSOPYx5V_u
>>>
>>> But the result is worse than the patch proposed; I rarely hit
>>> a 3 digit number of successes of move_pages(). But, on a
>>> base kernel without any changes, when I apply David's
>>> suggestion to change the test, if I choose 7 as the number
>>> of retries (= NR_MAX_MIGRATE_SYNC_RETRY) in the test, I
>>> can touch even 4 digits. I am puzzled.
>>> We can also try merging the for loops of unmap and move...
>>
>> If people are okay with this change, I guess I can send it as
>> a v2? I concur with your assessment that my initial approach
>> is solving a specific case; the above approach does give me
>> a slight improvement on arm64 and should be an improvement
>> in general, since it makes sense to defer retrying the failed folio
>> as much as we can.
> We need to deal with something else before a formal v2,
>
> - stats need to be fixed, please check result processing for the first
>    loop of migrate_pages_sync().

Sorry, can you point out where do they need to be fixed exactly?
The change I did is inside the while(!list_empty(from)) block,
and there is no stat computation being done there already.

>
> - Do we need something similar for async migration.
>
> - Can we add another level of explicit loop for the second loop of
>    migrate_pages_sync()?  That is to improve code readability.  Or, add a
>    function to dot that?
>
> - Is it good to remove retry loop in migrate_pages_batch()?  And do
>    retry in the caller?

I am personally in favour of leaving the retry loop, and async
migration, as it is. Since async version is basically minimal-effort
migration, it won't make sense to "optimize" it, given the code churn
it would create, including the change we will have to then do in
"if (mode == MIGRATE_ASYNC) => migrate_pages_batch(ASYNC)" inside
migrate_pages().

Sorry, what do you mean by "another level of explicit loop"?

>
> --
> Best Regards,
> Huang, Ying

