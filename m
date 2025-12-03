Return-Path: <linux-kselftest+bounces-46956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 716BDCA1BDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 22:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAC430762ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 21:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D722DC32E;
	Wed,  3 Dec 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HXuBc7Ih"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9662D94AA
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798669; cv=none; b=ZJBCeXGBWVidvS3kKrB2RRkAlFsOjxofBAVgZFxjcgqdGtvkx7QKeABx+ESiuJz/8FwVZLFkquawxSvxm2qN/0+KFUlwTIMRbIz0hIRV+5WEkxD/ihQuEJpMIN5LhpMAjqtiEvPxUm16IL1g3ECYcHczNsgIFJPtcVo469ADbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798669; c=relaxed/simple;
	bh=O9zAavxTCb1TAkIFYzgTdQqxEXTMai2KVO4nOW83EY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DiSOHu8etElYE9BeQvhD7VNTnnZhWFSOf5qEKBig3L2lVJDAd7EoYKPblFqmFHT6ACC0LgyRvXTcM3fld85WEzUYhcFBT6efKkuuXw19m5It3u4uuKhUEyfF4AUefu5hgxSCcWFli55FY8hCHpzWM6VO2rf2fwRCzIxfw5GTJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HXuBc7Ih; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c6d13986f8so299463a34.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 13:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764798663; x=1765403463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSMqQ9wEFyazEFxYHOzHs30SlRAaTphdBlHe5ArebZk=;
        b=HXuBc7IhUmgLlbuxibOhSFwgq2s/GkyAyAoHIH6fWw6GcbcIYUdK/ChYWb7O483Q2I
         4ivofcNL0JhmScuWuIm5CYewRxRSOM0IO0fhPLSMpf1QfEL2PeBLZRP04yEedMQNExZe
         TcAOsLygxqu2hZGZF/9eXmyitWdknABxZz5dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798663; x=1765403463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSMqQ9wEFyazEFxYHOzHs30SlRAaTphdBlHe5ArebZk=;
        b=fN4mkTCZ7qdwHMoMNNek26hSILTyD8/wM1j7hAcJBbWGZzejpuFtBL0/G6Uq8YN7Pf
         wpCcz2o4Nig/o5OXbX8NDZ78Woy6VgASwNT9cqR+54RbO40kNyGBGF2AclFHW+rsPARr
         /4h6oCGkwPrFvpU3nGQbTYaO4KSFIL8tM8ckknyIIoKOIP6Eq9cmS5+HCNE1z/cKZA5z
         PtMwtAP105HQ0sI+1+r1AjsQDike66ARoTnxFZOVZ64N8NaOvDFwa9AxTMISsEMqG1m/
         HK7kUYfExg+FMWpb3UbfaOYtGPFEei68WoxfwjXx8EcZjotOM4K8rcPhoK5uyAudO1FI
         /Pbw==
X-Forwarded-Encrypted: i=1; AJvYcCXWovVKoa0ew4ZgTqbr/LjxzovRBsXXpLdcjFNMREu3SLIGXs0McEKv6qBYMUniaklNX3jZOzxo1v/gwu2GVR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnbmwMx+6AmuMN1szxV9Cml2Gxi0yUoKnF+btT51/ozUkhmvU
	q7KXiOpCnLpSoE8t9ssihJfoSiubIGnAd2085judmtleWCx+EvOGpIAR44npyw6aBEnqXsvE7RT
	oo/VB
X-Gm-Gg: ASbGncul9hL6ME2144e6A9ZBp9YvDeMYloPKIFsyZ7wV+LL9ho+lCYpKSJwkRz9rDoq
	2l0LtOByxWknooA74G2x8c86vTO20CvZZRUvvqmy3a9LuNJ6rbL4QqmJJwVJcInp3FlsRHxA4tu
	9CX1COVPAlZmy32rLSrLGk6igvEtuibn2v1ac3ADbFDuxdZrlSsZTkjMA7oZcV4RNVjS4vKXvKq
	AsZAPDYRA68DgKO8bON+9wEVYtBc8fj0WhtpRHFkOg9TtOeVwjwPnug8T+Px5FbtZC38qbdSYuI
	7GfOnoR02AmxG6C6MHg3zJTsRRLVzPwUpEnT6kXX9RLDcWWivROSbiI/JP/4xN/1/Wptxdo059s
	s5izRQDLROMk/1QNopn1zqzAFTsu5XcyHQ8BX1M2bqt/t1fCDkxj2o0Wf
X-Google-Smtp-Source: AGHT+IFpdwEcy3/cEfbXY99G3KaEU0rlXTCqVKzf7UfjxpGGxqR+UZKQlJSOmxG6ym0PX4/MfbCy/A==
X-Received: by 2002:a9d:6b13:0:b0:7c5:38d2:fe1e with SMTP id 46e09a7af769-7c957c58041mr709947a34.11.1764798663333;
        Wed, 03 Dec 2025 13:51:03 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5d7d73sm9520754a34.3.2025.12.03.13.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:51:02 -0800 (PST)
Message-ID: <12c91daf-0d8f-4b97-a8ee-952dc305d6cb@linuxfoundation.org>
Date: Wed, 3 Dec 2025 14:51:01 -0700
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4f96cd7f-57d1-436a-8772-28cf1efe8154@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 14:01, Guenter Roeck wrote:
> On 12/3/25 09:55, Randy Dunlap wrote:
>>
>>
>> On 12/3/25 9:25 AM, Shuah wrote:
>>> On 12/2/25 22:20, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> when trying to build tools/testing/selftests, I get a lot of warnings such as
>>>>
>>>> mount-notify_test.c: In function ‘fanotify_fsmount’:
>>>> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
>>>>
>>>> and subsequent build errors.
>>>>
>>>> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
>>>> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'

This usually indicates missing libraries or header path
issues.

>>>>
>>>> This does not just affect a single file, but several of them.
>>>>
>>>> What am I missing ? Is there some magic needed to build the selftests ?
>>>
>>> Not sure. It built fine for me on Linux 6.18 latest. Are you missing
>>> a library possibly?
>>
>> Guenter, did you follow Documentation/dev-tools/kselftest.rst?
>>
> 
> The document says
> 
> To build the tests::
> 
>    $ make headers
>    $ make -C tools/testing/selftests
> 
> which is what I did.
> 
> I did run
> 
> kselftest_deps.sh gcc
> 
> which tells me
> 
> FAIL: net/tcp_ao/Makefile dependency check: $(LIB)
> FAIL: bpf/Makefile dependency check: $(LIBELF_LIBS)
> FAIL: bpf/Makefile dependency check: $(PCAP_LIBS)
> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
> --------------------------------------------------------
> Targets failed build dependency check on system:
> bpf net
> --------------------------------------------------------
> Missing libraries system
> $(LIB) $(LIBELF_LIBS) $(MNL_LDLIBS) $(PCAP_LIBS)
> 
> which doeesn't really help. For example, PCAP_LIBS seems to refer to libpcap,
> and I have libpcap-dev installed on my system.
> 
> Unless I am missing something that doesn't explain the build failures.
> 

I ran "make kselftest-all" - mount-notify/mount-notify_test.c built
fine on Linux 6.18 - which repo are you trying on?

Can you try "make kselftest-all" and tell me what happens?

I also tried

make -C tools/testing/selftests

and

make -C tools/testing/selftests TARGETS="filesystems/mount-notify"

Which repo are you trying on?

thanks,
-- Shuah




