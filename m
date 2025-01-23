Return-Path: <linux-kselftest+bounces-25043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C81A1AC28
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 22:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C89F18845C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB71CAA98;
	Thu, 23 Jan 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nkx//i1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADF1ADC62
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669418; cv=none; b=Uj11nUarhr2TafourjVR9CNpo4Mi5X4/Dmrgz+/7LJGJ3VYf5xoPji2q7MUwgjbY6W19IF3ui3KBU3Mm09ew8gaQDlQfH673th6HAkprAd2+N2Sa7WSS04sN2zwdiZdpTqEEL/5EtXJ4eR5TvFh0vWHa94guAI/trB6g1d8yqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669418; c=relaxed/simple;
	bh=ET0YpMKcnEM4kXMJlil3SBGzPFm72b+kLPD1LpTlE1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxWruJy34zLASZ0x1fLfgYheeXqW8+mkhgHTqp96/Y+WrkjdhnVSwIOdnqGgU7UJnbO9cnbVsknpzmbhfJjrWiACD+VMYeWb6G/uY1JKzBJL0AC/h45AEM9A6xos543sRgOATZa7UmFVyPjn/W6OdgT/8miNWC754UfZ8watq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nkx//i1C; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ce85e37887so12337425ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 13:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737669416; x=1738274216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/MnMokqSKu9BN0xk+SORtAOPFwZI9wvc/uRSw/lRyE=;
        b=Nkx//i1CRHstIwax0Ummp1k1/67Mkya1TyEpEwlia9vF68M00T154gHLu01xMQfjav
         9bN+vrO7ietvpZlpj4DMG4vmkrgLDZTcqC+2hO3m3LaZi6v+7LR/h5/C+1bNEyVDq/3J
         ngsaLSWI5JGqkR5MXxjaPGtYdaAqbZ39ev4RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669416; x=1738274216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/MnMokqSKu9BN0xk+SORtAOPFwZI9wvc/uRSw/lRyE=;
        b=Z1CTbhjqK/oshkrutkk+czOhaQB92g5Oe+yVQFFoqkNzV2iflzmOJOxyftEJFh9j1S
         R6747dliw0fpNYVHDS1dNbi6TchktJcwfINwihs6y/TG9hrZKkK+unMn5P2saLqKYVqT
         IJJI+LHfY2EWsS6rD06Ik4BVUs21oLFvEOyC3MvFxnwb9zcRH970YjhALXKSB6N69+Kx
         RgX8e1H12a0CIMLsaz20Bq78X5uUTv6F7dGAB0g8ghKc5XSgbWerQnSwuEzqVBq50x3H
         HAV5CTU2VzM/mlCgGcNRgiktHkVPYb8p3yAqcJB5UV4bg1NZNNjAJFgd5zLaD+jiMEzr
         R34Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkv9SHwE7Y+tyQKf/nKHDikKHMuyuu782aVeJxWrd3K4/Lr1l5AmWhF025QOgvLCkfSc90rifzC4f6shDbpQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlF7CBgZxd9l27Xm/eFFc8sMa5k2kW3ucABfDMWISPdXxWXlCb
	okAXFTFogV7GuKGXD+daZTiVkKdsSRMFKPntm/qGTcLjzQ+D9JH89mv27NHEspE=
X-Gm-Gg: ASbGnct8DoMsPNSxf1yCmNWuVouJ7vMV/u5GY1gMOaqGtP8uOaxfC+sRXmKfdihy88/
	G+seo2ecDNr9sLR18/BfaLx+a31dBaPUNDBwBPce/EepcYDQXl8n9siW6LsU4+8+zl0WLSX6O6k
	p+AV4gz8t4IPCLCGfh1g9u55QOz53jhLIqQRzzWyto+OKmn4jiDb2UTC20jPjgdV7OkKS7AextH
	7NwSWYM68gt98/4/yVOJzPrVGOyDNU3AVYAy0kFdnCdX1UgXePNKblv7rq6gYcxNO5TuWEhSuHO
	ewPi4XCpaG0uRyg=
X-Google-Smtp-Source: AGHT+IGYTAArNpdyyZwafhJ+kc2ko45bmyLxeOp/XuBVSjl25NBhXrOxRgs+f5XK9soZP6J3iUbJXA==
X-Received: by 2002:a05:6e02:160b:b0:3cf:b3ee:59e8 with SMTP id e9e14a558f8ab-3cfb3ee5b5cmr79160885ab.7.1737669416350;
        Thu, 23 Jan 2025 13:56:56 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc74e9472sm1859335ab.55.2025.01.23.13.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 13:56:55 -0800 (PST)
Message-ID: <571133ce-b4ae-4a9f-8601-443774804d1e@linuxfoundation.org>
Date: Thu, 23 Jan 2025 14:56:55 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/tracing: Test only toplevel README file not the
 instances
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250115191758.35b62738@gandalf.local.home>
 <20250115202607.00c6d353@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250115202607.00c6d353@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/25 18:26, Steven Rostedt wrote:
> On Wed, 15 Jan 2025 19:17:58 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: Steven Rostedt <rostedt@goodmis.org>
>>
>> For the tests that have both a README attribute as well as the instance
>> flag to run the tests as an instance, the instance version will always
>> exit with UNSUPPORTED. That's because the instance directory does not
>> contain a README file. Currently, the tests check for a README file in the
>> directory that the test runs in and if there's a requirement for something
>> to be present in the README file, it will not find it, as the instance
>> directory doesn't have it.
>>
>> Have the tests check if the current directory is an instance directory,
>> and if it is, check two directories above the current directory for the
>> README file:
>>
>>    /sys/kernel/tracing/README
>>    /sys/kernel/tracing/instances/foo/../../README
> 
> This is the same patch as:
> 
>    https://lore.kernel.org/all/20250116012041.326701057@goodmis.org/
> 
> But as there are other patches that depended on it, I just added this one
> into a patch set with them. But decided not to make that patch set a v2 as
> there was no changes with this one.
> 
> Damn, I forgot to add Shuah and kselftests mailing list to that one though :-p
> 

Do I need to do anything or is this taken care of?

thanks,
-- Shuah

