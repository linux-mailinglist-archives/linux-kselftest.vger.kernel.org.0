Return-Path: <linux-kselftest+bounces-14325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2893E429
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD4861F21A84
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A3125DB;
	Sun, 28 Jul 2024 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLnVvN2Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5117756;
	Sun, 28 Jul 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722156549; cv=none; b=Ues4fuXQcSUh//YGohI/Vx1jxKtKTzVSUkusL2xTGpikJstlG29CKGmkSqcE2Ju8FuACSQuVPgbPWW4MGpu2qDml+UDP2Zt9T/FT/beIHLAdny2RxVTSOku1cc3+ypBrmosSSsQIIM/GIszBUdvfwJ4NziuH1o6XHgSQIEQg5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722156549; c=relaxed/simple;
	bh=B0esyC3vDM3rQQi2aj0eDWOTot2ydHWRm3x5/KRF+88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QF9Gtab1pyYSGXNtfU9/FLg53DgIcJg8PIuDvLdnDfWivWE2wHdhuMCmlkZjlakJ6loHnyPn7jC7jKrwXe/HRWg2qW1N0NWt2THY9fnfpQ8sLMxsAY1MLqcDlF9few3zoc4CI3tuhhxjUTd1hlB8kgvwTJ3EwhWZmBn4bdLI3zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLnVvN2Y; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36841f56cf6so174699f8f.3;
        Sun, 28 Jul 2024 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722156546; x=1722761346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evXFs/LDhclMF9Lmn3M5N/hyBTPMP9UOlkTmgh1mwjc=;
        b=dLnVvN2Yu29Vzj473m1kS1eUPKX1BsEt5UsQXzfX5Hou+WH5axDhqnOAzttwuGcBX/
         4uvJyXWA3aT6oXnjYnlkwG0YbibTv7tKx9Zx5nNv41sHF6ogZr5nUfur7aseuUYV5Ul3
         TV0srKc0bi15KSUS87ZV5rRcUMKwHG6I2d7gJ9V8DsyapeOUE0h+V03zSc1YYh4EcEQu
         6tP2ec2QfiyRHIINH8hUgYW0NCCd+JGWieM+srwj/NooaJTlBshe7DusifVC2oxXE/+F
         ePouBL0QwoVFtIKcrk8Hbxj65ryt2PkX1MXIFnsXRD2nPSG9d3IFC6r+t2K29BCqMPsQ
         aStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722156546; x=1722761346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evXFs/LDhclMF9Lmn3M5N/hyBTPMP9UOlkTmgh1mwjc=;
        b=gypY/IYtTprHFejr0m4yf9mHdzHjlUzqspyVU9dmmUz8hHHUxkLJKV/S9saC4kbCCJ
         dGoJyU+va7fRhH2EWLV91yYWEhdSNuQjJwzfaJt4fBl1fsW6gHa+jg71b/ymeOfsBk7t
         I04qU4DMobRIqXWYgXbDACYus4golv5yEush26GSOUHLu5KkfzZG3yJHgFCg0CDa8BmN
         XiFikPMzk2prLYPsMOMLP31qUOEsCB9qOLgFibygSa24tRU6gW5w66wxoZo7tpP+Hcqm
         3vPDLupqLsdhXPCqYjOtLiOVW7Dtp+dTXD3IcOnbJ2iI+UfVn3nGO2WE9BH5ZrkZ6Kmj
         HpLA==
X-Forwarded-Encrypted: i=1; AJvYcCW0znQMVwr3kycrgIzciPbMK5H5nGT1f9f5c8NuNjZQmiM/XeaUGy8E+gOWgUatAwthhIezQgQekQk=@vger.kernel.org, AJvYcCWDev4215RxUeNESvJ1teKOl+71rA/3dxq6W1JIQky96a3chnY9Ey3s+waYZjfMM4xxMj6QqU6HuVXodQ0=@vger.kernel.org, AJvYcCXhx0c/SN07PaQtkF+W8Uc56YGmz0SgoVyyX8hZECYm6jV9y7KPXDxcVtAyXrO/eScpU5P4GY9oN0TgiOjD@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfKZZWSVDlWkhOTOLYu2/EHVc9sfCd4nu1Va293BEU3hSI59s
	qB6QNw4/b1WyT48B18UzCMsg0JzM6PxEAsT1cK9b2KkBnchyRJPV
X-Google-Smtp-Source: AGHT+IGfcV2eLH9UxDIWhtuJCcit8EsekBMHUr7GUyCrCLXfkrQCfKUu8FmHJO9a8w/WhUexmjSiTw==
X-Received: by 2002:a5d:6d8d:0:b0:364:8215:7142 with SMTP id ffacd0b85a97d-36b34d1840emr4655827f8f.1.1722156545352;
        Sun, 28 Jul 2024 01:49:05 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:1d00:5943:7f74:2af0? ([2a01:4b00:d20e:7300:1d00:5943:7f74:2af0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b368622c3sm9335264f8f.100.2024.07.28.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 01:49:04 -0700 (PDT)
Message-ID: <b45e7719-3ffa-48d9-bac5-a33db3c4e589@gmail.com>
Date: Sun, 28 Jul 2024 09:49:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, perex@perex.cz,
 tiwai@suse.com, corbet@lwn.net, broonie@kernel.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, aholzinger@gmx.de
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
 <20240726074750.626671-4-ivan.orlov0322@gmail.com>
 <6b0a39f4-1a0c-4e3e-955e-31bbb33ba54a@wanadoo.fr>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <6b0a39f4-1a0c-4e3e-955e-31bbb33ba54a@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 07:52, Christophe JAILLET wrote:
> Hi,
> 

Hi Christophe,

> ...
> 
>> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
>> index b970a1734647..3cf82641fc67 100644
>> --- a/sound/core/Kconfig
>> +++ b/sound/core/Kconfig
>> @@ -251,6 +251,17 @@ config SND_JACK_INJECTION_DEBUG
>>         Say Y if you are debugging via jack injection interface.
>>         If unsure select "N".
>> +config SND_UTIMER
>> +    bool "Enable support for userspace-controlled virtual timers"
>> +    depends on SND_TIMER
>> +    help
>> +      Say Y to enable the support of userspace-controlled timers. These
>> +      timers are purely virtual, and they are supposed to be triggered
>> +      from userspace. They could be quite useful when synchronizing the
>> +      sound timing with userspace applications (for instance, when 
>> sending
>> +      data through snd-aloop).
>> +
> 
> Unneeded extra new line.
> 
>> +
>>   config SND_VMASTER
>>       bool
> 
> ...
> 
>> +static void snd_utimer_free(struct snd_utimer *utimer)
>> +{
>> +    snd_timer_free(utimer->timer);
>> +    snd_utimer_put_id(utimer);
> 
> Missing kfree(utimer->name); ?
> 

Yeah, it definitely should be here... Thank you for finding this!

>> +    kfree(utimer);
>> +}
> 
> ...
> 
>> +static int snd_utimer_create(struct snd_utimer_info *utimer_info,
>> +                 struct snd_utimer **r_utimer)
>> +{
>> +    struct snd_utimer *utimer;
>> +    struct snd_timer *timer;
>> +    struct snd_timer_id tid;
>> +    int utimer_id;
>> +    int err = 0;
>> +    char *timer_name;
>> +
>> +    utimer = kzalloc(sizeof(*utimer), GFP_KERNEL);
>> +    if (!utimer)
>> +        return -ENOMEM;
>> +
>> +    timer_name = kzalloc(SNDRV_UTIMER_NAME_LEN, GFP_KERNEL);
> 
> kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id); ?
> and SNDRV_UTIMER_NAME_LEN becomes useless too.
> 
> In snd_timer_new() it is copied in a char[64] anyway, and if utimer_id 
> is small, we could even save a few bytes of memory.
> 

Wow, cool, I haven't heard of kasprintf but now I'll use it here in V2. 
Thanks!

-- 
Kind regards,
Ivan Orlov


