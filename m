Return-Path: <linux-kselftest+bounces-35389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52276AE0F15
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 23:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB99C5A5C73
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 21:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6A25FA05;
	Thu, 19 Jun 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoDdS7dl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88A630E852
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750369253; cv=none; b=qnhSfFsUB+6pgij+DQjjB6TENBEPxUqvSqBoxN+E/jhSdlYacBdxaxD2vsLAgkTNAkLrM18rGc96QTPykaYhWetPLtOtVGFfUHHigSGbpM9dstgXoce69NgqRPoqRX4gxQbiLtuj6uRrSKWo7Nt55XppZuu4aMQhnvMhWc+VHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750369253; c=relaxed/simple;
	bh=RFA/yqyQSPUwwdKTZXol6d3OW7IQQFMuZJNDfgY1kfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXAk+Thff2HpUAflFVjEx84WwT/TgDsRUIsWuOXQ7qzn8Wc36YgpI3ap/HqJ9kz8zbf+fuYlXRz+45Oey4UUFXOkb76UYoYb5UWet8XOgxCS0ZfdOiMxaoB9PCMpYT5BWRWyOS8jSvFqW59/ll5QNIgKrggAiKi2JLC7LuKa0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoDdS7dl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso12760335ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1750369249; x=1750974049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3x5oxeT4WtdtCLyQVGKYtv/Q4EkmPLsDdHFSt8usc=;
        b=AoDdS7dlAi3H+KHslgrptqS7gKW9PLNuEIaZoxi5uPR+r+Wxq3pIGaoD8QrdCJ8lhY
         ul8ebb7udWhnXCYx/oOvYXk56hdREeE84q7nv0J+J9ULx8ycbWeZ0T/9Vlt/t7g1MN3s
         OkIDMUKt80Op+5nQk5DgfK5Kt+3W0bPjIdEdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750369249; x=1750974049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y3x5oxeT4WtdtCLyQVGKYtv/Q4EkmPLsDdHFSt8usc=;
        b=VYfJnYcPB34jLitFKRY00qkJE7r+BqvWV53FrpDw14z6F4+goaFl+fvPwuLZsHsw3n
         f1+r5MVnijvEQewrs+h8+v5hnwPfG3sDy0hR1KoE1cjgXwNr61+dDmnQsQA2VZCcOahI
         AUxm+/LBeD5yPBNsiTD/mmCGyHHA0FDmTZQYlhcC45kYXs+3YD6BNYECL6ZUJ1kNPdhn
         5cgocMPiFYPoxYKQ/h0EKjQWqVXCHyE4nn8dUgz23SklLFg5LHSe1K7munyOiGVpVOkg
         RnXr6bnPoOgaXq8eOL6r4TiBCC7e0K2gd5npLe2jWyL+aRL6GYDJs48zuHjbcS3yH/K9
         yMyw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Jsy2nfr64Egb8kqPo+pLILLc67lSmvQ3GeDb4ATL/QnS0cEbNeTzCPzzU4g1R42z7Boo9utJGYnC8pWn2HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/24v83mkQfbKvWfNP0V1TvW+Waoi7XWICSAGfGkZiL6ddeFI
	icIbFtv1/HShTCMGep9kLv02SOEDaPI0lUrGbRR80iq20CfAxVAnaG0fy6OPBGnlbq0=
X-Gm-Gg: ASbGncunWMxB6MSOWa000Cxc72mr7v8WEFK+RR/kGHU2qliFNXmCH/FiBCBd9PDhTMh
	lD3CtJu8GoTibPZJQzrHujd4QV+CKji8eMa0brjJ728KdxcHHF1QW4KOyNDE8XjkndzWWAB8FU1
	MS2c0dLwoOER/JvcSaaQbvLvAZrKpRGNYgz3GX9jbwda/faxYAflb+KD6QRzVkAJKaMCSR2HUmH
	LR8+PwLpBF8gIHath6UR+d6JTMaNbT5EGaUY6YXrUt6JrsFBIZsZiOfri1ucwR5lNJN4NDacSkS
	FEh6vjnK84IWCPu03lS9kOBDTFO98w/BqQE6goAecYG4COdDqW3zr7clYaBSfucSnCzi6BUmAw=
	=
X-Google-Smtp-Source: AGHT+IGCXQ0P0NRFh7ydIGTlbS1aQeIfIQv8CbB2DliU8PwpYPDyu20ZGQPmw1y1tzyBgx1cTN0BZg==
X-Received: by 2002:a05:6e02:3f05:b0:3de:12ff:3604 with SMTP id e9e14a558f8ab-3de38cc9db5mr5134765ab.19.1750369248697;
        Thu, 19 Jun 2025 14:40:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5019e04e4bbsm141990173.70.2025.06.19.14.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 14:40:48 -0700 (PDT)
Message-ID: <f73fa51e-87e5-4805-bbbc-a7af9b50a1d8@linuxfoundation.org>
Date: Thu, 19 Jun 2025 15:40:46 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <91817e12-54c4-4241-b895-2e452a00e0c4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/19/25 13:00, John Hubbard wrote:
> On 6/19/25 10:00 AM, Shuah Khan wrote:
>> On 6/19/25 01:46, Chen Linxuan wrote:
>>> On Thu, Jun 19, 2025 at 5:23 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>> On 6/9/25 20:07, Chen Linxuan wrote:
> ...
>>>>> diff --git a/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c b/tools/testing/selftests/filesystems/mount-notify/ mount-notify_test.c
>>>>> index 63ce708d93ed0..34afe27b7978f 100644
>>>>> --- a/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c
>>>>> +++ b/tools/testing/selftests/filesystems/mount-notify/mount- notify_test.c
>>>>> @@ -465,7 +465,9 @@ TEST_F(fanotify, rmdir)
>>>>>        ASSERT_GE(ret, 0);
>>>>>
>>>>>        if (ret == 0) {
>>>>> -             chdir("/");
>>>>> +             // Suppress -Wunused-result
>>>>> +             // Ref: https://gcc.gnu.org/bugzilla/show_bug.cgi? id=66425#c34
>>>>> +             (void) !chdir("/");
> 
> This is quite ugly. :)
> 
>>>>>> Why not fix the problem the right way by checking the return value.
>>>> Suppressing the error isn't useful.
>>>
>>> The code is already handling cleanup in error cases,
>>> and I don't think checking the result of chdir would be useful here.
>>
> 
> Why not just fail with the appropriate test result, if chdir() fails
> here, instead of making a bit of a mess with odd void casts to a
> negated return value, and a reference to a compiler bug report?
> 
> Really, Shuah is putting you on the right path here.

Ha. I didn't ask to suppress the error with the cast. I asked
to check the return and fail.

> 
>> We check for chdir() in several tools in the kernel. Add a check for
>> it instead of suppressing the [-Wunused-result] - suppressing doesn't
>> do any good.

This is what I said.

thanks,
-- Shuah

