Return-Path: <linux-kselftest+bounces-11032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B238D68AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B94B28964
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E847BB01;
	Fri, 31 May 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0b0H4uHV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zWw66wax";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0b0H4uHV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zWw66wax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C92E63B;
	Fri, 31 May 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178757; cv=none; b=TGSMIYtJHlqMxwe3pts+joSo+UtW+UXTiXbgUwR3a7vWOvEQi7tFoMWZP8dedn6eEDCBmQmAn89iutf7PDbQWPgCKQS3ha293hG/E9Q9vekhSnA0oMaf23yv4hz+0R3lpzAj8ufAQTiFko5VyczI3cwp0sLzzytJakkW32q3HZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178757; c=relaxed/simple;
	bh=Jnh7QyNKun8BwM4RB9OQGdu5Wf0BrMYpllXHlrDsZWQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1BF/doLSg/WzCff1j1ryKijQ+xSNDsCDWa/a8aZemkj8qVjrJQW7QIJwAObFf4H6nqXi9BfBDIUbVXsYvRARJPbcyEqlRp8zCMMRrTHxxPrqVGWL9XZOa/z4g4AJNX/2/Aulk7VLlu/Khx3Fae31QQxBaSIJHLVrFYGOQxbJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0b0H4uHV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zWw66wax; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0b0H4uHV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zWw66wax; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6535721CDF;
	Fri, 31 May 2024 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717178752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdPRT5mE0rdQjCqwKaiwjzTSyrTE2NNeScJ+vvQaCOA=;
	b=0b0H4uHVlmn4PYaYPZ2RiJcGTLn0RThbzuWEnvlyiYM0RALGOFfxWm6m/kWMar0OrwsEgm
	knB4hmP8xlzt6OfHsTj9JITggfgoFD/sqK/U9ROxUtyg/iO0+IEF59vF1GgCorl7wTfAbC
	wihc2e2HbrukqIVvJsE26TzdBaou8sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717178752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdPRT5mE0rdQjCqwKaiwjzTSyrTE2NNeScJ+vvQaCOA=;
	b=zWw66waxNWCeJZGDYERyNFm4OpdmMPOhfUgvP2orQF5Af9CP9smNMVsDbI7yenSZl/+137
	qVDvUlt8Wgrw+nBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0b0H4uHV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zWw66wax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717178752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdPRT5mE0rdQjCqwKaiwjzTSyrTE2NNeScJ+vvQaCOA=;
	b=0b0H4uHVlmn4PYaYPZ2RiJcGTLn0RThbzuWEnvlyiYM0RALGOFfxWm6m/kWMar0OrwsEgm
	knB4hmP8xlzt6OfHsTj9JITggfgoFD/sqK/U9ROxUtyg/iO0+IEF59vF1GgCorl7wTfAbC
	wihc2e2HbrukqIVvJsE26TzdBaou8sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717178752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdPRT5mE0rdQjCqwKaiwjzTSyrTE2NNeScJ+vvQaCOA=;
	b=zWw66waxNWCeJZGDYERyNFm4OpdmMPOhfUgvP2orQF5Af9CP9smNMVsDbI7yenSZl/+137
	qVDvUlt8Wgrw+nBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A1F6132C2;
	Fri, 31 May 2024 18:05:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lAaiCIARWmaqOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 May 2024 18:05:52 +0000
Date: Fri, 31 May 2024 20:06:14 +0200
Message-ID: <878qzp97qh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13 9360
In-Reply-To: <21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
	<87cyp280yw.wl-tiwai@suse.de>
	<21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6535721CDF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, 31 May 2024 18:03:52 +0200,
Mark Brown wrote:
> 
> On Fri, May 31, 2024 at 05:17:43PM +0200, Takashi Iwai wrote:
> > On Fri, 31 May 2024 07:50:33 +0200,
> 
> > >     not ok 5 write_invalid.0.40
> > >     not ok 201 write_invalid.0.12
> > >     not ok 208 write_invalid.0.11
> > >     not ok 264 write_invalid.0.3
> > >     not ok 271 write_invalid.0.2
> > >     not ok 278 write_invalid.0.1
> > >     not ok 285 write_invalid.0.0
> 
> > Through a quick look, those are no real "failures".  It'd be more
> > preferable if the driver returns an error for invalid values, but
> > currently it's up to drivers how to deal with them, and some accept as
> > is but with correction of the values internally.  They are shown as
> > "skips" in the summary above you showed, after all.
> 
> I would say these are all bugs, they show the driver not correcting the
> value and allowing users to read back out of range values that were
> written.  Even if the driver is accepting out of range values I'd expect
> it to transform them somehow when storing, the program will accept a
> mismatched read when testing this case but it will complain if the read
> value is not valid according to the control's info.

Ideally, yeah.  But it's a whack-a-mole game, and my gut feeling is
that it'd be better to enable the input validation globally, something
like below.


Takashi

--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -219,7 +219,8 @@ config SND_PCM_XRUN_DEBUG
 	  the process or driver which causes the scheduling gaps.
 
 config SND_CTL_INPUT_VALIDATION
-	bool "Validate input data to control API"
+	bool "Validate input data to control API" if EXPERT
+	default y
 	help
 	  Say Y to enable the additional validation for the input data to
 	  each control element, including the value range checks.


