Return-Path: <linux-kselftest+bounces-32774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4BBAB1CB4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE041BC6B6B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 18:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DED2405EC;
	Fri,  9 May 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DAmP0kA7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF023FC5F
	for <linux-kselftest@vger.kernel.org>; Fri,  9 May 2025 18:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816808; cv=none; b=i46qiukOVtjblczAGuW88jtfgTF7r2zO/uydL4KiyzxovXXgArg0SiYvBSyOzlju5bnmw/TlLOAJKWGY/niNgQjObi/74N/X+9EZgl5mQHwBc/ahnc8/12hZs7RLaEt7we4di5SJcbv6AQSLuwCiTWElGuotYz6FwwhIIFtGrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816808; c=relaxed/simple;
	bh=pPb2yux8ncMb3CZqonAlRHIcg/L3bixa1GCZYae4d+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCJP07nv6opLImnP8JCySsTriMhA6mbYQK4aatJZGrlDrAKf8eactHPxJTec3aLljDyVtixi8XNyCF/3l6H8jkAkGVicT8OoM9gk4CSil/6+mpuIgLgWIuVryo+cOx/s7g6QjxgDLS/d/jhzY9N/SawI3VZNk5uOOvJnNDd6SWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DAmP0kA7; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-864a22fcdf2so81233039f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 May 2025 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746816805; x=1747421605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9M5vO0rVZ27fsI0jmDeqg70dl9WZ31TiFo3VqdX2ds=;
        b=DAmP0kA7GIo329pdFtQvTnWtJHnwcJ9l/Tpt32EIt0yZs8Y4xTakUAGecRzG1PfesD
         hqS+ni8gMQ5MPI6nfMxywtnb/SYMNX5apMFMBWw0ACb5N/6x/bBaBM3lCtuOPXP1+mg3
         fcStlhQz/H4cwEoEzYsijQ4pTofrep/oTQEyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746816805; x=1747421605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9M5vO0rVZ27fsI0jmDeqg70dl9WZ31TiFo3VqdX2ds=;
        b=dcjEwx+Kyvu58zKIbdTwq+OHuGn1r0ffkRJO73J/tvThiSqx1NEMQiRRKNiVl543rk
         73kyQS3BSNo0jVjoP3ZItuPB8ENQaPIfSkF+aN8Dp87IGJZx32dwvStlqVTSNk6MDBgJ
         qpyLy53M50phYILUfvd5AkzWsIUiIy/wnq4FW9wYQkTtuAtRppLjdSIPtNlTq1B2tita
         DRGQkC7y3yDh7wN0fjCu+cjfNSvxLZFN+7lPhuxysxFx+R7xlooBqMUqJZJc+WxNyKxG
         mkeh9D3AAZgBB41vP32c439FLUVU/N8KgoNwhM5Cf+8gd6l96jVGS8peg8ifhMy39O/Z
         jK0g==
X-Forwarded-Encrypted: i=1; AJvYcCVT2CuzfSPebP8xHPukFTDSke1xKAsvQpsbXfAAr83dkY0I+KOpxhB/cN7c+eGk2PwfTaA/DqtccRBVP3CGqrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRHQRdNUBHqqLmwxEya7oUuGkOtijnghdnKmbaRODBNf2W3tR
	f7RSCmGeytWuybYtJA00EWMkF+QGrZe+9jjXwCW3eMJmySaYOTyWbcZov5p0geU=
X-Gm-Gg: ASbGncsWPuFHlXHtGH8fYYrn9CuPm/2mkYqbCzeefIaVuJKD5Lt6T99GB8EbmnlMB9K
	r/DDkedKmqZw/bSURKO8Xxq8T6N0jYNmbKEi3aOG2DVHk3HoCZCrXJuJ8yPNVkQuRTvpJANiRcs
	DOjodOvh2mRhPKV9NaTDrW84BT1CiNt/705R9DptQPaU23oFytirgA8N4zaIbB+rGH2n5fdg4FE
	4d77APszwWFAfn6bpxojO7mBPQCvJ/iau+jTJ+qpTeJlo831JrNXj58Tl9Fl50DBZRUNKJ8ESVH
	TVapLsrP9FpS+oS7OgEY/KRiPlxo+pyXK2nj5hRDifbsnzocgXw95zauBEUiBw==
X-Google-Smtp-Source: AGHT+IHHhcCytqFUPDF35/kPT3/0/t4Ci198j+E83P+7wD1v00FjQaT1VCEeKAJMNE9MeCGbrOF93A==
X-Received: by 2002:a05:6602:2594:b0:85b:5c9a:a9ce with SMTP id ca18e2360f4ac-867550aa561mr972489639f.6.1746816805533;
        Fri, 09 May 2025 11:53:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2268628dsm514749173.144.2025.05.09.11.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 11:53:25 -0700 (PDT)
Message-ID: <a8bf3665-1c3c-4742-a435-a0ef6914dfd4@linuxfoundation.org>
Date: Fri, 9 May 2025 12:53:24 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/timens: Print TAP headers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, "Bird, Timothy" <Tim.Bird@sony.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
 <5609c6de-e5cf-4f6d-8412-71149fae2580@linuxfoundation.org>
 <20250509172639-61bade20-67f9-4815-8316-1bb16749f8d9@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250509172639-61bade20-67f9-4815-8316-1bb16749f8d9@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/25 09:41, Thomas Weißschuh wrote:
> +Cc Kees
> 
> On Wed, May 07, 2025 at 03:06:16PM -0600, Shuah Khan wrote:
>> On 5/2/25 06:03, Thomas Weißschuh wrote:
>>> The TAP specification requires that the output begins with a header line.
>>> These headers lines are missing in the timens tests.
>>>
>>> Print such a line.
>>
>> There is no cover letter for this - so I will respond to the first
>> patch.
> 
> Hm, I sent one and can also see it on lore.
> 
>> The TAP information is added by the kselftest wrapper if
>> you were to run the test using ksefltest.
>>
>> The following will add the TAP header or if you use make kselftest
>> command from the main Makefile.
>>
>> make -C timens run_tests
>>
>> cd timens; make run_tests (will also add TAP header)
>>
>> The only time you won't see the TAP headers is when you run the test
>> from the test directory just as a command. Is this what you need
>> to do? I would rather not see TAP headers added to invidual tests
>> unless there is a good reason for it.
> 
> Yes, I am running each test on its own, as part of kunit based on [0].
> I also looked at the vDSO selftests and those all print the TAP headers on
> their own. The same for all of the x86 selftests I looked at.

We have been a bit inconsistent with adding TAP headers to individual
tests. We added them to some and then when we found out the nesting
TAP headers issue, we stopped and never really cleaned up.

Since we have this kunit use-case, I am going to take this series
and see who complains. I don't think parsers are in the mix at least
for majority of ksefltest runs.

thanks,
-- Shuah

