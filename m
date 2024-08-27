Return-Path: <linux-kselftest+bounces-16388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B3F960927
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366D71F2450D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EAB1A0715;
	Tue, 27 Aug 2024 11:43:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B41A00F8;
	Tue, 27 Aug 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759000; cv=none; b=atNsro3cSqo00LOEqGP2GrKUDYzNDc61fsXEseIGWSsWhC2l0qQZOKJKDJnT4CCl8rIT4UtPehxkdvxXgpFoB4J7z8tGuCvaUr2CEKbDxZi1Y1IHNUJdukpouJvXLpqkJ7oVXAG0uBY9dcHwTiDqWJhagfQIgfAo5jlLzoRtUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759000; c=relaxed/simple;
	bh=RjmSkDXi2RDBfO+CadJcReFYsOAh8YsAaybNMMuqMZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8mLG70cklZkDXYf1Hsk+dhKVnQYYulQgHkwDHKARBePpx0d2FVuXplyv9d6tfjXLU9c1KbHxoaQBo27h86AEj6UQZi5hNuyzgdClIScX4RhIG1L7eAAZqVWZCO/JVpX5pKrRqwxQjw96Gadnuddw/WomT2fGeSHCxb2K8y85Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BC85DA7;
	Tue, 27 Aug 2024 04:43:43 -0700 (PDT)
Received: from [10.162.42.26] (e116581.arm.com [10.162.42.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5594E3F762;
	Tue, 27 Aug 2024 04:43:12 -0700 (PDT)
Message-ID: <4a1f75c2-1f00-4842-b2d8-fc94d82698f2@arm.com>
Date: Tue, 27 Aug 2024 17:13:06 +0530
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
 <51617076-3aec-413d-bf42-cf1c359a0c38@arm.com>
 <2b6112b1-ce10-4e14-87d4-04d64972be56@linuxfoundation.org>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <2b6112b1-ce10-4e14-87d4-04d64972be56@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/27/24 17:08, Shuah Khan wrote:
> On 8/22/24 05:10, Dev Jain wrote:
>>
>> On 8/22/24 08:33, Shuah Khan wrote:
>>> On 8/21/24 00:15, Dev Jain wrote:
>>>> Rename sigaltstack to signal, and rename the existing test to
>>>> sigaltstack.c.
>>>
>>> Can you elaborate on the benefits if renaming the test?
>>>
>>> Also you have such a good information in the cover-letter for this
>>> patch - it would be good to include it in the change log for this
>>> one or the new test.
>>
>> Okay.
>>
>>
>>>
>>> The new test itself is good. I don't understand the value of renaming.
>>> I can see the problems due to not being able to fix stables if the
>>> existing test needs fixing. If there are good reasons for renaming,
>>> I am all for it.
>>
>> After looking into some git history, now I understand that "sas" 
>> actually
>> has some meaning, although I still can't find its full-form :) I 
>> thought that
>> sigaltstack would be a better name, but I guess sas is a subset of 
>> sigaltstack
>> as part of SA_ONSTACK. So, let us drop the renaming of the test.
>>
>
> I assume you will be sending a new v6 patch series without the 
> renaming and just the
> new test?

I had already sent it:
https://lore.kernel.org/all/20240822121415.3589190-1-dev.jain@arm.com/

>
> thanks,
> -- Shuah
>

