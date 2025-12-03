Return-Path: <linux-kselftest+bounces-46955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188ADCA19BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 22:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15ED30088AB
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 21:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4523B2C1580;
	Wed,  3 Dec 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeOzuCmp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8EF253958
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764795680; cv=none; b=CFgBE3vnv+nxda2AN3i8QTmUrpOb0BwOLl0aSLmpbtZLMpy36vY8VNJq8rXVC9cIHr9Z7gk0eXcmEG96pIE+pCokRanFI84xeh02Qp2KyWM37CX9mxI5MU74ZixWQi32dBwCH4PvzxYajSBHuZctn8cE+hvWgsgQDNUWvpbQbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764795680; c=relaxed/simple;
	bh=s+s4z6tsTXL+hm03O6C1+a1kEU9ELNEOh3beZ2o8QF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NvBxwVWwlY45FfAbX28wgdp4XN9g/Bmo4EFXxF8iX7bB/UBs/VTSDRbvE0vHP3+XtVM433om+U+zmAFmALT+p8TDkqgKYKFPs/z1cfm0oLmxH14EP5Uu6o6vIHJUl7u15QUdIQv0u5izZ/uYro8O5SRv7WzwAVRSnTLSahF2+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeOzuCmp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298039e00c2so2642405ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 13:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764795677; x=1765400477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gqB9g3t+4p0L9h5VyzXhPMLTu2DQqiHGTMI7m9zj0yM=;
        b=DeOzuCmpI10u1lDv3WXA0ZYg84X+MGFGEGAM2pPCLbTv4AeaIOcszEUTrwnhM5rA67
         fQ9s1oXiNqvpDW9wYOUOH2zHhH20paIttIoKqhosOCxuWBAbQi0jVNtkyy/5mRbb6bgU
         FQTSEWIjAAqFH0DOKivISpwjJbgrTHy51P9CJka35ZpxitIDvrtxuFawSv9EZ5KBq+6j
         f+tD3UPXiZnZpb+aT8p44Db7OMeziYiN/z1ewvfSHrdcLxjARpufF0zjzPXkdu0s5IdI
         jmp8zQVwJZJM0PVOAJM3MpT8VkvDvEsQ1QvPtMY0qIGDf8Ti2CTp+vZj6sxef3B/8ZF2
         TqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764795677; x=1765400477;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gqB9g3t+4p0L9h5VyzXhPMLTu2DQqiHGTMI7m9zj0yM=;
        b=chzszyGdrhO1tkUmZpp6wE72jbZIoqMyIvD4ayrs1HqgriHqMws6aPgPMYoAvrQDz4
         PZSDZM1QycFj/MoBHQkDYeLXs1SxIbDf/YpwUFceMG24+hUe79sA3ogU4PzffyYzLfe3
         CMyP+Et71aTmuYu1uSSNLLjwYlve7tIot/WwVZMLK07jB4KXs/wcPWK2zjG8PMJBFFnF
         Ga93CED43AHGB4WSHuPnZIY/6+cqnj1Ncm/A9BDkKYFgAMXHMYozPDotWnXgTDlqHGQd
         sfp+9bc/UqNm0kdN8KG+Q/k2BKHXTwAYNdzitU17rFImHwTlAXd6xU3uooXiu4MbJbcT
         aVkw==
X-Forwarded-Encrypted: i=1; AJvYcCU0gxfrJosyjgmyxxJRqD9uSnpHH16enCPOy2LyDgF3LGIoPx43DynobRayfsObdaEWMPzqyViKdDtRM/oyBHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZIiL4NhGksMUWyNpn+iR8R13Mh3plzoiFxeQiR8iG8iKwlPD
	EL7cTk0awS90UHZhcfzI93VpnlKXXH697nfwb3vTAh0nSicgBixPBAof
X-Gm-Gg: ASbGnctS+pwss75Cuvo2GnkJun4dkux/jMc240M/Y4tw7VRgoJolB4vIHM6ND1PEsWq
	ToajrWdU6Kw9X8a63yNGPyUIvJZalwcqqM/2DooxJFGKO0KnXUCJOF2JyAKh82AuzBd8ZCHpcVW
	uhWQ2xvQA8Ej+B4HOSHB7qNgLPO3XOVU2C3u0iefkmt0QsVOfIm0yqETp1j9JcOal0YkMC1jV11
	Od4Xk6e7yDr0NkxiM7SD0ukyzuwydpU3ebTcBzHREYkhJbRyN4PNvw+TTy+7HnkQSrY78ejR/Mj
	kL5Amc+pg/wuDOt1LgVTzUVUIVzp9iq11/IuRwPX41UZwcH/Cp2wobCNjyVmQSP0zyKRitSUWMa
	rCe8ccK8itdUhF3o3/3gcb1riUSJ3t7aRHrtJ8wvJpzE0/cdwuP2Zl/Sryds8YAZeS5Y04zO5Y2
	cD9DHmNuTNs60dOwAzAvcgWWo7NRRdSDoS4TZkoS6KBFJj8mVndt1GYxS8xC0=
X-Google-Smtp-Source: AGHT+IFS6lwamE93w4Hz6p7e2w+Yya5WHdh12Pi5G0TqHFlb6OrNFsAZoAJXg254Gc3PPHMLV+UY5g==
X-Received: by 2002:a17:902:cf4a:b0:296:4d61:6cdb with SMTP id d9443c01a7336-29d6839a670mr49210285ad.27.1764795677046;
        Wed, 03 Dec 2025 13:01:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb276a7sm192264815ad.48.2025.12.03.13.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:01:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4f96cd7f-57d1-436a-8772-28cf1efe8154@roeck-us.net>
Date: Wed, 3 Dec 2025 13:01:14 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems when trying to build tools/testing/selftests
To: Randy Dunlap <rdunlap@infradead.org>, Shuah <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
 <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
 <d64e84ca-8a3a-4ddd-bbef-feebb17ff283@infradead.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <d64e84ca-8a3a-4ddd-bbef-feebb17ff283@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 09:55, Randy Dunlap wrote:
> 
> 
> On 12/3/25 9:25 AM, Shuah wrote:
>> On 12/2/25 22:20, Guenter Roeck wrote:
>>> Hi,
>>>
>>> when trying to build tools/testing/selftests, I get a lot of warnings such as
>>>
>>> mount-notify_test.c: In function ‘fanotify_fsmount’:
>>> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
>>>
>>> and subsequent build errors.
>>>
>>> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
>>> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
>>> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'
>>>
>>> This does not just affect a single file, but several of them.
>>>
>>> What am I missing ? Is there some magic needed to build the selftests ?
>>
>> Not sure. It built fine for me on Linux 6.18 latest. Are you missing
>> a library possibly?
> 
> Guenter, did you follow Documentation/dev-tools/kselftest.rst?
> 

The document says

To build the tests::

   $ make headers
   $ make -C tools/testing/selftests

which is what I did.

I did run

kselftest_deps.sh gcc

which tells me

FAIL: net/tcp_ao/Makefile dependency check: $(LIB)
FAIL: bpf/Makefile dependency check: $(LIBELF_LIBS)
FAIL: bpf/Makefile dependency check: $(PCAP_LIBS)
FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
FAIL: net/netfilter/Makefile dependency check: $(MNL_LDLIBS)
--------------------------------------------------------
Targets failed build dependency check on system:
bpf net
--------------------------------------------------------
Missing libraries system
$(LIB) $(LIBELF_LIBS) $(MNL_LDLIBS) $(PCAP_LIBS)

which doeesn't really help. For example, PCAP_LIBS seems to refer to libpcap,
and I have libpcap-dev installed on my system.

Unless I am missing something that doesn't explain the build failures.

Guenter


