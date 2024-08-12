Return-Path: <linux-kselftest+bounces-15149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77294E7E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA3C1C2162B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3AF158528;
	Mon, 12 Aug 2024 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVHo6GYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06C154C02;
	Mon, 12 Aug 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448114; cv=none; b=aGf3rkQlQyZvA9dNRknUFdw7q/Ba6pVLaAt2keX6tZcodBzPP9JX2+SupbMUe4XYf6Nu5TVS6W0stmMTl7gHv1B8uLnn7o1hM9PxAnd52baYKbeu0oWz3ujsXCUB+ozNq0p3Ujuc0flxL0C15Z3B43VzxPTmtzhwRnxgxwNU+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448114; c=relaxed/simple;
	bh=R3GVRoCsoHiXT0jKKOY18aLaysxVuUJwZl1VJQs3OcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DIe5oLXYRHQ0maMNg5nPOR/A698eVIgKd4nr+7hmq7MAmbe7amz3q2t1X77l1U+2CsqjP4HhZvVJ71c5H4VA+AS1vncpPBGa5681S+54yd8SrUP0/itV765tmEQMlJ0E09+wZ0L0hfMk48MWuhk9a+tgXlEKkpNsBU64/9UNn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVHo6GYm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723448113; x=1754984113;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=R3GVRoCsoHiXT0jKKOY18aLaysxVuUJwZl1VJQs3OcA=;
  b=AVHo6GYmFBSNdoCGD7a+XKlWc0zpjZV9URk7wwZQY8Lp47pJGP4kpAnl
   tXmoZ0fkrM8dyI6Bv6UQpO6+UhAxsuzQuKhLcaPca495fC2LYt25G1m2x
   wJRGxMaTdc62ebJrj7nSWWDzyQy0eC7/jDYsWXlvtl74ppqfsVyl63PrE
   0Zwke2SAg2I00ieFCvIeDPvMbec3w5ocdb57VavFgbyRGF661gjIEy9nF
   oDmT4LXMa/UAA6ndYaA4weDr6RTiEfFkV0SDMO54Rq7GBoEy1bHjZv8al
   zrfI2zyzEJHhdD7JiA/dZANicybA5tjbZFSxI4sDmtl+jV4e1pQ7AGKCb
   w==;
X-CSE-ConnectionGUID: +6LfrzB5Q2a0aCdXUxX0XQ==
X-CSE-MsgGUID: 8B7dB4hzQdOBuVzITNa30g==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="25408925"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="25408925"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:35:12 -0700
X-CSE-ConnectionGUID: 4VnSE5dyQ6GuS3L+L1HwsA==
X-CSE-MsgGUID: 9WXqtFFWQtyJ088YmVDxpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="57830132"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 00:35:06 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dev Jain <dev.jain@arm.com>
Cc: <akpm@linux-foundation.org>,  <shuah@kernel.org>,  <david@redhat.com>,
  <willy@infradead.org>,  <ryan.roberts@arm.com>,
  <anshuman.khandual@arm.com>,  <catalin.marinas@arm.com>,
  <cl@gentwo.org>,  <vbabka@suse.cz>,  <mhocko@suse.com>,
  <apopple@nvidia.com>,  <osalvador@suse.de>,
  <baolin.wang@linux.alibaba.com>,  <dave.hansen@linux.intel.com>,
  <will@kernel.org>,  <baohua@kernel.org>,  <ioworker0@gmail.com>,
  <gshan@redhat.com>,  <mark.rutland@arm.com>,
  <kirill.shutemov@linux.intel.com>,  <hughd@google.com>,
  <aneesh.kumar@kernel.org>,  <yang@os.amperecomputing.com>,
  <peterx@redhat.com>,  <broonie@kernel.org>,
  <mgorman@techsingularity.net>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
In-Reply-To: <95b72817-5444-4ced-998a-1cb90f42bf49@arm.com> (Dev Jain's
	message of "Mon, 12 Aug 2024 12:22:01 +0530")
References: <20240809103129.365029-1-dev.jain@arm.com>
	<20240809103129.365029-2-dev.jain@arm.com>
	<87frrauwwv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<15dbe4ac-a036-4029-ba08-e12a236f448a@arm.com>
	<87bk1yuuzu.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<95b72817-5444-4ced-998a-1cb90f42bf49@arm.com>
Date: Mon, 12 Aug 2024 15:31:33 +0800
Message-ID: <8734naurhm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dev Jain <dev.jain@arm.com> writes:

> On 8/12/24 11:45, Huang, Ying wrote:
>> Dev Jain <dev.jain@arm.com> writes:
>>
>>> On 8/12/24 11:04, Huang, Ying wrote:
>>>> Hi, Dev,
>>>>
>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>
>>>>> As already being done in __migrate_folio(), wherein we backoff if the
>>>>> folio refcount is wrong, make this check during the unmapping phase, upon
>>>>> the failure of which, the original state of the PTEs will be restored and
>>>>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>>>>> thread will make progress and migration will be retried.
>>>>>
>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>> ---
>>>>>    mm/migrate.c | 9 +++++++++
>>>>>    1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>> --- a/mm/migrate.c
>>>>> +++ b/mm/migrate.c
>>>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>    	}
>>>>>      	if (!folio_mapped(src)) {
>>>>> +		/*
>>>>> +		 * Someone may have changed the refcount and maybe sleeping
>>>>> +		 * on the folio lock. In case of refcount mismatch, bail out,
>>>>> +		 * let the system make progress and retry.
>>>>> +		 */
>>>>> +		struct address_space *mapping = folio_mapping(src);
>>>>> +
>>>>> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>>>>> +			goto out;
>>>>>    		__migrate_folio_record(dst, old_page_state, anon_vma);
>>>>>    		return MIGRATEPAGE_UNMAP;
>>>>>    	}
>>>> Do you have some test results for this?  For example, after applying the
>>>> patch, the migration success rate increased XX%, etc.
>>> I'll get back to you on this.
>>>
>>>> My understanding for this issue is that the migration success rate can
>>>> increase if we undo all changes before retrying.  This is the current
>>>> behavior for sync migration, but not for async migration.  If so, we can
>>>> use migrate_pages_sync() for async migration too to increase success
>>>> rate?  Of course, we need to change the function name and comments.
>>>
>>> As per my understanding, this is not the current behaviour for sync
>>> migration. After successful unmapping, we fail in migrate_folio_move()
>>> with -EAGAIN, we do not call undo src+dst (rendering the loop around
>>> migrate_folio_move() futile), we do not push the failed folio onto the
>>> ret_folios list, therefore, in _sync(), _batch() is never tried again.
>> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
>> called first, if failed, the folio will be restored to the original
>> state (unlocked).  Then migrate_pages_batch(,_SYNC*) is called again.
>> So, we unlock once.  If it's necessary, we can unlock more times via
>> another level of loop.
>
> Yes, that's my point. We need to undo src+dst and retry.

For sync migration, we undo src+dst and retry now, but only once.  You
have shown that more retrying increases success rate.

> We will have
> to decide where we want this retrying to be; do we want to change the
> return value, end up in the while loop wrapped around _sync(), and retry
> there by adding another level of loop, or do we want to make use of the
> existing retry loops, one of which is wrapped around _unmap(); the latter
> is my approach. The utility I see for the former approach is that, in case
> of a large number of page migrations (which should usually be the case),
> we are giving more time for the folio to get retried. The latter does not
> give much time and discards the folio if it did not succeed under 7 times.

Because it's a race, I guess that most folios will be migrated
successfully in the first pass.

My concerns of your method are that it deal with just one case
specially.  While retrying after undoing all appears more general.

If it's really important to retry after undoing all, we can either
convert two retying loops of migrate_pages_batch() into one loop, or
remove retry loop in migrate_pages_batch() and retry in its caller
instead.

--
Best Regards,
Huang, Ying

