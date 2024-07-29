Return-Path: <linux-kselftest+bounces-14382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B182593F72C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 16:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D6B280DB4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 14:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4A148826;
	Mon, 29 Jul 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IrINZfpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3WOkdpF+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IrINZfpH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3WOkdpF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77E2D05D;
	Mon, 29 Jul 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261710; cv=none; b=j2UXMSwaG10zib2K+qpRITHS4IUe7UpQM8xDGXljYCxTbpFFvErfyVFJoGEhzHTJJ3nz6RevRm9EXghq3i5dNTjz6Vc4F5ZAQhV1MLRxqs8YbQiHUR/wzrKGM8+0wtC6yNvwVO26vcqIW+dWZVcuvG7KSktGErTuBpa5WViSB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261710; c=relaxed/simple;
	bh=Owl1OIYHTF1V7vBi+ynNO4a2/eEjNT+ebMKM+3035nY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMA/EiW4qEhUF4h1mBEpeUQUJhUeJIPJqHYeR1FEne3fQAE6DfppSJvmT5uKquxWxzQmq5h9z2cOP0YGsW7S5uQ5WvqtVsSZDj4tnFMnTm5EDJseqShe+Hbonu7yreZoPfSUSht7IMHxWg9qoqNg3OjxGANuYssscB8/+YgPsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IrINZfpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3WOkdpF+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IrINZfpH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3WOkdpF+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE4F1F79C;
	Mon, 29 Jul 2024 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722261705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVUaDTmjkCvHr7RP0q30ab62OmQ9BCMWl7SWblWp8s8=;
	b=IrINZfpHyOirkmYdkMv//TJS4yGUZXypou2+5iQYWlugWn1Uc+D9Ed19fLVqsSA6vEJptD
	O4lcLp/NKqFXa0BYGhthlriAf3Yb4usNz7R+EMo9lmSyf7z8eYIKos9KqiIFHslY2Uf1I0
	4axwNyI47wBBODaFJfdm1+es9ZAj5GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722261705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVUaDTmjkCvHr7RP0q30ab62OmQ9BCMWl7SWblWp8s8=;
	b=3WOkdpF+CXlLXxDvkfBPxteGUv/PobJEePzDlOl5xdue++MpRCMDnstWj1O2gnRUwA48ub
	Mgcw6ZVckHaxFPBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722261705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVUaDTmjkCvHr7RP0q30ab62OmQ9BCMWl7SWblWp8s8=;
	b=IrINZfpHyOirkmYdkMv//TJS4yGUZXypou2+5iQYWlugWn1Uc+D9Ed19fLVqsSA6vEJptD
	O4lcLp/NKqFXa0BYGhthlriAf3Yb4usNz7R+EMo9lmSyf7z8eYIKos9KqiIFHslY2Uf1I0
	4axwNyI47wBBODaFJfdm1+es9ZAj5GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722261705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVUaDTmjkCvHr7RP0q30ab62OmQ9BCMWl7SWblWp8s8=;
	b=3WOkdpF+CXlLXxDvkfBPxteGUv/PobJEePzDlOl5xdue++MpRCMDnstWj1O2gnRUwA48ub
	Mgcw6ZVckHaxFPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5023313A9E;
	Mon, 29 Jul 2024 14:01:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X1khEsmgp2Z+YAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 29 Jul 2024 14:01:45 +0000
Date: Mon, 29 Jul 2024 16:02:22 +0200
Message-ID: <87h6c89tzl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	Axel Holzinger <aholzinger@gmx.de>
Subject: Re: [PATCH v2 3/4] ALSA: timer: Introduce virtual userspace-driven timers
In-Reply-To: <20240729085905.6602-4-ivan.orlov0322@gmail.com>
References: <20240729085905.6602-1-ivan.orlov0322@gmail.com>
	<20240729085905.6602-4-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,wanadoo.fr];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,lwn.net,kernel.org,vger.kernel.org,wanadoo.fr,gmx.de];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.60

On Mon, 29 Jul 2024 10:59:04 +0200,
Ivan Orlov wrote:
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
(snip)
> +/*
> + * This structure describes the userspace-driven timer. Such timers are purely virtual,
> + * and can only be triggered from software (for instance, by userspace application).
> + */
> +struct snd_utimer_info {
> +	/*
> +	 * To pretend being a normal timer, we need to know the frame rate and
> +	 * the period size in frames.
> +	 */
> +	snd_pcm_uframes_t frame_rate;
> +	snd_pcm_uframes_t period_size;

The units in timer API should be independent from PCM.
So use the explicit type such as __u64 here (so that you don't need
the compat ioctl conversion, too).

> +	unsigned int id;
> +};

We often put some reserved fields for future extension.
But I'm not sure whether it's needed at this time for this kind of
simple interface, though.

>  #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
>  #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
>  #define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
> @@ -990,6 +1005,8 @@ struct snd_timer_status {
>  #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
>  #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
>  #define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
> +#define SNDRV_TIMER_IOCTL_CREATE	_IOWR('T', 0xa5, struct snd_utimer_info)
> +#define SNDRV_TIMER_IOCTL_TRIGGER	_IO('T', 0xa6)

Once after adding the new API, don't forget to bump the protocol
version defined in SNDRV_TIMER_VERSION.

> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
(snip)
> +#ifdef CONFIG_SND_UTIMER
> +/*
> + * Since userspace-driven timers are passed to userspace, we need to have an identifier
> + * which will allow us to use them (basically, the subdevice number of udriven timer).
> + */
> +DEFINE_IDA(snd_utimer_ids);

Missing static.

> +static int snd_utimer_create(struct snd_utimer_info *utimer_info,
> +			     struct snd_utimer **r_utimer)
> +{
(snip)
> +	err = snd_timer_new(NULL, utimer->name, &tid, &timer);
> +	if (err < 0) {
> +		pr_err("Can't create userspace-driven timer\n");
> +		goto err_timer_new;
> +	}
> +
> +	timer->module = THIS_MODULE;
> +	timer->hw = timer_hw;
> +	timer->hw.resolution = NANO / utimer_info->frame_rate * utimer_info->period_size;

A sanity check is definitely needed for parameters like this.
e.g. you'd hit a zero-division Oops with this code.
Also, the resolution should be neither too small nor too high.

> +static int snd_utimer_ioctl_create(struct file *file,
> +				   struct snd_utimer_info __user *_utimer_info)
> +{
> +	struct snd_utimer *utimer;
> +	struct snd_utimer_info *utimer_info;
> +	int err;
> +
> +	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
> +	if (IS_ERR(utimer_info))
> +		return PTR_ERR(no_free_ptr(utimer_info));

no_free_ptr() is used only for the automatic cleanup stuff.

> +static int snd_utimer_ioctl_create(struct file *file,
> +				   struct snd_utimer_info __user *_utimer_info)
> +{
> +	return -EINVAL;

Better to keep -ENOTTY?


thanks,

Takashi

