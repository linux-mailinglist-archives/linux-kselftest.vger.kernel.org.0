Return-Path: <linux-kselftest+bounces-13729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DE9315AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 15:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53568B23D11
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B254818D4C0;
	Mon, 15 Jul 2024 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0qhpSI+P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6EW8QDW1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zUk81cQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Hbw/C4RB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C418C334;
	Mon, 15 Jul 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049775; cv=none; b=hVJxlmAKmVMhIZfpNsUJOnnpIfWe1p840jzsrSb9VW7ZXZ9cUQ1U1vTImxBnSyZUElmkQljDjRTBXHax64zhOcPtk/kxpfcagcod07ltrDWnbV+CzsO8GJdkh2dKe5GK9FkcreZ+Ckp4LSQbrG4isR5zkRz9xTBdQPHfG6UKWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049775; c=relaxed/simple;
	bh=gux/xEKHwBZQIgIxhtPr7SergtKmhzD2vfNEz/5zzrE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rM8VegwM4PAAzyI8CD05g7h6alG6doetVNWrsedDzpF0E0rVjr4Ez57GfypW5Z0hfuOicIfS4HwMDpoor3YexMhgYF54H1uNNWkqXWQE0HcIjx9D09OanrzWdMtNSnoEiaKB9QmC/faFqydlTq3lubwNDgZLR5OBg7dmEt5caTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0qhpSI+P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6EW8QDW1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zUk81cQG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Hbw/C4RB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 47E2F1F82A;
	Mon, 15 Jul 2024 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721049772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aC04bHkKwpK3ilmAvoletI8Ju318NGY+hsR+rUvzvI=;
	b=0qhpSI+PovE70LGPUCUWT3KMW34+kRjOdphacczp6VjszvaQuL2FsowC0OotxqM8XRBRhI
	dXj9sOpDoeCd5NkWbqsRyvAJ2b234dLzCVaf3VRppB+RDU+CkLSZLoBHEMTD0njUIYwGR5
	i3PdV2IRjS231aqOA1xCo1Z7DmNR4o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721049772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aC04bHkKwpK3ilmAvoletI8Ju318NGY+hsR+rUvzvI=;
	b=6EW8QDW1FJ2aWqR7vrg1DVCKK7fIsG4Ki11SZJOQAgZwitZc0IRgp182BhjrNcRwI5o01v
	lxS2+plsIqZQYBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721049771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aC04bHkKwpK3ilmAvoletI8Ju318NGY+hsR+rUvzvI=;
	b=zUk81cQG31Q5bY6VDO0F3t2xXTzHy3cJlL+GqLFwhDVZTxWYmM6q63NSk+TH4ftHNHKgBZ
	M3Luu/Lk5d9RDF2Q6BS360iGnZxLBBjIagYbOly9wLXWtXGDUczr+MKVppHg0zE/sqAHmR
	7U0G6NtIWoQS7YRNVX26iCJzl4WzDx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721049771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aC04bHkKwpK3ilmAvoletI8Ju318NGY+hsR+rUvzvI=;
	b=Hbw/C4RB0mBcwkvQpHEPO4kTAJUcRYkxpm0FLEpJqL/m5sdzC+zywVc2OpxIO1BdT48WKe
	bCyS4sQseCCGOJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE3B134AB;
	Mon, 15 Jul 2024 13:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GubkCasilWZcVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 15 Jul 2024 13:22:51 +0000
Date: Mon, 15 Jul 2024 15:23:24 +0200
Message-ID: <87le2223hv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Use card name rather than number in test names
In-Reply-To: <652d6fef-9e63-4c3c-b61b-8a47d6eadaf1@sirena.org.uk>
References: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
	<7cd921b3-fed9-4b0c-9ba8-381e45ef4218@perex.cz>
	<b3fdbb63-067b-4ff4-8fd8-1c2455a553a5@sirena.org.uk>
	<877cdrt3zc.wl-tiwai@suse.de>
	<e4962ea0-3f03-43b5-b773-68abe1d73cc9@perex.cz>
	<bb42afb8-48a7-4daf-b28b-b82bd5c77d57@sirena.org.uk>
	<c1be6bec-90f5-4bb3-b6b0-8524095fc490@perex.cz>
	<31e73e81-e60f-4d0b-b0ac-118f1dc72610@sirena.org.uk>
	<87plrhssa4.wl-tiwai@suse.de>
	<652d6fef-9e63-4c3c-b61b-8a47d6eadaf1@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Mon, 15 Jul 2024 15:18:44 +0200,
Mark Brown wrote:
> 
> On Sat, Jul 13, 2024 at 08:46:43AM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > OTOH, if the former is the problem, using longname won't help,
> > either, rather it can be confusing.  I noticed that the test output
> > truncates the name string, hence both cards look identical in the
> > actual output (except for the card listing at the beginning).
> 
> Interesting - I was mainly developing on a system with multiple HDA
> cards and was getting fairly clearly unique names.

An AMD system usually has two HD-audio entries, and both are "HD-audio
Generic".


Takashi

