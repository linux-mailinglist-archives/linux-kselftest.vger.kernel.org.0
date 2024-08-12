Return-Path: <linux-kselftest+bounces-15147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00894E72D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A781F20FB2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D0814F9E1;
	Mon, 12 Aug 2024 06:52:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109314E2C5;
	Mon, 12 Aug 2024 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445537; cv=none; b=jJwLEAn6wKmhU3g4SvlnHmOdafZfo3ypx+SZi6iLYkYtkGKc4ElxXuIDF0txqxn1HwlpEcn9gYdZhCfg3GBS2KepQ5ty0GRxMfNAMUThBOPhTZnTZ/ZZ8UEb5MEtCXWvLwTfdc8kVbSzQJ1tuslMstsITQiGUteadUqbTiDYOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445537; c=relaxed/simple;
	bh=YBCMrMAPOMjFTUWwn6wPLBEDF03Y/0b6KU/3UWiGgHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2TU5voysxd5hSCcqXuqpcrRT9G3lczDb8LkRbF6cJ/iaH5wdf2meZUxSxBllS9f0zPBWVIqi1/Sz0C0zIOLkQfQtWL6A778Y28PnpvdYJxzvoBw7ZpEAjcGYtwsYlVTy/aQCXremkMQCC59tT6XefN3Fy9pLYAa1PZCiG1emp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CFEFEC;
	Sun, 11 Aug 2024 23:52:39 -0700 (PDT)
Received: from [10.162.43.141] (e116581.arm.com [10.162.43.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDDEF3F6A8;
	Sun, 11 Aug 2024 23:52:04 -0700 (PDT)
Message-ID: <95b72817-5444-4ced-998a-1cb90f42bf49@arm.com>
Date: Mon, 12 Aug 2024 12:22:01 +0530
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
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <87bk1yuuzu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/24 11:45, Huang, Ying wrote:
> Dev Jain <dev.jain@arm.com> writes:
>
>> On 8/12/24 11:04, Huang, Ying wrote:
>>> Hi, Dev,
>>>
>>> Dev Jain <dev.jain@arm.com> writes:
>>>
>>>> As already being done in __migrate_folio(), wherein we backoff if the
>>>> folio refcount is wrong, make this check during the unmapping phase, upon
>>>> the failure of which, the original state of the PTEs will be restored and
>>>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>>>> thread will make progress and migration will be retried.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    mm/migrate.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>> index e7296c0fb5d5..477acf996951 100644
>>>> --- a/mm/migrate.c
>>>> +++ b/mm/migrate.c
>>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>    	}
>>>>      	if (!folio_mapped(src)) {
>>>> +		/*
>>>> +		 * Someone may have changed the refcount and maybe sleeping
>>>> +		 * on the folio lock. In case of refcount mismatch, bail out,
>>>> +		 * let the system make progress and retry.
>>>> +		 */
>>>> +		struct address_space *mapping = folio_mapping(src);
>>>> +
>>>> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>>>> +			goto out;
>>>>    		__migrate_folio_record(dst, old_page_state, anon_vma);
>>>>    		return MIGRATEPAGE_UNMAP;
>>>>    	}
>>> Do you have some test results for this?  For example, after applying the
>>> patch, the migration success rate increased XX%, etc.
>> I'll get back to you on this.
>>
>>> My understanding for this issue is that the migration success rate can
>>> increase if we undo all changes before retrying.  This is the current
>>> behavior for sync migration, but not for async migration.  If so, we can
>>> use migrate_pages_sync() for async migration too to increase success
>>> rate?  Of course, we need to change the function name and comments.
>>
>> As per my understanding, this is not the current behaviour for sync
>> migration. After successful unmapping, we fail in migrate_folio_move()
>> with -EAGAIN, we do not call undo src+dst (rendering the loop around
>> migrate_folio_move() futile), we do not push the failed folio onto the
>> ret_folios list, therefore, in _sync(), _batch() is never tried again.
> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
> called first, if failed, the folio will be restored to the original
> state (unlocked).  Then migrate_pages_batch(,_SYNC*) is called again.
> So, we unlock once.  If it's necessary, we can unlock more times via
> another level of loop.

Yes, that's my point. We need to undo src+dst and retry. We will have
to decide where we want this retrying to be; do we want to change the
return value, end up in the while loop wrapped around _sync(), and retry
there by adding another level of loop, or do we want to make use of the
existing retry loops, one of which is wrapped around _unmap(); the latter
is my approach. The utility I see for the former approach is that, in case
of a large number of page migrations (which should usually be the case),
we are giving more time for the folio to get retried. The latter does not
give much time and discards the folio if it did not succeed under 7 times.

>
> --
> Best Regards,
> Huang, Ying

