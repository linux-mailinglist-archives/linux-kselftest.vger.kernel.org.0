Return-Path: <linux-kselftest+bounces-12401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A3911CB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BA6284541
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09714169AF7;
	Fri, 21 Jun 2024 07:25:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED67E58D;
	Fri, 21 Jun 2024 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954721; cv=none; b=CFbtB00arrCUxlAzfWmCKdMLHJD3m+npsZ2EOPz6noyTXXuRyFpGXr5Ib4D6QFA4aL1z4qz5EIFm/+MOw5dfsXPnZgtrvw6bMgSJr5ncA/sEweAnSd1mNGIgXXB6ZQTSjDWwwNOnbSmjLL/1QG0gUH/mWOYROFixS5TYPq/bH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954721; c=relaxed/simple;
	bh=+ZSodkxtc1SeAq96MA++4d65ok/eUDgKasSj3x4GrZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6g53TaTSiXYrONwY+teodn2ehbYHTL6DOSmWgw8eS8y2WI5Y22ohu6U4+uPwcCQizMQSdlTJB0BeRT3VJJJkTxO0JrNY07aJO7y+uGyrHjunZw+o1a760bMkSGljMjgJ6BQrsoo9OvLpkmw/KTmP1rxkdmodQDEmQzIiedgUEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15AA0DA7;
	Fri, 21 Jun 2024 00:25:42 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D72F83F64C;
	Fri, 21 Jun 2024 00:25:14 -0700 (PDT)
Message-ID: <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
Date: Fri, 21 Jun 2024 08:25:13 +0100
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
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org
Cc: chrisl@kernel.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ying.huang@intel.com,
 linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
 <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/06/2024 12:34, David Hildenbrand wrote:
> On 20.06.24 11:04, Ryan Roberts wrote:
>> On 20/06/2024 01:26, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Both Ryan and Chris have been utilizing the small test program to aid
>>> in debugging and identifying issues with swap entry allocation. While
>>> a real or intricate workload might be more suitable for assessing the
>>> correctness and effectiveness of the swap allocation policy, a small
>>> test program presents a simpler means of understanding the problem and
>>> initially verifying the improvements being made.
>>>
>>> Let's endeavor to integrate it into the self-test suite. Although it
>>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
>>> expand its capabilities to support multiple sizes and simulate more
>>> complex systems in the future as required.
>>
>> I'll try to summarize the thread with Huang Ying by suggesting this test program
>> is "neccessary but not sufficient" to exhaustively test the mTHP swap-out path.
>> I've certainly found it useful and think it would be a valuable addition to the
>> tree.
>>
>> That said, I'm not convinced it is a selftest; IMO a selftest should provide a
>> clear pass/fail result against some criteria and must be able to be run
>> automatically by (e.g.) a CI system.
> 
> Likely we should then consider moving other such performance-related thingies
> out of the selftests?

Yes, that would get my vote. But of the 4 tests you mentioned that use
clock_gettime(), it looks like transhuge-stress is the only one that doesn't
have a pass/fail result, so is probably the only candidate for moving.

The others either use the times as a timeout and determines failure if the
action didn't occur within the timeout (e.g. ksm_tests.c) or use it to add some
supplemental performance information to an otherwise functionality-oriented test.


