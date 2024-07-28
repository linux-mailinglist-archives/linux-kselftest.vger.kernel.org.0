Return-Path: <linux-kselftest+bounces-14323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19B93E3B8
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 08:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88902B21305
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82068C07;
	Sun, 28 Jul 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tLyXTU/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976C8BEC;
	Sun, 28 Jul 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722149559; cv=none; b=kuP5fhDkyZdTENn4Xb5UIrk/IhpZB2X/QYcW1KLNiaOq/mP/DtVdxXvtGoiynFdHJIvlVcc2caqBdGvSVMjB5jsOjtjlx8qrSIIG5Zg7VwZ2GGlZcsXy3HgVdMH67PPH12w6cjJEVY8Za2hfP5oQhnKBVcFmzOgKe9nvVRI5TB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722149559; c=relaxed/simple;
	bh=w4VBB9LsLEaXL66z8li/akJJRFq8/zQyhynB6iTnz1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiGr3g1Bp+A+mWg7/K1IZzW0jglXE6F+ygOzDYpBvfC6cUqNfmyZoRZw4nreP4rt0zbUn7+fF5buMmTO4zYsLfDTOLtOuMyhIElzrEMVTahxxf5M/OxpzDwgCRbMbUg3JsZvJenTKWrMqQ2vZfeFw3IRlWkrnuvdmjepEh8wqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tLyXTU/w; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id XxlfsACLZx5lnXxlgszGbA; Sun, 28 Jul 2024 08:52:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722149554;
	bh=OFUunbe0HaG1IV8wUY0jJuTqlXVNzTwhJ7cRVKBT2/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=tLyXTU/wdkPEVD/Wa24n5UbJo/Fam9aRnKNXNKKNvoSj6WVk07y9er1HlF9zGFr1I
	 qoi/kmVv3uJllZLmH8pJ7tLr1Ak1nmpR4/vsRH4JS43nbqRiT5nytrQmWaBFEI5mnV
	 kzZfYSVXIV2cGJ96JmU4R8pCdCNSbzyw5YhDlPVjkbxJACyaDdRzIvzRqgGDNVUB3j
	 EZCWo1U8XCTPI0SFpw0QRqcA9hXCURyAkKXSfJ6rxmkQPpYUr9/w0FkLqhdrQ8nUoX
	 I2cKpb03fR/dFfQPv6unAMH1saSZ/DBNQNJN3WFJAs5IzV80t6f5bDcpPZJIBRaODl
	 pLkqj/2vHYkGg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 28 Jul 2024 08:52:34 +0200
X-ME-IP: 90.11.132.44
Message-ID: <6b0a39f4-1a0c-4e3e-955e-31bbb33ba54a@wanadoo.fr>
Date: Sun, 28 Jul 2024 08:52:30 +0200
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

Hi,

...

> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index b970a1734647..3cf82641fc67 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -251,6 +251,17 @@ config SND_JACK_INJECTION_DEBUG
>   	  Say Y if you are debugging via jack injection interface.
>   	  If unsure select "N".
>   
> +config SND_UTIMER
> +	bool "Enable support for userspace-controlled virtual timers"
> +	depends on SND_TIMER
> +	help
> +	  Say Y to enable the support of userspace-controlled timers. These
> +	  timers are purely virtual, and they are supposed to be triggered
> +	  from userspace. They could be quite useful when synchronizing the
> +	  sound timing with userspace applications (for instance, when sending
> +	  data through snd-aloop).
> +

Unneeded extra new line.

> +
>   config SND_VMASTER
>   	bool
>   

...

> +static void snd_utimer_free(struct snd_utimer *utimer)
> +{
> +	snd_timer_free(utimer->timer);
> +	snd_utimer_put_id(utimer);

Missing kfree(utimer->name); ?

> +	kfree(utimer);
> +}

...

> +static int snd_utimer_create(struct snd_utimer_info *utimer_info,
> +			     struct snd_utimer **r_utimer)
> +{
> +	struct snd_utimer *utimer;
> +	struct snd_timer *timer;
> +	struct snd_timer_id tid;
> +	int utimer_id;
> +	int err = 0;
> +	char *timer_name;
> +
> +	utimer = kzalloc(sizeof(*utimer), GFP_KERNEL);
> +	if (!utimer)
> +		return -ENOMEM;
> +
> +	timer_name = kzalloc(SNDRV_UTIMER_NAME_LEN, GFP_KERNEL);

kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id); ?
and SNDRV_UTIMER_NAME_LEN becomes useless too.

In snd_timer_new() it is copied in a char[64] anyway, and if utimer_id 
is small, we could even save a few bytes of memory.

CJ

> +	if (!timer_name) {
> +		kfree(utimer);
> +		return -ENOMEM;
> +	}
> +
> +	/* We hold the ioctl lock here so we won't get a race condition when allocating id */
> +	utimer_id = snd_utimer_take_id();
> +	if (utimer_id < 0) {
> +		err = utimer_id;
> +		goto err_take_id;
> +	}
> +
> +	sprintf(timer_name, "snd-utimer%d", utimer_id);
> +	utimer->name = timer_name;
> +	utimer->id = utimer_id;

...


