Return-Path: <linux-kselftest+bounces-12406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF0E911DE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D57B253D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478CC16D310;
	Fri, 21 Jun 2024 07:58:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163B816C869;
	Fri, 21 Jun 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956735; cv=none; b=HXjoih80WH1tIr39hdiHAHE/AtM4s0jxjM1RbW7Uf1lK6X2jsvRcdHpmn/qWSypUFaGQ8wFdFgYtWeeBZBWaFMuP06M/olJNeugwtkm3cQ+PB9slBUOdxZSduri4mlQ4tI+E94NLmZ3DTdnW1IS30gOMzcxptappqdwRE9nhRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956735; c=relaxed/simple;
	bh=uP8cgoFkKsQjYi7Xt/6FdFE5VBznIprS14DxiFpAS30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5c41zPKOyPKGLogEqPLu49aR7awvzeHABSpZBfIt64L2+EuZN6Y8qWkFi8K1VMA4ZXgJSLG/Dbu+Lg+su4KXrY4OiSZMDYjrzfsRmpeLiAfqYXFJ9GxbVLJyscn/fbIMmQVSN82PwvEgmE+cfwgpiwReXWm2+wVh1Mp9vzAnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAEA339;
	Fri, 21 Jun 2024 00:59:17 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 950893F64C;
	Fri, 21 Jun 2024 00:58:50 -0700 (PDT)
Message-ID: <1bbeb797-e07b-4c75-819f-7ce5f785037e@arm.com>
Date: Fri, 21 Jun 2024 08:58:49 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org, chrisl@kernel.org, hughd@google.com,
 kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org,
 ying.huang@intel.com, linux-kselftest@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
 <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
 <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
 <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/06/2024 08:47, Barry Song wrote:
> On Fri, Jun 21, 2024 at 7:25 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 20/06/2024 12:34, David Hildenbrand wrote:
>>> On 20.06.24 11:04, Ryan Roberts wrote:
>>>> On 20/06/2024 01:26, Barry Song wrote:
>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>
>>>>> Both Ryan and Chris have been utilizing the small test program to aid
>>>>> in debugging and identifying issues with swap entry allocation. While
>>>>> a real or intricate workload might be more suitable for assessing the
>>>>> correctness and effectiveness of the swap allocation policy, a small
>>>>> test program presents a simpler means of understanding the problem and
>>>>> initially verifying the improvements being made.
>>>>>
>>>>> Let's endeavor to integrate it into the self-test suite. Although it
>>>>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>>>>> expand its capabilities to support multiple sizes and simulate more
>>>>> complex systems in the future as required.
>>>>
>>>> I'll try to summarize the thread with Huang Ying by suggesting this test program
>>>> is "neccessary but not sufficient" to exhaustively test the mTHP swap-out path.
>>>> I've certainly found it useful and think it would be a valuable addition to the
>>>> tree.
>>>>
>>>> That said, I'm not convinced it is a selftest; IMO a selftest should provide a
>>>> clear pass/fail result against some criteria and must be able to be run
>>>> automatically by (e.g.) a CI system.
>>>
>>> Likely we should then consider moving other such performance-related thingies
>>> out of the selftests?
>>
>> Yes, that would get my vote. But of the 4 tests you mentioned that use
>> clock_gettime(), it looks like transhuge-stress is the only one that doesn't
>> have a pass/fail result, so is probably the only candidate for moving.
>>
>> The others either use the times as a timeout and determines failure if the
>> action didn't occur within the timeout (e.g. ksm_tests.c) or use it to add some
>> supplemental performance information to an otherwise functionality-oriented test.
> 
> Thank you very much, Ryan. I think you've found a better home for this
> tool . I will
> send v2, relocating it to tools/mm and adding a function to swap in
> either the whole
> mTHPs or a portion of mTHPs by "-a"(aligned swapin).
> 
> So basically, we will have
> 
> 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code under
> high exercise in a short time.
> 
> 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in freeing
> memory, as well as for munmap, app exits, or OOM killer scenarios. This ensures
> new mTHP is always generated, released or swapped out, similar to the behavior
> on a PC or Android phone where many applications are frequently started and
> terminated.
> 
> 3. Swap in with or without the "-a" option to observe how fragments
> due to swap-in
> and the incoming swap-in of large folios will impact swap-out fallback.
> 
> And many thanks to Chris for the suggestion on improving it within
> selftest, though I
> prefer to place it in tools/mm.

All sounds good to me!

If, (for future) you also wanted to test the vmscan swap-out path, the way I've
been doing that is to run the workload in a memory-constrained cgroup. That
means you don't need to exhaust all your phsical ram so speeds things up a lot.


> 
> Thanks
> Barry


