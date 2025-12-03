Return-Path: <linux-kselftest+bounces-46958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B59FFCA1D0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 23:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4FA1301AD37
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191072E4274;
	Wed,  3 Dec 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="frt6pfr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4723279DAD
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800717; cv=none; b=I1tVxK7RT5a5dmD/MikFy3oQfdF8ceDsrk6SoZZIZjk3OyLMcML3AHwA1Q01STCwZSqNMMKKP952zwMfsE6TVIK7mKXc0etkY84NnXBI11akiH85MLO6dSJ5OvywqVenbY4KPeksfROWbKngzYE6ea0sqbwormW7hNOAe+OEiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800717; c=relaxed/simple;
	bh=4SBgRp4n+DRsTD4L0ZplW0NQ7KL95skCU54ZwHxiPb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vDTVpZBKfCu/z1fwfsKFLMyoh6tJMktYvPZzPIzjt46+kJlB3/R5SxFc39taThXyiLddbeuC+rARfBngZK3yoWe15ysegqETMCJ6ncuu+Dwu0IB3/xLWuFwQi2oeuQa5w3vTab4NO2nv7iDjWr/xpiDEO1wyUV4oKxQ7CNFKFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=frt6pfr9; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4511744b411so137038b6e.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 14:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764800715; x=1765405515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CthXecajl4+p0sKrhX5bfUZIRCev2Dr0mohWtBY5/Lc=;
        b=frt6pfr98+alS7lpPctkNoaOZn4JXEHogXG3jZyfWx+GSSAfWMGqasqR/jX5IEeqwh
         rpB5FietrgL/UYqn4Ak1G+y6XWWekKZ8OJTRaJjgr97CB03+w0TkjVrFrLlUzYX49yjq
         Vq+uMvpvc+W32GYM8ML6RTdYlFtqx7v/RuzxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764800715; x=1765405515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CthXecajl4+p0sKrhX5bfUZIRCev2Dr0mohWtBY5/Lc=;
        b=iCafwDpIfHTky7g/se1wb2sslXqCRvQN9kaKE7TsIWJMRhWco7xFfciYBnb7K9ioyI
         LPWx/0f6pn2uBwXoVdjXI8/Jqz9zKDSuCCCprDbyAoEjCQNf6jpBHNyVL31mYID4hk9y
         yrBhZ2sCu52ecOPT3bx3dSTzMbgGt4UM2idLnljpHQsPAmRgckTfh8MKhOrEeMCOLUeW
         srtt/WeuDCqMtWA7O92tko3BnU9cDTd4DfoE71cH8blbPzDJpte0MafkQi8PCMLV1ofB
         QOQINI4QCcUbg6P3uvmikxl9o5q9CgnI+YCPuA7wM5pG8XoQFchHXQB209T2Kvc8i0I3
         3Jpw==
X-Forwarded-Encrypted: i=1; AJvYcCXkffehE435oMWQjZFwyEGt8IAJMpaswViJ8GyANCYMD8yHcP4KQO8seGD6Ltc8wKmzDcHDIbyA9yoNrpwAVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgqVM59F5Hx1VIRD06SITCVTHII3c4ZVKn7l1ZhJ9zZjWiBpm
	0JgvNnJzDH8dAOL6sk9FinRYMLOUTNlImikiL+IkUUgtzecZX0qBSahBettliand+V4=
X-Gm-Gg: ASbGncsH6IifNJP/9kDEcFZW0Hofb9dOiSvSVPjf/3RoCIMQng8E6c5DcLv9VL3jCoK
	eqG/3+S3g+8cfrmNg09GAi3SltXmCOXoSinFVbvfLx2jPHx5N3fXsiPYb0GoedGP339P6qVDOXu
	XD6viakB6w/fhdqXLa//ITb0kRYWYKTyNaUtel+nsHcmM6GHoosrgx6Oej5AP+OifcPEW6NwXv2
	zs/PpPfXOcWFkHmBZkN2OJR5GoPGjw6+pSjXyQJ1rQ0sTn5+zIQ1QhnH+M5AaLy7A9UIT0xIf+/
	mNvW6eoB+VhMgYqftWIwmUFwkRfCuBUjV8oEqODscBq9lUTIQXFY9ITh7llyXYS6cLvP8Ts3oSH
	/BmiIzBXv+B8B0jKZ3kb7Omz3SvxzF32UWTYrStnIbCSl4QpeJTrV8wK+
X-Google-Smtp-Source: AGHT+IEpkolFrcch/m3HXfBivPhLeQuPvPYHVhCJhGAAxL3+PJndCeOsgH+s1zXaUgPto9W4rAzv1w==
X-Received: by 2002:a05:6808:c151:b0:450:d056:e0d3 with SMTP id 5614622812f47-45379e1cd5cmr464443b6e.56.1764800714897;
        Wed, 03 Dec 2025 14:25:14 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc3fb2sm6337107eaf.11.2025.12.03.14.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:25:14 -0800 (PST)
Message-ID: <3aad353c-2e98-4baf-9e8e-86cb9f972f8c@linuxfoundation.org>
Date: Wed, 3 Dec 2025 15:25:13 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems when trying to build tools/testing/selftests
To: Guenter Roeck <linux@roeck-us.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
 <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
 <d64e84ca-8a3a-4ddd-bbef-feebb17ff283@infradead.org>
 <4f96cd7f-57d1-436a-8772-28cf1efe8154@roeck-us.net>
 <12c91daf-0d8f-4b97-a8ee-952dc305d6cb@linuxfoundation.org>
 <4bc33ae3-2dcd-45ad-8244-e76f9d6d9dca@roeck-us.net>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4bc33ae3-2dcd-45ad-8244-e76f9d6d9dca@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 15:01, Guenter Roeck wrote:
> On 12/3/25 13:51, Shuah Khan wrote:
>> On 12/3/25 14:01, Guenter Roeck wrote:
>>> On 12/3/25 09:55, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 12/3/25 9:25 AM, Shuah wrote:
>>>>> On 12/2/25 22:20, Guenter Roeck wrote:
>>>>>> Hi,
>>>>>>
>>>>>> when trying to build tools/testing/selftests, I get a lot of warnings such as
>>>>>>
>>>>>> mount-notify_test.c: In function ‘fanotify_fsmount’:
>>>>>> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
>>>>>>
>>>>>> and subsequent build errors.
>>>>>>
>>>>>> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
>>>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
>>>>>> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
>>>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'
>>
>> This usually indicates missing libraries or header path
>> issues.
>>
>>>>>>
>>>>>> This does not just affect a single file, but several of them.
>>>>>>
>>>>>> What am I missing ? Is there some magic needed to build the selftests ?
>>>>>
>>>>> Not sure. It built fine for me on Linux 6.18 latest. Are you missing
>>>>> a library possibly?
>>>>
>>>> Guenter, did you follow Documentation/dev-tools/kselftest.rst?
>>>>
>>>
>>> The document says
>>>
>>> To build the tests::
>>>
>>>    $ make headers
>>>    $ make -C tools/testing/selftests
>>>
>>> which is what I did.
>>>
>>> I did run
>>>
>>> kselftest_deps.sh gcc
>>>
>>> which tells me
>>>
>>> FAIL: net/tcp_ao/Makefile dependency check: $(LIB)
>>> FAIL: bpf/Makefile dependency check: $(LIBELF_LIBS)
>>> FAIL: bpf/Makefile dependency check: $(PCAP_LIBS)
>>> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
>>> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
>>> --------------------------------------------------------
>>> Targets failed build dependency check on system:
>>> bpf net
>>> --------------------------------------------------------
>>> Missing libraries system
>>> $(LIB) $(LIBELF_LIBS) $(MNL_LDLIBS) $(PCAP_LIBS)
>>>
>>> which doeesn't really help. For example, PCAP_LIBS seems to refer to libpcap,
>>> and I have libpcap-dev installed on my system.
>>>
>>> Unless I am missing something that doesn't explain the build failures.
>>>
>>
>> I ran "make kselftest-all" - mount-notify/mount-notify_test.c built
>> fine on Linux 6.18 - which repo are you trying on?
>>
>> Can you try "make kselftest-all" and tell me what happens?
>>
>> I also tried
>>
>> make -C tools/testing/selftests
>>
>> and
>>
>> make -C tools/testing/selftests TARGETS="filesystems/mount-notify"
>>
>> Which repo are you trying on?
>>
> 
> Mainline. Anyway, the problem turns out to be the glibc version. The missing functions
> require glibc 2.36 or later, but I have glibc version 2.35 installed on the affected system.
> 

Ah that makes sense.

thanks,
-- Shuah

