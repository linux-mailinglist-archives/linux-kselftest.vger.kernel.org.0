Return-Path: <linux-kselftest+bounces-11352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A99001B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 515FBB2480F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55575187325;
	Fri,  7 Jun 2024 11:12:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D2C18629A;
	Fri,  7 Jun 2024 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758745; cv=none; b=FOdrGysYKudOG2nDQNuoeYeyZRiMH8T81IYl7uK/Ufc7rdtKrUFMSFyXzaT0r3a6Np27sc8Wf+WVbOjdzwHTJ45mmhgeY2hsyuFPNvrRwlCLz14RKib2rgPu246UkqSKzUkU9kLpMyAsoe6OFOYswAmw8DXs/vyuTRIlb8npOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758745; c=relaxed/simple;
	bh=P2jinpvI+6JXnXr8CK7Na6QsQa8Mhn7gjzzH7d2TdqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le5Jc8G0m1cUMkMt4esb0+z9glYT/1D2A3o1a33d2KveR5L02I5ZvVKz8rhvfmB5KAI9jfN4ewng1Miu8QMImsXlohD99V0ngZMHc4YtdQQeo6cqOgPPoufR9mXbu3tAiq8oJexvsqXKkFTAXhxd1MuV3rxPDDB4KG2cyYTm63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 817092F4;
	Fri,  7 Jun 2024 04:12:47 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24123F762;
	Fri,  7 Jun 2024 04:12:20 -0700 (PDT)
Message-ID: <0d3fd536-5036-40e7-9783-80533914e32d@arm.com>
Date: Fri, 7 Jun 2024 12:12:19 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
Content-Language: en-GB
To: John Hubbard <jhubbard@nvidia.com>, Nathan Chancellor
 <nathan@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <20240603224706.GA245774@thelio-3990X>
 <2c57be33-77b8-419b-a708-e99aa9b44395@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2c57be33-77b8-419b-a708-e99aa9b44395@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/06/2024 05:55, John Hubbard wrote:
> On 6/3/24 3:47 PM, Nathan Chancellor wrote:
>> On Mon, Jun 03, 2024 at 04:32:30PM +0100, Mark Brown wrote:
>>> On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
>>>> The kselftests may be built in a couple different ways:
>>>>      make LLVM=1
>>>>      make CC=clang
>>>>
>>>> In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
>>>> of lib.mk, and any Makefiles that include lib.mk, can base decisions
>>>> solely on whether or not LLVM is set.
>>>
>>> ICBW but I believe there are still some architectures with clang but not
>>> lld support where there's a use case for using CC=clang.
>>
>> Does CC=clang even work for the selftests? lib.mk here uses 'CC :=' so
>> won't CC=clang get overridden to CC=$(CROSS_COMPILE)gcc?
>>
> 
> I received a report that someone (I forget who or what) was definitely
> attempting to just set CC=clang. But yes, it definitely doesn't work
> properly for CROSS_COMPILE.

This history as I recall, is that I got a bug report [1] stating that:

# tools/testing/selftests/fchmodat2$ make CC=clang

and

# tools/testing/selftests/openat2$ make CC=clang

were both failing due to the -static-libsan / -static-libasan difference between
gcc and clang. I attempted to fix that with [2], which used cc-option to
determine which variant to use. That never got picked up, and John
coincidentally did a similar fix, but relying on LLVM=1 instead.

If we are concluding that CC=clang is an invalid way to do this, then I guess we
should report that back to [1]?

[1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
[2]
https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/

Thanks,
Ryan


> 
> And the more we talk it through, the less I like this direction that
> I went off on. Let's just drop this patch and instead consider moving
> kselftest builds closer to kbuild, instead of making it more different.
> 
> 
> thanks,


