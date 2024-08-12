Return-Path: <linux-kselftest+bounces-15146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA094E6C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C981C21499
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF014F9C5;
	Mon, 12 Aug 2024 06:33:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243513BAEE;
	Mon, 12 Aug 2024 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444390; cv=none; b=Ya9i3hppPhAOKdVHCawMe6ORbCDCWGHxW4aZNy9HRif42CLm/Ku1T5AcJy4VRF6JsGiFJGZRcJLhGD+wGFpn2n2MPwPAcvjVUnIxhigfjStcXVyS8NQ3kEHaV920FWPoRmfBL+hIA4WK2bZ6D6LJWstNhP02lqw7uDPNNMeAwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444390; c=relaxed/simple;
	bh=VM2opmt6NPAPqN8bMcKi/ZF3TKtMFq3bhhKzow0dnDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZlFwAzh1P6RwKQBR/+r8/1hATYIE9XsLFEhkOPzHE1nrlpyIViw+T1QCZyjZuK8zhb8CBWfsUQIoHlAXQEQ/r8HbRAqGBlfJBscKbIY/p+xrY9b9ia2lVKB7w7ATDn3rnEXDHPPhQWDCzVoFovO0slCl4j383ww9g8dD/oqvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5D4EFEC;
	Sun, 11 Aug 2024 23:33:33 -0700 (PDT)
Received: from [10.162.43.141] (e116581.arm.com [10.162.43.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A59D33F73B;
	Sun, 11 Aug 2024 23:32:58 -0700 (PDT)
Message-ID: <fd15bf5d-25ec-46d6-aa80-865cf0c925a9@arm.com>
Date: Mon, 12 Aug 2024 12:02:55 +0530
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
 <cc1ababf-cda5-4eaf-9e67-47c26d5d70fe@arm.com>
 <877ccmuus2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <877ccmuus2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/24 11:50, Huang, Ying wrote:
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
>> Noting that the migration selftest is operating on a single page,
>> before the patch, the test fails on shared-anon mappings on an
>> average of 10 iterations of move_pages(), and after applying the
>> patch it fails on average of 100 iterations, which makes sense
>> because the unmapping() will get retried 3 + 7 = 10 times.
> Thanks!  What is the test results for
>
> https://lore.kernel.org/all/20240801081657.1386743-1-dev.jain@arm.com/
>
> ?

That solves the problem completely, makes the test pass. Although
that still may not be a good solution since it solves the problem
for this particular case (reader thread faulting and raising refcount).
As David notes, a concurrent read()/write() should also create this
refcount race problem.


>
>>> My understanding for this issue is that the migration success rate can
>>> increase if we undo all changes before retrying.  This is the current
>>> behavior for sync migration, but not for async migration.  If so, we can
>>> use migrate_pages_sync() for async migration too to increase success
>>> rate?  Of course, we need to change the function name and comments.
> --
> Best Regards,
> Huang, Ying
>

