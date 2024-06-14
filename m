Return-Path: <linux-kselftest+bounces-11935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E306908BD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87B11F24574
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219471991C2;
	Fri, 14 Jun 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiA5nWLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iO18bxaY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiA5nWLt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iO18bxaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225247E574;
	Fri, 14 Jun 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368682; cv=none; b=px21cRrRwCqsPP9SeXIl/hh0wnPmj+G3IwlUWlhB5ozuVRChR489Mkq/8LAs0Du6p8YM+RxcCqtp+SIZzjbcXhCcqFzcuJZlHsn0Eo1poqSjo/BJ6hiXGUZRrwaD1Ne6NOjSWedeu4JLUs3e1A9R0PMS69lvYVBaO2FgEDFUYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368682; c=relaxed/simple;
	bh=u0+bSty2Vsfe0uiDHHGwpRksQ4Yyn27Kbc4yk1RvnAI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT8u9AeP5NvJfofAsax/hUgEEpFGTmOxyrH/stCc0AEnkEGFx3Y5D1AMd+DrihTxsxhMysJF8oFMtxueczdd5evwDBJw/WH0coOfbjJZ7JgQJW1mXhwfve8e8ALLKPCIqhtDTbyAL8NhsTauIRGLhLrOj8NegBZ1x59G0ZpnwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiA5nWLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iO18bxaY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiA5nWLt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iO18bxaY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23318204B8;
	Fri, 14 Jun 2024 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718368678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJiDYYUp3S7xN1KBWl1+361/F4ZGe6iSoZW7tqd9y5o=;
	b=kiA5nWLtxIcv5D40pi+ekiZQrCOYCem9y82Id648hPvnpQ7TKpS5csAkY2q8qMxilzlaDg
	NC2z6DRmWNP5RcCZ0Yo9oK53KJHTCPLzsWA+ObBGaFgKPbLsGVU0e61a06naTI6rQeTiBv
	vasjkeoCcs9rXPrnprid309Bf8Acbw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718368678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJiDYYUp3S7xN1KBWl1+361/F4ZGe6iSoZW7tqd9y5o=;
	b=iO18bxaYB4EhiBGjLXHjzQBhCA5wu/Br+yOv7VBvu5BW+nMynB8iwcyxI7wz7pPuzl7Cyy
	gOxDwffYHXxgzFCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kiA5nWLt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iO18bxaY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718368678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJiDYYUp3S7xN1KBWl1+361/F4ZGe6iSoZW7tqd9y5o=;
	b=kiA5nWLtxIcv5D40pi+ekiZQrCOYCem9y82Id648hPvnpQ7TKpS5csAkY2q8qMxilzlaDg
	NC2z6DRmWNP5RcCZ0Yo9oK53KJHTCPLzsWA+ObBGaFgKPbLsGVU0e61a06naTI6rQeTiBv
	vasjkeoCcs9rXPrnprid309Bf8Acbw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718368678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJiDYYUp3S7xN1KBWl1+361/F4ZGe6iSoZW7tqd9y5o=;
	b=iO18bxaYB4EhiBGjLXHjzQBhCA5wu/Br+yOv7VBvu5BW+nMynB8iwcyxI7wz7pPuzl7Cyy
	gOxDwffYHXxgzFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF50413AAF;
	Fri, 14 Jun 2024 12:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3cMwNaU5bGakLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:37:57 +0000
Date: Fri, 14 Jun 2024 14:38:22 +0200
Message-ID: <87ed8z8zsx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13 9360
In-Reply-To: <6496e595-48e7-4c92-8239-7bf8fc9d73d9@perex.cz>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
	<87cyp280yw.wl-tiwai@suse.de>
	<21f73368-5db6-49a1-b8b7-9b06e698327a@sirena.org.uk>
	<878qzp97qh.wl-tiwai@suse.de>
	<c9707ade-bd43-419b-8959-0b45d572facd@sirena.org.uk>
	<87h6dv92tl.wl-tiwai@suse.de>
	<6496e595-48e7-4c92-8239-7bf8fc9d73d9@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23318204B8
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Spam-Level: 

On Fri, 14 Jun 2024 13:42:05 +0200,
Jaroslav Kysela wrote:
> 
> On 14. 06. 24 13:33, Takashi Iwai wrote:
> > On Mon, 03 Jun 2024 13:38:18 +0200,
> > Mark Brown wrote:
> >> 
> >> On Fri, May 31, 2024 at 08:06:14PM +0200, Takashi Iwai wrote:
> >>> Mark Brown wrote:
> >>>> On Fri, May 31, 2024 at 05:17:43PM +0200, Takashi Iwai wrote:
> >>>>> On Fri, 31 May 2024 07:50:33 +0200,
> >> 
> >>>> I would say these are all bugs, they show the driver not correcting the
> >>>> value and allowing users to read back out of range values that were
> >>>> written.  Even if the driver is accepting out of range values I'd expect
> >>>> it to transform them somehow when storing, the program will accept a
> >>>> mismatched read when testing this case but it will complain if the read
> >>>> value is not valid according to the control's info.
> >> 
> >>> Ideally, yeah.  But it's a whack-a-mole game, and my gut feeling is
> >>> that it'd be better to enable the input validation globally, something
> >>> like below.
> >> 
> >> Yeah, I mean I tend to think the whole accepting invalid values thing is
> >> questionable to start off with so I do think that's a good idea.  That
> >> said we probably should still be fixing the drivers as well.
> > 
> > OK, I'm going to submit a patch set for addressing those.
> 
> I think that this check should be optional (as discussed some years
> ago), because the driver code can implement the validation / bitmask
> handling in a more efficient way that we can do in the ALSA core
> code. Those double checks are not so nice. But they may be enabled by
> default as suggested to log problems for users building custom
> kernels, IMHO.

Yes, what I've worked on are the coverage in HD-audio and vmaster code
as well as the enablement of validation for user control elements.
It's not about unconditional enablement of input validation.


thanks,

Takashi

