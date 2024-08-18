Return-Path: <linux-kselftest+bounces-15590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA34955BE4
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A6E281CD1
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Aug 2024 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CD8462;
	Sun, 18 Aug 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E3Uevejq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ltivvQaN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E3Uevejq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ltivvQaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611417993;
	Sun, 18 Aug 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723968135; cv=none; b=sy3cFdiajtXWn7lYSD2IemdDPLVIIq31uZATeygWujRjmqqx7mbj7pOsxosqgrXwwgEVLdkg6FsFF9j/CDcTtrBGr5uSIaTouGutTY3WY/bkyPet7Nu+nuP+29o0dNC7448lM5m0Yzq0kun9NO3BDxWtG42hGkpBB2e2uTSU1Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723968135; c=relaxed/simple;
	bh=d5ke7UFVpyIUJSVCgMZIUzaxhV+6Je8WoGvdRhjeKQ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otyiiCGGOFfvuuR4FxWoPpB+r98tOxc5iUdE60qU88mFIUn/Q8pfW8gwxKaurmlNAOPASM0anCH5QZDSjM+zJW/W5FwpVaONd7IvDEgdMu72frJHdiyGaOSFZ3VJ5TuVHmARvg8TL8b55zu+2b79l9lUdMOF0Jm1JPUG+fD/nFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E3Uevejq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ltivvQaN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E3Uevejq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ltivvQaN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54489226AE;
	Sun, 18 Aug 2024 08:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723968131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03RAG1GbRJWY/6jNzq3WTvIQdSfxH6+QOJGFqzQaIPU=;
	b=E3UevejqXaoY0+FmPeRJIPj85Ek09tOEjGHJTsPeLVJrHSf30cT4YGMsUaGVg6Mez8wEd+
	cek6Cnpd8e/jTgrlp1JzRyJKwKPINBDCRZghQLDiPhVktM2xBqZH+8owdjwhagZtNb24T0
	QYtTbnNEfyZyCJrDcZs6Ak4nALT9qYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723968131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03RAG1GbRJWY/6jNzq3WTvIQdSfxH6+QOJGFqzQaIPU=;
	b=ltivvQaNfsfLsH+kf31mN92C4XCWSSCntAmHOCWli5xQWGpJC72pUcBVfGdBbYq7h9Kqhy
	HhovlmdUTxwlrLDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E3Uevejq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ltivvQaN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723968131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03RAG1GbRJWY/6jNzq3WTvIQdSfxH6+QOJGFqzQaIPU=;
	b=E3UevejqXaoY0+FmPeRJIPj85Ek09tOEjGHJTsPeLVJrHSf30cT4YGMsUaGVg6Mez8wEd+
	cek6Cnpd8e/jTgrlp1JzRyJKwKPINBDCRZghQLDiPhVktM2xBqZH+8owdjwhagZtNb24T0
	QYtTbnNEfyZyCJrDcZs6Ak4nALT9qYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723968131;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=03RAG1GbRJWY/6jNzq3WTvIQdSfxH6+QOJGFqzQaIPU=;
	b=ltivvQaNfsfLsH+kf31mN92C4XCWSSCntAmHOCWli5xQWGpJC72pUcBVfGdBbYq7h9Kqhy
	HhovlmdUTxwlrLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01FAC136ED;
	Sun, 18 Aug 2024 08:02:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 95odOoKqwWYnRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 18 Aug 2024 08:02:10 +0000
Date: Sun, 18 Aug 2024 10:02:52 +0200
Message-ID: <87a5ha1cnn.wl-tiwai@suse.de>
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
	aholzinger@gmx.de
Subject: Re: [PATCH v5 0/4] Introduce userspace-driven ALSA timers
In-Reply-To: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
References: <20240813120701.171743-1-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 54489226AE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,wanadoo.fr];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,lwn.net,kernel.org,vger.kernel.org,wanadoo.fr,gmx.de];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim]
X-Spam-Score: -4.01

On Tue, 13 Aug 2024 14:06:57 +0200,
Ivan Orlov wrote:
> 
> There are multiple possible timer sources which could be useful for
> the sound stream synchronization: hrtimers, hardware clocks (e.g. PTP),
> timer wheels (jiffies). Currently, using one of them to synchronize
> the audio stream of snd-aloop module would require writing a
> kernel-space driver which exports an ALSA timer through the
> snd_timer interface.
> 
> However, it is not really convenient for application developers, who may
> want to define their custom timer sources for audio synchronization.
> 
> For instance, we could have a network application which receives frames
> and sends them to snd-aloop pcm device, and another application
> listening on the other end of snd-aloop. It makes sense to transfer a
> new period of data only when certain amount of frames is received
> through the network, but definitely not when a certain amount of jiffies
> on a local system elapses. Since all of the devices are purely virtual
> it won't introduce any glitches and will help the application developers
> to avoid using sample-rate conversion.
> 
> This patch series introduces userspace-driven ALSA timers: virtual
> timers which are created and controlled from userspace. The timer can
> be created from the userspace using the new ioctl SNDRV_TIMER_IOCTL_CREATE.
> After creating a timer, it becomes available for use system-wide, so it
> can be passed to snd-aloop as a timer source (timer_source parameter
> would be "-1.SNDRV_TIMER_GLOBAL_UDRIVEN.{timer_id}"). When the userspace
> app decides to trigger a timer, it calls another ioctl
> SNDRV_TIMER_IOCTL_TRIGGER on the file descriptor of a timer. It
> initiates a transfer of a new period of data.
> 
> Userspace-driven timers are associated with file descriptors. If the
> application wishes to destroy the timer, it can simply release the file
> descriptor of a virtual timer.
> 
> I believe introducing new ioctl calls is quite inconvenient (as we have
> a limited amount of them), but other possible ways of app <-> kernel
> communication (like virtual FS) seem completely inappropriate for this
> task (but I'd love to discuss alternative solutions).
> 
> This patch series also updates the snd-aloop module so the global timers
> can be used as a timer_source for it (it allows using userspace-driven
> timers as timer source).
> 
> V1 -> V2:
> - Fix some problems found by Christophe Jaillet
> <christophe.jaillet@wanadoo.fr>
> V2 -> V3:
> - Add improvements suggested by Takashi Iwai <tiwai@suse.de>
> V3 -> V4:
> - Address comments from Jaroslav Kysela <perex@perex.cz> and Mark Brown
> <broonie@kernel.org>
> V4 -> V5:
> - Add missing error processing noticed by Takashi Iwai <tiwai@suse.de>
> - Return timer file descriptor as part of the snd_timer_uinfo structure.
> This is a more standard way of using ioctl interface, where the return
> value of the ioctl is either 0 or an error code.
> 
> Please, find the patch-specific changelog in the following patches.
> 
> Ivan Orlov (4):
>   ALSA: aloop: Allow using global timers
>   Docs/sound: Add documentation for userspace-driven ALSA timers
>   ALSA: timer: Introduce virtual userspace-driven timers
>   selftests: ALSA: Cover userspace-driven timers with test

Now applied to for-next branch.


thanks,

Takashi

