Return-Path: <linux-kselftest+bounces-9502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF2E8BC83E
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E06F1C21341
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A67E58D;
	Mon,  6 May 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SdPpOIwq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pIUBUnAB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SdPpOIwq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pIUBUnAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7844D9E2;
	Mon,  6 May 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979961; cv=none; b=NIleP9RFG2VaGMjfCFjwTC2KxylbQ9QIsVtYbUy5x/Utjn5v0v8UWsEajzomF8o/tGh0GAiLAzZ4F3uoR6Rw37VQ3Q7Uf1buqnShvhlkaeELXQV3lsDNwX+gT2DFHq8NevCRiJdXjbC3rV8O1N3ahzGQV+8il4ofAOHOlUj/e98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979961; c=relaxed/simple;
	bh=2qf5MESMKz0rbf+sBoiM5dawaPuX0O13HjmplCWnva8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt6mBtVw0Jaga6dC2vXUzhGsm7+VnTGNzj+rGMDsDb8vDaSxvMy4h87kvtbt9jJhJqMCik4KYZlsT/yivtfWXd2FLF18ZSS/E8kOQoWuNs9os8I53i42HTutNKfjnp8vl1USqLk4NCGTKroQy56gK0VHcTUTfC8/hEdLNJ5ndNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SdPpOIwq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pIUBUnAB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SdPpOIwq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pIUBUnAB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9D0E75F913;
	Mon,  6 May 2024 07:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714979957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcLvCNWG1BpMQqyznUL8QmAGxy+Av9osQDupzzbn2/U=;
	b=SdPpOIwqkOVpjDLEBurmdDR5GNv1CLLUPiytFFC2JytOISY1j1ak+gIHyXN1k0EYEnFrIU
	00MmXlUXYzz0M1e6r6DkQIkCmFc9nWSQUk9PVGIUiLy04XpqMdXW6ajQbr2l+0r7Y1l+Qi
	YfYv32Sd8qDgHAt6wvxlsF/yAV1VVYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714979957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcLvCNWG1BpMQqyznUL8QmAGxy+Av9osQDupzzbn2/U=;
	b=pIUBUnABkD51ctrCllCiIm8e8a9fVgJEolYDruV5OfPfbPDK5cjnuNCBA1Q3pQj1Z/hDDk
	LVxZPxC7qbra9KBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714979957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcLvCNWG1BpMQqyznUL8QmAGxy+Av9osQDupzzbn2/U=;
	b=SdPpOIwqkOVpjDLEBurmdDR5GNv1CLLUPiytFFC2JytOISY1j1ak+gIHyXN1k0EYEnFrIU
	00MmXlUXYzz0M1e6r6DkQIkCmFc9nWSQUk9PVGIUiLy04XpqMdXW6ajQbr2l+0r7Y1l+Qi
	YfYv32Sd8qDgHAt6wvxlsF/yAV1VVYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714979957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcLvCNWG1BpMQqyznUL8QmAGxy+Av9osQDupzzbn2/U=;
	b=pIUBUnABkD51ctrCllCiIm8e8a9fVgJEolYDruV5OfPfbPDK5cjnuNCBA1Q3pQj1Z/hDDk
	LVxZPxC7qbra9KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3810313A25;
	Mon,  6 May 2024 07:19:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HAZcDHWEOGZXVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 07:19:17 +0000
Date: Mon, 06 May 2024 09:19:31 +0200
Message-ID: <875xvrif0c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-sound@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests/alsa: missing a return value in unused dump_config_tree()
In-Reply-To: <20240505210824.55392-1-jhubbard@nvidia.com>
References: <20240505210824.55392-1-jhubbard@nvidia.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -1.32
X-Spam-Level: 
X-Spamd-Result: default: False [-1.32 / 50.00];
	BAYES_HAM(-2.52)[97.82%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,perex.cz,suse.com,gmail.com,vger.kernel.org,valentinobst.de,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Sun, 05 May 2024 23:08:24 +0200,
John Hubbard wrote:
> 
> dump_config_tree() is declared to return an int, but the compiler cannot
> prove that it always returns any value at all. This leads to a clang
> warning, when building via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> Furthermore, Mark Brown noticed that dump_config_tree() isn't even used
> anymore, so just delete the entire function.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Thanks, applied now.


Takashi

