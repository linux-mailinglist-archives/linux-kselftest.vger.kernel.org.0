Return-Path: <linux-kselftest+bounces-34177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F00FACBD47
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3778E3A4BF4
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 22:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E024DD0D;
	Mon,  2 Jun 2025 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GUFRRk28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C2182D0
	for <linux-kselftest@vger.kernel.org>; Mon,  2 Jun 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903088; cv=none; b=Z7GzWtDTlavMRfO2YtwWotzk5g+4J25TmAhLX4/B6sZUXJZwzeGHJIm4xb4JYw9LvzrNKNrthbKLDC+OqZ97sKzmw3KYIBIdTSEpT4qsc8DvQtQiExNUP2PKdNRl9KocXR8DOTq2Vu2enSWvOqzOgKvQbrqviKgruHkt3tE4rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903088; c=relaxed/simple;
	bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5jQPMJvyASjV+6SZxzG+9ZpL083e1gJyndjehKEPq/p5GEdDrC1zdUFx2gac2C7SgZUliiUe+6jJfuBT8xTHgmAF4KEgpz/r1rRCTkx2vARamJ5gcNl3XLSN86oLGApIOA5gOtwgs+FwSPSNfMoAu0wZh8j+OtoVBKbpz0kvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GUFRRk28; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3da82c6c5d4so41233925ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Jun 2025 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748903084; x=1749507884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
        b=GUFRRk28OpOQL19ikT4PHwTSapkMk/noXHCUXrgS323PzUWoFQaGZVpcucGQrS2FIC
         KCMNjVbzNgKH2DWaece/WKEEVinH8iPEnEqa8P/ung4GvoDYz37NDXc4S8GSfviXgwIF
         Wq+cIi8hiUCYGrKP63fBsahMHSOOq/M8N+Bcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903084; x=1749507884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
        b=hzP4WNpfDXriLoR53dbeolFYjEqAjyh0B0BPwBEX01eCrvcQ3li3iaiRUtixCxbSZM
         AHNezMWn5f2so3G+p+JaTWn7qZU54VjwsobALm6xNzTeMhT/4FtgUr6yySjGAWSuH+XN
         pYUIFNn2DM897ffHpHkbRDU919U0ykaDaAtAUK7p6f2tdLlpfo616/w0iVaLfl3hOx82
         ZMEAdUnIvh23OqWvLA0RsTs1JVL3v7H09psSMjB5sEvh12y2VPhOP3+fRluf2DNGxokN
         h/k7QLPpVnj4pB2GI5USlBG8i2PMUnZ+x31HG95TG+6lLizNCgXK890uH5SUXFo+2qwP
         MZAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38mUg7Dyzd86DlzC3f9mELsdozlafp02DrtIkxB5LXK1dnSw5IUOq/6TOhomDYW0ykgkRFMs17AL5XH8qvcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4xHtbaMUO1D29qBjsp6izylWVbb1EjDStfWcditB9FhIrCy0
	Vtspn3qhConmwTW2APZWo63pgSpnHtwoNNtNuAJUwg19ECDMt4rYHIsBotkKagMIfn4=
X-Gm-Gg: ASbGncsXlwjg32UqvMkP+UicWr8dsf1juRJ1raLN49e4/v06qsrrRt0XqiKzS/EGr1B
	XyjxJtJO6pW7bLtb1aWTPbp8cgrqelF/fdk9P2aTMz1sT/KitPsbNsuiwrlE25tRw1J72Yru6AA
	tQ6GqCCywwJttEAZsT5zlPgNlenLdC9QOarETNigH3iXZuzRm/8JW9zIsuNuFx9FdT5/Dvyvx2R
	zjcndA3X1aoq0AwecHIuBO1lq5CZusnmbNtCw0yEilY9cuC5vq9grHiXaWIP1+5pA3VzMQhZ9ta
	iHlLi7Vddhh6rVnZTHIU1MeKRWqjjCRmmK8gUNU4f5PIlEI+ocDdjjaUd5j/0Q==
X-Google-Smtp-Source: AGHT+IEoBt1WDQlTWQAcC5v2oWlv5fTd2KvSmZQf2T9kZlu31kwNdxUFhUjaMoZ7f5E6YihUTLo/9A==
X-Received: by 2002:a05:6e02:1a4b:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3dda3388352mr97576605ab.15.1748903084143;
        Mon, 02 Jun 2025 15:24:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7ed8160sm1959548173.98.2025.06.02.15.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:24:43 -0700 (PDT)
Message-ID: <1e36801d-7bf5-46dd-bcc5-669fba575806@linuxfoundation.org>
Date: Mon, 2 Jun 2025 16:24:42 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, broonie@kernel.org, mic@digikod.net,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
 <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
 <20250530180750.4c722f71@kernel.org>
 <74d3a550-a828-4666-8664-d08d06fc6f0f@opensource.cirrus.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <74d3a550-a828-4666-8664-d08d06fc6f0f@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 07:34, Richard Fitzgerald wrote:
> On 31/05/2025 2:07 am, Jakub Kicinski wrote:
>> On Fri, 30 May 2025 10:59:54 -0600 Shuah Khan wrote:
>>> On 5/30/25 07:58, Jakub Kicinski wrote:
>>>> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
>>>>
>>>> The commit in question breaks kunit for older compilers:
>>>>> $ gcc --version
>>>>    gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>>>>
>>>> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>>>>    Configuring KUnit Kernel ...
>>>>    Regenerating .config ...
>>>>    Populating config with:
>>>>    $ make ARCH=x86_64 O=.kunit olddefconfig
>>>
>>>
>>>>    ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>>>    This is probably due to unsatisfied dependencies.
>>>>    Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
>>>
>>> Does adding config option work for you?
>>> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN
>>
>> Nope (with this patch applied):
>>
>> $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN=y
>> [18:02:47] Configuring KUnit Kernel ...
>> Regenerating .config ...
>> Populating config with:
>> $ make ARCH=um O=.kunit olddefconfig
>> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>> This is probably due to unsatisfied dependencies.
>> Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
>> Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".
>>
>>>> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
>>>> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> ---
>>>> I'd like to take this in via netdev since it fixes our CI.
>>>> We'll send it to Linus next week.
>>>
>>> I am good with reverting it for now.
>>>
>>> David, Brendan,
>>> We will have to enable this at a later time. Also we saw this problem
>>> before with other configs. Anyway way to fix this for alltests case?
>>
>> FWIW Richard commented in the linked thread, IIUC this was just for
>> added coverage but not a hard requirement.
> Correct. It's not required (for me). It found a bug in my code, so it
> seemed useful to have enabled while testing. I thought this was safe to
> do, I didn't know that this only works with certain platforms and
> compilers.

Thanks for clarifying. Looks good to me.

thanks,
-- Shuah


