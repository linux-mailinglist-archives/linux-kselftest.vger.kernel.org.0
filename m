Return-Path: <linux-kselftest+bounces-12545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F52914313
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 09:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B02A284AD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 07:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A540870;
	Mon, 24 Jun 2024 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFBbNy9N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22062E634;
	Mon, 24 Jun 2024 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212465; cv=none; b=D7uWyadBhDb6hssZZRpMlbVIyfVnXypB0mBQOz5TOPkWuum2zXkP28D2Hhrw5+m52vanXns1iUpDsrj4qJ3bwomlizs1cRCqiTMcULB5sknX8wToXn/HnCRlTo+tFH3UWxqBOdUu139J/2DGgjkonLGgHI0fVi9RMhXLnmvNo2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212465; c=relaxed/simple;
	bh=vysncUCoKhlu8IYF+ovoiOg/W8vMI8Njteu+rthszIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ft3CN4gkipJhdioTcMMRpIBbR14YduFcGOfor0eRO0KSuZXLwjnzDkWSRmq4syUugANoNCVqIDo+hfEBqsFMEtsbJofFqS5MNeFScAtB5pYa0cHJNSOr1LNoXywzJWUTcvYqhk0AjwGYqGHAwwYBDPFouMEXS8ClD4T2HVzE514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFBbNy9N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719212464; x=1750748464;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=vysncUCoKhlu8IYF+ovoiOg/W8vMI8Njteu+rthszIg=;
  b=ZFBbNy9N+TeazYwYac9MGAsFNZOo8IpAlBmfvXHf8eu1vmd95Ig9gcQT
   jnSLC3ltFDguZwVilRxqk7YoYDKpbSI19sVUMEt6nOqlCFlKUOgfE8Jic
   tmyKbtpQqPCIY2+3+LsbKvYHaqXOUyCLax+lNgCMuMFowFMINpuiBP0Db
   tEP7292qOTyLfpsiZDJcHdg8VK/IcbWiWmPCKOx1FBVShE2/1vA15DPXo
   dqa/WhFXraezAil1HptJxt3zbevAKtA1mLW6nozdjD+M3Erbl3E72rPVq
   IeeJlizcXLstH7Gvi7SQfGfs73N+IJiEhuGChDBHH9cBSVNtXEhj0MPt2
   g==;
X-CSE-ConnectionGUID: ZWcY7ZW9R6yICNfGahiAEg==
X-CSE-MsgGUID: 2tM+ksI0TBqTt/Xuc5RMyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="15859102"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="15859102"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:01:03 -0700
X-CSE-ConnectionGUID: 2G9ck0J0QrKUee6WV/mE4Q==
X-CSE-MsgGUID: SaZ8xHkJRCS25xxymusKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="47652596"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:01:00 -0700
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
In-Reply-To: <CAGsJ_4y9JinvzA6Wd2aXe_FRYhxED0vkkvU2HwWW8WBEX+8oqw@mail.gmail.com>
	(Barry Song's message of "Mon, 24 Jun 2024 16:05:44 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
	<d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
	<b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
	<CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
	<87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xX52FKG+o7vsjAwBLjvfPH=tg_36xqjCnwc5yGV=SaVg@mail.gmail.com>
	<878qyv0zwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4y9JinvzA6Wd2aXe_FRYhxED0vkkvU2HwWW8WBEX+8oqw@mail.gmail.com>
Date: Mon, 24 Jun 2024 14:59:09 +0800
Message-ID: <871q4m25du.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Mon, Jun 24, 2024 at 3:44=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Fri, Jun 21, 2024 at 9:24=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@=
arm.com> wrote:
>> >> >>
>> >> >> On 20/06/2024 12:34, David Hildenbrand wrote:
>> >> >> > On 20.06.24 11:04, Ryan Roberts wrote:
>> >> >> >> On 20/06/2024 01:26, Barry Song wrote:
>> >> >> >>> From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >>>
>> >> >> >>> Both Ryan and Chris have been utilizing the small test program=
 to aid
>> >> >> >>> in debugging and identifying issues with swap entry allocation=
. While
>> >> >> >>> a real or intricate workload might be more suitable for assess=
ing the
>> >> >> >>> correctness and effectiveness of the swap allocation policy, a=
 small
>> >> >> >>> test program presents a simpler means of understanding the pro=
blem and
>> >> >> >>> initially verifying the improvements being made.
>> >> >> >>>
>> >> >> >>> Let's endeavor to integrate it into the self-test suite. Altho=
ugh it
>> >> >> >>> presently only accommodates 64KB and 4KB, I'm optimistic that =
we can
>> >> >> >>> expand its capabilities to support multiple sizes and simulate=
 more
>> >> >> >>> complex systems in the future as required.
>> >> >> >>
>> >> >> >> I'll try to summarize the thread with Huang Ying by suggesting =
this test program
>> >> >> >> is "neccessary but not sufficient" to exhaustively test the mTH=
P swap-out path.
>> >> >> >> I've certainly found it useful and think it would be a valuable=
 addition to the
>> >> >> >> tree.
>> >> >> >>
>> >> >> >> That said, I'm not convinced it is a selftest; IMO a selftest s=
hould provide a
>> >> >> >> clear pass/fail result against some criteria and must be able t=
o be run
>> >> >> >> automatically by (e.g.) a CI system.
>> >> >> >
>> >> >> > Likely we should then consider moving other such performance-rel=
ated thingies
>> >> >> > out of the selftests?
>> >> >>
>> >> >> Yes, that would get my vote. But of the 4 tests you mentioned that=
 use
>> >> >> clock_gettime(), it looks like transhuge-stress is the only one th=
at doesn't
>> >> >> have a pass/fail result, so is probably the only candidate for mov=
ing.
>> >> >>
>> >> >> The others either use the times as a timeout and determines failur=
e if the
>> >> >> action didn't occur within the timeout (e.g. ksm_tests.c) or use i=
t to add some
>> >> >> supplemental performance information to an otherwise functionality=
-oriented test.
>> >> >
>> >> > Thank you very much, Ryan. I think you've found a better home for t=
his
>> >> > tool . I will
>> >> > send v2, relocating it to tools/mm and adding a function to swap in
>> >> > either the whole
>> >> > mTHPs or a portion of mTHPs by "-a"(aligned swapin).
>> >> >
>> >> > So basically, we will have
>> >> >
>> >> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation=
 code under
>> >> > high exercise in a short time.
>> >> >
>> >> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap=
 in freeing
>> >> > memory, as well as for munmap, app exits, or OOM killer scenarios. =
This ensures
>> >> > new mTHP is always generated, released or swapped out, similar to t=
he behavior
>> >> > on a PC or Android phone where many applications are frequently sta=
rted and
>> >> > terminated.
>> >>
>> >> MADV_DONTNEED 64KB memory, then memset() it, this just simulates the
>> >> large folio swap-in exactly, which hasn't been merged by upstream.  I
>> >> don't think that it's a good idea to make such kind of trick.
>> >
>> > I disagree. This is how userspace heaps can manage memory
>> > deallocation.
>>
>> Sorry, I don't understand how.  Can you show some examples?  Such as
>> strace log with 64KB aligned MADV_DONTNEED?
>
> In Java heap and memory allocators such as jemalloc and Scudo, memory is =
freed
> using the MADV_DONTNEED flag when either free() is called or garbage coll=
ection
> occurs. In Android, the Java heap is freed in chunks aligned to 64KB
> or larger.

Originally, I heard about that MADV_FREE is used by jemalloc.  Now, I
know that they use MADV_DONTNEED too.  Thanks!

Although I still suspect that libc/java allocator will free pages in
exact 64KB size (IIUC, they should free pages in much larger trunk).  I
agree that MADV_DONTNEED is a way to create fragmentation in swap
devices.

> In
> Scudo and jemalloc, there is a configuration option to set the
> management granularity.
> This granularity is set to match the mTHP size(though the default
> value is 16KB in the
> latest Android if we don't run mTHP). Otherwise, you could end up with
> millions of
> partial unmap operations, which would severely degrade the performance of=
 mTHP.
>
> Imagine libc/Java functioning like a slab allocator. When kfree() is
> called, some pages
> may become completely unoccupied and can be returned to the buddy allocat=
or. In
> userspace, memory is given back to the kernel in a similar manner,
> typically using
> MADV_DONTNEED. Therefore, MADV_DONTNEED is the most common memory
> reclamation behavior in Android, coming with free(), delete() or GC.
>
> Imagine a system with extensive malloc, free, new, and delete
> operations, where objects
> are constantly being created and destroyed.
>
> On the other hand, whether libc/Java use MADV_DONTNEED to free memory is =
not
> crucial, although they do. We need a method to simulate the lifecycle
> of applications
> =E2=80=94exiting and starting anew=E2=80=94on PCs or Android phones. It d=
oesn't matter if you
> use MADV_DONTNEED or munmap to achieve this.
>
> It is important to note that mTHP currently operates on a one-shot
> basis(after swap-out,
> you never get them back as mTHP as we don't support large folios
> swapin). For the test
> program, we need a method to generate new mTHPs continuously. Without thi=
s,
> after the initial iterations, we would be left with only folios,
> rendering the entire
> test program *pointless*.

I understand the requirements for new mTHPs.

>>
>> > Additionally, in the event of an application exit, munmap, or OOM kill=
er, the
>> > amount of freed memory can be much larger than 64KB. The primary purpo=
se
>> > of using MADV_DONTNEED is to release anonymous memory and generate
>> > new mTHP so that the iteration can continue. Otherwise, the test progr=
am
>> > becomes entirely pointless, as we only have large folios at the beginn=
ing.
>> > That is exactly why Chris has failed to find his bugs by using other s=
mall
>> > programs.
>>
>> Although I still don't understand how 64KB aligned MADV_DONTNEED is used
>> for libc/java heap or munmap in a practical way.  After more thoughts, I
>> think 64KB Aligned MADV_DONTNEED can simulate the fragmentation effect
>> of processes exit at some degree if 64KB folios in these processes are
>> swapped out without splitting.  If you have no other practical use
>> cases, I suggest to make it explicit with comments in program.
>>

[snip]

--
Best Regards,
Huang, Ying

