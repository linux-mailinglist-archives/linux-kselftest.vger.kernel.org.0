Return-Path: <linux-kselftest+bounces-15620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CFA95640D
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239341C2107B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30E14A0B9;
	Mon, 19 Aug 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv8ahGcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAED1B960;
	Mon, 19 Aug 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724050916; cv=none; b=RPR/w7tFT2FbMdY3uwqc15aYNeDHg98aL+k4GRCO+DhpN2YRLxCjTLU13gPfPQbN8FXknVRDWh/LXS7gePQWjDz7WRN4JVwwwCWFjAVBo/0KK4Oe95wAWyGwjt16VmSfSsitFqMJUj96tTMtY2Oyypv8h3yS6QMs3EDipz9vHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724050916; c=relaxed/simple;
	bh=XPKIKSGQsM7DCWaQ6/c8d7hDW2E6Ywe4ScSLyzkJIRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g7MxyluS8/xM4NH/jgFNE9ETKaXF48M3sNof0zj824L3gmELwOSevUxCgJ/3PNRSRCIPM6Vsp7crchpSlS18IXMQ61YQjgZGe4fj+NFZ4dSg8onhXWpqSmKsjsnCjjYpPdtltWbY7m9iZvCAKaRjfc5xE8DEld0ANxKNsTdXSN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv8ahGcT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724050915; x=1755586915;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=XPKIKSGQsM7DCWaQ6/c8d7hDW2E6Ywe4ScSLyzkJIRQ=;
  b=Mv8ahGcTjCxT+K1QDbrrdAAmhuL9y5ysd9WTXY41J8fT66CtxKyrNOfk
   XAWueklBvd6aLnQzyeAorChbliZg9PnEBcsIT1Qy+qv6v/NOB1NFGw3Lz
   UVnzWlEhlZSPKLioXro1t5DFCvycYgO20vqjv1tGP2wXkaGEs50xYpOQC
   f4KRyBlUlWYAdNsRpy2H+cNFbKa/P5aJM6lUk3MEg+sCV5rQM1WaJdBou
   5FqxlJOKCZnOdlZaOuuGJQHZXTxeP4ZFGIabAx+5YffWJd5mGeeSGK9m+
   PaJ26beOexM5/WBuUG2FMDJ4VcGULNjjt+/+GZwdIRLkrcsxkFgeNsEG+
   w==;
X-CSE-ConnectionGUID: 1r9yzzphRpCF6eqm1Z8p8A==
X-CSE-MsgGUID: v8C8p6aMR2u5BEzADwmMiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="13086575"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="13086575"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:01:53 -0700
X-CSE-ConnectionGUID: tHEUm6KNSp2I7a5pXWBpVg==
X-CSE-MsgGUID: tfrMnVkBRP2vSuupBojeYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60844933"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:01:45 -0700
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
In-Reply-To: <c40de4d7-e37e-4d2f-bd7a-a2a5497a2419@arm.com> (Dev Jain's
	message of "Fri, 16 Aug 2024 17:01:58 +0530")
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
Date: Mon, 19 Aug 2024 14:58:12 +0800
Message-ID: <87a5h9hud7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dev Jain <dev.jain@arm.com> writes:

> On 8/13/24 12:52, Dev Jain wrote:
>>
>> On 8/13/24 10:30, Dev Jain wrote:
>>>
>>> On 8/12/24 17:38, Dev Jain wrote:
>>>>
>>>> On 8/12/24 13:01, Huang, Ying wrote:
>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>
>>>>>> On 8/12/24 11:45, Huang, Ying wrote:
>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>
>>>>>>>> On 8/12/24 11:04, Huang, Ying wrote:
>>>>>>>>> Hi, Dev,
>>>>>>>>>
>>>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>>>
>>>>>>>>>> As already being done in __migrate_folio(), wherein we
>>>>>>>>>> backoff if the
>>>>>>>>>> folio refcount is wrong, make this check during the
>>>>>>>>>> unmapping phase, upon
>>>>>>>>>> the failure of which, the original state of the PTEs will be
>>>>>>>>>> restored and
>>>>>>>>>> the folio lock will be dropped via migrate_folio_undo_src(),
>>>>>>>>>> any racing
>>>>>>>>>> thread will make progress and migration will be retried.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>> ---
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 mm/migrate.c | 9 +++++++++
>>>>>>>>>> =C2=A0=C2=A0=C2=A0 1 file changed, 9 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>> @@ -1250,6 +1250,15 @@ static int
>>>>>>>>>> migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!foli=
o_mapped(src)) {
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Someone may =
have changed the refcount and maybe
>>>>>>>>>> sleeping
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on the folio=
 lock. In case of refcount mismatch,
>>>>>>>>>> bail out,
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * let the syst=
em make progress and retry.
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_space=
 *mapping =3D folio_mapping(src);
>>>>>>>>>> +
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio_ref_count(=
src) !=3D
>>>>>>>>>> folio_expected_refs(mapping, src))
>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 __migrate_folio_record(dst, old_page_state,
>>>>>>>>>> anon_vma);
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return MIGRATEPAGE_UNMAP;
>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>> Do you have some test results for this?=C2=A0 For example, after
>>>>>>>>> applying the
>>>>>>>>> patch, the migration success rate increased XX%, etc.
>>>>>>>> I'll get back to you on this.
>>>>>>>>
>>>>>>>>> My understanding for this issue is that the migration success
>>>>>>>>> rate can
>>>>>>>>> increase if we undo all changes before retrying. This is the
>>>>>>>>> current
>>>>>>>>> behavior for sync migration, but not for async migration.=C2=A0 If
>>>>>>>>> so, we can
>>>>>>>>> use migrate_pages_sync() for async migration too to increase
>>>>>>>>> success
>>>>>>>>> rate?=C2=A0 Of course, we need to change the function name and
>>>>>>>>> comments.
>>>>>>>> As per my understanding, this is not the current behaviour for sync
>>>>>>>> migration. After successful unmapping, we fail in
>>>>>>>> migrate_folio_move()
>>>>>>>> with -EAGAIN, we do not call undo src+dst (rendering the loop
>>>>>>>> around
>>>>>>>> migrate_folio_move() futile), we do not push the failed folio
>>>>>>>> onto the
>>>>>>>> ret_folios list, therefore, in _sync(), _batch() is never
>>>>>>>> tried again.
>>>>>>> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will be
>>>>>>> called first, if failed, the folio will be restored to the original
>>>>>>> state (unlocked).=C2=A0 Then migrate_pages_batch(,_SYNC*) is called
>>>>>>> again.
>>>>>>> So, we unlock once.=C2=A0 If it's necessary, we can unlock more tim=
es via
>>>>>>> another level of loop.
>>>>>> Yes, that's my point. We need to undo src+dst and retry.
>>>>> For sync migration, we undo src+dst and retry now, but only once.=C2=
=A0 You
>>>>> have shown that more retrying increases success rate.
>>>>>
>>>>>> We will have
>>>>>> to decide where we want this retrying to be; do we want to change the
>>>>>> return value, end up in the while loop wrapped around _sync(),
>>>>>> and retry
>>>>>> there by adding another level of loop, or do we want to make use
>>>>>> of the
>>>>>> existing retry loops, one of which is wrapped around _unmap();
>>>>>> the latter
>>>>>> is my approach. The utility I see for the former approach is
>>>>>> that, in case
>>>>>> of a large number of page migrations (which should usually be
>>>>>> the case),
>>>>>> we are giving more time for the folio to get retried. The latter
>>>>>> does not
>>>>>> give much time and discards the folio if it did not succeed
>>>>>> under 7 times.
>>>>> Because it's a race, I guess that most folios will be migrated
>>>>> successfully in the first pass.
>>>>>
>>>>> My concerns of your method are that it deal with just one case
>>>>> specially.=C2=A0 While retrying after undoing all appears more genera=
l.
>>>>
>>>>
>>>> Makes sense. Also, please ignore my "change the return value"
>>>> thing, I got confused between unmap_folios, ret_folios, etc.
>>>> Now I think I understood what the lists are doing :)
>>>>
>>>>>
>>>>> If it's really important to retry after undoing all, we can either
>>>>> convert two retying loops of migrate_pages_batch() into one loop, or
>>>>> remove retry loop in migrate_pages_batch() and retry in its caller
>>>>> instead.
>>>>
>>>> And if I implemented this correctly, the following makes the test
>>>> pass always:
>>>> https://www.codedump.xyz/diff/Zrn7EdxzNXmXyNXe
>>>
>>>
>>> Okay, I did mess up with the implementation, leading to a false
>>> positive. Let me try again :)
>>
>>
>> Hopefully this should do the job:
>> https://www.codedump.xyz/diff/ZrsIV8JSOPYx5V_u
>>
>> But the result is worse than the patch proposed; I rarely hit
>> a 3 digit number of successes of move_pages(). But, on a
>> base kernel without any changes, when I apply David's
>> suggestion to change the test, if I choose 7 as the number
>> of retries (=3D NR_MAX_MIGRATE_SYNC_RETRY) in the test, I
>> can touch even 4 digits. I am puzzled.
>> We can also try merging the for loops of unmap and move...
>
>
> If people are okay with this change, I guess I can send it as
> a v2? I concur with your assessment that my initial approach
> is solving a specific case; the above approach does give me
> a slight improvement on arm64 and should be an improvement
> in general, since it makes sense to defer retrying the failed folio
> as much as we can.

We need to deal with something else before a formal v2,

- stats need to be fixed, please check result processing for the first
  loop of migrate_pages_sync().

- Do we need something similar for async migration.

- Can we add another level of explicit loop for the second loop of
  migrate_pages_sync()?  That is to improve code readability.  Or, add a
  function to dot that?

- Is it good to remove retry loop in migrate_pages_batch()?  And do
  retry in the caller?

--
Best Regards,
Huang, Ying

