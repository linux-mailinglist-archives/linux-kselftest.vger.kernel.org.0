Return-Path: <linux-kselftest+bounces-12003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3F7909685
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B8B21189
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 07:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1A116415;
	Sat, 15 Jun 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SnDTr6gZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gnb/VUXF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ydAZ5Fea";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5g8pH8MU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A74156CF;
	Sat, 15 Jun 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436511; cv=none; b=ixuDsiR3YJgli5MQG4pNEwNuZ0JZLyIOoAv59kIzHGQb/E3L5buuPbRdFJYeTY5g1USGg8+Ww/GQk9UGxGvfZ7E//Vkmk9p6sH7zpbdNPK45e3umqTM0nilqWC8Z+konLggWxUS9J3OfoegESJMx1if6c6dz8FtRDFXaz0D4irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436511; c=relaxed/simple;
	bh=Gmf/GCSfj2IJ1f8i3OyX/gd5DRC6rHWSRFmox1Dm7ms=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU3V8zvSBuHEJg8wLu3LLLAE4EQl7/HSEZK9MlvqxEkp1FbxoTDmZykEAzgOdScfT5fnu+cOXwZtD43EB4axBXsnEC/CD2c0UEPIXqJDKFCP5gAiKRhwExeBIROEzSZ/vGc7htfpPGTO38FDkcFR72ulQdCvlsPgAtIUhVdqjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SnDTr6gZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gnb/VUXF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ydAZ5Fea; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5g8pH8MU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C568B20F38;
	Sat, 15 Jun 2024 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718436507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPeFPKpIv5I8mXAPJclpINgNlcuhdl7fnkFQBFolFBk=;
	b=SnDTr6gZ7A4nW3n3EybpjFVDO1yURbu+SILT93rxMATHJcfihx2wby1FoqsRn52xs+8MZM
	7rdjUCeYixp8bRjxmjgaC/Ucy8Ao6Z3IqH5zADfdEyI0v1PHVu9ZvsQqr9YlrfaCKbZ9TJ
	Wu1t+mbPX56IkX79+KcWQQ6bMM1ThvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718436507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPeFPKpIv5I8mXAPJclpINgNlcuhdl7fnkFQBFolFBk=;
	b=Gnb/VUXFurQYNKv1REx1UaCj0j2GjotS92BTZr38XVcfoM1jJOzmoIok82wy7o2jqFBu8p
	DVZvCOhyFQtnIpAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ydAZ5Fea;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5g8pH8MU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718436506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPeFPKpIv5I8mXAPJclpINgNlcuhdl7fnkFQBFolFBk=;
	b=ydAZ5FeaCFNQZPyaQqbvC6vf6w0rSDgHi7BnSgghfg1kUPpJav4jos9neOZycM6LFWVxI8
	Eb4UxmHrPbTu7LXo5AXe8fnrKO5523XTLSfzPcIg4P6pS6i9476x6hNaD21kpT8Kh2iAFK
	ajAe+icX5dEemwghV8CArvq53UPcEPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718436506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IPeFPKpIv5I8mXAPJclpINgNlcuhdl7fnkFQBFolFBk=;
	b=5g8pH8MUqDyVJ15kM1qFTdAd/hjg/HZRcj+pjx8diWopCmk2tEk0uqVCIJYh0aLXnF0UYJ
	NHgE3OClWIHubmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 862C413AAF;
	Sat, 15 Jun 2024 07:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D9/4HppCbWbyTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 15 Jun 2024 07:28:26 +0000
Date: Sat, 15 Jun 2024 09:28:50 +0200
Message-ID: <871q4y7jgt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values for user elements
In-Reply-To: <20240615051329.GA494527@workstation.local>
References: <20240614153717.30143-1-tiwai@suse.de>
	<20240614153717.30143-4-tiwai@suse.de>
	<20240615051329.GA494527@workstation.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C568B20F38
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat, 15 Jun 2024 07:13:29 +0200,
Takashi Sakamoto wrote:
> 
> Hi,
> 
> On Fri, Jun 14, 2024 at 05:37:12PM +0200, Takashi Iwai wrote:
> > Although we have already a mechanism for sanity checks of input values
> > for control writes, it's not applied unless the kconfig
> > CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
> > Nevertheless, it still makes sense to apply the check for user
> > elements despite of its cost, as that's the only way to filter out the
> > invalid values; the user controls are handled solely in ALSA core
> > code, and there is no corresponding driver, after all.
> > 
> > This patch enables the input value validation for user control
> > elements no matter whether CONFIG_SND_CTL_INPUT_VALIDATION is set or
> > not.  The kselftest will be happier with this change, as the incorrect
> > values will be bailed out now with errors.
> > 
> > For other normal controls, the check is applied still only when
> > CONFIG_SND_CTL_INPUT_VALIDATION is set.
> > 
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
> > Reviewed-by: Jaroslav Kysela <perex@perex.cz>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/core/control.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/core/control.c b/sound/core/control.c
> > index fb0c60044f7b..50890983d7e2 100644
> > --- a/sound/core/control.c
> > +++ b/sound/core/control.c
> > @@ -1317,7 +1317,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
> >  	snd_ctl_build_ioff(&control->id, kctl, index_offset);
> >  	result = snd_power_ref_and_wait(card);
> >  	/* validate input values */
> > -	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
> > +	if ((IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) ||
> > +	     (vd->access & SNDRV_CTL_ELEM_ACCESS_USER)) && !result) {
> >  		struct snd_ctl_elem_info info;
> >  
> >  		memset(&info, 0, sizeof(info));
> 
> In my opinion, the validation in 'snd_ctl_elem_user_put()' is preferable
> instead. In the function, it is free to access to 'struct
> user_element.info' for the validation.

Yeah, more optimization would be possible and we can do it later.
My patch achieves the purpose in the smallest change.

> In the commit coment, I can see "that's the only way to filter out the
> invalid values", however it not so good idea, since the ALSA control core
> function loses transparency against control elements somehow.

Transparency?  The sanity check of input values is done in each driver
side, hence some overhead is more or less always present, depending on
the implementation.

> Furthermore, I can see "there is no corresponding driver", however it is
> suspicious somehow. It would be smart to charge the validation
> implementation for user-defined control element set if forcing it.

The context there implies that, in the case of user elements, all
handled in sound/core/control.c, and there is no other dedicated
driver code handling the control put for those controls, hence
sound/core/control.c is the only place where we can address the
issue.


thanks,

Takashi

