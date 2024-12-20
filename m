Return-Path: <linux-kselftest+bounces-23647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8F99F8E7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BE160373
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01111AA1F1;
	Fri, 20 Dec 2024 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/zOjsko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7SDhuTMb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O/zOjsko";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7SDhuTMb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7251A0737;
	Fri, 20 Dec 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685274; cv=none; b=PSdPN0xLpNViJwJVOd+2HE8gXiCj+qoDvXCKQXbabbBAvlcZWc8eEK38iME01NOkf2mH6q3dJbF6MQx6O2hj4O3IgwNv4MGI0d66vKatTnOn8B5UdIQUuN13Jprx5YfZQwoC3Z3iegEGsWvyydv283CTXP1cxSH8HVBrKwC4xAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685274; c=relaxed/simple;
	bh=mtsHNjErBVbM6gd7EEjP+xrkYhw1P+PuXWzaMldQ6PA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbkbfF3E3YeJjXozjrTaq4Yj1ZBhvb0Tk6F6wqWtzPxa5/rg49yv2W0OV6afR7uY99Lesv9XlTg5+pqy7M9hY+5SulpJAx0B7JbkeBkOvSxDDbv/JWC+iPznqtjGYfdrfKukHKxQyBuCDS/mRviiJe3Y/EP1iArkLpRLtJT6UDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/zOjsko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7SDhuTMb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O/zOjsko; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7SDhuTMb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6490F1F365;
	Fri, 20 Dec 2024 09:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734685270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQKf9XZcrQRmEaqIbgcvlF0ZTKrQqX3PeU841MH1EY=;
	b=O/zOjskoj+E2hvPTcL0W71i/X0+PINNJ54B0ou6mw/SMUkSqae6dARnx3mq0nUc6l8KKkm
	50al0JoOAJSZ3n3NWPXD0ZUrpPOCeHiRA1BvxBBzfczoqLklmMGvgOITXBPVEUc0HnEF+m
	T/Hn7ibqWvwzHLY66t7ybNrQHNnCASU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734685270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQKf9XZcrQRmEaqIbgcvlF0ZTKrQqX3PeU841MH1EY=;
	b=7SDhuTMbeqe2Rl2FiMm6Rbx0f6KgKxtCLhZbNKz8+aZ+yOVxqDm5cZPtAM6Ral1qQUeQzs
	7afiKStdTM9QbLBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O/zOjsko";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7SDhuTMb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734685270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQKf9XZcrQRmEaqIbgcvlF0ZTKrQqX3PeU841MH1EY=;
	b=O/zOjskoj+E2hvPTcL0W71i/X0+PINNJ54B0ou6mw/SMUkSqae6dARnx3mq0nUc6l8KKkm
	50al0JoOAJSZ3n3NWPXD0ZUrpPOCeHiRA1BvxBBzfczoqLklmMGvgOITXBPVEUc0HnEF+m
	T/Hn7ibqWvwzHLY66t7ybNrQHNnCASU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734685270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vNQKf9XZcrQRmEaqIbgcvlF0ZTKrQqX3PeU841MH1EY=;
	b=7SDhuTMbeqe2Rl2FiMm6Rbx0f6KgKxtCLhZbNKz8+aZ+yOVxqDm5cZPtAM6Ral1qQUeQzs
	7afiKStdTM9QbLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1F8413A32;
	Fri, 20 Dec 2024 09:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FW/XK1UyZWcybgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 20 Dec 2024 09:01:09 +0000
Date: Fri, 20 Dec 2024 10:01:09 +0100
Message-ID: <8734iirane.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] selftests/alsa: Fix circular dependency involving global-timer
In-Reply-To: <20241218025931.914164-1-lizhijian@fujitsu.com>
References: <20241218025931.914164-1-lizhijian@fujitsu.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 6490F1F365
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Wed, 18 Dec 2024 03:59:31 +0100,
Li Zhijian wrote:
> 
> The pattern rule `$(OUTPUT)/%: %.c` inadvertently included a circular
> dependency on the global-timer target due to its inclusion in
> $(TEST_GEN_PROGS_EXTENDED). This resulted in a circular dependency
> warning during the build process.
> 
> To resolve this, the dependency on $(TEST_GEN_PROGS_EXTENDED) has been
> replaced with an explicit dependency on $(OUTPUT)/libatest.so. This change
> ensures that libatest.so is built before any other targets that require it,
> without creating a circular dependency.
> 
> This fix addresses the following warning:
> 
> make[4]: Entering directory 'tools/testing/selftests/alsa'
> make[4]: Circular default_modconfig/kselftest/alsa/global-timer <- default_modconfig/kselftest/alsa/global-timer dependency dropped.
> make[4]: Nothing to be done for 'all'.
> make[4]: Leaving directory 'tools/testing/selftests/alsa'
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied now.  Thanks.


Takashi

