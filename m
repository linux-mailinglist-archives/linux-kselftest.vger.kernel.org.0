Return-Path: <linux-kselftest+bounces-9504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911BF8BC885
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9451C20889
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B6013F44F;
	Mon,  6 May 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZEVw2SwU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FhvHSAqv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n6GhvFeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LoDu9hAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5F5A0E1;
	Mon,  6 May 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981512; cv=none; b=L9c7r+0rrU7b4kA09e9X1iAOz3GcoojQIrV9c9s7wjaLlekwYeXahyt3zMCNbkQGiAGPqXI6fGeM2y8RWukI/jBFPrWRS2Hb9Hcxf/4Xl0CVKgW775QfXAzvm+3beqICYpF6pJzxTR9dj5e8KaNhPlgHzrmpc1RHsXQoO/zj6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981512; c=relaxed/simple;
	bh=hbk+KfVwD07Qx/5jw2FufoF+HQqBivDwwUKf9HHF5Gw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjEfcdYq/U5KP1aeC49YBS6shU6cteGBMG22hjFTdOF0GyGQjUakD5cB1WhCwNtRjh9EDS6b66F1lLe0W18dii256VBifHjCIDVdm7I3eImqPpWOvHjLY/hDwWicHRcUynRODewX9YfM+HSP714w8IyU8Reh3GbAnQAtQcaFAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZEVw2SwU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FhvHSAqv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n6GhvFeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LoDu9hAr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F08E65F971;
	Mon,  6 May 2024 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8NhZ5Z++Xyx8ycFFvX5+HcsU9P3SaLsiqRdiI3IPaY=;
	b=ZEVw2SwUfMrUiAbA/C0PQARZG1+2mEULj+ogwY00PnSzxv8n3XbAD7p0oSjJUPJV49vhyi
	l0lyD9/hOPCdZh25TOQptixkW4LRaihlRMibf5vrwHVxRI9esvH3/FPnWcAFJMr3Es+i6h
	jkU/RXCSCip4wYP25HCeoiwQ+UzJVW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8NhZ5Z++Xyx8ycFFvX5+HcsU9P3SaLsiqRdiI3IPaY=;
	b=FhvHSAqvlBOCf3pBYOM7ewfRIkQlM7/bNdA7ET5J+UxJTnlzFjXbLJoXddGk9c3GYYHObI
	RTwTEQDm+LZoU0AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714981506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8NhZ5Z++Xyx8ycFFvX5+HcsU9P3SaLsiqRdiI3IPaY=;
	b=n6GhvFeTvZLhw6DOAciUhZSNHWlXUcrX3TrM2yXiURUPGhAW3bAzpxjtd8sXtwV3nDp17m
	PyoNmrZ1P8BFpltJPSM9hdgdtb8Y0q8m96MtFAmhHZjwfz4q8U41DYSpJAFic4Sd47t4Ll
	3Yz1DGNIiVmunhuHJECcxWwP1pmy6Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714981506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8NhZ5Z++Xyx8ycFFvX5+HcsU9P3SaLsiqRdiI3IPaY=;
	b=LoDu9hAr2qw6VHTydgDo63ELGjlIT/gkRfiuhXF548fhNfeaGM266uSegnnVSmVVmknqyD
	omoJT6E4CjZK0fBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D00113A25;
	Mon,  6 May 2024 07:45:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yCkdJYKKOGbnXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 07:45:06 +0000
Date: Mon, 06 May 2024 09:45:21 +0200
Message-ID: <87zft3gz8u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/alsa: missing a return value in unused dump_config_tree()
In-Reply-To: <a80cb2a2-735d-4539-a758-a536296975cd@perex.cz>
References: <20240505210824.55392-1-jhubbard@nvidia.com>
	<875xvrif0c.wl-tiwai@suse.de>
	<a80cb2a2-735d-4539-a758-a536296975cd@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,nvidia.com,kernel.org,suse.com,gmail.com,vger.kernel.org,valentinobst.de,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Mon, 06 May 2024 09:27:38 +0200,
Jaroslav Kysela wrote:
> 
> On 06. 05. 24 9:19, Takashi Iwai wrote:
> > On Sun, 05 May 2024 23:08:24 +0200,
> > John Hubbard wrote:
> >> 
> >> dump_config_tree() is declared to return an int, but the compiler cannot
> >> prove that it always returns any value at all. This leads to a clang
> >> warning, when building via:
> >> 
> >>      make LLVM=1 -C tools/testing/selftests
> >> 
> >> Furthermore, Mark Brown noticed that dump_config_tree() isn't even used
> >> anymore, so just delete the entire function.
> >> 
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > 
> > Thanks, applied now.
> 
> This function is nice for debugging. I'd prefer to keep it with the fix.

I'm find in either way; just submit a fix patch, then.


thanks,

Takashi

