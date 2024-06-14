Return-Path: <linux-kselftest+bounces-11948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62941908DA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E161C20BC0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CA6EAE5;
	Fri, 14 Jun 2024 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K4CTG6B6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qwER1kT8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K4CTG6B6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qwER1kT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5697DF78;
	Fri, 14 Jun 2024 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375989; cv=none; b=kPEYRUySvqVT89+zYoSU3GDgH0Dm6LfNyOvyV5GGTzdAWruSRbCttvxQczAVJpZPBdSNl+Vi5FNgeAKLp62I/yZOIzT8rlqxJm+K8zOfZoCvLeC5kmdZio/GlyfNlb7ED42vlKp8SwfDfExLXjAhuDWfS3kA4OIJghvm2oqvnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375989; c=relaxed/simple;
	bh=TEHPQyoz/fVVQX4q9Q9DdacRD3WmsxsGHepRhosoJVI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtfJn/KYEOD+iP+wwUJp0J9CZ7+/QDjkCb9AcLOzBP2KcZzlT+vkt2fmrD60N9/OSl6hEJ2o0WNb18hBOkVd+WPh2U8hIO9Tl4rG/GzBSDai4Q2PXEB848G29boODxD2GUCM+mBUqRBP1hyYSq57HCzOIKUFzGfcjj2TK7tTuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K4CTG6B6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qwER1kT8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K4CTG6B6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qwER1kT8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C494F205CA;
	Fri, 14 Jun 2024 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718375985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTimLGbSxrf1m6fMBODTnL8sY0r82zSL2w94Mol2gIg=;
	b=K4CTG6B6nTmnOjT1Pkq/PCt3GGEVb+CMXwosFpx3lxw6d9peYc4M28AG6/FCi1zuD6v+Pp
	rNBvrm/NRrUiWaQ7v67GVvLYwUJ22M64AWS52tti4UsV6ENqEm8FOC3ThCf4wYjRBZM1pG
	5oM5ZJMsrAJ+2f96uhpgAdb6K+sN/Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718375985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTimLGbSxrf1m6fMBODTnL8sY0r82zSL2w94Mol2gIg=;
	b=qwER1kT83iM5kRKmo9ZC0SxKLs2oAoh9GzQIJ4SDjSADz37Jnw171Dtn5aOfq4w0+6zrQp
	ppCvda5KQWDqerDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K4CTG6B6;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qwER1kT8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718375985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTimLGbSxrf1m6fMBODTnL8sY0r82zSL2w94Mol2gIg=;
	b=K4CTG6B6nTmnOjT1Pkq/PCt3GGEVb+CMXwosFpx3lxw6d9peYc4M28AG6/FCi1zuD6v+Pp
	rNBvrm/NRrUiWaQ7v67GVvLYwUJ22M64AWS52tti4UsV6ENqEm8FOC3ThCf4wYjRBZM1pG
	5oM5ZJMsrAJ+2f96uhpgAdb6K+sN/Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718375985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTimLGbSxrf1m6fMBODTnL8sY0r82zSL2w94Mol2gIg=;
	b=qwER1kT83iM5kRKmo9ZC0SxKLs2oAoh9GzQIJ4SDjSADz37Jnw171Dtn5aOfq4w0+6zrQp
	ppCvda5KQWDqerDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E60013AAF;
	Fri, 14 Jun 2024 14:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lkUmITFWbGZnUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 14:39:45 +0000
Date: Fri, 14 Jun 2024 16:40:10 +0200
Message-ID: <87sexf7flh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] kselftest/alsa: mixer-test: Skip write tests for volatile controls
In-Reply-To: <ZmxTrzZK2lwSLRpl@finisterre.sirena.org.uk>
References: <20240614124728.27901-1-tiwai@suse.de>
	<20240614124728.27901-5-tiwai@suse.de>
	<ZmxTrzZK2lwSLRpl@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C494F205CA
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 14 Jun 2024 16:29:03 +0200,
Mark Brown wrote:
> 
> On Fri, Jun 14, 2024 at 02:47:26PM +0200, Takashi Iwai wrote:
> 
> > The control elements with volatile flag don't guarantee that the
> > written values are actually saved for the next reads, hence they
> > aren't suitable for the standard mixer tests.  Skip the write tests
> > for those volatile controls for avoiding confusion.
> 
> We should still verify that you can actually write I think...
> 
> > +	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
> > +		ksft_print_msg("%s is volatile\n", ctl->name);
> > +		ksft_test_result_skip("write_invalid.%d.%d\n",
> > +				      ctl->card->card, ctl->elem);
> > +		return;
> > +	}
> 
> ...and that you don't read back invalid values after a write like this
> for example.  I think any change for this should be in the validation of
> the read but we should still try the writes we think we can do.

OK, makes sense.  Will respin this one.


thanks,

Takashi

