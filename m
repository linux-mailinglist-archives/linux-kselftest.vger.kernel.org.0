Return-Path: <linux-kselftest+bounces-49335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC8DD3A111
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 09:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B3D3052216
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A033B95B;
	Mon, 19 Jan 2026 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="POlJiMfh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ELWoi3/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="POlJiMfh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/ELWoi3/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9D33B6E3
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810397; cv=none; b=IFx9hzttsbnq9Cg5PnTY87mBefuUWTrQmIl0H7zfh+Cv8fiyo877VEmQCEc+0qbCpMyU0GWP0Jo5EgzFyLIxcw7xsEagn2Mdy3V4gA5Z3YIEgrz368uR3vtwXWjDwJZRUKQecO4c6Df3qWmRp8JH8G/NKMSJVmOnXVavv/EyCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810397; c=relaxed/simple;
	bh=dzR7IlHYGiqPhdMdXkSmlLc0iaUDKl6iDUNVKCB/31Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJR9t1JMWYiI+35cNDNLcc3aHyilXsTDAb7WPmoTzWivYBJqFxoYG64b1j73R1MBdABc3l3sHX+EcpdI2iguN/gM3Uo+XZ5DoniChxQDeBLOYBCdSIYjAIt+eF1Y9/0M0AxtI/q9aK4IE0/ZuqSAtPmRhbGyZmbBcYwRU+zdCwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=POlJiMfh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ELWoi3/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=POlJiMfh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/ELWoi3/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52E4F5BCFD;
	Mon, 19 Jan 2026 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768810393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+lnzNn2RNyrWZ3zG80/zBHHSqAJv3kKq5ycL8kFYA=;
	b=POlJiMfhrHOJmIqSfFc0E06EPiur5CRRi1kpN0mOz01T/5PZpSjrmZJigprL8vW19D5CkU
	fxeyBA60fJEana5xtbUIIoL0ZkMGx1oArQH5AccxkY6FMnzA6acaW1VvdhDWaNLo1itk28
	7W3non1+KHFQBxQlzlq+9/T+KjXo3Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768810393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+lnzNn2RNyrWZ3zG80/zBHHSqAJv3kKq5ycL8kFYA=;
	b=/ELWoi3/cS2Tvw7eohEgoDTYhKHJbRMgBSaerFLmzE0ZNVOaHyBw1iqGqZgTkLpRbTcDI0
	UsB0n/Uym+Jv2GDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1768810393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+lnzNn2RNyrWZ3zG80/zBHHSqAJv3kKq5ycL8kFYA=;
	b=POlJiMfhrHOJmIqSfFc0E06EPiur5CRRi1kpN0mOz01T/5PZpSjrmZJigprL8vW19D5CkU
	fxeyBA60fJEana5xtbUIIoL0ZkMGx1oArQH5AccxkY6FMnzA6acaW1VvdhDWaNLo1itk28
	7W3non1+KHFQBxQlzlq+9/T+KjXo3Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1768810393;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GS+lnzNn2RNyrWZ3zG80/zBHHSqAJv3kKq5ycL8kFYA=;
	b=/ELWoi3/cS2Tvw7eohEgoDTYhKHJbRMgBSaerFLmzE0ZNVOaHyBw1iqGqZgTkLpRbTcDI0
	UsB0n/Uym+Jv2GDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16CD13EA63;
	Mon, 19 Jan 2026 08:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dQwcBJnnbWloBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Jan 2026 08:13:13 +0000
Date: Mon, 19 Jan 2026 09:13:12 +0100
Message-ID: <87pl7681gn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: LeeYongjun <jun85566@gmail.com>
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: alsa: Remove unused variable in utimer-test
In-Reply-To: <20260118065510.29644-1-jun85566@gmail.com>
References: <20260118065510.29644-1-jun85566@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, 18 Jan 2026 07:55:10 +0100,
LeeYongjun wrote:
> 
> The variable 'i' in wrong_timers_test() is declared but never used.
> This was detected by Cppcheck static analysis.
> 
> tools/testing/selftests/alsa/utimer-test.c:144:9: style: Unused variable: i [unusedVariable]
> 
> Remove it to clean up the code and silence the warning.
> 
> Signed-off-by: LeeYongjun <jun85566@gmail.com>

Thanks, applied now.


Takashi

