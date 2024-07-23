Return-Path: <linux-kselftest+bounces-14085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBA93A40C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34B3B21704
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0415747F;
	Tue, 23 Jul 2024 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKrFPClq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FE156F5D
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750118; cv=none; b=FQRY54FEB5C7xfR7FJMEz15mgsAMGvMMQeGJovQPA6363ODPfPlO13N6T53v9D9DD3lO0O3/a0qdMgs6hf1X+b2FkmUH0Mh2YflVI2IM585BFSXqwcWF7FZqrjHLrUgLh/WZ90pIFLAkVCSCUt0GNZJGllY1ulhu74QKGyliLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750118; c=relaxed/simple;
	bh=pKgz77waICa546rfGgU6tjUnrgO9VIGblXenGg93D5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uLNg7+nwC90KOKiqd7s/mopOw1L54SvTmrLW81sZKBpAP7J39+7cjdWN4Bfq5jXZZAPhqLo5hE6JDISomes39QbYJtjtS8buWeDuFhhvnwHouHJ460/sizbD24f+IRLDc+0jaq+Uv39I5i0GejWrDJtGYBsZbsMlIRrPhGuYDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKrFPClq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8084f783737so31492339f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721750116; x=1722354916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lg1BsDoFTVJYikAOrp8+ys3hLPaS+7BQa4llRdXSLUA=;
        b=dKrFPClqg0C1za62cMZAEPTk6u1uSifz7yjGAEMmRKdeSvdHH0FTwT56FKm6lOtN29
         b3FT42j7gxjHmiVp0y1vU/9HUsYciq2Ao3N/Cxg9p+64lZMDKpYLj55uz8R/2J6VatJi
         NJ0rU+FzJPupZM0kAztJzwIf9WwgZR/++wNjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750116; x=1722354916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg1BsDoFTVJYikAOrp8+ys3hLPaS+7BQa4llRdXSLUA=;
        b=rIPZRZIW3oh+Ird75j9iLsbPs7u1SUEUOZCtIhz8x3p+R6haidNwD95JIlcVmM4pME
         pTbPgKOXwutmR/odo0ugOUSJMV4mJ4XHCZfFX1wglOchPLCg0XK/msHQFNsiLdTmhWEw
         oKt7bhbnqIev/kFJ1vuPYEws3uEmGGvWm+J9jfwMaVLqAMvrtotqkolxbtNidU+Qkt4f
         KskxlKciAKwqLr9c4K8URXwyhdcXZojLIxECc3xR21zl0g5llzvgPB1P6bOBQpYSQuwf
         wzqrRqZKa5co0Yyh6THCOp0uSQVdscbabO/33tXGHTvoOq47OOgW7ZGKtag2new6OFFC
         EAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1P2ibz2N1tQUWyo7vAPYrZEclttR7Zft67lfJVLpvmQSWY/SpY+Kit4rp3sG2ynV5N637NXkuvCPB3ShOcIwquJlYIemP6o9XDzE2BF0c
X-Gm-Message-State: AOJu0Yy9v2qf6YytmdvTEj2uH5WXzkw9E99SCbqpnUBXM4GNSyR9oH4o
	tjZh9bUXSg4IRMPWfUL4+8xNkKIR3vFVcPNmSjx3223BAdDiGvjfSFQ51etVyeA=
X-Google-Smtp-Source: AGHT+IH3jhqVl6/DZ+4DZmo8QwwuG+XqV7XSC40U/FhKoPqCMXQg5gRdnLSL4oPL6QjiMiA5bL2Wzw==
X-Received: by 2002:a05:6602:2543:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-81aa4ccdb27mr693914339f.1.1721750116383;
        Tue, 23 Jul 2024 08:55:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819aba13e14sm314871639f.2.2024.07.23.08.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 08:55:15 -0700 (PDT)
Message-ID: <2ee0f5df-9a9e-4625-ab09-b21596a0685f@linuxfoundation.org>
Date: Tue, 23 Jul 2024 09:55:15 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
To: Dev Jain <dev.jain@arm.com>, Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
 <20240630151808.GA13321@redhat.com>
 <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
 <abd97c85-c9d9-43c9-b0c2-36f6f0e442e0@linuxfoundation.org>
 <01e41c46-255a-419a-9b72-485a2798205f@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <01e41c46-255a-419a-9b72-485a2798205f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 22:30, Dev Jain wrote:
> 
> On 7/22/24 20:28, Shuah Khan wrote:
>> On 7/15/24 05:49, Dev Jain wrote:
>>>
>>> On 6/30/24 20:48, Oleg Nesterov wrote:
>>>> I see nothing wrong, but perhaps this test can be simplified?
>>>> Feel free to ignore.
>>>>
>>>> Say,
>>>>
>>>> On 06/27, Dev Jain wrote:
>>>>> +void handler_usr(int signo, siginfo_t *info, void *uc)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Break out of infinite recursion caused by raise(SIGUSR1) invoked
>>>>> +     * from inside the handler
>>>>> +     */
>>>>> +    ++cnt;
>>>>> +    if (cnt > 1)
>>>>> +        return;
>>>>> +
>>>>> +    ksft_print_msg("In handler_usr\n");
>>
>> This message isn't very useful. Why do you need this message?
> 
> 
> There isn't any specific use; I am just showing the progress
> 
> of the test. If you think this is just waste output....

Showing progress will not be useful unless it is also giving useful
information to the user. It doesn't look like it in this case.

You can drop this message.

> 
>>
>>>>> +
>>>>> +    /* SEGV blocked during handler execution, delivered on return */
>>>>> +    if (raise(SIGSEGV))
>>>>> +        ksft_exit_fail_perror("raise");>>> +
>>>>> +    ksft_print_msg("SEGV bypassed successfully\n");
>>>> You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and check if
>>>> SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == NULL.
>>>>
>>>
>>> IMHO, isn't raising the signal, and the process not terminating, a stricter test? I have already included your described approach in
>>> the last testcase; so, the test includes both ways: raising the
>>> signal -> process not terminating, and checking blockage with sigprocmask().
>>

thanks,
-- Shuah


