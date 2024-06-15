Return-Path: <linux-kselftest+bounces-12007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5759097FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C721C20E1F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B033BBEF;
	Sat, 15 Jun 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l240lk40";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G6UvPLI8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l240lk40";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G6UvPLI8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174E38FA6;
	Sat, 15 Jun 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451410; cv=none; b=IueneGko8shpl3FsBv4eAHy74K52Gl5UoozvYtw5Neo+Rhee/Dnd1Y1fUZScgWxmS0Dng6P3kAk8pjW5jxpQ8SoJ+3fRA6cy72ZFCc1aIJNtFWwu+/RycC+Bo5N6G7xy4H5WE2cdDasuy+CENg4MC+0WTh5BchvVxGhU2vyJcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451410; c=relaxed/simple;
	bh=oUob+DnFOs9yHxycTlmxQwh1YEyn6diRHxgQtIkYdh8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keWLtSt26apCvwVQhv7gujOO2o1cLE9RTQDuX6G7YsRQr0PzoFqLxnGVaOXoStv5fPaP8FDbuXBj9a7Tmmw8vjvzxvOuCZcwdYspv5OcIzCUf9qb2zkTtUEBwLLN4mYpWpbkU82nQcao7m0qI3Zk8UH+mLw9WPnfCtrwbtrW740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l240lk40; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G6UvPLI8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l240lk40; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G6UvPLI8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46B8534368;
	Sat, 15 Jun 2024 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718451406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ0Mbb82t3+WdsJXovcY8NA4wQs8wZTSl9/UY9uWask=;
	b=l240lk405LrHJ3FhwDLPzeaImwwXO1E0kD4xeHyWTGLIE6a3em7rC21IUxQNBU0ska4EQv
	7noPKTr/0b8SRCgq4wrE0cBg4egdGvHhBp8XxdxGU7i3ihgGwXY11yoDqmTk40H6/N19uS
	o+wS1r9KxqBICcZ8jR98jKpBAFn58vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718451406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ0Mbb82t3+WdsJXovcY8NA4wQs8wZTSl9/UY9uWask=;
	b=G6UvPLI8yCu1q0aNejjG1NxArfoKhbGJVcHmprw5XOEaDwViGRI8Ap1rSv35QZFx8Ycafy
	hUMrDqpP4c90xQCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718451406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ0Mbb82t3+WdsJXovcY8NA4wQs8wZTSl9/UY9uWask=;
	b=l240lk405LrHJ3FhwDLPzeaImwwXO1E0kD4xeHyWTGLIE6a3em7rC21IUxQNBU0ska4EQv
	7noPKTr/0b8SRCgq4wrE0cBg4egdGvHhBp8XxdxGU7i3ihgGwXY11yoDqmTk40H6/N19uS
	o+wS1r9KxqBICcZ8jR98jKpBAFn58vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718451406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZ0Mbb82t3+WdsJXovcY8NA4wQs8wZTSl9/UY9uWask=;
	b=G6UvPLI8yCu1q0aNejjG1NxArfoKhbGJVcHmprw5XOEaDwViGRI8Ap1rSv35QZFx8Ycafy
	hUMrDqpP4c90xQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0241713A7F;
	Sat, 15 Jun 2024 11:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8LqLOs18bWYsBQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 15 Jun 2024 11:36:45 +0000
Date: Sat, 15 Jun 2024 13:37:09 +0200
Message-ID: <87le365tei.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux-sound@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values for user elements
In-Reply-To: <87tthu6225.wl-tiwai@suse.de>
References: <20240614153717.30143-1-tiwai@suse.de>
	<20240614153717.30143-4-tiwai@suse.de>
	<20240615051329.GA494527@workstation.local>
	<871q4y7jgt.wl-tiwai@suse.de>
	<20240615080235.GA508000@workstation.local>
	<87tthu6225.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sat, 15 Jun 2024 10:30:10 +0200,
Takashi Iwai wrote:
> 
> On Sat, 15 Jun 2024 10:02:35 +0200,
> Takashi Sakamoto wrote:
> > 
> > On Sat, Jun 15, 2024 at 09:28:50AM +0200, Takashi Iwai wrote:
> > > > In the commit coment, I can see "that's the only way to filter out the
> > > > invalid values", however it not so good idea, since the ALSA control core
> > > > function loses transparency against control elements somehow.
> > > 
> > > Transparency?  The sanity check of input values is done in each driver
> > > side, hence some overhead is more or less always present, depending on
> > > the implementation.
> > >
> > > > Furthermore, I can see "there is no corresponding driver", however it is
> > > > suspicious somehow. It would be smart to charge the validation
> > > > implementation for user-defined control element set if forcing it.
> > > 
> > > The context there implies that, in the case of user elements, all
> > > handled in sound/core/control.c, and there is no other dedicated
> > > driver code handling the control put for those controls, hence
> > > sound/core/control.c is the only place where we can address the
> > > issue.
> > 
> > If you can force the validation to _all_ of the existing drivers by any
> > kind of mechanism, it would be. Actually, not. We can have such driver
> > which handles the write request without such validation, and control core
> > allows it. The kernel configuration is to ease the detection of such
> > drivers (and applications) in application runtime. Therefore the
> > transparency would be lost by the patch.
> 
> In principle, the validation should be done for *every* kcontrol.  The
> lack of the validation was ignored so far with a naive assumption that
> the driver treats properly nevertheless.  But since we're checking it
> more strictly in kselftest, the problem became more obvious, and this
> is a corresponding fix for user control element part.  HD-audio driver
> had another issues and they are fixed in other patches of this
> series.
> 
> > Assuming that two control element exist in a sound card, which has the
> > same information and TLV response, except for the flag of
> > SNDRV_CTL_ELEM_ACCESS_USER. For the same value data, one operation with
> > SNDRV_CTL_IOCTL_ELEM_WRITE is successful, and another operation with
> > SNDRV_CTL_ELEM_ACCESS_USER is failed. When encountering this issue,
> > the programmer of the application suspect the bug pertaining to the latter
> > control, then the programmer find the latter has
> > SNDRV_CTL_ELEM_ACCESS_USER. Then the programmer would judge that 'I got
> > it, it is a bug of user-defined control element set' even if the program
> > includes the bug for min/max/step computation and the underlying sound
> > driver includes the bug not to validate value data.
> 
> No, it's a wrong understanding, other way round: the driver must
> validate the values by itself.
> 
> > The patch loses transparency in the above step. Without the patch, both
> > operations finish with the equivalent result.
> > 
> > Nevertheless, I think the validation is itself preferable.
> 
> The validation is not "preferable" but rather "mandatory".
> 
> > In my opinion,
> > the validation before/after the call of 'snd_kcontrol_put_t' would result
> > in the different argument. The 'validate-before-call' is the argument of
> > control core function, while 'validate-after-call is the argument of
> > implementation of user-defined element set. The patch should belong to the
> > latter to extend current implementation of user-defined element set.
> > Thus I suggest to put the validation into the put callback function,
> > regardless of the optimization to which you address.
> 
> I don't get the argument, sorry.
> If you have a better point, please submit an incremental patch.

Or did you meant something like below?


Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3] ALSA: control: Apply sanity check of input values for user elements

Although we have already a mechanism for sanity checks of input values
for control writes, it's not applied unless the kconfig
CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
Nevertheless, it still makes sense to apply the same check for user
elements despite of its cost, as that's the only way to filter out the
invalid values; the user controls are handled solely in ALSA core
code, and there is no corresponding driver, after all.

This patch adds the same input value validation for user control
elements at its put callback.  The kselftest will be happier with this
change, as the incorrect values will be bailed out now with errors.

For other normal controls, the check is applied still only when
CONFIG_SND_CTL_INPUT_VALIDATION is set.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb0c60044f7b..1dd2337e2930 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1480,12 +1480,16 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
+	int err, change;
 	struct user_element *ue = kcontrol->private_data;
 	unsigned int size = ue->elem_data_size;
 	char *dst = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
+	err = sanity_check_input_values(ue->card, ucontrol, &ue->info, false);
+	if (err < 0)
+		return err;
+
 	change = memcmp(&ucontrol->value, dst, size) != 0;
 	if (change)
 		memcpy(dst, &ucontrol->value, size);
-- 
2.43.0


