Return-Path: <linux-kselftest+bounces-14342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254FD93E47F
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF761F214B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957228683;
	Sun, 28 Jul 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OkL57efV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3E28382;
	Sun, 28 Jul 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722162599; cv=none; b=VX6LZNSjQnX2fCi1MCULpkpH1oQlszJl80Q/4RIjLiW4IeYQ5uWieP9W2URMX1EZrEZbjNnIZkRQzjzHZEU7d/rMGc9bBKtG1ffYugQAGGz32UTzJ08eVEq0tEaC6HLcGFNFV9Cy4IMtSNa5M0ez4o+UNw3f2A7c2f0KcUn6xLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722162599; c=relaxed/simple;
	bh=X4zyslduhoxBJhcIf9T3uXj0lYCZ88zJlCzb9/Q4Mzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upBq5lDF8fbJS4bLBPeACSsFxDsLyl5k8sYzGdszSNP+/DA6lJWi7KOb3b2gd0+aUxp0WxoFU1rlBBn7pPkrH7CWM7fbxrTQ3RU0Ytp2mPgt8gp0ieY3JePl4U73m8lRLu0MtlElw1HuzeNK/j+BPcj9xU83BiyUKjS7DH56Ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=OkL57efV; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Y19zscztz6NRTY19zs8LwH; Sun, 28 Jul 2024 12:29:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722162593;
	bh=p46J9kZB/fzXgFZvNvDVd+YvmQ29LxB8OC6+hd1jihc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OkL57efVzquh5+3kouEh51FEacBXQOyAxV53ErXxQODSw5317wzHaJXtennFC2wiq
	 DgqLE6sfQ2ai1LjPSmXYtLEn6JOygS2W0jFmvjispvmQSGaI6BHNo/m0ouQg6Pg3u2
	 rJ6BKlp3R67ng6BaeSjHQi5Y1EwcdrzD+QY/HqJZ54gfSto/AZTxknHxvFoQjT9sHd
	 bLrYfil7D2KZ1TPLczAeNW+owbhDNskjtnaDkpZ5V+xdVcSkoD9it//4iEzOKh7IcV
	 oFgKfvuATdUSfRkQHDCxGN+LDOA5HEHapmrqf4rhZg0KiOUqt01UJ5JXaDTPKkQTjM
	 Jghuy/xQ53Jvg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 28 Jul 2024 12:29:53 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c73da5fd-51a9-4744-9687-0ebc56c34fca@wanadoo.fr>
Date: Sun, 28 Jul 2024 12:29:51 +0200
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
 <42ba79ad-3354-448d-ae03-6f68d51f46c5@wanadoo.fr>
 <08bdc510-da39-42d4-a104-9c7119d082ea@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <08bdc510-da39-42d4-a104-9c7119d082ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/07/2024 à 11:42, Ivan Orlov a écrit :
> On 7/28/24 10:30, Christophe JAILLET wrote:
>> Le 28/07/2024 à 10:51, Ivan Orlov a écrit :
>>> On 7/28/24 07:59, Christophe JAILLET wrote:
>>>> Le 26/07/2024 à 09:47, Ivan Orlov a écrit :
>>>>> Implement two ioctl calls in order to support virtual userspace-driven
>>>>> ALSA timers.
>>>>>
>>>>> The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
>>>>> snd_utimer_info struct as a parameter and returns a file descriptor of
>>>>> a virtual timer. It also updates the `id` field of the snd_utimer_info
>>>>> struct, which provides a unique identifier for the timer (basically,
>>>>> the subdevice number which can be used when creating timer instances).
>>>>>
>>>>> This patch also introduces a tiny id allocator for the 
>>>>> userspace-driven
>>>>> timers, which guarantees that we don't have more than 128 of them 
>>>>> in the
>>>>> system.
>>>>>
>>>>> Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
>>>>> the virtual timer (and calls snd_timer_interrupt for the timer under
>>>>> the hood), causing all of the timer instances binded to this timer to
>>>>> execute their callbacks.
>>>>>
>>>>> The maximum amount of ticks available for the timer is 1 for the 
>>>>> sake of
>>>>> simplification of the userspace API. 'start', 'stop', 'open' and 
>>>>> 'close'
>>>>> callbacks for the userspace-driven timers are empty since we don't
>>>>> really do any hardware initialization here.
>>>>>
>>>>> Suggested-by: Axel Holzinger <aholzinger@gmx.de>
>>>>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>>>>> ---
>>>>
>>>> ...
>>>>
>>>>> +#ifdef CONFIG_SND_UTIMER
>>>>> +/*
>>>>> + * Since userspace-driven timers are passed to userspace, we need 
>>>>> to have an identifier
>>>>> + * which will allow us to use them (basically, the subdevice 
>>>>> number of udriven timer).
>>>>> + *
>>>>> + * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to 
>>>>> (SNDRV_UTIMERS_MAX_COUNT - 1).
>>>>> + * When we take one of them, the corresponding entry in 
>>>>> snd_utimer_ids becomes true.
>>>>> + */
>>>>> +static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
>>>>> +
>>>>> +static void snd_utimer_put_id(struct snd_utimer *utimer)
>>>>> +{
>>>>> +    int timer_id = utimer->id;
>>>>> +
>>>>> +    snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
>>>>> +    snd_utimer_ids[timer_id] = false;
>>>>> +}
>>>>> +
>>>>> +static int snd_utimer_take_id(void)
>>>>> +{
>>>>> +    size_t i;
>>>>> +
>>>>> +    for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
>>>>> +        if (!snd_utimer_ids[i]) {
>>>>> +            snd_utimer_ids[i] = true;
>>>>> +            return i;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return -EBUSY;
>>>>> +}
>>>>
>>>> Also the bitmap API could be useful here.
>>>>
>>>
>>> Awesome, will use it in V2.
>>
>> Hmm, maybe DEFINE_IDA(), ida_alloc_max() and ida_free() would be even 
>> better.
>>
> 
> It looks like IDA allocator uses XArrays under the hood to allocate ids 
> between 0 and INT_MAX... Considering the fact, that we currently could 
> have up to 128 userspace-driven timers in the system, using XArrays 
> seems a bit redundant, and I believe bitmap approach would be more 
> efficient. What do you think?
> 

I may be wrong but I think that ida allocates hunks for 1024 bits (128 
bytes * 8) at a time. (see [1])

So with this extra sape and the sapce for the xarray, it would waste a 
few bytes of memory, yes.

With ida, there is also some locking that may be unnecessary (but harmless)


Hoping, I got it right, here are a few numbers:

On a x86_64, with allmodconfig:

Your initial patch:
    text	   data	    bss	    dec	    hex	filename
   55020	   1783	    268	  57071	   deef	sound/core/timer.o

With ida:
   54763	   1631	    116	  56510	   dcbe	sound/core/timer.o
+ 128 bytes of runtime memory allocation

With bitmap:
   54805	   1535	    132	  56472	   dc98	sound/core/timer.o


I think that the code would be slightly more elegant with ida, but 
implementing it with a bitmap does not add that much complexity.

CJ


[1]: 
https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/idr.h#L238

