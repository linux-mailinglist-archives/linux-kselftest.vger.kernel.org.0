Return-Path: <linux-kselftest+bounces-13652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD392F6D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155E5283038
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE058142E97;
	Fri, 12 Jul 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VTxBamhV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a3qo/WpF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uk9jn/w7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gvn1FByN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97F8142648;
	Fri, 12 Jul 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720772475; cv=none; b=GVmgkdgSahEQBG1/8RWRvS8N53n6Z2ttRoLgNb4YgRsjBFDsO62R43Rqs+sIjcHhnvWbisBEbIy/Ij7rkvu+RWBadVjw24jtcgD2oDosMU7jaFpx1PS4UvWGHK/Jf5hn5/Ffod5t7C5MYmhPwsBD+9AUrj31dtYfVH6AmDD3aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720772475; c=relaxed/simple;
	bh=p9/qiAKcZbyP9wlf3L0QQhEm0oQL1Tnf2wENYdgqhS0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/HED1n9vinnGCU5gsW0dSTz6bWf+7vj3q4u/lsx5/eqvGCxmyY2Lroc8taAp/YOcnbfwqquEh4PNVVxGEtxMFmVt/JlX4BStCTYY5RxPFb238pkUsm8NcfIJgsIqwSoWP5yjl12URsCAV7n3zjrzztzKOO9SA9FGak2hWZ7wzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VTxBamhV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a3qo/WpF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uk9jn/w7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gvn1FByN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCE771FB71;
	Fri, 12 Jul 2024 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720772472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myQxO7WO5T9CFH3oPmFlxpq8hqCNcsmKBXpMHwzA1KY=;
	b=VTxBamhVjolVsWvKHm7HtZyoFt84+LN9ENnOV49NlJ7mcUpePrPaTN12J3ln6+AOLHwtw+
	iO92OBxp+dNOJxcYcSOh91N4433iFF+dio9Akk9mpQBq0NXaGxOvSp+ppTzvCNqaTa/pnt
	8i6P+O5wsQy/vW6f//flMhZhrYCjzDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720772472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myQxO7WO5T9CFH3oPmFlxpq8hqCNcsmKBXpMHwzA1KY=;
	b=a3qo/WpFwlagMk221vR2zJQva+WvLdRyQ1/N09tQudIX7F2t5bbt/DRAg8k8y7a52nsFv6
	6d37pq/Kpfm+v8AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uk9jn/w7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gvn1FByN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720772471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myQxO7WO5T9CFH3oPmFlxpq8hqCNcsmKBXpMHwzA1KY=;
	b=uk9jn/w7SYRzB2NvPAuLvE03/OEBrj50rxjOliVZiZtHGiMDDF1sbJCIDN2zowMrmhmH8w
	pKEsvE4xB/mm26VsIuwenOMgmsZdV8zA8jQ1W10NTgLbUWOR75vAe8bA3mwbbI4yBLu7Qf
	ZyDgWhAA0W6t+MPsGdRRPaiYztdZVok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720772471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myQxO7WO5T9CFH3oPmFlxpq8hqCNcsmKBXpMHwzA1KY=;
	b=Gvn1FByNPh6gzNnatLD3LAeNjoUWYQ2PWaLT0YDP6p4tVj6j55QVU7O2B9jpo1+Nb9SLTu
	r76yKq1E6aK0bNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76DB21373E;
	Fri, 12 Jul 2024 08:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CqRsG3fnkGZTAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jul 2024 08:21:11 +0000
Date: Fri, 12 Jul 2024 10:21:43 +0200
Message-ID: <877cdrt3zc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test names
In-Reply-To: <b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
	<7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
	<b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: CCE771FB71

On Thu, 11 Jul 2024 18:19:25 +0200,
Mark Brown wrote:
> 
> On Thu, Jul 11, 2024 at 06:08:38PM +0200, Jaroslav Kysela wrote:
> > On 11. 07. 24 16:33, Mark Brown wrote:
> 
> > > Address this by replacing our use of card numbers with card names which are
> > > more likely to be stable across runs. We use the long name since in the
> 
> > I think that a combination of card number and card ID may be sufficient (and
> > a compromise). It's shorter and user-friendly. Additionally, a table may be
> > printed at the beginning of report with card number, card ID and long card
> > name for further processing and identification.
> 
> These don't help, the problem is that anything which includes the card
> number in the test name result is going to result in unstable test names
> depending on race conditions at boot.  There are automated systems that
> parse kselftest output generically, I'm not sure there's a great deal of
> enthusiasm for writing a custom parser for the ALSA selftests
> specifically.

OTOH, longname can be really ugly to read, and it can vary because it
often embeds address or irq numbers in the string.

If a general name is the goal, how about using shortname instead?

Or use id field, as Jaroslav suggested, but without the card number
suffix; then it's unique among multiple cards.


thanks,

Takashi

