Return-Path: <linux-kselftest+bounces-9622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488F8BE945
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369521C23BF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E42916C456;
	Tue,  7 May 2024 16:34:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622316C453;
	Tue,  7 May 2024 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099661; cv=none; b=FJDQDKmoZYztIJ1rX4CUBcnUJmvskM9A3L6XULOsySQdmJTiRft+kUrGatwa5SZovDStODpKpaoCipp5kAqYAQYOVtEZN2iKZrZJr0/AEltPSfvN/u761WDqK+ASZWc0/uwfGKhaMBQqVwrQARYzSvDNxyEb9WM9SDT9d/8Du6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099661; c=relaxed/simple;
	bh=iRYaj26xe3Mr9cMwrKwc53RE8huH+KTl5l/a7Ec9pW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uwa/jNZRQBmrGWBGB58aImbAbi6UWDikaidOIQIicOMUUGGEHbi6LdR46M9Vu+j7IB8Ohu/tm7P1L9CdOOh5cJEm81FL7LwnOX9tuyyT0ZZv/vT1navkqjRKEhaWBNSl1YRshFE0m5ob44ozLDiBXb4IUvTw19GozWk4sLbCPEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7BA01063;
	Tue,  7 May 2024 09:34:42 -0700 (PDT)
Received: from [10.1.34.181] (XHFQ2J9959.cambridge.arm.com [10.1.34.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFA83F587;
	Tue,  7 May 2024 09:34:15 -0700 (PDT)
Message-ID: <518dd1e3-e31a-41c3-b488-9b75a64b6c8a@arm.com>
Date: Tue, 7 May 2024 17:34:14 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9e346b64-0a7c-4eb9-88c4-8fb6cf65b33f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/05/2024 17:19, John Hubbard wrote:
> On 5/7/24 12:45 AM, Ryan Roberts wrote:
>> On 04/05/2024 05:43, John Hubbard wrote:
> ...
>> Hi John,
>>
>> I sent out a similar fix a couple of weeks ago, see [1]. I don't think it got
>> picked up though. It takes a slightly different approach, explicitly adding
>> -static-libsan (note no 'a') for clang, instead of relying on its default.
>>
>> And it just drops helpers.h from the makefile altogether, on the assumption that
>> it was a mistake; its just a header and shouldn't be compiled directly. I'm not
>> exactly sure what the benefit of adding it to LOCAL_HDRS is?
> 
> Ah no, you must not drop headers.h. That's a mistake itself, because
> LOCAL_HDRS adds a Make dependency; that's its purpose. If you touch
> helpers.h it should cause a rebuild, which won't happen if you remove it
> from LOCAL_HDRS.

Ahh. I was under the impression that the compiler was configured to output the
list of dependencies for make to track (something like -M, from memory ?). Since
helpers.h is included from helpers.c I assumed it would be tracked like this - I
guess its not that simple?

Anyway, on the basis that LOCAL_HDRS is the right way to do this, let's go with
your version and drop mine:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> The way it works is that lib.mk adds $(LOCAL_HDRS) to the dependencies list,
> but then filters precisely that same set *out* of the list that it provides
> to the compile invocation.
> 
> The other way to implement this requirement of "some things need to be
> Make dependencies, and some need to be both dependencies and compilation
> inputs", is to add everything to the dependency list, but then use a
> separate list of files to pass to the compiler. For an example of that,
> see $(EXTRA_FILES) in patch 1/7 [1] of my selftests/x86 cleanup.
> 
> [1] https://lore.kernel.org/all/20240503030214.86681-2-jhubbard@nvidia.com/
> 
> thanks,
> John Hubbard
> 
>>
>> [1]
>> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
>>
>> Thanks,
>> Ryan
>>
>>
>>> ---
>>>   tools/testing/selftests/openat2/Makefile | 14 ++++++++++++--
>>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/openat2/Makefile
>>> b/tools/testing/selftests/openat2/Makefile
>>> index 254d676a2689..185dc76ebb5f 100644
>>> --- a/tools/testing/selftests/openat2/Makefile
>>> +++ b/tools/testing/selftests/openat2/Makefile
>>> @@ -1,8 +1,18 @@
>>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>>   -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>>> -static-libasan
>>> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>>>   TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>>>   +# gcc requires -static-libasan in order to ensure that Address Sanitizer's
>>> +# library is the first one loaded. However, clang already statically links the
>>> +# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>>> +# -static-libasan for clang builds.
>>> +ifeq ($(LLVM),)
>>> +    CFLAGS += -static-libasan
>>> +endif
>>> +
>>> +LOCAL_HDRS += helpers.h
>>> +
>>>   include ../lib.mk
>>>   -$(TEST_GEN_PROGS): helpers.c helpers.h
>>> +$(TEST_GEN_PROGS): helpers.c
>>>
>>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
>>
> 
> thanks,


