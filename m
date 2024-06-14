Return-Path: <linux-kselftest+bounces-11965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E22A5908FA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BB6B21DBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F815ECD0;
	Fri, 14 Jun 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAEcq3M+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JLwND+Vv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IAEcq3M+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JLwND+Vv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40A364A1;
	Fri, 14 Jun 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381271; cv=none; b=tCsR75IqauYzPWgnQrSHKeoWysrCVvRi/wqR5+1r5HK18cR2X2Ux51Vk5PDqUv4Gyrd9n+fcAd1GGzGc8AVN0e2Wq0T0rcU7vE6W4Ptv0LbirpuZrNBkd7YuevXjEEdCewD4gnfeCEWnRbhaKizi+Dj0Kek/a4RhN8DptCZJy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381271; c=relaxed/simple;
	bh=EPYGks1oF4t1pSzt13AslbpA6lQSp9ejBHZE12oAvU0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pH3zSM6WflE01fjD6pOsLeN37xqSv7jJcWXNpeq67RhZyqz19UXTwbC+3tZQ9MjXT6p//K5w4Vci+iuVsjRW5NvzNGIZhD2Ocvp55CKvoJcwpx47FjyrnKpwrVOmV00gACXZwUWQm8R3h/69AnhS3dqCG0I/sKddMJL/s3ynXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IAEcq3M+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JLwND+Vv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IAEcq3M+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JLwND+Vv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7904F20673;
	Fri, 14 Jun 2024 16:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718381267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNW8Q786tZlIdq1RZ+Zry9tmb4Cs7d83PtQBlDpyMq4=;
	b=IAEcq3M+2pKSPIxb2+cg5OVMz8KR12IbhjZ5pswfaKv15dYWeBXgLtW+IWkG7yBRzmwdPO
	yVA3Avv4NsygKST2ok09vNMqSpoTXBZNUoZeProWaZwttNnDF2Ba78ytThterQztQqFzmJ
	nrgONppKQS8eTaARBXHtJbEu16pWVhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718381267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNW8Q786tZlIdq1RZ+Zry9tmb4Cs7d83PtQBlDpyMq4=;
	b=JLwND+VvMjPRexnQGCzfooAmPS10/01jz7Y7wgpvV9kTMYEa0Vk6EDcpgA9Vqf7eBd0zl7
	Tc0oV/LFJk8sFsBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IAEcq3M+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JLwND+Vv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718381267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNW8Q786tZlIdq1RZ+Zry9tmb4Cs7d83PtQBlDpyMq4=;
	b=IAEcq3M+2pKSPIxb2+cg5OVMz8KR12IbhjZ5pswfaKv15dYWeBXgLtW+IWkG7yBRzmwdPO
	yVA3Avv4NsygKST2ok09vNMqSpoTXBZNUoZeProWaZwttNnDF2Ba78ytThterQztQqFzmJ
	nrgONppKQS8eTaARBXHtJbEu16pWVhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718381267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNW8Q786tZlIdq1RZ+Zry9tmb4Cs7d83PtQBlDpyMq4=;
	b=JLwND+VvMjPRexnQGCzfooAmPS10/01jz7Y7wgpvV9kTMYEa0Vk6EDcpgA9Vqf7eBd0zl7
	Tc0oV/LFJk8sFsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A0913AAF;
	Fri, 14 Jun 2024 16:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OfBzENNqbGYhbQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 16:07:47 +0000
Date: Fri, 14 Jun 2024 18:08:12 +0200
Message-ID: <878qz77bir.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/6] kselftest/alsa: mixer-test: Skip write verification for volatile controls
In-Reply-To: <ZmxoaWvgZk7tJq-7@finisterre.sirena.org.uk>
References: <20240614153717.30143-1-tiwai@suse.de>
	<20240614153717.30143-5-tiwai@suse.de>
	<ZmxoaWvgZk7tJq-7@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7904F20673
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Fri, 14 Jun 2024 17:57:37 +0200,
Mark Brown wrote:
> 
> On Fri, Jun 14, 2024 at 05:37:13PM +0200, Takashi Iwai wrote:
> 
> > @@ -616,6 +616,10 @@ static int write_and_verify(struct ctl_data *ctl,
> >  	if (!snd_ctl_elem_info_is_readable(ctl->info))
> >  		return err;
> >  
> > +	/* Skip the verification for volatile controls, too */
> > +	if (snd_ctl_elem_info_is_volatile(ctl->info))
> > +		return err;
> > +
> 
> I think we should do the checks in test_ctl_get_value() still - a read
> and then ctl_value_is_valid() on whatever we read.  It doesn't need to
> match the value we wrote but it should still be valid for the control.

So something like below?


Takashi

-- 8< --
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v3] kselftest/alsa: mixer-test: Allow value mismatch for volatile controls

The control elements with volatile flag don't guarantee that the
written values are actually saved for the next reads, hence we can't
verify the written values reliably.  Return as success for volatile
controls even if the value verification after writes fails, in order
to avoid false-positive.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/alsa/mixer-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..62b77737f0de 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -668,6 +668,10 @@ static int write_and_verify(struct ctl_data *ctl,
 		ksft_print_msg("%s read and written values differ\n",
 			       ctl->name);
 
+	/* Allow difference for volatile controls */
+	if (snd_ctl_elem_info_is_volatile(ctl->info))
+		return 0;
+
 	return -1;
 }
 
-- 
2.43.0


