Return-Path: <linux-kselftest+bounces-12012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4728909C1E
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971541F2239B
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BC178396;
	Sun, 16 Jun 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxEG0O/S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QEXDPlNR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxEG0O/S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QEXDPlNR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3F2941B;
	Sun, 16 Jun 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523124; cv=none; b=ojxMu/vnQL1mzHA50ivmAgegsIMptAi9KgPKxrdYPJksb3HSOATGzbz1+HzVtU3IK3reMm5OCTd4QVZLJR2KYJviQslRXaJxa9sXnWUNHi0oqMzsEXgoctsVc+UUUmJDEz394H8FZ6FjpXw2eWJ4hOYaumH0zjLuq8B/AUJt/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523124; c=relaxed/simple;
	bh=jW6ZH3b0hQagO4XnjOskiZetbS/zqijEdXjO4cycVR4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhaL0vOZx190F6qd9wWPEva6sa9106hxWk1sSAnlpmOgFtSP8d7pHyzAUMkXQ69fncjj9RDm6XOTgOqM0vNS+xtQVkMiy6RWjRz5i/0iOrxurd4rnUC0QzfDv1VaX9JNqCqMjcKP1Lq3K1JtFOKvKyfeY1PFhsYnL3JfWM3iTTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxEG0O/S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QEXDPlNR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxEG0O/S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QEXDPlNR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63B2735066;
	Sun, 16 Jun 2024 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5UlOdMzu7VkWukPE9vEuu2E0mkGNjfYXyW/FkFubVs=;
	b=SxEG0O/S3Wlvi/j831KzY3EP/jJvB0fY1PNOr09hcKyvQifr/UIWB6Myz0iXhQFGhw01Fg
	f9l//pG4ZCU0hN2TiRQaW61i99+KlXFx0ZLutZ3OVDUHqStvJjrF9UtO4YVH4HTDaXKMAF
	+XeIH3eTldngNUq4d4NOIG8lRzwswVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5UlOdMzu7VkWukPE9vEuu2E0mkGNjfYXyW/FkFubVs=;
	b=QEXDPlNRIPnHdyY8AYNRPsNGM1eNn/NjI3OC0vMgSHz28qzuPVComzHIz5v81Msk2+/eAl
	dnoXLMH/kfueSICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5UlOdMzu7VkWukPE9vEuu2E0mkGNjfYXyW/FkFubVs=;
	b=SxEG0O/S3Wlvi/j831KzY3EP/jJvB0fY1PNOr09hcKyvQifr/UIWB6Myz0iXhQFGhw01Fg
	f9l//pG4ZCU0hN2TiRQaW61i99+KlXFx0ZLutZ3OVDUHqStvJjrF9UtO4YVH4HTDaXKMAF
	+XeIH3eTldngNUq4d4NOIG8lRzwswVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523120;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5UlOdMzu7VkWukPE9vEuu2E0mkGNjfYXyW/FkFubVs=;
	b=QEXDPlNRIPnHdyY8AYNRPsNGM1eNn/NjI3OC0vMgSHz28qzuPVComzHIz5v81Msk2+/eAl
	dnoXLMH/kfueSICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E5F213AB9;
	Sun, 16 Jun 2024 07:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MdMYCvCUbmabCgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:32:00 +0000
Date: Sun, 16 Jun 2024 09:32:24 +0200
Message-ID: <87bk415omv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Fix validation of writes to volatile controls
In-Reply-To: <20240614-alsa-selftest-volatile-v1-1-3874f02964b1@kernel.org>
References: <20240614-alsa-selftest-volatile-v1-1-3874f02964b1@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Fri, 14 Jun 2024 18:40:37 +0200,
Mark Brown wrote:
> 
> When validating writes to controls we check that whatever value we wrote
> actually appears in the control.  For volatile controls we cannot assume
> that this will be the case, the value may be changed at any time
> including between our write and read.  Handle this by moving the check
> for volatile controls that we currently do for events to a separate
> block and just verifying that whatever value we read is valid for the
> control.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

I'll pick this in v3 patch set.


thanks,

Takashi

