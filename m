Return-Path: <linux-kselftest+bounces-12006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F34D9096FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 10:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCC71F222A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A618037;
	Sat, 15 Jun 2024 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d6s7TFlZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zd7P6hNT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PndSsm2R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ro3UtvlO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE0B1CFBC;
	Sat, 15 Jun 2024 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718440197; cv=none; b=VM4Ard+rYp/nFtbzzs42bBzfw/S0rl/pBfEvRSI/kLTC/w0pydKG8tu2E1aFNpgz64FSKRhoT2FDImj50vXoX2dWimJmbO2x7b7w7+3rBEl7oAeJcKeWd2xpZGIDI2I2LgiYnyi8zgt3ywyOa/EPtwd1le5TBPSR7g9GW99G3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718440197; c=relaxed/simple;
	bh=27kVOwGhuh+hyYnGedPXIunXzWGqwdCDTWzecz6GW50=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6Wv07PveuuHO6xDzxXXF2ijFK6l09a7nHzFx0MqCJiGI+G1CspSOiZIDYuC0jtP8RqpoHvPVstUgaSavzZdJ0i8fNA4Jep3X3PbPvX40lO10Nu3igRHKrQaYjei2CYhcxkyk9eacCt2O11NKNvmG8DbOafIqxcj2xY1NtNKIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d6s7TFlZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zd7P6hNT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PndSsm2R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ro3UtvlO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFCEC20FD9;
	Sat, 15 Jun 2024 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718440188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2S/z+hkksxKZKAznuoIFYVD3E8l+bEpqh8nUCf+uGQ=;
	b=d6s7TFlZoksib+8TwcscxdVxwl+HDlI63HSEn2Y7ilkbA5awajQkgzG1HGCWmWVNw2vAs4
	T/H2cNNa6IGOLh28XqtewDHjN8Dm9DKemeJJVuRWFDvyId7RJsfHqQzotC3oNGXAHcb1Vd
	J4a8RhsudJQhFB9cqM55VJ01FsNEt5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718440188;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2S/z+hkksxKZKAznuoIFYVD3E8l+bEpqh8nUCf+uGQ=;
	b=Zd7P6hNTjsPnY3li5Q2lG6RYHxIXwpr/5MRaPUGza/kyWE0wTdUnlPC2UE1ct2ez/ktalo
	053lPcdFVvDAewDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718440186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2S/z+hkksxKZKAznuoIFYVD3E8l+bEpqh8nUCf+uGQ=;
	b=PndSsm2RAmagqC5kOib6HsvEyFu16nW3EXFlJwlXqYH7qxd3lAnth8jgYmFFvQV4rYG6LM
	/tl35o/Sea4pkt00MhoHz+F1lZc8bHUK/84wQJaJggMfhPwSxgtG7Kl9m/FfAoJPnYARdo
	i4+4ps2pF1kFRVFCabc+qouWz4uacvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718440186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j2S/z+hkksxKZKAznuoIFYVD3E8l+bEpqh8nUCf+uGQ=;
	b=Ro3UtvlO2sk2aG9OgWrauz3T1xOQ2pnpuMp+XdVZOEtcziL/FQPnppkvKKjnrr4hGIpeig
	PzBPBifFe49Cc4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEFB213A7F;
	Sat, 15 Jun 2024 08:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9toAKfpQbWbOWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 15 Jun 2024 08:29:46 +0000
Date: Sat, 15 Jun 2024 10:30:10 +0200
Message-ID: <87tthu6225.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values for user elements
In-Reply-To: <20240615080235.GA508000@workstation.local>
References: <20240614153717.30143-1-tiwai@suse.de>
	<20240614153717.30143-4-tiwai@suse.de>
	<20240615051329.GA494527@workstation.local>
	<871q4y7jgt.wl-tiwai@suse.de>
	<20240615080235.GA508000@workstation.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sat, 15 Jun 2024 10:02:35 +0200,
Takashi Sakamoto wrote:
> 
> On Sat, Jun 15, 2024 at 09:28:50AM +0200, Takashi Iwai wrote:
> > > In the commit coment, I can see "that's the only way to filter out the
> > > invalid values", however it not so good idea, since the ALSA control core
> > > function loses transparency against control elements somehow.
> > 
> > Transparency?  The sanity check of input values is done in each driver
> > side, hence some overhead is more or less always present, depending on
> > the implementation.
> >
> > > Furthermore, I can see "there is no corresponding driver", however it is
> > > suspicious somehow. It would be smart to charge the validation
> > > implementation for user-defined control element set if forcing it.
> > 
> > The context there implies that, in the case of user elements, all
> > handled in sound/core/control.c, and there is no other dedicated
> > driver code handling the control put for those controls, hence
> > sound/core/control.c is the only place where we can address the
> > issue.
> 
> If you can force the validation to _all_ of the existing drivers by any
> kind of mechanism, it would be. Actually, not. We can have such driver
> which handles the write request without such validation, and control core
> allows it. The kernel configuration is to ease the detection of such
> drivers (and applications) in application runtime. Therefore the
> transparency would be lost by the patch.

In principle, the validation should be done for *every* kcontrol.  The
lack of the validation was ignored so far with a naive assumption that
the driver treats properly nevertheless.  But since we're checking it
more strictly in kselftest, the problem became more obvious, and this
is a corresponding fix for user control element part.  HD-audio driver
had another issues and they are fixed in other patches of this
series.

> Assuming that two control element exist in a sound card, which has the
> same information and TLV response, except for the flag of
> SNDRV_CTL_ELEM_ACCESS_USER. For the same value data, one operation with
> SNDRV_CTL_IOCTL_ELEM_WRITE is successful, and another operation with
> SNDRV_CTL_ELEM_ACCESS_USER is failed. When encountering this issue,
> the programmer of the application suspect the bug pertaining to the latter
> control, then the programmer find the latter has
> SNDRV_CTL_ELEM_ACCESS_USER. Then the programmer would judge that 'I got
> it, it is a bug of user-defined control element set' even if the program
> includes the bug for min/max/step computation and the underlying sound
> driver includes the bug not to validate value data.

No, it's a wrong understanding, other way round: the driver must
validate the values by itself.

> The patch loses transparency in the above step. Without the patch, both
> operations finish with the equivalent result.
> 
> Nevertheless, I think the validation is itself preferable.

The validation is not "preferable" but rather "mandatory".

> In my opinion,
> the validation before/after the call of 'snd_kcontrol_put_t' would result
> in the different argument. The 'validate-before-call' is the argument of
> control core function, while 'validate-after-call is the argument of
> implementation of user-defined element set. The patch should belong to the
> latter to extend current implementation of user-defined element set.
> Thus I suggest to put the validation into the put callback function,
> regardless of the optimization to which you address.

I don't get the argument, sorry.
If you have a better point, please submit an incremental patch.


thanks,

Takashi

