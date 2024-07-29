Return-Path: <linux-kselftest+bounces-14408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E2940140
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC9A28291C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF0190462;
	Mon, 29 Jul 2024 22:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UktLaLZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C118F2FD;
	Mon, 29 Jul 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292656; cv=none; b=Uw+ehoeG9P1cJ8sSi9iyVjOowdddGS+EphZJ9WI4SMRHTmSAg9S61nh6vszr3FSYisEl4AwAcL6RqiwY6DoU1FHad6ZcaUextACQiEBMOWiqpH1UixaFW6W5npbnwilO0g/NfyYJeBjULatL9tZ52lGPaCGKrfmnTbsDiVOFbV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292656; c=relaxed/simple;
	bh=uyeP2/MLy9i7q7DZLG4tKT3WQLbttQA6hmdbPlrX1CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBlYPrjuFWF9QVpQydFIydgFovjOjvN5wkpTej751VRruTjHBv+mLW2LJ9tvXpjs6EyKi5Pw+QG6/KnOKtyyPUe79xBC4hUft7OLav/9YU170CkB/qNiAORRLWXcYUElkkWSGhPSRVvh2bH/1dAVq8/rOIkSpqE1FL0msqeorEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UktLaLZM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ac10b7cso437205e9.3;
        Mon, 29 Jul 2024 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722292652; x=1722897452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TuSPq7xMvyL8V/4jWvjLPZZucNG2HeXMEGBogZGNac0=;
        b=UktLaLZMzCmOLPUpuugHgyChq9YHlqgrzglZWlz3gxRJ7akGboBXzo9mn5SxqDnENY
         L1/iVqrXuxoMGnE0sIoPqOnV3E9u4vf9ps09l3PWSNg8BEEfS74xp4mxAKKG0dOwG0FR
         FN+TAwZsP7fIAgg/Z0k8SWU5Rms1aATOvkZbR+6477f8ioaiXJ3ILic0WRhXky3UOP5Y
         LanAOLDhJF2DXklITp97c4LYXioMplmIlBX1fiK4QDe1yXzhOz/F5YT9baGD/mWmeaIO
         Rs02D7wtAwOCwav1rU57IZq3NNhqHM21Tki14V3clqIA5CNp+WZGewuhvmamGBDUYFr0
         RVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722292652; x=1722897452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuSPq7xMvyL8V/4jWvjLPZZucNG2HeXMEGBogZGNac0=;
        b=EuxDHxdMaGAhsLjE7EY9oBeeVlXvQSGya4FUK/a9jtNPxOmGMEqE0jo2jCTEBFKz12
         EQA/f/JrR6earwOnPzbIkYu82csjAEkQT8Y9nzHdLQ9vGG0VJqHqXorZSq4aMGpYmDBx
         0UYRCUDUdq9SuVFkyROSME3W2yGZ9mnyixzFsfkNeW6vA/wL3bLm59ehxKCNrLz1wmgV
         92/FBDOTm1GVdUnSuEo8+SqHG+QXi58DodE3JC30AQAotM4ONMaOg4Y8x/zRgZEk/qFM
         Zq/PsyRn1WBFOoYjZlWY0hwIcDwac1h1E17olh+kvKliq7DojD9fA0RdpbgxwWOUOW7I
         u68g==
X-Forwarded-Encrypted: i=1; AJvYcCV6yRfn8y5zFHKgoc2zXDBHaplbigVSygASgtyaslzJqSdCWdjfp5ExYIusuRWornKXqmVjAeYV33EqfOEq@vger.kernel.org, AJvYcCVCox57fjF8nbWM2QE182d+ali1WQj956ZPE4TyiRbBu282XUyv58jLiy+MdL3Cc45pfY7mIHNAwYV+Tzk=@vger.kernel.org, AJvYcCWnXDFp+tizZPBfXcgrT7h4CUM9Y+JXOdnfss0ijC19/gzmLELHSA2etrLLL/ylFZyirFf0bunjzj8=@vger.kernel.org, AJvYcCWohBaQwKrtRYmKJKCadA8MGE2QtvpDJXJ935lSaLWspsmrTHn9KSei0Q6XjHUgWawOhV70gppIJWAzBj37mn9d@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC+4bsiLmP4wwm3zxGxR9k8cfdWAuHgfj6d24TxMkaHAejxil
	9LutsRJyokh2Rxq3AiinnTxOUD5MkntILj4iYVJgKPikB2WjqFiW
X-Google-Smtp-Source: AGHT+IFr5IcJVq8AfQOuAQZZHPotCVtkmUnrIh5Jb1K3Etigel6lo7bMmdM8830oCCYQoOYeJgoZXA==
X-Received: by 2002:a05:600c:3ca8:b0:426:6cd1:d104 with SMTP id 5b1f17b1804b1-4280578251bmr70361265e9.4.1722292652132;
        Mon, 29 Jul 2024 15:37:32 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:cbb1:99a8:b4d0:fbe5? ([2a01:4b00:d20e:7300:cbb1:99a8:b4d0:fbe5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428218a3934sm14362105e9.45.2024.07.29.15.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 15:37:31 -0700 (PDT)
Message-ID: <d4c65f00-276a-400a-b1b0-e96f5fca2d3f@gmail.com>
Date: Mon, 29 Jul 2024 23:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, corbet@lwn.net, broonie@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 Axel Holzinger <aholzinger@gmx.de>
References: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
 <20240729085905.6602-4-ivan.orlov0322@gmail.com>
 <87h6c89tzl.wl-tiwai@suse.de>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87h6c89tzl.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 15:02, Takashi Iwai wrote:
> On Mon, 29 Jul 2024 10:59:04 +0200,
> Ivan Orlov wrote:
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
> (snip)

Hi Takashi,

Thank you so much for the review.

>> +/*
>> + * This structure describes the userspace-driven timer. Such timers are purely virtual,
>> + * and can only be triggered from software (for instance, by userspace application).
>> + */
>> +struct snd_utimer_info {
>> +	/*
>> +	 * To pretend being a normal timer, we need to know the frame rate and
>> +	 * the period size in frames.
>> +	 */
>> +	snd_pcm_uframes_t frame_rate;
>> +	snd_pcm_uframes_t period_size;
> 
> The units in timer API should be independent from PCM.
> So use the explicit type such as __u64 here (so that you don't need
> the compat ioctl conversion, too).
> 

Alright, I'll use __u64 here (initially I thought it is going to be more 
clear because it specifies the unit `period_size` is stored in, but I 
agree that it should be completely independent from pcm).

>> +	unsigned int id;
>> +};
> 
> We often put some reserved fields for future extension.
> But I'm not sure whether it's needed at this time for this kind of
> simple interface, though.
> 

Yeah, I don't think we are going to add anything else to the timers 
anytime soon... However, I'll probably add a small reserved space here 
(16 bytes, for instance), just in case we decide to add more parameters. 
Thanks!

>>   #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
>>   #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
>>   #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
>> @@ -990,6 +1005,8 @@ struct snd_timer_status {
>>   #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
>>   #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
>>   #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
>> +#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_utimer_info)
>> +#define SNDRV_TIMER_IOCTL_TRIGGER	_IO('T', 0xa6)
> 
> Once after adding the new API, don't forget to bump the protocol
> version defined in SNDRV_TIMER_VERSION.
> 

Ah, alright, I'll fix that in V3. Sorry, haven't noticed it :(

>> --- a/sound/core/timer.c
>> +++ b/sound/core/timer.c
> (snip)
>> +#ifdef CONFIG_SND_UTIMER
>> +/*
>> + * Since userspace-driven timers are passed to userspace, we need to have an identifier
>> + * which will allow us to use them (basically, the subdevice number of udriven timer).
>> + */
>> +DEFINE_IDA(snd_utimer_ids);
> 
> Missing static.
> 

Ah, yes, I missed the static here. thanks!

>> +static int snd_utimer_create(struct snd_utimer_info *utimer_info,
>> +			     struct snd_utimer **r_utimer)
>> +{
> (snip)
>> +	err = snd_timer_new(NULL, utimer->name, &tid, &timer);
>> +	if (err < 0) {
>> +		pr_err("Can't create userspace-driven timer\n");
>> +		goto err_timer_new;
>> +	}
>> +
>> +	timer->module = THIS_MODULE;
>> +	timer->hw = timer_hw;
>> +	timer->hw.resolution = NANO / utimer_info->frame_rate * utimer_info->period_size;
> 
> A sanity check is definitely needed for parameters like this.
> e.g. you'd hit a zero-division Oops with this code.
> Also, the resolution should be neither too small nor too high.
> 

Yeah, allowing zero division here (and overflows) is a very bad idea... 
I'll add some checks in V3.

>> +static int snd_utimer_ioctl_create(struct file *file,
>> +				   struct snd_utimer_info __user *_utimer_info)
>> +{
>> +	struct snd_utimer *utimer;
>> +	struct snd_utimer_info *utimer_info;
>> +	int err;
>> +
>> +	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
>> +	if (IS_ERR(utimer_info))
>> +		return PTR_ERR(no_free_ptr(utimer_info));
> 
> no_free_ptr() is used only for the automatic cleanup stuff.
> 

Probably, I should use automatic cleanup here as well (as it is done in 
snd_timer_user_ginfo).

>> +static int snd_utimer_ioctl_create(struct file *file,
>> +				   struct snd_utimer_info __user *_utimer_info)
>> +{
>> +	return -EINVAL;
> 
> Better to keep -ENOTTY?

Initial idea was that EINVAL here would say that the functionality is 
supported, but disabled in the config, but it seems like it breaks the 
convention this way so I'm going to change this to ENOTTY in the next 
version.

Thank you!
-- 
Kind regards,
Ivan Orlov


