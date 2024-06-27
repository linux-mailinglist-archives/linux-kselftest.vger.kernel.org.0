Return-Path: <linux-kselftest+bounces-12846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D09A91A0FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F900B2240E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235526F30B;
	Thu, 27 Jun 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vpwwC1D2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W83jFYSa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vpwwC1D2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W83jFYSa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6F6288BD;
	Thu, 27 Jun 2024 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475044; cv=none; b=NhYA11kPqSQdku2uxOvKR56iJW+n3hDqweoSeizggSYzmnzNTOsqz3e2OZKhJ/74LAlzYwaPBn0xnYbALI5JyGDsfdZ9dbde5xQPUjhRCSNxUX1EVOvqiU32tTxWkWIU/d21yRmGy+sZBA9FA9KKQx687KklPBx3YKVM8VQkhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475044; c=relaxed/simple;
	bh=ufGuGd3hT7L+aLFQrsbFstDYud+aN3bGPAcDPDd59WM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgbmBzGjrheptxD1db6vGqXZVN1E2kniAp1sdYqkgwDhByx62ljfv4dww9r7YNprKx+l1Bg8qLScj5ShMDMJNEsgXShzbFyEKosnibE+WXPnr35EHhPkUQmQTxa8KSBdIJkEBpOgb0RyXFXg1WCr47qHZfBWtOQ+/k+CGEgJ8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vpwwC1D2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W83jFYSa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vpwwC1D2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W83jFYSa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 650641FBAB;
	Thu, 27 Jun 2024 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HY2aGPC0WvkJPwPz/6L4o8PZmsUMm2P0ZgwZlEgSINc=;
	b=vpwwC1D23BpyRwUVI7r5t8FbA0SeYs7hD1EcsTn/KqsOA/5PbD7uDPTeddhIa7uoqa1U8Z
	Z2CnDMjNfuNxtUQETH5NjcpA7VyJWsdMmqJUMCAz+LEOtd+GJ3kYRvDMY6W7E7v98UW76d
	mV+xIMOkzX7IoQZXwUZZs2HgkoX7VBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HY2aGPC0WvkJPwPz/6L4o8PZmsUMm2P0ZgwZlEgSINc=;
	b=W83jFYSaMajPTmtWPxbncQyA/S0GCHEKrEvV8TMKE7MerovVBfatK2fV7l6cp4QZOdQEBl
	rLOK7SOH3Mdu+RBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vpwwC1D2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W83jFYSa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719475040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HY2aGPC0WvkJPwPz/6L4o8PZmsUMm2P0ZgwZlEgSINc=;
	b=vpwwC1D23BpyRwUVI7r5t8FbA0SeYs7hD1EcsTn/KqsOA/5PbD7uDPTeddhIa7uoqa1U8Z
	Z2CnDMjNfuNxtUQETH5NjcpA7VyJWsdMmqJUMCAz+LEOtd+GJ3kYRvDMY6W7E7v98UW76d
	mV+xIMOkzX7IoQZXwUZZs2HgkoX7VBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719475040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HY2aGPC0WvkJPwPz/6L4o8PZmsUMm2P0ZgwZlEgSINc=;
	b=W83jFYSaMajPTmtWPxbncQyA/S0GCHEKrEvV8TMKE7MerovVBfatK2fV7l6cp4QZOdQEBl
	rLOK7SOH3Mdu+RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C982137DF;
	Thu, 27 Jun 2024 07:57:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EL2hCWAbfWZBAQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 27 Jun 2024 07:57:20 +0000
Date: Thu, 27 Jun 2024 09:57:48 +0200
Message-ID: <874j9eizr7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-sound@vger.kernel.org,
	broonie@kernel.org
Subject: Re: [PATCH] selftests/alsa:Fix printf format string in pcm-test.c
In-Reply-To: <20240626084859.4350-1-zhujun2@cmss.chinamobile.com>
References: <20240626084859.4350-1-zhujun2@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 650641FBAB
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, 26 Jun 2024 10:48:59 +0200,
Zhu Jun wrote:
> 
> Inside of test_pcm_time() arguments are printed via printf
> but '%d' is used to print @flags (of type unsigned int).
> Use '%u' instead, just like we do everywhere else.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied now to for-next branch.  Thanks.


Takashi

