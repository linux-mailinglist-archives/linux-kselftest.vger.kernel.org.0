Return-Path: <linux-kselftest+bounces-16923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60F967FA1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D81B1F21CA7
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 06:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330331547ED;
	Mon,  2 Sep 2024 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzyNckG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8401CD2B;
	Mon,  2 Sep 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259557; cv=none; b=rSa8qeU5HBWSge6UL9Yg8pHAdfMO2l3eO1qMRvZrwLqi+FRR44DoG/Pv9RZv5uT9aDGMZZCQ4jTHbO518bxP6jiYoOfat4HArY/8hPA/v9NSAdgww1DYQgTFkZ1q4SnUMpHuUfjmrPrzow2U7d8Lap09MdfvMgx1u+RrL6oOkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259557; c=relaxed/simple;
	bh=TgRjWdA3MYKllIz5983cGV1QafEL/tzJZ1c/6x8OR+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnrA5QrBceX7MRY6Cic8Fdn4GNhepLGqzHvIoHvDN0lb9ay2rdaLoPXlbK3yCSX+nNmt5aef5tRfMmtVvRoV64MkskNgrCvH77h/v3pDySkCRFizvJMMjNPzYnCkEBb/MGu+xYmjgwHSqFfXOqBB0eqe1TB85GUcYWxx/0UMJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzyNckG0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725259555; x=1756795555;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=TgRjWdA3MYKllIz5983cGV1QafEL/tzJZ1c/6x8OR+I=;
  b=lzyNckG0mIMFeG3uXmSfNNBR85Ttte/MlnkQn9apPKTJe3PYSC+Ld9Ax
   JEX7tNZRaMb9A/K+w741L68QeXyjl3axuuJPPHyJrerh/Mb/m0LYxuQem
   8ezi8Ev3mz19COU8JMURNdeEL9qn1Tyo07/96rEh452ic65fyED0IOEYd
   8qFzp0vFex4z+MU+ZyVBrWUXUT8wTW1JZYRh08dNC6/5JbqDh/PniamoB
   O1DL+tnFbNYLXLTUpC783mPLTP0nY9zpEghyb1C6oaYQnwALhFLmvvVPP
   Cu2l0WUSPor03K4shnHd1RNr9TNBptab6qdMpY2mhJnvJ7ibtv8ozKvaX
   Q==;
X-CSE-ConnectionGUID: j+2S9HPHQ9+THQFLflGwjw==
X-CSE-MsgGUID: 3PLFOLKFSuGnPbsXEkhLJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23400200"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23400200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:45:54 -0700
X-CSE-ConnectionGUID: KyWSBiSzS4OZqneZgNXqpQ==
X-CSE-MsgGUID: qcMJfwT1QhWwMNjP1Bk9EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="95318859"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 23:45:48 -0700
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
In-Reply-To: <c2ca1845-7eec-4119-b7b6-f6694e4a7799@arm.com> (Dev Jain's
	message of "Tue, 20 Aug 2024 12:46:22 +0530")
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
	<c2ca1845-7eec-4119-b7b6-f6694e4a7799@arm.com>
Date: Mon, 02 Sep 2024 14:42:15 +0800
Message-ID: <87mskqftfc.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8/19/24 12:28, Huang, Ying wrote:
>> Dev Jain <dev.jain@arm.com> writes:
>>
>>> On 8/13/24 12:52, Dev Jain wrote:
>>>> On 8/13/24 10:30, Dev Jain wrote:
>>>>> On 8/12/24 17:38, Dev Jain wrote:
>>>>>> On 8/12/24 13:01, Huang, Ying wrote:
>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>
>>>>>>>> On 8/12/24 11:45, Huang, Ying wrote:
>>>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>>>
>>>>>>>>>> On 8/12/24 11:04, Huang, Ying wrote:
>>>>>>>>>>> Hi, Dev,
>>>>>>>>>>>
>>>>>>>>>>> Dev Jain <dev.jain@arm.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> As already being done in __migrate_folio(), wherein we
>>>>>>>>>>>> backoff if the
>>>>>>>>>>>> folio refcount is wrong, make this check during the
>>>>>>>>>>>> unmapping phase, upon
>>>>>>>>>>>> the failure of which, the original state of the PTEs will be
>>>>>>>>>>>> restored and
>>>>>>>>>>>> the folio lock will be dropped via migrate_folio_undo_src(),
>>>>>>>>>>>> any racing
>>>>>>>>>>>> thread will make progress and migration will be retried.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0 mm/migrate.c | 9 +++++++++
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0 1 file changed, 9 insertions(+)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>>>>>>>>>>> index e7296c0fb5d5..477acf996951 100644
>>>>>>>>>>>> --- a/mm/migrate.c
>>>>>>>>>>>> +++ b/mm/migrate.c
>>>>>>>>>>>> @@ -1250,6 +1250,15 @@ static int
>>>>>>>>>>>> migrate_folio_unmap(new_folio_t get_new_folio,
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!f=
olio_mapped(src)) {
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Someone ma=
y have changed the refcount and maybe
>>>>>>>>>>>> sleeping
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * on the fol=
io lock. In case of refcount mismatch,
>>>>>>>>>>>> bail out,
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * let the sy=
stem make progress and retry.
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct address_spa=
ce *mapping =3D folio_mapping(src);
>>>>>>>>>>>> +
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (folio_ref_coun=
t(src) !=3D
>>>>>>>>>>>> folio_expected_refs(mapping, src))
>>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto out;
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 __migrate_folio_record(dst, old_page_state,
>>>>>>>>>>>> anon_vma);
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return MIGRATEPAGE_UNMAP;
>>>>>>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> Do you have some test results for this?=C2=A0 For example, after
>>>>>>>>>>> applying the
>>>>>>>>>>> patch, the migration success rate increased XX%, etc.
>>>>>>>>>> I'll get back to you on this.
>>>>>>>>>>
>>>>>>>>>>> My understanding for this issue is that the migration success
>>>>>>>>>>> rate can
>>>>>>>>>>> increase if we undo all changes before retrying. This is the
>>>>>>>>>>> current
>>>>>>>>>>> behavior for sync migration, but not for async migration.=C2=A0=
 If
>>>>>>>>>>> so, we can
>>>>>>>>>>> use migrate_pages_sync() for async migration too to increase
>>>>>>>>>>> success
>>>>>>>>>>> rate?=C2=A0 Of course, we need to change the function name and
>>>>>>>>>>> comments.
>>>>>>>>>> As per my understanding, this is not the current behaviour for s=
ync
>>>>>>>>>> migration. After successful unmapping, we fail in
>>>>>>>>>> migrate_folio_move()
>>>>>>>>>> with -EAGAIN, we do not call undo src+dst (rendering the loop
>>>>>>>>>> around
>>>>>>>>>> migrate_folio_move() futile), we do not push the failed folio
>>>>>>>>>> onto the
>>>>>>>>>> ret_folios list, therefore, in _sync(), _batch() is never
>>>>>>>>>> tried again.
>>>>>>>>> In migrate_pages_sync(), migrate_pages_batch(,MIGRATE_ASYNC) will=
 be
>>>>>>>>> called first, if failed, the folio will be restored to the origin=
al
>>>>>>>>> state (unlocked).=C2=A0 Then migrate_pages_batch(,_SYNC*) is call=
ed
>>>>>>>>> again.
>>>>>>>>> So, we unlock once.=C2=A0 If it's necessary, we can unlock more t=
imes via
>>>>>>>>> another level of loop.
>>>>>>>> Yes, that's my point. We need to undo src+dst and retry.
>>>>>>> For sync migration, we undo src+dst and retry now, but only once.=
=C2=A0 You
>>>>>>> have shown that more retrying increases success rate.
>>>>>>>
>>>>>>>> We will have
>>>>>>>> to decide where we want this retrying to be; do we want to change =
the
>>>>>>>> return value, end up in the while loop wrapped around _sync(),
>>>>>>>> and retry
>>>>>>>> there by adding another level of loop, or do we want to make use
>>>>>>>> of the
>>>>>>>> existing retry loops, one of which is wrapped around _unmap();
>>>>>>>> the latter
>>>>>>>> is my approach. The utility I see for the former approach is
>>>>>>>> that, in case
>>>>>>>> of a large number of page migrations (which should usually be
>>>>>>>> the case),
>>>>>>>> we are giving more time for the folio to get retried. The latter
>>>>>>>> does not
>>>>>>>> give much time and discards the folio if it did not succeed
>>>>>>>> under 7 times.
>>>>>>> Because it's a race, I guess that most folios will be migrated
>>>>>>> successfully in the first pass.
>>>>>>>
>>>>>>> My concerns of your method are that it deal with just one case
>>>>>>> specially.=C2=A0 While retrying after undoing all appears more gene=
ral.
>>>>>>
>>>>>> Makes sense. Also, please ignore my "change the return value"
>>>>>> thing, I got confused between unmap_folios, ret_folios, etc.
>>>>>> Now I think I understood what the lists are doing :)
>>>>>>
>>>>>>> If it's really important to retry after undoing all, we can either
>>>>>>> convert two retying loops of migrate_pages_batch() into one loop, or
>>>>>>> remove retry loop in migrate_pages_batch() and retry in its caller
>>>>>>> instead.
>>>>>> And if I implemented this correctly, the following makes the test
>>>>>> pass always:
>>>>>> https://www.codedump.xyz/diff/Zrn7EdxzNXmXyNXe
>>>>>
>>>>> Okay, I did mess up with the implementation, leading to a false
>>>>> positive. Let me try again :)
>>>>
>>>> Hopefully this should do the job:
>>>> https://www.codedump.xyz/diff/ZrsIV8JSOPYx5V_u
>>>>
>>>> But the result is worse than the patch proposed; I rarely hit
>>>> a 3 digit number of successes of move_pages(). But, on a
>>>> base kernel without any changes, when I apply David's
>>>> suggestion to change the test, if I choose 7 as the number
>>>> of retries (=3D NR_MAX_MIGRATE_SYNC_RETRY) in the test, I
>>>> can touch even 4 digits. I am puzzled.
>>>> We can also try merging the for loops of unmap and move...
>>>
>>> If people are okay with this change, I guess I can send it as
>>> a v2? I concur with your assessment that my initial approach
>>> is solving a specific case; the above approach does give me
>>> a slight improvement on arm64 and should be an improvement
>>> in general, since it makes sense to defer retrying the failed folio
>>> as much as we can.
>> We need to deal with something else before a formal v2,
>>
>> - stats need to be fixed, please check result processing for the first
>>    loop of migrate_pages_sync().
>
> Sorry, can you point out where do they need to be fixed exactly?
> The change I did is inside the while(!list_empty(from)) block,
> and there is no stat computation being done there already.

The migration failure for one folio may be counted multiple times during
retrying.  So, you may need to drop counting except the final one.

>>
>> - Do we need something similar for async migration.
>>
>> - Can we add another level of explicit loop for the second loop of
>>    migrate_pages_sync()?  That is to improve code readability.  Or, add a
>>    function to dot that?
>>
>> - Is it good to remove retry loop in migrate_pages_batch()?  And do
>>    retry in the caller?
>
> I am personally in favour of leaving the retry loop, and async
> migration, as it is. Since async version is basically minimal-effort
> migration, it won't make sense to "optimize" it, given the code churn
> it would create, including the change we will have to then do in
> "if (mode =3D=3D MIGRATE_ASYNC) =3D> migrate_pages_batch(ASYNC)" inside
> migrate_pages().

I think that it may make sense to improve async migration too if it's
possible and not too complex.  If necessary, we can refactor the code to
improve the readability.

> Sorry, what do you mean by "another level of explicit loop"?

I mean something like,

for (i =3D 0; i < NR_MAX_MIGRATE_SYNC_RETRY; i++) {
        while (!list_empty(from)) {
                migrate_pages_batch(, 1);
        }
}

--
Best Regards,
Huang, Ying

