Return-Path: <linux-kselftest+bounces-13704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7CF93041D
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 08:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8F01F22355
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882C1BDE6;
	Sat, 13 Jul 2024 06:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JLivPKX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RD+xW6hL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JLivPKX4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RD+xW6hL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43BF9EC;
	Sat, 13 Jul 2024 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720853175; cv=none; b=e07ROU5WIm17D5DSxT2TLCBJMxkpXLmRszYP+5mDefaQI9xUdyLrUwXRPslnzqWpRM/odaNlKN2kvXMHZaUSfHo8PG+YwKQ41k0GSjv2X1FQUBpDf+gYjmCIdv3vbf4K7bW2fzAYzK4NL4mWCdumscqWeYzZKTKXaZBRcflc/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720853175; c=relaxed/simple;
	bh=yY33+5APyjEzae2iAwViq+yRRVuxE+Rb8qhIWwuuLeo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGPAr8iwDTzk2ev9CTzLsk2mtg63z3TW8CYT84Oai3rqCbTfARTP/vnuq9E6VqfXacLv7mDqZ5lzcnwjGBj4Vk21qOHDxXeEntMABcVBZi68dBEqWJQeq03KLj3NUGVsG0qoIq7/l9rNG43HyhIAQd4Q87kkXBs3G18HEtpumko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JLivPKX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RD+xW6hL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JLivPKX4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RD+xW6hL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B27481FBCD;
	Sat, 13 Jul 2024 06:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720853171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYtwHX31WJYVhnvwXw7XNIn9nZhkjNRMDGCTQUdLam4=;
	b=JLivPKX4psON5JyiZ6nk6I/Y0uzb16X5RMTp9hp+esYWTKf4LWh1znvgQ7cp6ti5Oc7YCb
	27kcw+BlR2ucIAGcj5GyQQdosU6TsEFSA/spL3sDJMxpIz0D827hRAnzkKs8zKn9sIaz7L
	v4CnylJJXlc1axLVZ1F9zcRYurdkfpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720853171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYtwHX31WJYVhnvwXw7XNIn9nZhkjNRMDGCTQUdLam4=;
	b=RD+xW6hLqdCYbQquS1M2tEQuyoiTjocmCo8stvc6uIdiU0RE6cbg+F+15zXxZK9Y1dAF1O
	3/NwQmOyvv4sYlDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JLivPKX4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RD+xW6hL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720853171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYtwHX31WJYVhnvwXw7XNIn9nZhkjNRMDGCTQUdLam4=;
	b=JLivPKX4psON5JyiZ6nk6I/Y0uzb16X5RMTp9hp+esYWTKf4LWh1znvgQ7cp6ti5Oc7YCb
	27kcw+BlR2ucIAGcj5GyQQdosU6TsEFSA/spL3sDJMxpIz0D827hRAnzkKs8zKn9sIaz7L
	v4CnylJJXlc1axLVZ1F9zcRYurdkfpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720853171;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYtwHX31WJYVhnvwXw7XNIn9nZhkjNRMDGCTQUdLam4=;
	b=RD+xW6hLqdCYbQquS1M2tEQuyoiTjocmCo8stvc6uIdiU0RE6cbg+F+15zXxZK9Y1dAF1O
	3/NwQmOyvv4sYlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75D2D134AB;
	Sat, 13 Jul 2024 06:46:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ZY8G7MikmYhYwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 13 Jul 2024 06:46:11 +0000
Date: Sat, 13 Jul 2024 08:46:43 +0200
Message-ID: <87plrhssa4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test names
In-Reply-To: <31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
	<7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
	<b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
	<877cdrt3zc.wl-tiwai@suse.de>
	<e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
	<bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
	<c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
	<31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: B27481FBCD

On Fri, 12 Jul 2024 20:19:33 +0200,
Mark Brown wrote:
> 
> On Fri, Jul 12, 2024 at 06:25:21PM +0200, Jaroslav Kysela wrote:
> > On 12. 07. 24 15:00, Mark Brown wrote:
> 
> > > The trouble with the ID field is that it's too short and seems likely to
> > > create collisions, for example HDA stuff just seems to default to NVidia
> > > for nVidia cards which seems very likely to create collisions if someone
> > > has two graphics cards in their system.
> 
> > The default IDs are always unique - see snd_card_set_id_no_lock() in
> > sound/core/init.c . Basically, the suffix will follow the device probe order
> > in this case.
> 
> Sure, but the genesis of this patch is that probe order isn't
> sufficiently stable and we want to avoid names based on it...  using the
> ID will be more likely to work out stable than just pure probe order but
> it's still got the same issue.

Are you trying to solve the issue with two cards of the same driver,
which are swapped sometimes at the probe time?  Or the mixture of
different cards that are swapped?

In the latter case, id should work well.  The id is primarily created
from the (short)name string, and the suffix is added only when
conflicting.

OTOH, if the former is the problem, using longname won't help,
either, rather it can be confusing.  I noticed that the test output
truncates the name string, hence both cards look identical in the
actual output (except for the card listing at the beginning).


Takashi

