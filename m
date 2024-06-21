Return-Path: <linux-kselftest+bounces-12428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C491206C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1248B1F22589
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F716DEDA;
	Fri, 21 Jun 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xjr+1la/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569912D1EB;
	Fri, 21 Jun 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961886; cv=none; b=IpcRC4fmu7RkZsiHah9ELbjzO+aiwd5bq0EUsJl9KQYtxn2SLiSm4QGiyjGKZXcv71GgldsR4zE3yQR3CxtIbObJ5rz+2FqK/NnJiKBWK18Bmulv/7ei7KdcyVZGfi0dcwaBRP07CLPa5CQomeQVsWvaH36MbT5GQzpVr8SrxPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961886; c=relaxed/simple;
	bh=NBWTcpKZIKcW6NL5NChdd9KplU+HhaBpcnqHOd3GkH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lfIoKYNGPYW9cNHvlFd+4u/LI2DUXFPCOrjMZyKhuyMExl7j+jbG5qJHVQwkn1KUEoPFQI4T4jBCuMtuBwdOAabr0rAHxb5YEyT03kMsizE1Jxflm3RTYsmpzgnPTmcj7xUVUDlDh+UEWvlqVjn7QM/HCrF3gQEurmfKeN8XXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xjr+1la/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718961884; x=1750497884;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=NBWTcpKZIKcW6NL5NChdd9KplU+HhaBpcnqHOd3GkH4=;
  b=Xjr+1la/RYE8GyospQ++KXqNTjwku905qConReluT5tFSOj0sQE3JCG6
   3Hx+O+yuRKW75Yps+NJAWFE0Mj7PRwePhCQlTFHqHjP8fZ20kPukDx2cH
   xtfCm42b+VupvN5ZG1ACNB3ZAA6Cj6/z8avsOXBgm7YhVLZ0BPfX9Jv2m
   cQgTMp70S9JCE7yhaR8duRTp1d+RVDIuvq4bmJJK1b9RAU6vm9+xc0OqD
   /42yCY+S/sulrJ5zKkoLIZGi061Q/Z6WN4dgN+pU91zBtjWk7ys99goFQ
   B4och0PmkCC1uzOk3KpwksyE05+gNvFou71qJrwmzia881JPowrkt+9pr
   Q==;
X-CSE-ConnectionGUID: 90Ys6P04TCOakwPiuE3+uA==
X-CSE-MsgGUID: 3k4KlAn1TgyjhPF5C1pZcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15821218"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15821218"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:24:43 -0700
X-CSE-ConnectionGUID: 22g+VwFiQBWSlHtaAoNqOg==
X-CSE-MsgGUID: f/88ox6tSbeoFtvnlyIrMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="43203306"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:24:40 -0700
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
In-Reply-To: <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
	(Barry Song's message of "Fri, 21 Jun 2024 19:47:02 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
	<d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
	<b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
	<CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
Date: Fri, 21 Jun 2024 17:22:49 +0800
Message-ID: <87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
>>
>> On 20/06/2024 12:34, David Hildenbrand wrote:
>> > On 20.06.24 11:04, Ryan Roberts wrote:
>> >> On 20/06/2024 01:26, Barry Song wrote:
>> >>> From: Barry Song <v-songbaohua@oppo.com>
>> >>>
>> >>> Both Ryan and Chris have been utilizing the small test program to aid
>> >>> in debugging and identifying issues with swap entry allocation. While
>> >>> a real or intricate workload might be more suitable for assessing the
>> >>> correctness and effectiveness of the swap allocation policy, a small
>> >>> test program presents a simpler means of understanding the problem a=
nd
>> >>> initially verifying the improvements being made.
>> >>>
>> >>> Let's endeavor to integrate it into the self-test suite. Although it
>> >>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>> >>> expand its capabilities to support multiple sizes and simulate more
>> >>> complex systems in the future as required.
>> >>
>> >> I'll try to summarize the thread with Huang Ying by suggesting this t=
est program
>> >> is "neccessary but not sufficient" to exhaustively test the mTHP swap=
-out path.
>> >> I've certainly found it useful and think it would be a valuable addit=
ion to the
>> >> tree.
>> >>
>> >> That said, I'm not convinced it is a selftest; IMO a selftest should =
provide a
>> >> clear pass/fail result against some criteria and must be able to be r=
un
>> >> automatically by (e.g.) a CI system.
>> >
>> > Likely we should then consider moving other such performance-related t=
hingies
>> > out of the selftests?
>>
>> Yes, that would get my vote. But of the 4 tests you mentioned that use
>> clock_gettime(), it looks like transhuge-stress is the only one that doe=
sn't
>> have a pass/fail result, so is probably the only candidate for moving.
>>
>> The others either use the times as a timeout and determines failure if t=
he
>> action didn't occur within the timeout (e.g. ksm_tests.c) or use it to a=
dd some
>> supplemental performance information to an otherwise functionality-orien=
ted test.
>
> Thank you very much, Ryan. I think you've found a better home for this
> tool . I will
> send v2, relocating it to tools/mm and adding a function to swap in
> either the whole
> mTHPs or a portion of mTHPs by "-a"(aligned swapin).
>
> So basically, we will have
>
> 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code =
under
> high exercise in a short time.
>
> 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in fr=
eeing
> memory, as well as for munmap, app exits, or OOM killer scenarios. This e=
nsures
> new mTHP is always generated, released or swapped out, similar to the beh=
avior
> on a PC or Android phone where many applications are frequently started a=
nd
> terminated.

MADV_DONTNEED 64KB memory, then memset() it, this just simulates the
large folio swap-in exactly, which hasn't been merged by upstream.  I
don't think that it's a good idea to make such kind of trick.

> 3. Swap in with or without the "-a" option to observe how fragments
> due to swap-in
> and the incoming swap-in of large folios will impact swap-out fallback.

It's good to create fragmentation with swap-in.  Which is more practical
and future-proof.  And, I believe that we can reduce large folio
swap-out fallback rate without the large folio swap-in trick.

> And many thanks to Chris for the suggestion on improving it within
> selftest, though I
> prefer to place it in tools/mm.

--
Best Regards,
Huang, Ying

