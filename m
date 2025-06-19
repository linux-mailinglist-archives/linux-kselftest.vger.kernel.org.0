Return-Path: <linux-kselftest+bounces-35390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A3AE0F16
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE291BC1368
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38A25F798;
	Thu, 19 Jun 2025 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z5to+WTx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB518A92D
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369425; cv=none; b=MnmR4aAhz21aa7F2tYTtxdWDSsPH6Czvo/Bgwz0StyO1S6brgzH9/nTvWddCZnORa1/qKX2BokKJxeieBtNyRkVQw4CWRCrszYzKTEUHssuCDq6pIgCXCNSMiYTPR9T3Mt80D0Alvw+jesd2RqthDV0CjepDbtVUsWCCpxwj+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369425; c=relaxed/simple;
	bh=a8LYviNq9YTYBcBCE7EKNDp6/+znT0swyLSfViL3a+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqoRZWV+P/dDRXfP4GSnyR1L6bXmjDJ4Hs9iFVitwm9rKjrbXz0jDddQFdpiJvGOi8fu0NGXmrLQugFo6MqSMp+c4blfno7BqR9ul/+eh8RK+QaBv/CVQcBJm2IjffITPf/Mom0vn0fq0zhyJj+vfEZnMjNZj9mSRDWQXDiWO9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z5to+WTx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73a01a7bee7so401275a34.1
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750369422; x=1750974222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtdWcZD9H9MU+GvH5qLxp8IIrliybyOXwnsM3fxu7b8=;
        b=Z5to+WTx7TU+LsGOSauXJtjocY7EQwJangRlopFX02fqKnFuQIFrBEdW01cMxHDchu
         /oHmhoHvLdpVZAfSyoNh+uDK7PWjsM5id6rRYo/IPRUr6X7bw1IK5sbLpWTM3eA4ZFWs
         qOMHCfzj3r1Ws1UkyUz3b3vD0tniep+uaYyDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750369422; x=1750974222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtdWcZD9H9MU+GvH5qLxp8IIrliybyOXwnsM3fxu7b8=;
        b=LCKmNEJ+AMhqHkPDOmAMBbW3P8KEtT6gQy3EGwwgWxQ+kq0LdJ3j1pKJx24RHrtp0a
         phYoV0SIoJDD1upnSz6erEGyiSSne7CEffr+MoUMe9MvzdfRf6eGUiHmfLTeXYvCgIb4
         HEbffCMRBXuEia1989JKuwCZ9fGJkL5IjjxJKLZqXEXUawOIa/SYH7gerUyqZPcS5cRW
         XGWiuUg+5zwPnQSKP/p1ghsk/Dc5E3qh0T/PD2YFuqXQzYKbkxwRPxfUwCw2EggJL70A
         O233F6rDJuMWg0GPktHPEw7FTzKDWiopSZlNBHqF33KlmGZiStDk5jypH2TlBkzNIUWw
         aH6w==
X-Forwarded-Encrypted: i=1; AJvYcCU3sxdVo/kzxi3HIJjg4ut4lsRR7fSrqRYEg1nMZUszwwF4OUIdR4413+KIgEsyImj44w+cvfCD47qI20Wl5XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbJcB3QL5uRRpy19GJeGk0Cme1kg9MZvp6kfTGnCRJaQ+ZOqC
	EltM0ho6w4QPv7yNuIY0b8hQJXX1aUJU/jU9zRFu+9LgzLAxmVKkAaef/6lzqGdEq+4=
X-Gm-Gg: ASbGncvp1HcY1TtqPBPSO+9mcVwOjXd1yjGyak8r7YIbH3YwyqF/T+F169/PgUrwnsw
	zRmtTPDwWachp/gbKA1TaSD99IjFelh2rib2Da0TwKP1wawNoQSXIQauQB6h/EzXIkPWnqL3RSZ
	qrLM5Qtmrd3DKHylDJ/3EA/vPecTA6f4U1hq2KmeAnvXbdl5ChU/PQz4GDAZrqfI9Wwfe/denO+
	eK5zZBozqCxcmlKkYlcLHbbAxg0eMTUGQcqm467Klpmw33E6q+uuFj+0w/r4D5O9hV529AfQiFq
	Fe0TOnjZAdPmpdB35ETAqKPsG2WjDZaJtUMMihnKIHU9N4DVMBWLQ2XKt/1g6SDIjDIBK1Pw4g=
	=
X-Google-Smtp-Source: AGHT+IG3zun6seWH0e2DDXaQTs69ENPXpIXcFxWPe0R6l6nMcNZ0CpLymICDCoYf5D5y3PDwuid1/w==
X-Received: by 2002:a05:6830:3e95:b0:72b:7cc8:422 with SMTP id 46e09a7af769-73a91d4be8fmr149617a34.20.1750369422633;
        Thu, 19 Jun 2025 14:43:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90ca8712sm77065a34.45.2025.06.19.14.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 14:43:42 -0700 (PDT)
Message-ID: <4d625aaf-5c8c-4097-897e-a6ebb469c183@linuxfoundation.org>
Date: Thu, 19 Jun 2025 15:43:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] selftests: Suppress unused variable warning
To: John Hubbard <jhubbard@nvidia.com>,
 Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Jan Kara <jack@suse.cz>, zhanjun@uniontech.com, niecheng1@uniontech.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250610020758.2798787-2-chenlinxuan@uniontech.com>
 <6972404e-0237-47b9-8e3e-15551bea3440@linuxfoundation.org>
 <CAC1kPDPg0AN9Ft3SNM6JDcZf=XD1oinqeAMzuRpZF3nzemZ=Kg@mail.gmail.com>
 <265ebc1f-b0c0-4c57-92b2-41714469c7f5@linuxfoundation.org>
 <91817e12-54c4-4241-b895-2e452a00e0c4@nvidia.com>
 <f73fa51e-87e5-4805-bbbc-a7af9b50a1d8@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f73fa51e-87e5-4805-bbbc-a7af9b50a1d8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/25 15:40, Shuah Khan wrote:
> On 6/19/25 13:00, John Hubbard wrote:
>> On 6/19/25 10:00 AM, Shuah Khan wrote:
>>> On 6/19/25 01:46, Chen Linxuan wrote:
>>>> On Thu, Jun 19, 2025 at 5:23 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>> On 6/9/25 20:07, Chen Linxuan wrote:
>> ...
>>>>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c b/tools/testing/selftests/filesystems/mount-notify/ mount-notify_test.c
>>>>>> index 63ce708d93ed0..34afe27b7978f 100644
>>>>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c
>>>>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c
>>>>>> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
>>>>>>        ASSERT_GE(ret, 0);
>>>>>>
>>>>>>        if (ret == 0) {
>>>>>> -             chdir("/");
>>>>>> +             // Suppress -Wunused-result
>>>>>> +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi? id=66425#c34
>>>>>> +             (void) !chdir("/");
>>
>> This is quite ugly. :)
>>
>>>>>>> Why not fix the problem the right way by checking the return value.
>>>>> Suppressing the error isn't useful.
>>>>
>>>> The code is already handling cleanup in error cases,
>>>> and I don't think checking the result of chdir would be useful here.
>>>
>>
>> Why not just fail with the appropriate test result, if chdir() fails
>> here, instead of making a bit of a mess with odd void casts to a
>> negated return value, and a reference to a compiler bug report?
>>
>> Really, Shuah is putting you on the right path here.
> 
> Ha. I didn't ask to suppress the error with the cast. I asked
> to check the return and fail.
> 
>>

Sorry John. I didn't read it correctly the first time.
I probably go get more coffee. :)

thanks,
-- Shuah



