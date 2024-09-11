Return-Path: <linux-kselftest+bounces-17762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2F59759A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 19:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AA528303A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0691B3F02;
	Wed, 11 Sep 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AMV6oX8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0158AC4
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076510; cv=none; b=gmCsab8ohtCa0aA6Bza7tJUajQHKl0PxtaIYUIgdvYYPhzh3ZjeKrCpUpOJvbnheUJAzyqpRG2ycOw1iQLKorJwU+OrCNyhh+6bQFMAIJL+pig9xa+S7TQyfcS7hoJYxQvyjnyEZDisXZsZ6aS500f2XtTAqCQt36cty4CItpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076510; c=relaxed/simple;
	bh=4MLw3w+AyWXYKNzizJpKkr3qxd0kHTmFnrxreF7e6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEUPtt5gOJQK0pAd/D7v2x8hJqsRjgFil22SWCqBy7oU1yUuApQtyuE4oQ1i7eLB75oRBFDfJUGyp4Mp0csNHW+7VzjKw8K08rdgEBhjqQp4fFzagG+4ImHrOtRm+CNmfWVML5dbTg8uIUoNpi5MnuEghBOPs5D6dvEhg2Bc8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AMV6oX8L; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa4fd82a4so1837139f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Sep 2024 10:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726076507; x=1726681307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/Evpj4ztjn5sSYeRX1VYm9ZhgH1mvXmTv8yveHVyJ0=;
        b=AMV6oX8LNsQvtNikWJawXK3wJpP/MlzsuXg7tFTWfsITaw8aA3lF66KjoJb9NzLfTe
         3rzCOH6I3HRkOUBjc0VJ4Z5EJKZAgcgCD5ryC+7AqgzdGCLU132JuL2/1PSgaf+yByHi
         umJIafL2hX6h/ZZhnyzYu4iukhAbOrICJTBU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076507; x=1726681307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Evpj4ztjn5sSYeRX1VYm9ZhgH1mvXmTv8yveHVyJ0=;
        b=CxaDGr/JHR+Yg/7IJlWNbEDspplqzHNbW7dxzc3U+2wJnb7X0jN9wXcAvrz0njw8JN
         O1MsaHyZgLgaKMm1RMI1zAJnNDKiwn7drBf3vU/Yi9dSyr3ZEy/A4fIzOk+O6M8vPsJX
         N3wiClHtjS2I2rjAOnReYJwiwAkXfrYuho9CUxxnllQKa39PjAZhUdqFUvSgOAFIC1BW
         iM4JHRy0CiPGnHSE+E9hBJwQEqRobVP2f5I05XWfvGD9I99i/PzJYwX6FkFCGJrRuCcV
         BB/aKW8IG8S86dxk9X3Ak7AHGfm8isccHqRSiVk3OmvQA9pKDmC4ghLQqTZQEjQkCpZW
         cC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN60liUJ7ckZsRZyZM1q8R/I+yxsVQBl9sGRcgE+IjkeZ0+Q8vV5hfHUwCg3hfLfYEDvf4yp5JDic/lwj6ps4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq40JJamAidY+nNZ989zw1yAvldftiOKf3H9Efsu9ftZgHulT
	vpklS5awFafVJXTasw0ny4BFGxtflwCVaHMFmr+7wwL6cQccvoLOxQJhR9H826g=
X-Google-Smtp-Source: AGHT+IGFmDEYu28+n/w2kkrEpd8aFfbcheCsyGwcyD5LEwqOedHuJ+I2YPLNuin7DXlUtBx55jN3Lg==
X-Received: by 2002:a05:6602:26c7:b0:82d:b5a:b050 with SMTP id ca18e2360f4ac-82d1f985155mr52957039f.15.1726076506789;
        Wed, 11 Sep 2024 10:41:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8ff048sm98878173.152.2024.09.11.10.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 10:41:46 -0700 (PDT)
Message-ID: <449d19f6-5869-43c6-81d3-7f77d4e4d449@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:41:45 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kselftest: Use strerror() on nolibc
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, Willy Tarreau <w@1wt.eu>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
 <1c94b9bd-78d1-433a-959e-420a456bd40c@linuxfoundation.org>
 <16611552-10d8-46d0-8163-460c0cbec2e5@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <16611552-10d8-46d0-8163-460c0cbec2e5@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 09:44, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> On 2024-09-11 09:36:50+0000, Shuah Khan wrote:
>> On 9/10/24 22:42, zhangjiao2 wrote:
>>> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>>
>>> Nolibc gained an implementation of strerror() recently.
>>> Use it and drop the ifndef.
>>>
>>> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>>> ---
>>>    tools/testing/selftests/kselftest.h | 8 --------
>>>    1 file changed, 8 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>>> index e195ec156859..29fedf609611 100644
>>> --- a/tools/testing/selftests/kselftest.h
>>> +++ b/tools/testing/selftests/kselftest.h
>>> @@ -373,15 +373,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg,
>>>    static inline __noreturn void ksft_exit_fail_perror(const char *msg)
>>>    {
>>> -#ifndef NOLIBC
>>>    	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
>>> -#else
>>> -	/*
>>> -	 * nolibc doesn't provide strerror() and it seems
>>> -	 * inappropriate to add one, just print the errno.
>>> -	 */
>>> -	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
>>> -#endif
>>>    }
>>>    static inline __noreturn void ksft_exit_xfail(void)
>>
>> Adding nolibc maintainers for review.
>>
>> Willy and Thomas, please review.
> 
> Acked-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> I did the same for another kselftests function when introducing
> strerror(). This one was apparently missed or didn't exist yet.
> 
> 


Thank you. Applied to linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah


