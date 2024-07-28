Return-Path: <linux-kselftest+bounces-14328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3037593E457
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 11:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0695E281978
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E901BF37;
	Sun, 28 Jul 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKv9R1yJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA54D534;
	Sun, 28 Jul 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722159785; cv=none; b=MwXUW0/g6hEY2UYa9JCyBtJhMWtn5UaIwUQPW7pKOigIAkaCb9Nzz04/abdjeXoColuTtlwXiUNYR530ThvidkOimi5IX0e8QpXupymNNKfwRcgrvnvjgz5shNFOxoRAGdtOBunMZ/i/TwVxWvbLtQCEaJNfP71zQJhrQdoO4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722159785; c=relaxed/simple;
	bh=9K9MXRLy14iUiCrEGnTxwO4GHEMMBJM/TWlBGTNncw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IauXfzmrKmXnUZ+TEmdhaq746B5JQz1kGb06t3LW9HkkoiR8G/Ga+k4USZCn5c6VvzL0bBcHMmFqJZkwP1ZB8/6xc0cYMPaRYgWDSJx5JbAYDeKgmlgFm7DKBOd6iQezUgth28bdIvhrZc6eb/kKIoRjhgDHm8I8yjZ05kPZbnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKv9R1yJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso153983f8f.2;
        Sun, 28 Jul 2024 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722159782; x=1722764582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9R5xGNkFmRHXQYQVczCGuGgKp6enXGudOPKY559vV0=;
        b=JKv9R1yJw0ZWTPqullZp8IoIlxa5CJbVj+aME0LZii7NQ3XOh8D1M0X56BDmr+Dinp
         k4RWZY5Ty53uatOKDeKP3XWmrGWYQGEQWJz0KNlDdZ5q4LaOn9DKmzZoHWCM7W2K3DGx
         L5tc2wN/bj6lzTx8JgPaSzN9CTkO1f8H4r4pVA83G72xINiMyZtRJYPYq/GqYlIzfbSX
         BupLmRfMuiFNnTqt8EKLAC2tA7i6IqM3iLK5e6fzY9hpT6/n8HSJUMPPdRSh+EU9QCDE
         V2QsAW30iTtTo2vszUmEDGlgQoJ4LcQZXQG7ArqoyaMiGkgdtX2vgrTB4ZX0Le/FERbr
         NKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722159782; x=1722764582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9R5xGNkFmRHXQYQVczCGuGgKp6enXGudOPKY559vV0=;
        b=De4h/zaOirNmOwb+jE5ykqz/yC8tyKunp1MQXlTGVUHFR+tdHqewQnmdDOAQSjJDWC
         paC+Uu4ume4P4T+Lr0R/txw9ao/ttSE6jJIAIL/MI7MrjejuC8VZNrQQywuuFYi/OWf+
         7TT/RVLGaImjpYohoDIv6gp/ulhq2IBzrCwoVxCoJJYBv62Ft1tDalwaT7bhJOi1JhY3
         3LsAu9xsvJNRcHzM8uxz8W8Djz76Hr5PLneTeB9Bqbq3ywgAX8lJ6E2DaapSmJo/JQAE
         GScjJtNyYRacSPiyzaQiVBsdnk9dHU+CykExAYOFVv7GZQaIpmaABXpClO/j/gXgcvML
         lZhA==
X-Forwarded-Encrypted: i=1; AJvYcCUS2rqynQub6flRBwnVDXtHjanQLEKOZesDFpZhck1OoowOe6YKNHwjbuHACJXep6/K6JOVp11Fykc=@vger.kernel.org, AJvYcCVDyEBLMcJLGoqkC3TVdm2/qmQ2xJEv7cbESTjPy+Xy2+5UF4IrviXkwSBH6bsCVCI940kaAbFyDRuyHI4=@vger.kernel.org, AJvYcCWFBHWKc1SmNOwFtPGen+5n8hi8myCZYaj0zh12ktEdyYIUew9Cd1JkZVeyJL3waD+WSHdB7UEIahwjowg4@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyTtlo2tOnFtGlE3KUQUrgebzAegHl+95b/wN1MY50g+ipVSI
	YbvNDEURKJu15z5ZNyrBRRZCmPk0FLjzxboc9Fq0XQVUmWXYsE0J
X-Google-Smtp-Source: AGHT+IF0WJW3BoGEGaqc9cO7GiIyCqUsu2oYeZbpHD83HDKoLKAjZ517/zvYX82M9eQIDym4SKhzuQ==
X-Received: by 2002:adf:fa8d:0:b0:36b:36aa:a14e with SMTP id ffacd0b85a97d-36b36aaa367mr3154327f8f.8.1722159781970;
        Sun, 28 Jul 2024 02:43:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:1d00:5943:7f74:2af0? ([2a01:4b00:d20e:7300:1d00:5943:7f74:2af0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857db6sm9441245f8f.73.2024.07.28.02.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 02:43:01 -0700 (PDT)
Message-ID: <08bdc510-da39-42d4-a104-9c7119d082ea@gmail.com>
Date: Sun, 28 Jul 2024 10:42:59 +0100
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
 <3ab0aa72-4f89-4911-8546-ce17f362c981@gmail.com>
 <42ba79ad-3354-448d-ae03-6f68d51f46c5@wanadoo.fr>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <42ba79ad-3354-448d-ae03-6f68d51f46c5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 10:30, Christophe JAILLET wrote:
> Le 28/07/2024 à 10:51, Ivan Orlov a écrit :
>> On 7/28/24 07:59, Christophe JAILLET wrote:
>>> Le 26/07/2024 à 09:47, Ivan Orlov a écrit :
>>>> Implement two ioctl calls in order to support virtual userspace-driven
>>>> ALSA timers.
>>>>
>>>> The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
>>>> snd_utimer_info struct as a parameter and returns a file descriptor of
>>>> a virtual timer. It also updates the `id` field of the snd_utimer_info
>>>> struct, which provides a unique identifier for the timer (basically,
>>>> the subdevice number which can be used when creating timer instances).
>>>>
>>>> This patch also introduces a tiny id allocator for the userspace-driven
>>>> timers, which guarantees that we don't have more than 128 of them in 
>>>> the
>>>> system.
>>>>
>>>> Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
>>>> the virtual timer (and calls snd_timer_interrupt for the timer under
>>>> the hood), causing all of the timer instances binded to this timer to
>>>> execute their callbacks.
>>>>
>>>> The maximum amount of ticks available for the timer is 1 for the 
>>>> sake of
>>>> simplification of the userspace API. 'start', 'stop', 'open' and 
>>>> 'close'
>>>> callbacks for the userspace-driven timers are empty since we don't
>>>> really do any hardware initialization here.
>>>>
>>>> Suggested-by: Axel Holzinger <aholzinger@gmx.de>
>>>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>>> ---
>>>
>>> ...
>>>
>>>> +#ifdef CONFIG_SND_UTIMER
>>>> +/*
>>>> + * Since userspace-driven timers are passed to userspace, we need 
>>>> to have an identifier
>>>> + * which will allow us to use them (basically, the subdevice number 
>>>> of udriven timer).
>>>> + *
>>>> + * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to 
>>>> (SNDRV_UTIMERS_MAX_COUNT - 1).
>>>> + * When we take one of them, the corresponding entry in 
>>>> snd_utimer_ids becomes true.
>>>> + */
>>>> +static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
>>>> +
>>>> +static void snd_utimer_put_id(struct snd_utimer *utimer)
>>>> +{
>>>> +    int timer_id = utimer->id;
>>>> +
>>>> +    snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
>>>> +    snd_utimer_ids[timer_id] = false;
>>>> +}
>>>> +
>>>> +static int snd_utimer_take_id(void)
>>>> +{
>>>> +    size_t i;
>>>> +
>>>> +    for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
>>>> +        if (!snd_utimer_ids[i]) {
>>>> +            snd_utimer_ids[i] = true;
>>>> +            return i;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return -EBUSY;
>>>> +}
>>>
>>> Also the bitmap API could be useful here.
>>>
>>
>> Awesome, will use it in V2.
> 
> Hmm, maybe DEFINE_IDA(), ida_alloc_max() and ida_free() would be even 
> better.
> 

It looks like IDA allocator uses XArrays under the hood to allocate ids 
between 0 and INT_MAX... Considering the fact, that we currently could 
have up to 128 userspace-driven timers in the system, using XArrays 
seems a bit redundant, and I believe bitmap approach would be more 
efficient. What do you think?

-- 
Kind regards,
Ivan Orlov


