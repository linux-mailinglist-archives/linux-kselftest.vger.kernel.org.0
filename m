Return-Path: <linux-kselftest+bounces-46957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B3CA1C12
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7F83009955
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C582DEA6B;
	Wed,  3 Dec 2025 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC0DKEfw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C62DEA8C
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 22:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764799267; cv=none; b=C97yRfWZyXilkVhQlclzxTz1X+VDfuld/7m8begSB3iNPsw6YBRwvQCMpErG5CTEUZdXeL6n3LZRJX6U7XsYydajiaohhF1u/+meRVRwvKZTJLZzp7A1Mzb54sxP784/coSvyh2l6hshAYmKm9ookeYTQ7Lfu8ZZNV1mXORzjEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764799267; c=relaxed/simple;
	bh=9sT0+fJ8TXMm4TYaKGBYGldy8CbgZxP+m35lqd6NMSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EfZ783yE8lOqud1ynF7m7xxX/YaX0uDcq9wniJEpPI/mfoarcoFDI9llM6mPuAwpt/Ze6KKN1VA5NRD9RPSwqHFYkgwb3jvlLNiA40RJfPdwGikkoyHJ6VmD7z8BOfuLHuXCqgG1SMYdnVw3EmbsXfdKwhECqW2Uajpt1QgWwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC0DKEfw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29558061c68so3455965ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 14:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764799265; x=1765404065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vs1pb8av9udKBXDYgDxZN37oa5+nlO58rjH1cH6Twc8=;
        b=bC0DKEfwvdlztdVXUq9cmfsyz/pR5nzBZbXo5sV+EnOsKVhe95sO5NNlou91uzsKft
         71PQnH87gfA6E90HY9t8SpRNTVaTJ3rebZCrqwyX2yKKE1xMsj05Riju1YSESi7Vn8r8
         DJZU7osThTvnylNDWIo0cgOJjtoNmNMTJpS2BWNs6DNBwqpL++X7b7E8ioP+QelZwheO
         4WCXftyaDf2u65u7XKLwwJcy6k9jOZVwlJqIneOimU5MTxq6AXVLcm5bnPwaH/7B9ztz
         rTBeX8uNuf+WFEcOIiTG9JDAh6s2e5mKyXHdQW8dltn7yhC2yyKm88io6F4OTyfWpZbj
         Xv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764799265; x=1765404065;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vs1pb8av9udKBXDYgDxZN37oa5+nlO58rjH1cH6Twc8=;
        b=vuV6U5zsiuyOV5Vk0iv+tRpGe/QF9YbIEUjexvH5ttSKFymrqVtnp2HYUWvURaMlzM
         T6u3+UcCDySG7fPE5JjKTarE7yrKwFflniqOku77Nil2vBzAj2pUwvpKvvcG4IKbyomQ
         SguMFaoOzsqB+/FBf4G6qic5LPRjAqrhYHTBafY7DHO93n7IsBhwXEkDuog+33T0lEST
         rQjBrrRV3NLb2f5C/2ZYAdVuY6bF6pqx/o7ERBsJsa5HyNmpOV1DYJu0KNqrC4vqMIRu
         WRCW5KApR8OMN9xaiQZ535ma+huue8ZWe4cIUx+la72+CrxCDWpQ0U8NzCjOSseFldZF
         +Iiw==
X-Forwarded-Encrypted: i=1; AJvYcCUbVFZGnmyiHU750S4h3Yg0yR4w63SaDcf+CRnpQaM8FDe7g+9HWx0EoFZZ44uqGltVgE55aQXApkNtklbT4AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3u0ayAFqSAdHpm9b8onLdi3PntYzjPIu0Mf2Cggg06QwsY/ui
	Ym0fUHuVvCW1E+qkhZTuy4Z2USz7iyBkGalKrptgqAo5qpg4Rxr9NaDD
X-Gm-Gg: ASbGnctJs5HOG7179eDFUPdgDuhwwy3weBWMlyoPnMMSTZ9aKPGxskNdAZ1KSVUNY/E
	RHePFKGePWmNRYyqElUd7ejexWAuTBPn2/Du2vKVX8sCvL9MPlGqX3i9T2xlYvM1VZcszt2JGlg
	vC7gqFvIljvqEh8mJAGi0uHeZLc/XgoSQ7b8nRy0c0DtZ5ik3t6pkB1TwoyOq9VS6xKMGWmpGRm
	0vj2T6mih0dI1kAHUgBzyH3z6JH/EYjmzRMiNmzdZ52Ryq/EJcq30iJ+hBf7UNNAceIOlM3fE0Y
	IomuWMFAWvl6LHXMwagQWtVgX9vCNc0HTb10sH+TYm9djP9Z7EO1Zdm340MVo5hZKJw2Qn2zWFT
	u2N1og82UFXjyi8zS2v6ZJ90+PUuo0lPoHdriJQZiw+nTkm9hp34NNEbNwm+3Xv/g9cPgCCg7G+
	0iPo9du+hU52RmGQd+
X-Google-Smtp-Source: AGHT+IE00D191qMm+BuTvKlU1KXNZVzXoU4O5oIOtdH9iSVALchyNR82XBIX+6YzLxrdVObLDQMpeA==
X-Received: by 2002:a17:903:3807:b0:297:c638:d7ca with SMTP id d9443c01a7336-29d683643fdmr42183445ad.14.1764799264363;
        Wed, 03 Dec 2025 14:01:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce416f00sm194406845ad.4.2025.12.03.14.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 14:01:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4bc33ae3-2dcd-45ad-8244-e76f9d6d9dca@roeck-us.net>
Date: Wed, 3 Dec 2025 14:01:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems when trying to build tools/testing/selftests
To: Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
 <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
 <d64e84ca-8a3a-4ddd-bbef-feebb17ff283@infradead.org>
 <4f96cd7f-57d1-436a-8772-28cf1efe8154@roeck-us.net>
 <12c91daf-0d8f-4b97-a8ee-952dc305d6cb@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <12c91daf-0d8f-4b97-a8ee-952dc305d6cb@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 13:51, Shuah Khan wrote:
> On 12/3/25 14:01, Guenter Roeck wrote:
>> On 12/3/25 09:55, Randy Dunlap wrote:
>>>
>>>
>>> On 12/3/25 9:25 AM, Shuah wrote:
>>>> On 12/2/25 22:20, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> when trying to build tools/testing/selftests, I get a lot of warnings such as
>>>>>
>>>>> mount-notify_test.c: In function ‘fanotify_fsmount’:
>>>>> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
>>>>>
>>>>> and subsequent build errors.
>>>>>
>>>>> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
>>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
>>>>> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
>>>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'
> 
> This usually indicates missing libraries or header path
> issues.
> 
>>>>>
>>>>> This does not just affect a single file, but several of them.
>>>>>
>>>>> What am I missing ? Is there some magic needed to build the selftests ?
>>>>
>>>> Not sure. It built fine for me on Linux 6.18 latest. Are you missing
>>>> a library possibly?
>>>
>>> Guenter, did you follow Documentation/dev-tools/kselftest.rst?
>>>
>>
>> The document says
>>
>> To build the tests::
>>
>>    $ make headers
>>    $ make -C tools/testing/selftests
>>
>> which is what I did.
>>
>> I did run
>>
>> kselftest_deps.sh gcc
>>
>> which tells me
>>
>> FAIL: net/tcp_ao/Makefile dependency check: $(LIB)
>> FAIL: bpf/Makefile dependency check: $(LIBELF_LIBS)
>> FAIL: bpf/Makefile dependency check: $(PCAP_LIBS)
>> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
>> FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
>> --------------------------------------------------------
>> Targets failed build dependency check on system:
>> bpf net
>> --------------------------------------------------------
>> Missing libraries system
>> $(LIB) $(LIBELF_LIBS) $(MNL_LDLIBS) $(PCAP_LIBS)
>>
>> which doeesn't really help. For example, PCAP_LIBS seems to refer to libpcap,
>> and I have libpcap-dev installed on my system.
>>
>> Unless I am missing something that doesn't explain the build failures.
>>
> 
> I ran "make kselftest-all" - mount-notify/mount-notify_test.c built
> fine on Linux 6.18 - which repo are you trying on?
> 
> Can you try "make kselftest-all" and tell me what happens?
> 
> I also tried
> 
> make -C tools/testing/selftests
> 
> and
> 
> make -C tools/testing/selftests TARGETS="filesystems/mount-notify"
> 
> Which repo are you trying on?
> 

Mainline. Anyway, the problem turns out to be the glibc version. The missing functions
require glibc 2.36 or later, but I have glibc version 2.35 installed on the affected system.

Thanks,
Guenter


