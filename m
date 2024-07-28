Return-Path: <linux-kselftest+bounces-14326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CB793E42D
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93311F22038
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 08:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B958015E97;
	Sun, 28 Jul 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLlcXe+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA28F9F8;
	Sun, 28 Jul 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722156689; cv=none; b=I4UqpMY8w/20tbkssJxIiAlBvc9ZJr98+JKKKKNNVJMqOr/PoFd04Tcnphke57aKEpmCRzbiiGaZhf/mthrEzePaL97/YR6lCliHV5MkvY35bEt6HjYWF21gIbUjQD1IN6mUuKktxzwqEnG1VIuXjJeii1ZZF3KKt3c+JP+YCkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722156689; c=relaxed/simple;
	bh=g3TcyyJ7JcBB/E3uMfjnrlxTshswPbPUgcCxLenzVo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqhT4thRvn74jFf8//suNWcksn12O1iPRpnW8K9mHP3cOcq/0axIq/VaHYmuG5zIanaGJu1d8xCEHCynR8qIaQpGBtn0dW3bqG1yfuL7MjNsT0DML/g22Yf6Krxfs3FE84xGqNUTCmPTum5WetkIAb1RiMT0e7LVPOxCHX9rFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLlcXe+A; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-368633ca4ffso161239f8f.0;
        Sun, 28 Jul 2024 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722156686; x=1722761486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fFRJsv0r9FOhit89mGrjjDOTjioZ+AI5gd5+LyCXTE=;
        b=dLlcXe+AG+9k5qyre6XTOBbv5eub9BN1MCKG/B34OcmBRH5wvleEM+qBkIYlv0d2+n
         YViEvYVoWyGamQ4ie645HxUQUNtOqtndCwb6bdwF754xp21GDrUNggnZUOR8MW64BA/f
         UW3YG8FS9v3Nj2YaGCyp1zGw3zCYH5tKRd6vDsnZVvTbmcaT6OuXWbEOdEE7I+4liwd0
         lD6afYIUB8XcuUKqmaI0KiW5q+HD87Al8vp4pXS0hCMpVWi5yMsGkfCaHcyl62vWWNi4
         ea2QTJ/UbEad5cPFHzxkSd637JfM8KDSbCTaP4dj7pyICleXw7qWP3kzlSIgN8Oxvk2E
         o9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722156686; x=1722761486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fFRJsv0r9FOhit89mGrjjDOTjioZ+AI5gd5+LyCXTE=;
        b=Y9vVaEAGaUwXYJpOj0IsfeZXxTd4JS8ktgpSgY1wjM8rTzASBNc93NFsGdUvD+TBWe
         /TJnwXsrWLpX0dQHAOfs656EQbTZCtU4N7Uw92Eb/IpAd++YwupdTKhizAw935brEY0o
         l2svGuko2JzqK+y5E1W4xtxQ9IO9zPc6ZvWTM28k2ge5Gol4OYvV2Vxf1s5HiJOrjCKz
         +Qbeqs4/VGdmdjqgOivLBNOMtiANLca6K743yz+16R2YmlPA+gYcBBBB5ZONHowC+v/J
         LKb0t2tXP03oGaVGLlFE2JmdqG4VpGy9GaoFNFosPdzQBLEYs1Z3j+1sPesZlJlYsdn7
         b53w==
X-Forwarded-Encrypted: i=1; AJvYcCWFZrbatPkyPitp80rY5Ln0/ukHULISJCvj3V+8rGKU18Mys9aNeFO0UjqYXz3Fy9hhqGgwIKGhA92na2Ka@vger.kernel.org, AJvYcCWa0gIjP/aUsasQwHYKWlyu+usoAqBxaJbKJxrQk/jkdZhZp6RXHSelPOdKQJ7+8vBf+CcAMip7CtQ=@vger.kernel.org, AJvYcCXHW/L3NLuiH+GyzAtRkQ1sz369UQt6BLXcI8eZs/ntlkylnALVV9BqOV7uA9tsCTdJtZwPd6rrNb1mOUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwR8vpo9T2JIcVfpc25nyzt6nrK+Tp1wWt+s9k4OOtvGZg/KiA
	U1lrbo9h8yoOOxHhEXpDfChQvlWfI0wMH2jDekpndx2ia6BskqYnm5fPEA==
X-Google-Smtp-Source: AGHT+IE2CQTvhsLw/8YVxTpgFvbiZTQhmvsE1mktJzUgo+gPEAzzuyUz4oP1+K8+oWH5h54sSNn3Rw==
X-Received: by 2002:a05:600c:3b21:b0:424:ac9f:5c61 with SMTP id 5b1f17b1804b1-428057706aemr45784535e9.3.1722156686173;
        Sun, 28 Jul 2024 01:51:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:1d00:5943:7f74:2af0? ([2a01:4b00:d20e:7300:1d00:5943:7f74:2af0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280ca10aa6sm86140805e9.26.2024.07.28.01.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 01:51:25 -0700 (PDT)
Message-ID: <3ab0aa72-4f89-4911-8546-ce17f362c981@gmail.com>
Date: Sun, 28 Jul 2024 09:51:24 +0100
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
 <0576f5dd-656b-4085-8c8d-b0f845875f0f@wanadoo.fr>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <0576f5dd-656b-4085-8c8d-b0f845875f0f@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 07:59, Christophe JAILLET wrote:
> Le 26/07/2024 à 09:47, Ivan Orlov a écrit :
>> Implement two ioctl calls in order to support virtual userspace-driven
>> ALSA timers.
>>
>> The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
>> snd_utimer_info struct as a parameter and returns a file descriptor of
>> a virtual timer. It also updates the `id` field of the snd_utimer_info
>> struct, which provides a unique identifier for the timer (basically,
>> the subdevice number which can be used when creating timer instances).
>>
>> This patch also introduces a tiny id allocator for the userspace-driven
>> timers, which guarantees that we don't have more than 128 of them in the
>> system.
>>
>> Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
>> the virtual timer (and calls snd_timer_interrupt for the timer under
>> the hood), causing all of the timer instances binded to this timer to
>> execute their callbacks.
>>
>> The maximum amount of ticks available for the timer is 1 for the sake of
>> simplification of the userspace API. 'start', 'stop', 'open' and 'close'
>> callbacks for the userspace-driven timers are empty since we don't
>> really do any hardware initialization here.
>>
>> Suggested-by: Axel Holzinger <aholzinger@gmx.de>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
> 
> ...
> 
>> +#ifdef CONFIG_SND_UTIMER
>> +/*
>> + * Since userspace-driven timers are passed to userspace, we need to 
>> have an identifier
>> + * which will allow us to use them (basically, the subdevice number 
>> of udriven timer).
>> + *
>> + * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to 
>> (SNDRV_UTIMERS_MAX_COUNT - 1).
>> + * When we take one of them, the corresponding entry in 
>> snd_utimer_ids becomes true.
>> + */
>> +static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
>> +
>> +static void snd_utimer_put_id(struct snd_utimer *utimer)
>> +{
>> +    int timer_id = utimer->id;
>> +
>> +    snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
>> +    snd_utimer_ids[timer_id] = false;
>> +}
>> +
>> +static int snd_utimer_take_id(void)
>> +{
>> +    size_t i;
>> +
>> +    for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
>> +        if (!snd_utimer_ids[i]) {
>> +            snd_utimer_ids[i] = true;
>> +            return i;
>> +        }
>> +    }
>> +
>> +    return -EBUSY;
>> +}
> 
> Also the bitmap API could be useful here.
> 

Awesome, will use it in V2.

Thank you!


-- 
Kind regards,
Ivan Orlov


