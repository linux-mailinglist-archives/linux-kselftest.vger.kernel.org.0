Return-Path: <linux-kselftest+bounces-17755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2919757F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD8EB21B69
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249D31AAE0C;
	Wed, 11 Sep 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M6teSROF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42839185B48
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070730; cv=none; b=jnLiyIMnitSSbEUa4+gFseVinoMXG9Aw4VzrGJ0D5+6k/l1AjJT9kA73Ub4AyKU2kh/TLD22qlHQ1G7Te9LWkMG4UFj88sCTFNoEm9EI4mgBI5D/x+tvWdqpW4DZhBQ5fDNhcGr85qHiI3G5sd3KXmqwwuKpHTr+tN5vtEVMfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070730; c=relaxed/simple;
	bh=vVZnPoaE4LggcEZLAPIaQZAUImydt4yJz2th7TcSAng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNrcOKKHPTQM2AjYLDzT+UM2s4PF+SVWcD7mbKSPYQAYegph0sJzQn2zpB8ChZOchLBCRa7S/NPrbw+9T048NCe17b/2fGlSQ879rOfYqAhY/HeB2dl5szGeyQWURimLMBdOvyj/jHoGDyQL34b9C3izZ5LmHLQR8OlUFv9Tq1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M6teSROF; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-82aef2c1e5fso211449739f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726070727; x=1726675527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=M6teSROFNydjTBzX58tX+cL6vELBY8AUooloRjYO1frbc0Yvb852U6rxJs3v1uOtjl
         4wXU/wx0bc+FITuU7fOg7TbrtXU0oLtNigAG1PeYxoDvPubS0ig9IB0CZxJePbRSUqnw
         ZrPeHdJQ6s/L1hChXNbapujx+5cZdeS8crK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070727; x=1726675527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Iw9687spOPNQCPbJFKxHUyq06TwqtAPtEJ5vZKod8=;
        b=PzLdHd3wUyXD1rCv7z9DkkuOKe6ZPI2sYGmrZ7nm1FIIgm9tlh0TC+Plh4p67S+ahI
         wcmPPftzDHqh6ZoP6MoVrsUHjMk/1Uwu3C2/EduPrEz+C361Ufq5EvVhNEzs48ikvIHs
         AoXFMEu2M2TXowz0c6jd7OPOsMyEk9euqeP3RjLpozL5EPFzNnsMCAmWlcpn12Qos48A
         Afu1CbOGan+492xvl4faNNvFPRrY194Z6PUacf7M8iX429xDTMcdebE14z2v98reqIN3
         eqvonh94goO4CGt5gO9KKFM3Df8dtO5cWAATyDDLcBOu7kgBb2bP5oYd7pGJ08g9K84v
         mYLg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjpaqi4YYwyhhOObR4ayhjA3Gy8kcdZc5HS8afCjbB96eh4VMlHvshj0lECwH3oaWWHs9l/5dDFa1onXBDW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/OUWaR/cac7LyTpHB8CGu3txEdqd5dkuvXKYTzwpM4wO/eGM
	g64s/Tornzivz5TbQiQykHhI9lalcgbzS+T98Vic5gysWJ9Vw+FRBNenK7lCDig=
X-Google-Smtp-Source: AGHT+IGEh7vjg7kq8R20aGT4OVcirpJB3SMMzymLEMZ/gLxeZmcW+d+B8YzJGPUgnDl45eazKCfULw==
X-Received: by 2002:a05:6e02:174b:b0:39b:640e:c5fa with SMTP id e9e14a558f8ab-3a04f0ce28cmr207759325ab.19.1726070727091;
        Wed, 11 Sep 2024 09:05:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8da6e4sm54775173.124.2024.09.11.09.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 09:05:26 -0700 (PDT)
Message-ID: <67cac093-e50c-44d7-8cdf-16b6624765ee@linuxfoundation.org>
Date: Wed, 11 Sep 2024 10:05:25 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/2] ring-buffer/selftest: Verify the entire
 meta-page padding
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@android.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240910162335.2993310-1-vdonnefort@google.com>
 <20240910162335.2993310-2-vdonnefort@google.com>
 <20240910124541.23426cee@gandalf.local.home>
 <14143861-bc16-47f4-ba8d-7d577e7a9dd0@linuxfoundation.org>
 <ZuFMK7yndArZo4pA@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZuFMK7yndArZo4pA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/24 01:52, Vincent Donnefort wrote:
> On Tue, Sep 10, 2024 at 12:49:58PM -0600, Shuah Khan wrote:
>> On 9/10/24 10:45, Steven Rostedt wrote:
>>>
>>> Shuah,
>>>
>>> Can you take this through your tree?
>>>
>>> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> I can take this through my tree.
>>
>>>
>>> -- Steve
>>>
>>>
>>> On Tue, 10 Sep 2024 17:23:34 +0100
>>> Vincent Donnefort <vdonnefort@google.com> wrote:
>>>
>>>> Improve the ring-buffer meta-page test coverage by checking for the
>>>> entire padding region to be 0 instead of just looking at the first 4
>>>> bytes.
>>>>
>>>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>>>> Cc: linux-kselftest@vger.kernel.org
>>>> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>>
>> Vincent,
>>
>> Can you please rebase these on linux-kselftest next branch and
>> resend.  This patch doesn't apply.
>>
>> Also please fix the subject to say:
>>
>> selfttests/ring-buffer
> 
> Will do, but it depends linux-trace/ring-buffer/for-next which hasn't make it
> yet to linux-next.

In which case it has to go through tracing tree.

Steve, This is yours to take due to the dependency on linux-trace/ring-buffer/for-next

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


