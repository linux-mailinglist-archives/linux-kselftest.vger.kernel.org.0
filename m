Return-Path: <linux-kselftest+bounces-15143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F8A94E67B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DE21F2136C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26214E2C1;
	Mon, 12 Aug 2024 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RR6g6q5l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E65196;
	Mon, 12 Aug 2024 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443573; cv=none; b=lvRy8fBGecfBCFtzlOLxemGajr2hM6ZlmjcDd5ckFOmVz8p4BNJe0fzBCg1JseO2ZrnXagnWvH2wt0SggDUpGgKMoV0oPlNvzpIv7UECmN+zgafr+29dXrKjs0xa5qPZ9kfyD3ZNbarVQe+Y3zz0u16z4QED7nZnh956lhd3/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443573; c=relaxed/simple;
	bh=upPcG7x+Ow0LLe8ZkMqMsAdNeXtuQTLEUkwMBpfkz/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+Us6jYVZy9kjeldTwkpOyQb57zVaEHXy4LR1+1ehlBLjGYAMwfA79ud6+P32NSyAZY5gtUop1llcxS1BylbdahxcUGQztiWyjazG98QogbMATYny21fLicpDKof5ABukBd59v9EIFDyG2dik6L73PxMLL+wDK9Emz2+qLXkxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RR6g6q5l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723443572; x=1754979572;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=upPcG7x+Ow0LLe8ZkMqMsAdNeXtuQTLEUkwMBpfkz/k=;
  b=RR6g6q5lagu6tox4achoDA8eGUn9+BJUxfQ+/KypF9LTGCZ5Fplb34P2
   2fFZ365MB1bF0rJd7r0LK0V/J5muiGAveNv0i+uVoG38d1pVXRdkVkdfG
   GDEQxg8vICC5LMTc1C1c0UIUpAK622nQ6nhbG4oWaCKkk6iobOx1x4ic3
   ohhqXJuIjBDZB+Zw1D1wYv0syRazq1GQ1Wpf3B7k0Di99K8c3tFPxVDvJ
   uG9SiZubDi+xgS2Cfgr+tHGudgGWxBN/Fj9p9geScva71nYhOPN2aCAP+
   NdzX3lw5Wh0dnhzHpiVEUW50MxTHPQdNnyYXLEE+NokX55fdKDkMS8zid
   Q==;
X-CSE-ConnectionGUID: TKvTeeBdQ8+XF7RT49sn6g==
X-CSE-MsgGUID: t+1miN/vQIq/kOlHKgkOag==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21664563"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21664563"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:19:30 -0700
X-CSE-ConnectionGUID: AC5fCf66Sdu4WnmmH4vGsw==
X-CSE-MsgGUID: ztVQmoM7TGe+GOWf4XCOBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="95665801"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 23:19:22 -0700
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
In-Reply-To: <15dbe4ac-a036-4029-ba08-e12a236f448a@arm.com> (Dev Jain's
	message of "Mon, 12 Aug 2024 11:31:29 +0530")
References: <20240809103129.365029-1-dev.jain@arm.com>
	<20240809103129.365029-2-dev.jain@arm.com>
	<87frrauwwv.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<15dbe4ac-a036-4029-ba08-e12a236f448a@arm.com>
Date: Mon, 12 Aug 2024 14:15:49 +0800
Message-ID: <87bk1yuuzu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dev Jain <dev.jain@arm.com> writes:

> On 8/12/24 11:04, Huang, Ying wrote:
>> Hi, Dev,
>>
>> Dev Jain <dev.jain@arm.com> writes:
>>
>>> As already being done in __migrate_folio(), wherein we backoff if the
>>> folio refcount is wrong, make this check during the unmapping phase, upon
>>> the failure of which, the original state of the PTEs will be restored and
>>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>>> thread will make progress and migration will be retried.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   mm/migrate.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index e7296c0fb5d5..477acf996951 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>   	}
>>>     	if (!folio_mapped(src)) {
>>> +		/*
>>> +		 * Someone may have changed the refcount and maybe sleeping
>>> +		 * on the folio lock. In case of refcount mismatch, bail out,
>>> +		 * let the system make progress and retry.
>>> +		 */
>>> +		struct address_space *mapping = folio_mapping(src);
>>> +
>>> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>>> +			goto out;
>>>   		__migrate_folio_record(dst, old_page_state, anon_vma);
>>>   		return MIGRATEPAGE_UNMAP;
>>>   	}
>> Do you have some test results for this?  For example, after applying the
>> patch, the migration success rate increased XX%, etc.
>
> I'll get back to you on this.
>
>>
>> My understanding for this issue is that the migration success rate can
>> increase if we undo all changes before retrying.  This is the current
>> behavior for sync migration, but not for async migration.  If so, we can
>> use migrate_pages_sync() for async migration too to increase success
>> rate?  Of course, we need to change the function name and comments.
>
>
> As per my understanding, this is not the current behaviour for sync
> migration. After successful unmapping, we fail in migrate_folio_move()
> with -EAGAIN, we do not call undo src+dst (rendering the loop around
> migrate_folio_move() futile), we do not push the failed folio onto the
> ret_folios list, therefore, in _sync(), _batch() is never tried again.

In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
called first, if failed, the folio will be restored to the original
state (unlocked).  Then migrate_pages_batch(,_SYNC*) is called again.
So, we unlock once.  If it's necessary, we can unlock more times via
another level of loop.

--
Best Regards,
Huang, Ying

