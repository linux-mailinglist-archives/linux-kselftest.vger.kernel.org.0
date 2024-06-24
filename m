Return-Path: <linux-kselftest+bounces-12532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E79140DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B56F283CD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D886FD0;
	Mon, 24 Jun 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BHpbte1r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13F53A7;
	Mon, 24 Jun 2024 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719200689; cv=none; b=iGuFc2BdJSoqkvugJx1tBP42HHrwWct4sK5zhbB/MlkX3nQyoTth+2aLXrgua4RZvrK0xNW311myvjKlBR933XVKhmMFF6I2BpV4hgO0luR8wcAS8sLuUdYWiegPf7LpVJWVgtZJSdlGpzV284Fe6lkC8lc90Zl5Ib14ihE6KzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719200689; c=relaxed/simple;
	bh=WFvlK0QDfHGuvHUJ7K90wbNAELTGJ7ciK90MEAQK2iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DiqyHEynoaP8us0QK0cjWTInn7HKhciMxx2ToBTXEqefq6sAHaeipdqtW1ip/0W7dehfo2MX07fUt5iQxF4aOmGdawfgFINRIlKtgQP0tQOJIrm81qn5X+pzBtWJgwxG8LpDKv2bcfjvzQ5wWY2Qxnq+v2IJM0pUYPZjocy8RaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BHpbte1r; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719200687; x=1750736687;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=WFvlK0QDfHGuvHUJ7K90wbNAELTGJ7ciK90MEAQK2iQ=;
  b=BHpbte1rAwYcFKO7N1XF0oYfSgcXP5ud+c3G/9Pu3sN9MQZh1kjMVa0c
   6RCodDxDoaiqBdQGqmKTaaMpLSz6ENp0v0n4DMMcALbnehHTp0wROTXKy
   dzp9E7g66JZc0Xp/6FnFQ17cqRXkpKciazBHxvzpGaJY2+XzLIMDW+W+d
   kjBL+gSXAP5zY/vmrjASYeE2JVIgOhT+uUIm66MJPyEotOhrDTgUdIfpR
   qVIrrgi+fqC/M/0JYr42FmelXJnBT/z7h7CkgGk3zfAPKhmgBHn5mIjsL
   QxV5mNGenjk2phcdN9a1GpyJP6Bc3MIw85CniEX7x3MhymQYKWLdaXMx1
   Q==;
X-CSE-ConnectionGUID: cP21HeLwQwquIKPvHmV/JQ==
X-CSE-MsgGUID: +aMrINMyRa2PSrfwEkB30A==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="19057998"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="19057998"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 20:44:46 -0700
X-CSE-ConnectionGUID: /g9UOsk8SDOYU0UgIF/DTQ==
X-CSE-MsgGUID: Rs5v1uNDSsCCC7HqVsV7aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47693440"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 20:44:42 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  David Hildenbrand
 <david@redhat.com>,  akpm@linux-foundation.org,  shuah@kernel.org,
  linux-mm@kvack.org,  chrisl@kernel.org,  hughd@google.com,
  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <CAGsJ_4xX52FKG+o7vsjAwBLjvfPH=tg_36xqjCnwc5yGV=SaVg@mail.gmail.com>
	(Barry Song's message of "Fri, 21 Jun 2024 21:43:20 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
	<d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
	<b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
	<CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
	<87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xX52FKG+o7vsjAwBLjvfPH=tg_36xqjCnwc5yGV=SaVg@mail.gmail.com>
Date: Mon, 24 Jun 2024 11:42:51 +0800
Message-ID: <878qyv0zwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Fri, Jun 21, 2024 at 9:24=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
>> >>
>> >> On 20/06/2024 12:34, David Hildenbrand wrote:
>> >> > On 20.06.24 11:04, Ryan Roberts wrote:
>> >> >> On 20/06/2024 01:26, Barry Song wrote:
>> >> >>> From: Barry Song <v-songbaohua@oppo.com>
>> >> >>>
>> >> >>> Both Ryan and Chris have been utilizing the small test program to=
 aid
>> >> >>> in debugging and identifying issues with swap entry allocation. W=
hile
>> >> >>> a real or intricate workload might be more suitable for assessing=
 the
>> >> >>> correctness and effectiveness of the swap allocation policy, a sm=
all
>> >> >>> test program presents a simpler means of understanding the proble=
m and
>> >> >>> initially verifying the improvements being made.
>> >> >>>
>> >> >>> Let's endeavor to integrate it into the self-test suite. Although=
 it
>> >> >>> presently only accommodates 64KB and 4KB, I'm optimistic that we =
can
>> >> >>> expand its capabilities to support multiple sizes and simulate mo=
re
>> >> >>> complex systems in the future as required.
>> >> >>
>> >> >> I'll try to summarize the thread with Huang Ying by suggesting thi=
s test program
>> >> >> is "neccessary but not sufficient" to exhaustively test the mTHP s=
wap-out path.
>> >> >> I've certainly found it useful and think it would be a valuable ad=
dition to the
>> >> >> tree.
>> >> >>
>> >> >> That said, I'm not convinced it is a selftest; IMO a selftest shou=
ld provide a
>> >> >> clear pass/fail result against some criteria and must be able to b=
e run
>> >> >> automatically by (e.g.) a CI system.
>> >> >
>> >> > Likely we should then consider moving other such performance-relate=
d thingies
>> >> > out of the selftests?
>> >>
>> >> Yes, that would get my vote. But of the 4 tests you mentioned that use
>> >> clock_gettime(), it looks like transhuge-stress is the only one that =
doesn't
>> >> have a pass/fail result, so is probably the only candidate for moving.
>> >>
>> >> The others either use the times as a timeout and determines failure i=
f the
>> >> action didn't occur within the timeout (e.g. ksm_tests.c) or use it t=
o add some
>> >> supplemental performance information to an otherwise functionality-or=
iented test.
>> >
>> > Thank you very much, Ryan. I think you've found a better home for this
>> > tool . I will
>> > send v2, relocating it to tools/mm and adding a function to swap in
>> > either the whole
>> > mTHPs or a portion of mTHPs by "-a"(aligned swapin).
>> >
>> > So basically, we will have
>> >
>> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation co=
de under
>> > high exercise in a short time.
>> >
>> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in=
 freeing
>> > memory, as well as for munmap, app exits, or OOM killer scenarios. Thi=
s ensures
>> > new mTHP is always generated, released or swapped out, similar to the =
behavior
>> > on a PC or Android phone where many applications are frequently starte=
d and
>> > terminated.
>>
>> MADV_DONTNEED 64KB memory, then memset() it, this just simulates the
>> large folio swap-in exactly, which hasn't been merged by upstream.  I
>> don't think that it's a good idea to make such kind of trick.
>
> I disagree. This is how userspace heaps can manage memory
> deallocation.

Sorry, I don't understand how.  Can you show some examples?  Such as
strace log with 64KB aligned MADV_DONTNEED?

> Additionally, in the event of an application exit, munmap, or OOM killer,=
 the
> amount of freed memory can be much larger than 64KB. The primary purpose
> of using MADV_DONTNEED is to release anonymous memory and generate
> new mTHP so that the iteration can continue. Otherwise, the test program
> becomes entirely pointless, as we only have large folios at the beginning.
> That is exactly why Chris has failed to find his bugs by using other small
> programs.

Although I still don't understand how 64KB aligned MADV_DONTNEED is used
for libc/java heap or munmap in a practical way.  After more thoughts, I
think 64KB Aligned MADV_DONTNEED can simulate the fragmentation effect
of processes exit at some degree if 64KB folios in these processes are
swapped out without splitting.  If you have no other practical use
cases, I suggest to make it explicit with comments in program.

> On the other hand, we definitely want large folios swap-in, otherwise, mT=
HP
> is just a toy to Android or similar system where more than 2/3 memory cou=
ld
> be in swap. We do NOT want single-use mTHP.

I agree that large folios swap-in has its value at least in some
situations.  Whether we should take it as default behavior is another
topic, we can discuss it further in the future.

>>
>> > 3. Swap in with or without the "-a" option to observe how fragments
>> > due to swap-in
>> > and the incoming swap-in of large folios will impact swap-out fallback.
>>
>> It's good to create fragmentation with swap-in.  Which is more practical
>> and future-proof.  And, I believe that we can reduce large folio
>> swap-out fallback rate without the large folio swap-in trick.
>>
>> > And many thanks to Chris for the suggestion on improving it within
>> > selftest, though I
>> > prefer to place it in tools/mm.

--
Best Regards,
Huang, Ying

