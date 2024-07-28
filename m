Return-Path: <linux-kselftest+bounces-14324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169DD93E3E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 09:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5192EB211DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 07:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F418C09;
	Sun, 28 Jul 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XGb0oC4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA22F30;
	Sun, 28 Jul 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722150516; cv=none; b=UFdgmmvQb0jIoufDonw0FdTWfauFP7Ew39Uy3WgGRgVWVP4FsIMF2pA0b56rBU8FlwjR+AkP9iccWKPKSk3+XhHN2gKHt93OfFPLZiZ1lWu95LDCmhyynXSeXMkPza/+6WPdXkLMFz6IrzsETbcOIfhZhGpgid1MatrwyBdgXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722150516; c=relaxed/simple;
	bh=XPloegrAQj5If0URiRrdUc1LA1dXgbBo0/Y44IynSjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE0u9nJ1Dt9k0bm7eq2DyoSmr0+q9bq/BnRcaYXDnDJTg2EwzQZPMa1JUr5xLqkBvOOw5nAaXV0AzYIJLVBYxt5CgLT154E3w36ylhhlmnQ83USWggm57cmXsgkfCcZrO90yNONJy4sZiz44upgQcIz2jpKoqxf0Og5O2vUL3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XGb0oC4f; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Xxs2sX5MAGdLxXxs2sF2Sj; Sun, 28 Jul 2024 08:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722149948;
	bh=n3xHZPZxtqhkSm8JPGNh+hOGTvxd4rcXGKbmto4kynk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XGb0oC4fNxtR7RUJGTgOVGegcJz5jhAsIk0Co8K92L8WsZFkhH0vAKLy2WAkMSlcy
	 IbmoPIRg7eoYnG1bFLJaR8GaLbKBHwgBIMR1b12G/QUxx9hLA+nmp2rHR9SnFtP5LH
	 ocffLueqU1fW9Wgu48Yl4mIHiywaD5oF2g827+UrOyEeBIeZ0mo5Cc9wevyPkeNyU4
	 G5mvvYhQSHVjIuIu8NuuaVy7NsZ11OKtKZtHMYv70+yq/chClNBY0kohl+QbNQUoGE
	 NyZumvdFquu8zjy1Vd79uPW8nma9gEVQbEJ3sYJ09MK1OyeXb+7SU0LXiAZVHr4kjn
	 ohAyEQ2aNrO5w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 28 Jul 2024 08:59:08 +0200
X-ME-IP: 90.11.132.44
Message-ID: <0576f5dd-656b-4085-8c8d-b0f845875f0f@wanadoo.fr>
Date: Sun, 28 Jul 2024 08:59:06 +0200
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
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240726074750.626671-4-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/07/2024 à 09:47, Ivan Orlov a écrit :
> Implement two ioctl calls in order to support virtual userspace-driven
> ALSA timers.
> 
> The first ioctl is SNDRV_TIMER_IOCTL_CREATE, which gets the
> snd_utimer_info struct as a parameter and returns a file descriptor of
> a virtual timer. It also updates the `id` field of the snd_utimer_info
> struct, which provides a unique identifier for the timer (basically,
> the subdevice number which can be used when creating timer instances).
> 
> This patch also introduces a tiny id allocator for the userspace-driven
> timers, which guarantees that we don't have more than 128 of them in the
> system.
> 
> Another ioctl is SNDRV_TIMER_IOCTL_TRIGGER, which allows us to trigger
> the virtual timer (and calls snd_timer_interrupt for the timer under
> the hood), causing all of the timer instances binded to this timer to
> execute their callbacks.
> 
> The maximum amount of ticks available for the timer is 1 for the sake of
> simplification of the userspace API. 'start', 'stop', 'open' and 'close'
> callbacks for the userspace-driven timers are empty since we don't
> really do any hardware initialization here.
> 
> Suggested-by: Axel Holzinger <aholzinger@gmx.de>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

...

> +#ifdef CONFIG_SND_UTIMER
> +/*
> + * Since userspace-driven timers are passed to userspace, we need to have an identifier
> + * which will allow us to use them (basically, the subdevice number of udriven timer).
> + *
> + * We have a pool of SNDRV_UTIMERS_MAX_COUNT ids from 0 to (SNDRV_UTIMERS_MAX_COUNT - 1).
> + * When we take one of them, the corresponding entry in snd_utimer_ids becomes true.
> + */
> +static bool snd_utimer_ids[SNDRV_UTIMERS_MAX_COUNT];
> +
> +static void snd_utimer_put_id(struct snd_utimer *utimer)
> +{
> +	int timer_id = utimer->id;
> +
> +	snd_BUG_ON(timer_id < 0 || timer_id >= SNDRV_UTIMERS_MAX_COUNT);
> +	snd_utimer_ids[timer_id] = false;
> +}
> +
> +static int snd_utimer_take_id(void)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < SNDRV_UTIMERS_MAX_COUNT; i++) {
> +		if (!snd_utimer_ids[i]) {
> +			snd_utimer_ids[i] = true;
> +			return i;
> +		}
> +	}
> +
> +	return -EBUSY;
> +}

Also the bitmap API could be useful here.

CJ


