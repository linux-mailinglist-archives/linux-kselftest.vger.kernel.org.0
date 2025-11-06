Return-Path: <linux-kselftest+bounces-44936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93738C3A5DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C075A4F3692
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F52DA774;
	Thu,  6 Nov 2025 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+vov1lo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WDbZDSbM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+vov1lo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WDbZDSbM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600161FDA89
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426145; cv=none; b=lbv3oxvC+/JelAvax+XgY7ujtv2Q+J55jeRfrhnFCSLkYrGvmsKXnh9cX4ZflzwzPw03qksarKZKKkUCq3HJC3Sd9Pk2wryVCiMtgExN4GuQQkggnFyYDayH4DW5qozwkdZvEC8t6W8wG7uq0PhJ7uuI4sdN394/wyeHKjZinsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426145; c=relaxed/simple;
	bh=OVla41PY7UFKaD9+VHMLpzzv7PkhppoSlmWwbfwH830=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nU0UD2iCsoGQok4XxEr7mLd7RvrD9ln/yZwPA0FNns4K21RkG0QiLcD0r8S8gadgzqLvRz8PcVQbh+IMWKHSNqYfzAfPPM/lNvmE5N6E4rd2g69k5SinFqsBmir/Rk8hCMh3yjcY0T+1lG2SGdp9S/hSiXkcerJbPpJkkjSK05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J+vov1lo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WDbZDSbM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J+vov1lo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WDbZDSbM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8143B211D2;
	Thu,  6 Nov 2025 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762426141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXcgSpymOp8wGcue3Nl8qbOnhNfOEFlaam7VRUMp1Xg=;
	b=J+vov1loujZKg2EFgWvHEwYUQJVtAAq3owJpdETEAOtRtxw3Kaj1frsRnrVWu29S+RzYUK
	SpNzs0LU+BjtEd14ht1ck9ipBc46Fpr6TyRpX3ZBbeut0pyZVwjxi25TSAkB+K269q+ppm
	82qw+/2fyDpWDQyRLWf8hNzSzcXndHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762426141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXcgSpymOp8wGcue3Nl8qbOnhNfOEFlaam7VRUMp1Xg=;
	b=WDbZDSbMjnV4s3TSuBk9ts+hIvVyAQOWHCQIke9Mv8OLU57jugO/w0Ceh+0Thx82ob2VYJ
	Uk8bIj9e8ywqQbBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762426141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXcgSpymOp8wGcue3Nl8qbOnhNfOEFlaam7VRUMp1Xg=;
	b=J+vov1loujZKg2EFgWvHEwYUQJVtAAq3owJpdETEAOtRtxw3Kaj1frsRnrVWu29S+RzYUK
	SpNzs0LU+BjtEd14ht1ck9ipBc46Fpr6TyRpX3ZBbeut0pyZVwjxi25TSAkB+K269q+ppm
	82qw+/2fyDpWDQyRLWf8hNzSzcXndHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762426141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXcgSpymOp8wGcue3Nl8qbOnhNfOEFlaam7VRUMp1Xg=;
	b=WDbZDSbMjnV4s3TSuBk9ts+hIvVyAQOWHCQIke9Mv8OLU57jugO/w0Ceh+0Thx82ob2VYJ
	Uk8bIj9e8ywqQbBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5837A13A31;
	Thu,  6 Nov 2025 10:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jDoQFB19DGmiZgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:49:01 +0000
Date: Thu, 06 Nov 2025 11:49:00 +0100
Message-ID: <87zf8zfnc3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Cc: broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/alsa: correct grammar in conf_get_bool error string
In-Reply-To: <20251106055819.1996-1-zhangchujun@cmss.chinamobile.com>
References: <20251106055819.1996-1-zhangchujun@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 06 Nov 2025 06:58:19 +0100,
Zhang Chujun wrote:
> 
> The phrase "an bool" is grammatically incorrect; it should be
> "a bool".
> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

Applied now.  Thanks.


Takashi

