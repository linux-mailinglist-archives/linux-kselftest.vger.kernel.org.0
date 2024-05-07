Return-Path: <linux-kselftest+bounces-9627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EE88BE9E4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E64128B91A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036415FD03;
	Tue,  7 May 2024 16:56:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82E54BEA;
	Tue,  7 May 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101004; cv=none; b=YSefSJ9DuWzp/6hi3e35gFU0mgbbyhtcWqyRgTtC/FK+LVoQmAPks5SdMIvUoqhVk9Yh5bQh0NvOW47Osrd7b/j6gE/n5UZaoTi0yyTRqlpds1mYnfPx3uhTuW+kBqjYg0aihoAGCj8qo+q1r9JjCKxlkT2b4RilboJH81NicEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101004; c=relaxed/simple;
	bh=P+ipyRNAkG1tIcELNjSx9jh4wymOHO4binW0dDyHggs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4MEnqQi+CHNBYR0PrDeNxjZMfnon7estK+5ceMf7k08k0scduVjf0rsaRrh6XsYWwr3/1ct5XigF1EO8urygCgWXM9ZHPsFXLnIR0Ymq0phjdYEVUJJ/hETL9knO3SgRM7fl7aCD0R+p3DUSrmmsVgZjOzIMcYR9t4RrZM/QoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03B71063;
	Tue,  7 May 2024 09:57:07 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749443F587;
	Tue,  7 May 2024 09:56:40 -0700 (PDT)
Message-ID: <1f8711d2-8505-4685-9e0f-180bdc709381@arm.com>
Date: Tue, 7 May 2024 17:56:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <8fdefaa9-675e-4b37-9456-896b9989d18f@arm.com>
 <9e346b64-0a7c-4eb9-88c4-8fb6cf65b33f@nvidia.com>
 <518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com>
 <c1ff82e6-4d6a-4680-925f-5f0226ba32c4@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c1ff82e6-4d6a-4680-925f-5f0226ba32c4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2024 17:47, John Hubbard wrote:
> On 5/7/24 9:34 AM, Ryan Roberts wrote:
>> On 07/05/2024 17:19, John Hubbard wrote:
>>> On 5/7/24 12:45 AM, Ryan Roberts wrote:
>>>> On 04/05/2024 05:43, John Hubbard wrote:
>>> ...
>>>> Hi John,
>>>>
>>>> I sent out a similar fix a couple of weeks ago, see [1]. I don't think it got
>>>> picked up though. It takes a slightly different approach, explicitly adding
>>>> -static-libsan (note no 'a') for clang, instead of relying on its default.
>>>>
>>>> And it just drops helpers.h from the makefile altogether, on the assumption
>>>> that
>>>> it was a mistake; its just a header and shouldn't be compiled directly. I'm not
>>>> exactly sure what the benefit of adding it to LOCAL_HDRS is?
>>>
>>> Ah no, you must not drop headers.h. That's a mistake itself, because
>>> LOCAL_HDRS adds a Make dependency; that's its purpose. If you touch
>>> helpers.h it should cause a rebuild, which won't happen if you remove it
>>> from LOCAL_HDRS.
>>
>> Ahh. I was under the impression that the compiler was configured to output the
>> list of dependencies for make to track (something like -M, from memory ?). Since
>> helpers.h is included from helpers.c I assumed it would be tracked like this - I
>> guess its not that simple?
> 
> This can be done, but it is not automatic with GNU Make. You have to explicitly
> run gcc -M, capture the output in a dependencies list, and track it. Which the
> Kbuild system does, but kselftest does not.

Understood - thanks for the lesson!

> 
> After just now sweeping through kselftest to fix up the clang build, I see a
> lot of mistaken or partial use of the kselftest build's Make variables, because
> people naturally reason based on what they know about Kbuild, and it doesn't
> always translate. And LOCAL_HDRS might need some more documentation too.
> I'll keep thinking about how to clarify this, I have a couple early ideas.
> 
>>
>> Anyway, on the basis that LOCAL_HDRS is the right way to do this, let's go with
>> your version and drop mine:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
> 
> Thanks for the review!
> 
> thanks,


