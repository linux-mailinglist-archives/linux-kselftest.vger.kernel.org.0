Return-Path: <linux-kselftest+bounces-16045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D695B383
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9729C1C22EDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF5183CAB;
	Thu, 22 Aug 2024 11:10:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF61802AB;
	Thu, 22 Aug 2024 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325054; cv=none; b=WZKaOVYZ3Ydn08ma+2nRMK37bEpcym7F7KjAEkasnzF9Gkp4BpKodyOYQlOqRb1TcM5JcV7ZCiS/Evb1JH70niisq+s4zpykpeDQygMfd9cSnEZROGOlxmT5p2OQjdAg5VaWLYoAeJvYLvrJuiWpZZBMI5OIaMqPTiFPKNO4Mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325054; c=relaxed/simple;
	bh=XWWYSuILmc2KaR1F7fSC/wqsBG/6TN/tnzp4GRVvdqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXc2WvSBcWzYxVHanyoslJPu1M6ip5gJVW1GhY/qjLPWRm2fU4R1ZmkUHqO+IBJ4YyDbpAgn7qYcykDk1uJdrkrR4Od3LM8Uf+ZlX6S05DE50MMer1T95MVBAUt0nW/OtUwf1hXkDqksYn05tIWpsIEdOHGbJAcruoxzVZmGTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 689C5DA7;
	Thu, 22 Aug 2024 04:11:17 -0700 (PDT)
Received: from [10.163.87.181] (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44AEF3F58B;
	Thu, 22 Aug 2024 04:10:45 -0700 (PDT)
Message-ID: <51617076-3aec-413d-bf42-cf1c359a0c38@arm.com>
Date: Thu, 22 Aug 2024 16:40:37 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests: Rename sigaltstack to generic signal
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240821061523.2650568-1-dev.jain@arm.com>
 <20240821061523.2650568-2-dev.jain@arm.com>
 <1ac911c2-9d9c-4408-8697-1e90b3ae3e8d@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1ac911c2-9d9c-4408-8697-1e90b3ae3e8d@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/22/24 08:33, Shuah Khan wrote:
> On 8/21/24 00:15, Dev Jain wrote:
>> Rename sigaltstack to signal, and rename the existing test to
>> sigaltstack.c.
>
> Can you elaborate on the benefits if renaming the test?
>
> Also you have such a good information in the cover-letter for this
> patch - it would be good to include it in the change log for this
> one or the new test.

Okay.


>
> The new test itself is good. I don't understand the value of renaming.
> I can see the problems due to not being able to fix stables if the
> existing test needs fixing. If there are good reasons for renaming,
> I am all for it.

After looking into some git history, now I understand that "sas" actually
has some meaning, although I still can't find its full-form :) I thought 
that
sigaltstack would be a better name, but I guess sas is a subset of 
sigaltstack
as part of SA_ONSTACK. So, let us drop the renaming of the test.

>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> ---
>> tools/testing/selftests/Makefile | 2 +-
>>   tools/testing/selftests/{sigaltstack => signal}/.gitignore      | 2 +-
>>   tools/testing/selftests/{sigaltstack => signal}/Makefile        | 2 +-
>>   .../selftests/{sigaltstack => signal}/current_stack_pointer.h   | 0
>>   .../selftests/{sigaltstack/sas.c => signal/sigaltstack.c}       | 0
>>   5 files changed, 3 insertions(+), 3 deletions(-)
>>   rename tools/testing/selftests/{sigaltstack => signal}/.gitignore 
>> (76%)
>>   rename tools/testing/selftests/{sigaltstack => signal}/Makefile (72%)
>>   rename tools/testing/selftests/{sigaltstack => 
>> signal}/current_stack_pointer.h (100%)
>>   rename tools/testing/selftests/{sigaltstack/sas.c => 
>> signal/sigaltstack.c} (100%)
>>
>> diff --git a/tools/testing/selftests/Makefile 
>> b/tools/testing/selftests/Makefile
>> index bc8fe9e8f7f2..edbe30fb3304 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -87,7 +87,7 @@ TARGETS += rtc
>>   TARGETS += rust
>>   TARGETS += seccomp
>>   TARGETS += sgx
>> -TARGETS += sigaltstack
>> +TARGETS += signal
>>   TARGETS += size
>>   TARGETS += sparc64
>>   TARGETS += splice
>> diff --git a/tools/testing/selftests/sigaltstack/.gitignore 
>> b/tools/testing/selftests/signal/.gitignore
>> similarity index 76%
>> rename from tools/testing/selftests/sigaltstack/.gitignore
>> rename to tools/testing/selftests/signal/.gitignore
>> index 50a19a8888ce..98a7bbc4f325 100644
>> --- a/tools/testing/selftests/sigaltstack/.gitignore
>> +++ b/tools/testing/selftests/signal/.gitignore
>> @@ -1,2 +1,2 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>> -sas
>> +sigaltstack
>> diff --git a/tools/testing/selftests/sigaltstack/Makefile 
>> b/tools/testing/selftests/signal/Makefile
>> similarity index 72%
>> rename from tools/testing/selftests/sigaltstack/Makefile
>> rename to tools/testing/selftests/signal/Makefile
>> index 3e96d5d47036..dd6be992fd81 100644
>> --- a/tools/testing/selftests/sigaltstack/Makefile
>> +++ b/tools/testing/selftests/signal/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   CFLAGS = -Wall
>> -TEST_GEN_PROGS = sas
>> +TEST_GEN_PROGS = sigaltstack
>>     include ../lib.mk
>>   diff --git 
>> a/tools/testing/selftests/sigaltstack/current_stack_pointer.h 
>> b/tools/testing/selftests/signal/current_stack_pointer.h
>> similarity index 100%
>> rename from tools/testing/selftests/sigaltstack/current_stack_pointer.h
>> rename to tools/testing/selftests/signal/current_stack_pointer.h
>> diff --git a/tools/testing/selftests/sigaltstack/sas.c 
>> b/tools/testing/selftests/signal/sigaltstack.c
>> similarity index 100%
>> rename from tools/testing/selftests/sigaltstack/sas.c
>> rename to tools/testing/selftests/signal/sigaltstack.c
>
> thanks,
> -- Shuah
>

