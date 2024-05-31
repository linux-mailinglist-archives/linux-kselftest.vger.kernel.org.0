Return-Path: <linux-kselftest+bounces-11022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432518D6592
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7424C1C20E11
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99776020;
	Fri, 31 May 2024 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ry3bup68";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U2LKWUYV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ry3bup68";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U2LKWUYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2029A0;
	Fri, 31 May 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168648; cv=none; b=C4gj6P2+x7dBYqxZTT+iFUnTAolUUFFsSbG5AGr8K31nGr6CMAkoPdwXeXiL8J4D9oSz1I9bWQXfGVPLP09kDlsbUp1XOiG62TL4PwkM1xk1IrCswdRqanU89vc0Skd2m1hHNAPfvyMxwRl7xMDnEKShrW9rO3gQCzmDcfSKxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168648; c=relaxed/simple;
	bh=j90dkoE4gB+U3AUAq21TrscoPMna81eAAwDJ2eTkjeQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7vengNJG9lft3h7nJ+Jm7uLCSWnaH3bDHWEhWFaY6zdlj6pcXWTy45tC4W7bsAJEohKuyQzjr/QcQHIjhuphmenPM7UsESoKwvHruQQh9QVwkcamV61I/OVGKbbJgQlmAlbDVvUyEL//Yt269ECU5it1SOq7TVGD2TlLmdv6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ry3bup68; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U2LKWUYV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ry3bup68; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U2LKWUYV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B28221FB75;
	Fri, 31 May 2024 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717168640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az+gMiHCtpICBTPpp3rvWiLE4WJNHFVrf/L6gIfNwSA=;
	b=Ry3bup685Uw6i2N8S2egIj2kUxPXG4p7GSll2jQ9oTE/O49rzc/6BHLlRmsM2IIHeCeEOU
	+2SSp5BDeTasd3aZlPTquuJwdNPhAk7V0sJM3jtJOWhhnd7YG3hUvJyv4ZAAgsLg7b7A5U
	NoOAzS/1x5LuBRwU7kmL3phuNCC+tjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717168640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az+gMiHCtpICBTPpp3rvWiLE4WJNHFVrf/L6gIfNwSA=;
	b=U2LKWUYVL7rHdR92nuv9GeHnP0i744vqVgMda6xboMorO47aVUwHsdPW3IuZRwMVIUuvw9
	hsJQ+kULJlZQ1DCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ry3bup68;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U2LKWUYV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1717168640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az+gMiHCtpICBTPpp3rvWiLE4WJNHFVrf/L6gIfNwSA=;
	b=Ry3bup685Uw6i2N8S2egIj2kUxPXG4p7GSll2jQ9oTE/O49rzc/6BHLlRmsM2IIHeCeEOU
	+2SSp5BDeTasd3aZlPTquuJwdNPhAk7V0sJM3jtJOWhhnd7YG3hUvJyv4ZAAgsLg7b7A5U
	NoOAzS/1x5LuBRwU7kmL3phuNCC+tjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1717168640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=az+gMiHCtpICBTPpp3rvWiLE4WJNHFVrf/L6gIfNwSA=;
	b=U2LKWUYVL7rHdR92nuv9GeHnP0i744vqVgMda6xboMorO47aVUwHsdPW3IuZRwMVIUuvw9
	hsJQ+kULJlZQ1DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C58132C2;
	Fri, 31 May 2024 15:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GkSwHgDqWWYACAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 May 2024 15:17:20 +0000
Date: Fri, 31 May 2024 17:17:43 +0200
Message-ID: <87cyp280yw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13 9360
In-Reply-To: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.10
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B28221FB75
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-2.59)[98.16%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, 31 May 2024 07:50:33 +0200,
Paul Menzel wrote:
> 
> Dear Linux folks,
> 
> 
> Running the ALSA kselftests with Linux 6.10-rc1, `mixer-test` shows
> ten failures:
> 
>     # Totals: pass:24 fail:0 xfail:0 xpass:0 skip:11 error:0
> 
> These are:
> 
>     not ok 5 write_invalid.0.40
>     not ok 11 write_valid.0.39
>     not ok 18 write_valid.0.38
>     not ok 25 write_valid.0.37
>     not ok 201 write_invalid.0.12
>     not ok 208 write_invalid.0.11
>     not ok 264 write_invalid.0.3
>     not ok 271 write_invalid.0.2
>     not ok 278 write_invalid.0.1
>     not ok 285 write_invalid.0.0

Through a quick look, those are no real "failures".  It'd be more
preferable if the driver returns an error for invalid values, but
currently it's up to drivers how to deal with them, and some accept as
is but with correction of the values internally.  They are shown as
"skips" in the summary above you showed, after all.

A more strict check can be enabled by a kconfig option
CONFIG_SND_CTL_INPUT_VALIDATION=y generically.


thanks,

Takashi

