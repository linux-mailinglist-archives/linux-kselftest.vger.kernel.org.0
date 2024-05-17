Return-Path: <linux-kselftest+bounces-10335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3E8C829B
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 10:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45304281F13
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFE747F;
	Fri, 17 May 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rMK2mNeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sNJo8VmE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rMK2mNeT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sNJo8VmE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F988F59;
	Fri, 17 May 2024 08:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934924; cv=none; b=F0DDUKu+11XjGZHVJB79qpnrQ/V7jmSnHZXLnMswL5UtDVOsvXVSLpBpujOm+EPBR0Z960m8qkVX3+UBn82a/++j7/+lrEabH3USjKWMu/OwIAnBsKPfAhiQdfHtq4TBUusCt9SfVG7mKBaDXXP72EIqbX7+YnsRRqnk03CKV7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934924; c=relaxed/simple;
	bh=+g/ULRGcWDI4ygVhmLRXFXl/uZbJJNcEYRH2MQAqF4U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTt9MmUENv3HFthGYsi2a8zylBRgBhHZrsINxLEsNb6GH4i3ms+B1LPTOV22d25Lc0EtDxHN9KySxDD/MxF0n7bP35En6jsfmj8b9HpEGW4+zQ05RG8dtjwImxu5Bb9IEl1Pg0eZ8PuQncqvQpXruAADFraBlgT1xVJ+xfpElyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rMK2mNeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sNJo8VmE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rMK2mNeT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sNJo8VmE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 577355D172;
	Fri, 17 May 2024 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715934921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCzq8BhBN43vXaJEDcgYaSLDk4zBHsmFnr5eCbxmA4=;
	b=rMK2mNeTMoyHZOOQt4nLwvgQkO2zPAGabrfTRcLD3X9NaYsNquKddjfD2rsa5iY4E52UKf
	dwZico4g3FJZhb0lkXEPQ9SH+DfFVsNAoN65gvUGYb4yKPZ/CyEy4P1SkOlPLurdHyu7zl
	83rkzmt2OeOLZPIcaYYpb0W6Kbgsfso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715934921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCzq8BhBN43vXaJEDcgYaSLDk4zBHsmFnr5eCbxmA4=;
	b=sNJo8VmE4PrRvt2HsWHyNwSXwbSkpJnBBW5MJ0vjxciFUsmsEW+at+2NW/IKkiS5G/MGt7
	OxAttVw7fTYMvZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715934921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCzq8BhBN43vXaJEDcgYaSLDk4zBHsmFnr5eCbxmA4=;
	b=rMK2mNeTMoyHZOOQt4nLwvgQkO2zPAGabrfTRcLD3X9NaYsNquKddjfD2rsa5iY4E52UKf
	dwZico4g3FJZhb0lkXEPQ9SH+DfFVsNAoN65gvUGYb4yKPZ/CyEy4P1SkOlPLurdHyu7zl
	83rkzmt2OeOLZPIcaYYpb0W6Kbgsfso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715934921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMCzq8BhBN43vXaJEDcgYaSLDk4zBHsmFnr5eCbxmA4=;
	b=sNJo8VmE4PrRvt2HsWHyNwSXwbSkpJnBBW5MJ0vjxciFUsmsEW+at+2NW/IKkiS5G/MGt7
	OxAttVw7fTYMvZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02CB313942;
	Fri, 17 May 2024 08:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W3SuOsgWR2aXdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 May 2024 08:35:20 +0000
Date: Fri, 17 May 2024 10:35:38 +0200
Message-ID: <871q6025ut.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Edward Liaw <edliaw@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Ensure _GNU_SOURCE is defined
In-Reply-To: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
References: <20240516-kselftest-fix-gnu-source-v1-1-e482ca6bfff7@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-2.75 / 50.00];
	BAYES_HAM(-2.45)[97.49%];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -2.75
X-Spam-Flag: NO

On Thu, 16 May 2024 17:27:33 +0200,
Mark Brown wrote:
> 
> The pcmtest driver tests use the kselftest harness which requires that
> _GNU_SOURCE is defined but nothing causes it to be defined.  Since the
> KHDR_INCLUDES Makefile variable has had the required define added let's
> use that, this should provide some futureproofing.
> 
> Fixes: daef47b89efd ("selftests: Compile kselftest headers with -D_GNU_SOURCE")
> Signed-off-by: Mark Brown <broonie@kernel.org>

The commit isn't yet in the Linus upstream tree but only in
linux-next.  I guess it's better to put the fix in the tree (Shuah's?)
that introduced this change.  So feel free to take my ack:

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

> ---
>  tools/testing/selftests/alsa/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 5af9ba8a4645..c1ce39874e2b 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  
> -CFLAGS += $(shell pkg-config --cflags alsa)
> +CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
>  LDLIBS += $(shell pkg-config --libs alsa)
>  ifeq ($(LDLIBS),)
>  LDLIBS += -lasound
> 
> ---
> base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
> change-id: 20240516-kselftest-fix-gnu-source-81ddd00870a8
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

