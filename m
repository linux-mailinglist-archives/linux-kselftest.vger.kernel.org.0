Return-Path: <linux-kselftest+bounces-38100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8522B173AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5E1188B1EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC05D1DE3BA;
	Thu, 31 Jul 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NiX9QtKc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lYBpol9o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mmXKQ5t/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XgyjxJvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D51D6DB9
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974175; cv=none; b=p1R9+13E9OIdIE7PSBvxCK7CNvlkMxSB/cXP/7XZjDsdT6qIO2PzeyNs8W1JBTru9Qh1utnL2XwKtl1caB0f9KFphPB3La3uo8CtLk9G/kM/RPXo0qOfYlPMfPgynpC2I/mJjv/IyOCKeqcWnLE1KufCXlF1qyRlmBuUSa/CP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974175; c=relaxed/simple;
	bh=u4Pi+O6lI3yHDxb4aitwkcmubgdC5V4iIugleQEtQFw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXgPM2jWEuwfgM4dBF55YgdJOnm9JrwNNi2qtbKt81sKpxs2V9a0rlH1wQzZVbBLOt3aZlnDkDOb+UkusqmsHtklMZUTRyfNwdC6U8r1UbCp+X5a82LnTaeoBB6j/rpkgPwzTpiykYuICVgtZEzyauGy/8JRqHE0tZqU9pX5HrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NiX9QtKc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lYBpol9o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mmXKQ5t/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XgyjxJvh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2B41F80C;
	Thu, 31 Jul 2025 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753974167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhMZ2WGYNcjGe2YN1a1sOTxLRB2mHVM2V8K9nUJHQ04=;
	b=NiX9QtKcoPsCtfrCOp23lOHvu/cpnJCLWpTrqMKYAmmdcoZyv35I4iMKf7cM1H8wEAKUSI
	lobQysWv6e3w15g8blEcvhMZoUCzkUYwU8lQe3n3mOfntq3bN4D1nsvvVwypzj9FmlW+8R
	/8oUmjPiK7LBzN34FzV+68jzX4hV1EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753974167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhMZ2WGYNcjGe2YN1a1sOTxLRB2mHVM2V8K9nUJHQ04=;
	b=lYBpol9oRbrX2ahWC7W67rbLQG3J2rwxfpMH7Gc3fSQ9gC6OX72e6A8AoCNlflKCwHf5Gc
	yidAJ0ANdySq4aCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mmXKQ5t/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XgyjxJvh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753974162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhMZ2WGYNcjGe2YN1a1sOTxLRB2mHVM2V8K9nUJHQ04=;
	b=mmXKQ5t/BEtkFPkXM5vl4iHVOXRW2Qc0H0HPAmQDZZzSLTXSpt1UyH7NARfeNBJyyDpJB4
	Trxfa5PTJfc89b43DihRhuAGacFMLlqZbEiJL0cK56Rz7uQGL5nHHJZOxeYDbHuu7dYS/3
	fWMqSQjVUs5BsDX7vaxnOUcj7kCRfzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753974162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JhMZ2WGYNcjGe2YN1a1sOTxLRB2mHVM2V8K9nUJHQ04=;
	b=XgyjxJvhNzF8fJHnW9vGVoN3v8XyPtoG0NfdXJCVmtJusTuCtCHm7b8a9GkkH1802symqG
	rsutd0a0CcAVZnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A42913876;
	Thu, 31 Jul 2025 15:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFUjCZKFi2ifDAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 15:02:42 +0000
Date: Thu, 31 Jul 2025 17:02:41 +0200
Message-ID: <87frecqu7i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	Jun Zhan <zhanjun@uniontech.com>
Subject: Re: [PATCH] selftests: ALSA: fix memory leak in utimer test
In-Reply-To: <DE4D931FCF54F3DB+20250731100222.65748-1-wangyuli@uniontech.com>
References: <DE4D931FCF54F3DB+20250731100222.65748-1-wangyuli@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6F2B41F80C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_URIBL_FAIL(0.00)[uniontech.com:query timed out];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Thu, 31 Jul 2025 12:02:22 +0200,
WangYuli wrote:
> 
> Free the malloc'd buffer in TEST_F(timer_f, utimer) to prevent
> memory leak.
> 
> Reported-by: Jun Zhan <zhanjun@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>

Thanks, applied now.  I added Fixes tag in my side.


Takashi

> ---
>  tools/testing/selftests/alsa/utimer-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
> index 32ee3ce57721..37964f311a33 100644
> --- a/tools/testing/selftests/alsa/utimer-test.c
> +++ b/tools/testing/selftests/alsa/utimer-test.c
> @@ -135,6 +135,7 @@ TEST_F(timer_f, utimer) {
>  	pthread_join(ticking_thread, NULL);
>  	ASSERT_EQ(total_ticks, TICKS_COUNT);
>  	pclose(rfp);
> +	free(buf);
>  }
>  
>  TEST(wrong_timers_test) {
> -- 
> 2.50.1
> 

