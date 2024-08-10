Return-Path: <linux-kselftest+bounces-15116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299594DDFA
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E74B1F21EE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797349626;
	Sat, 10 Aug 2024 18:43:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6CA441F;
	Sat, 10 Aug 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723315385; cv=none; b=beHV65bdUKtX3dPY6qAM7chu8T/AyqGdoUWg2L42reCN6NA2YsFhgvbQz9+cszY5iPiqJccHMNOVLd7OO8YgSb+wrHXm1h1LEAOF+GfC8dbVeSIrdX4Chhgt59dilzYIFfZ4l6Jxt8hbWQJMnJBIVGZjLoxqhpw+S0FN+vR0dRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723315385; c=relaxed/simple;
	bh=Dm9WfJRUoHBGXJN1A+UviXh2kbATf2tzBSS+wUFKbs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CUA1pGmSqUlU0pdKpJitAgJ4+P7w6JdWQAC55vZHKmPEVyy99vtu9Q5uksbUxuk1VTj0k8wtagK2roqY6yoM3jFfGpEhtx5sv6q9R1k4GXvv0mNhDHm2Eiqyfd5aV06+3ayUnEoPY2MB5w/47oDgg92aPqObJU17nCHvpQ0eh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A76C3FEC;
	Sat, 10 Aug 2024 11:43:26 -0700 (PDT)
Received: from [10.163.56.130] (unknown [10.163.56.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 995183F71E;
	Sat, 10 Aug 2024 11:42:51 -0700 (PDT)
Message-ID: <5a4ae1d3-d753-4261-97a8-926e44d4217a@arm.com>
Date: Sun, 11 Aug 2024 00:12:43 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
 <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/9/24 19:17, David Hildenbrand wrote:
> On 09.08.24 12:31, Dev Jain wrote:
>> As already being done in __migrate_folio(), wherein we backoff if the
>> folio refcount is wrong, make this check during the unmapping phase, 
>> upon
>> the failure of which, the original state of the PTEs will be restored 
>> and
>> the folio lock will be dropped via migrate_folio_undo_src(), any racing
>> thread will make progress and migration will be retried.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/migrate.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e7296c0fb5d5..477acf996951 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t 
>> get_new_folio,
>>       }
>>         if (!folio_mapped(src)) {
>> +        /*
>> +         * Someone may have changed the refcount and maybe sleeping
>> +         * on the folio lock. In case of refcount mismatch, bail out,
>> +         * let the system make progress and retry.
>> +         */
>> +        struct address_space *mapping = folio_mapping(src);
>> +
>> +        if (folio_ref_count(src) != folio_expected_refs(mapping, src))
>> +            goto out;
>
> This really seems to be the latest point where we can "easily" back 
> off and unlock the source folio -- in this function :)
>
> I wonder if we should be smarter in the migrate_pages_batch() loop 
> when we start the actual migrations via migrate_folio_move(): if we 
> detect that a folio has unexpected references *and* it has waiters 
> (PG_waiters), back off then and retry the folio later. If it only has 
> unexpected references, just keep retrying: no waiters -> nobody is 
> waiting for the lock to make progress.


The patch currently retries migration irrespective of the reason of 
refcount change.

If you are suggesting that, break the retrying according to two conditions:

1. If the folio has waiters, retry according to 
NR_MAX_MIGRATE_PAGES_RETRY = 10.

2. If not, retry for a large number of iterations, say 10,000, since we 
just need to keep

retrying till the racer finishes reading the folio/failing on 
folio_trylock(), and decrementing

refcount.

If so, we will have to make the check as a refcount freeze(with 
xas_lock()); if we don't do that,

anyone can increase the refcount again, reading data from a stale 
reference to the folio, making

our check futile (which begs the question: is commit 0609139 correct? 
Checking refcount mismatch

in __migrate_folio() is ineffective since after that, and before 
folio_ref_freeze() in __folio_migrate_mapping(),

the refcount may change.) As a result, the freeze will have to take 
place immediately after we unmap

the folios from everyone's address space, something like:

while (!folio_ref_freeze(src, expected_count) && ++retries < 10000) {

         if (folio has waiters)

                 break;    /* will be retried by the outer loop giving 
us 10 chances in total */

}


> This really seems to be the latest point where we can "easily" back 
> off and unlock the source folio -- in this function :)
> For example, when migrate_folio_move() fails with -EAGAIN, check if 
> there are waiters (PG_waiter?) and undo+unlock to try again later.


Currently, on -EAGAIN, migrate_folio_move() returns without undoing src 
and dst; even if we were to fall

through to _undo_src/dst, the folios will not be unmapped again since 
_unmap() and _move() are

wrapped around different loops. This is what I was hinting to when I 
wrote in the cover letter:

"...there is no way the refcount would be decremented; as a result, this 
renders the retrying

useless" since upon the failure of _move(), the lock will not be dropped 
(which is dropped

through undo_src()), rendering the _move() loop useless. Sorry, should 
have noted this there.





