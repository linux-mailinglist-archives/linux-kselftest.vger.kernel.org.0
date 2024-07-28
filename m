Return-Path: <linux-kselftest+bounces-14327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E493E44E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 11:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7793EB210C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C221799B;
	Sun, 28 Jul 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iMCcTFIN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A5168D0;
	Sun, 28 Jul 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722159059; cv=none; b=LptCZkZABjDZ7dX/X/nrFtvxO3y8wJTPMwiNeey7gP2DQW97jdZkQte791AFMm0I03nNgjEDM6UlRrJzL+OM/LF3UL594dnU367qNafebXBMsmElVtZbxRAIR8mmcjwHr13ZLV4uM7IGjzcncEVEZKOK5wSsucMWmfedwbLk84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722159059; c=relaxed/simple;
	bh=Sb6PagWHJopb5flWw28N+nQdK1mZdEL89WZHCedwF5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Weq4+mYpqTTnjXQktoZsERFOe19BqeId+y3gJxB6M4CesbggUViEKG1RoZ4UsNbDhhopHJJFZNnj/kMt+OEViQgxjBHg8yMfNFJosvL+CdbOgS/rz0xHWOR2AdbxBJMUizR4mdkyIzlbnweQjvba0udT6TRgrhQpwLPtw5tItDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iMCcTFIN; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Y0EnstIRknYGvY0EnslPAy; Sun, 28 Jul 2024 11:30:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722159049;
	bh=B6QN6fZDyLaAGWpJB5Hz98gt3ufWWIQxuTRONW6K2yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iMCcTFIN9zsxxGG7VwNX/IkPMpuh8n1OGy+Mf/hH+WoVMcYVdnTXySOrKexl+UdY1
	 PWXTUbVpazId8NxTpeCCCOVEqFYsOMmahJ9Q/cjnddkYd7/0oC8lKenW69Z23+EO8W
	 khdmeNvI/NKSagL4WVPyAVoN2ElOGUzrkEiyjPaYn8Gzjwb492vybUq/rxYIPEeDoz
	 eR3y0TmgYEoYnoc/mL5uqYfAwasKvB1ztnc8drkv8FpGvnK0VCrEu//Wej6w2E48li
	 iU/0Dw/OIvzTRrhThd2jh52YexSC9FeDKspKd71qRMQUPRBzQPkS5jZt0tYTuhM9be
	 PAPd+KB/v0Vwg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 28 Jul 2024 11:30:49 +0200
X-ME-IP: 90.11.132.44
Message-ID: <42ba79ad-3354-448d-ae03-6f68d51f46c5@wanadoo.fr>
Date: Sun, 28 Jul 2024 11:30:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com,
 corbet@lwn.net, broonie@kernel.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, aholzinger@gmx.de
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
 <20240726074750.626671-4-ivan.orlov0322@gmail.com>
 <0576f5dd-656b-4085-8c8d-b0f845875f0f@wanadoo.fr>
 <3ab0aa72-4f89-4911-8546-ce17f362c981@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <3ab0aa72-4f89-4911-8546-ce17f362c981@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/07/2024 à 10:51, Ivan Orlov a écrit :
> On 7/28/24 07:59, Christophe JAILLET wrote:
>> Le 26/07/2024 à 09:47, Ivan Orlov a écrit :
>>> Implement two ioctl calls in order to support virtual userspace-driven
>>> ALSA timers.
>>>
>>> The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
>>> snd_utimer_info struct as a parameter and returns a file descriptor of
>>> a virtual timer. It also updates the `id` field of the snd_utimer_info
>>> struct, which provides a unique identifier for the timer (basically,
>>> the subdevice number which can be used when creating timer instances).
>>>
>>> This patch also introduces a tiny id allocator for the userspace-driven
>>> timers, which guarantees that we don't have more than 128 of them in the
>>> system.
>>>
>>> Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
>>> the virtual timer (and calls snd_timer_interrupt for the timer under
>>> the hood), causing all of the timer instances binded to this timer to
>>> execute their callbacks.
>>>
>>> The maximum amount of ticks available for the timer is 1 for the sake of
>>> simplification of the userspace API. 'start', 'stop', 'open' and 'close'
>>> callbacks for the userspace-driven timers are empty since we don't
>>> really do any hardware initialization here.
>>>
>>> Suggested-by: Axel Holzinger <aholzinger@gmx.de>
>>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>> ---
>>
>> ...
>>
>>> +#ifdef CONFIG_SND_UTIMER
>>> +/*
>>> + * Since userspace-driven timers are passed to userspace, we need to 
>>> have an identifier
>>> + * which will allow us to use them (basically, the subdevice number 
>>> of udriven timer).
>>> + *
>>> + * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to 
>>> (SNDRV_UTIMERS_MAX_COUNT - 1).
>>> + * When we take one of them, the corresponding entry in 
>>> snd_utimer_ids becomes true.
>>> + */
>>> +static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
>>> +
>>> +static void snd_utimer_put_id(struct snd_utimer *utimer)
>>> +{
>>> +    int timer_id = utimer->id;
>>> +
>>> +    snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
>>> +    snd_utimer_ids[timer_id] = false;
>>> +}
>>> +
>>> +static int snd_utimer_take_id(void)
>>> +{
>>> +    size_t i;
>>> +
>>> +    for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
>>> +        if (!snd_utimer_ids[i]) {
>>> +            snd_utimer_ids[i] = true;
>>> +            return i;
>>> +        }
>>> +    }
>>> +
>>> +    return -EBUSY;
>>> +}
>>
>> Also the bitmap API could be useful here.
>>
> 
> Awesome, will use it in V2.

Hmm, maybe DEFINE_IDA(), ida_alloc_max() and ida_free() would be even 
better.

CJ

> 
> Thank you!
> 
> 


