Return-Path: <linux-kselftest+bounces-6774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FF1890AA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D591C2D7B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFEA138493;
	Thu, 28 Mar 2024 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpnfpnTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5228536AF5
	for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656524; cv=none; b=nqnTyeAKFTtXF0vi+jaqF3A/kf6cZMqDAscfKIvXCIMD136by/xDacqxge1phMYMHffBcJsl4vO+Iuz9C+9yjoPZey82gzCoZGu7hsuIMkz4lv7mqkKP7CEEnkw62kW5SipJR9JRerPDJaW1Gx1YE+BUCwiYwppVDCuPvHP3Y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656524; c=relaxed/simple;
	bh=I6t3KgEjU2qRRP9KcrIVac26J7Ptg9Ppmc9MupShoAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1b1byTIGX0n8RWarjDtMHd22+1o2UhwqBRk5y5w9ujJ7SLz1WPk321puTMo7uLfFfJm40CArzY2UW0j0nJ/KoDOYMTu6y1vZ9NxqPsMUN4fclQVYNiPsIqf2MgeI1jVOwvc5xeJosQRcPlbLo47gAmRionrFB14JfTlVokKxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpnfpnTg; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-366b8b0717cso1770225ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Mar 2024 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711656521; x=1712261321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hX2UbkZLAvO5S7Uy00v/GVOeEJGGpXwNcZ+Fuf8n4FI=;
        b=YpnfpnTgwIdALWq7x4aoH3uydG5qqCsPZLAMPt2eGGQWzMyiwd4n7tdUkOBVCul53E
         +71MEGOl7faNC6m4tVQ0sFXcWvOz+G7zyTeO0P5v812bXSx97B9u04C6gYcn1lQ1JqE3
         8UY8hnjtoIeLlvrXm4BXSJHAy958jGBzRg9mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656521; x=1712261321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hX2UbkZLAvO5S7Uy00v/GVOeEJGGpXwNcZ+Fuf8n4FI=;
        b=FUr0tgp4v052kiJndNOu/jk6v8og9vcdviId9uh48UWnrxIz+Ly3fwP4uI0hmHho+W
         1x4g4n6C7puF53gCZpk5MjhON3J1SUHAe0y7wHWPrfx624FYVUjewx2+m1/yhvZg+Rxa
         d8tnbDoi9CThN7XlX7sqSueWWKEhVJ6kY4bm9E09+R/C92fTrN/shMKOvsPrFqA+uyB5
         nvjnVEGRjhVP2Qu4+Fd6ojgGiYxdTaBqkhED3MuX1zTjl8ztYtUoew+0Nw/t8A1W6J2F
         QJ82XxojS8v/hNXcND/w2jMXimfydfkf19CcY2L3Gt6F8ahOn42un4Uw3omiW/n118W9
         huZg==
X-Forwarded-Encrypted: i=1; AJvYcCVAfyLbXI3geeP4ZrgHkyaoUknfxXiUrzqORzfXOdzTWuRa8u5l4dOT8n4pBwjGspFgHfwXJ4EEdHv5bF9RkxFOhKMQbl6olTDMLg8knmUq
X-Gm-Message-State: AOJu0YyFnvN3YozbrTX2NMkIH98q/Ttat9GCsePxPDgTdgdl16mdpFxW
	jCyqsEMHhKRYGDwVJwVrwX0rTJ3x4c4BMZ/7Mr/7K+YhVLmjqSMZI1ea1oJB+x8=
X-Google-Smtp-Source: AGHT+IH5wuRtwUVhmqx4NqxWb5J05EXj4zhK6mJCrXso5RB+soobtzV7zz03fOsFxx7Dm/XUqXlavQ==
X-Received: by 2002:a5d:9b1a:0:b0:7d0:8461:7819 with SMTP id y26-20020a5d9b1a000000b007d084617819mr243559ion.1.1711656521397;
        Thu, 28 Mar 2024 13:08:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x101-20020a0294ee000000b0047ecf81bea3sm367165jah.84.2024.03.28.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 13:08:40 -0700 (PDT)
Message-ID: <6591ea0d-572b-4deb-b2a7-da58ed91c8f9@linuxfoundation.org>
Date: Thu, 28 Mar 2024 14:08:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kunit alltests runs broken in mainline
To: David Gow <davidgow@google.com>, Johannes Berg
 <johannes@sipsolutions.net>, SeongJae Park <sj@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
 "x86@kernel.org" <x86@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
 <20240325185235.2f704004@kernel.org>
 <33670310a2b84d1a650b2aa087ac9657fa4abf84.camel@sipsolutions.net>
 <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOS=F0uFA=6+cab56a_-bS1p79BrpF6zJco7j+W74Z4BR5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 04:09, David Gow wrote:
> On Tue, 26 Mar 2024 at 15:55, Johannes Berg <johannes@sipsolutions.net> wrote:
>>
>> On Tue, 2024-03-26 at 01:52 +0000, Jakub Kicinski wrote:
>>>
>>> I'm late to the party, but FWIW I had to toss this into netdev testing
>>> tree as a local patch:
>>>
>>> CONFIG_NETDEVICES=y
>>> CONFIG_WLAN=y
>>
>> I'll send this in the next wireless pull, soon.

You are welcome to send this with wireless pull if you like
or I can include it in my pull request.

Either way let me know:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

>>
>>> CONFIG_DAMON_DBGFS_DEPRECATED=y
>>
>>> The DAMON config was also breaking UML for us, BTW, and I don't see
>>> any fix for that in Linus's tree. Strangeness.
>>
>> I noticed that too (though didn't actually find the fix) against net-
>> next, wireless trees are still a bit behind. I guess it'll get fixed
>> eventually.
>>
> 
> + Shuah, sj
> 
> Thanks for fixing this. I've sent out a fix (though I'm not 100% sure
> it's the right one) to the DAMON issue here:
> https://lore.kernel.org/linux-kselftest/20240326100740.178594-1-davidgow@google.com/
> 

I applied this to linux-kselftest kunit-fixes branch

I am planning to send this up tomorrow.

> I don't think it'd conflict with the wireless fix, but if so, I'm
> happy for them both to go in via KUnit if that's easier.
> 

thanks,
-- Shuah

