Return-Path: <linux-kselftest+bounces-11923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79490908AD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 13:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075B81F21209
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06A1922C0;
	Fri, 14 Jun 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rxtRXEBE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mJ4LRxTQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rxtRXEBE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mJ4LRxTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253378C90;
	Fri, 14 Jun 2024 11:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364770; cv=none; b=H3hqs2vynxyi13c3RYPywesp4stv6iNBazTWm/ciAoCrWxT/cfPKwIYWLm+smmEgCrlLE1JQrKYtebRLW/lio2iB9PCBn/CSdyYSGS078iWwCQ8+rNvaOb3mW8zzTMn7xcbxxOtmYNZyJC9lCdg1bpIFAXZBLaaPv+ygwfWa/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364770; c=relaxed/simple;
	bh=NBtEaNmbsTJCymlIquc1Dvbcv407nCNkYKp41aRNGvE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAsXx3TVuluRlItJ7o2A/VI2yFX+Jxv5JmaCpsU5kjIof1q/fGRiUgMZ1WygvlG67RXjZSGBXvODu6ddxQEWClOccOKv7knA8hqxWHy86/nJt/KXvkMetU7HGR7bcyxRcG2vdSRp6uREsIdmgvWCDg+lXO9+WQ/qD7UMQFyVR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rxtRXEBE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mJ4LRxTQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rxtRXEBE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mJ4LRxTQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 727E6203F9;
	Fri, 14 Jun 2024 11:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718364766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHfqrYa/9tev/K9EyZaq0Uq+1EvUZ06X32SKQIlbZpo=;
	b=rxtRXEBE3JaPBn7JCQhg+74yRHKSETDEvAyNqHn5DDe36tqdLbQOh1j534eX9oDWCwZh1q
	pICdipMedjigW0tl6FVonbClP+v9LAhQmRtwQtKs1CXjBfOlzWcPL9QuTvatOEchizcVCc
	3cYjgL3In8wjtJ4YW3CmG3xhbdfreUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718364766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHfqrYa/9tev/K9EyZaq0Uq+1EvUZ06X32SKQIlbZpo=;
	b=mJ4LRxTQDsKEUyNntf2LbX8m5+oT+UYOHiOgxMZrbz2VVsTzi4jf596/moeR+fVZasDFF7
	kRYOvDD0oB4MrsBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718364766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHfqrYa/9tev/K9EyZaq0Uq+1EvUZ06X32SKQIlbZpo=;
	b=rxtRXEBE3JaPBn7JCQhg+74yRHKSETDEvAyNqHn5DDe36tqdLbQOh1j534eX9oDWCwZh1q
	pICdipMedjigW0tl6FVonbClP+v9LAhQmRtwQtKs1CXjBfOlzWcPL9QuTvatOEchizcVCc
	3cYjgL3In8wjtJ4YW3CmG3xhbdfreUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718364766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OHfqrYa/9tev/K9EyZaq0Uq+1EvUZ06X32SKQIlbZpo=;
	b=mJ4LRxTQDsKEUyNntf2LbX8m5+oT+UYOHiOgxMZrbz2VVsTzi4jf596/moeR+fVZasDFF7
	kRYOvDD0oB4MrsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B7A713AAF;
	Fri, 14 Jun 2024 11:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PIIbDV4qbGYfGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 11:32:46 +0000
Date: Fri, 14 Jun 2024 13:33:10 +0200
Message-ID: <87h6dv92tl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13 9360
In-Reply-To: <c9707ade-bd43-419b-8959-0b45d572facd@sirena.org.uk>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
	<87cyp280yw.wl-tiwai@suse.de>
	<21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
	<878qzp97qh.wl-tiwai@suse.de>
	<c9707ade-bd43-419b-8959-0b45d572facd@sirena.org.uk>
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

On Mon, 03 Jun 2024 13:38:18 +0200,
Mark Brown wrote:
> 
> On Fri, May 31, 2024 at 08:06:14PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Fri, May 31, 2024 at 05:17:43PM +0200, Takashi Iwai wrote:
> > > > On Fri, 31 May 2024 07:50:33 +0200,
> 
> > > I would say these are all bugs, they show the driver not correcting the
> > > value and allowing users to read back out of range values that were
> > > written.  Even if the driver is accepting out of range values I'd expect
> > > it to transform them somehow when storing, the program will accept a
> > > mismatched read when testing this case but it will complain if the read
> > > value is not valid according to the control's info.
> 
> > Ideally, yeah.  But it's a whack-a-mole game, and my gut feeling is
> > that it'd be better to enable the input validation globally, something
> > like below.
> 
> Yeah, I mean I tend to think the whole accepting invalid values thing is
> questionable to start off with so I do think that's a good idea.  That
> said we probably should still be fixing the drivers as well.

OK, I'm going to submit a patch set for addressing those.


Takashi

