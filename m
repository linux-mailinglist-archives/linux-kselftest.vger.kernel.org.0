Return-Path: <linux-kselftest+bounces-15193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45A94FD84
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 08:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B62B213D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01C36AFE;
	Tue, 13 Aug 2024 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yfonxd4A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FLaanZn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yfonxd4A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FLaanZn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06942374C;
	Tue, 13 Aug 2024 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723528935; cv=none; b=Eqb40expiSzc9MGf9Li8D2WKMWsAyL+jCGWfk/nmYLT2Sx5zN2Dw+yFth81Vh/ojY9KHlmaRRyzZvt6BuaN6+mtUsB3eAxls4+rYUxjapQ3ga06dWTj+omQ7X5KydGdqOts3T01zDmexAncOJz0htOyibwtX4V1gUzxgBwm0WV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723528935; c=relaxed/simple;
	bh=OjLN19HU3mLCsXhYlfdKT7dHHQUZUv/OjRXggZr1QsA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB2+pypdsKh7iHhCW11iACdnc0vs9C73x1NrXWyOPk0sEIhLTLbW2ggRkRcEautpJlcP/wahBh71e0O7EKDckBZv5fDp0YEJifxh3O1/AC1t5kipcGi/6afRagGtdQJ6wLBZLX92j9yGfUNXpX6FMiHK3WBcj5/iPtjpcKcgZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yfonxd4A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FLaanZn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yfonxd4A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FLaanZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5E312270A;
	Tue, 13 Aug 2024 06:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723528931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVkwWKxTSpRkPweEImYn5jNfhe+tzmk8OXzSLOoKwg=;
	b=yfonxd4AO6qRrG9eo8KSQB83I0rwb/ixXqcVyvDW9aAyJ7lJffFzz4kL07tcpjrzDMguP+
	pIO1tbRdEK+7g97fDeoe/tJmiG/8I0TiqPxFWaVK6KCuZHUMfBKw04SyHKfm1DqW/5OCVm
	anAlmcSnsKYNzEJEOXsF+bEAYg21Sq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723528931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVkwWKxTSpRkPweEImYn5jNfhe+tzmk8OXzSLOoKwg=;
	b=2FLaanZnIGDZKboPEcw0bPT0FsBmQhguEWH06OxnhxMNumCqP9gdHzoW6+DnxpNaIcXRYf
	7xMKNovBZx9DJKCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yfonxd4A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2FLaanZn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723528931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVkwWKxTSpRkPweEImYn5jNfhe+tzmk8OXzSLOoKwg=;
	b=yfonxd4AO6qRrG9eo8KSQB83I0rwb/ixXqcVyvDW9aAyJ7lJffFzz4kL07tcpjrzDMguP+
	pIO1tbRdEK+7g97fDeoe/tJmiG/8I0TiqPxFWaVK6KCuZHUMfBKw04SyHKfm1DqW/5OCVm
	anAlmcSnsKYNzEJEOXsF+bEAYg21Sq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723528931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYVkwWKxTSpRkPweEImYn5jNfhe+tzmk8OXzSLOoKwg=;
	b=2FLaanZnIGDZKboPEcw0bPT0FsBmQhguEWH06OxnhxMNumCqP9gdHzoW6+DnxpNaIcXRYf
	7xMKNovBZx9DJKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60F4013ABD;
	Tue, 13 Aug 2024 06:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3rMMFuP2umZvCgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 06:02:11 +0000
Date: Tue, 13 Aug 2024 08:02:51 +0200
Message-ID: <87ikw5c644.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr,
	aholzinger@gmx.de
Subject: Re: [PATCH v4 3/4] ALSA: timer: Introduce virtual userspace-driven timers
In-Reply-To: <20240811202337.48381-4-ivan.orlov0322@gmail.com>
References: <20240811202337.48381-1-ivan.orlov0322@gmail.com>
	<20240811202337.48381-4-ivan.orlov0322@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: B5E312270A
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,wanadoo.fr];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,lwn.net,kernel.org,vger.kernel.org,wanadoo.fr,gmx.de];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Sun, 11 Aug 2024 22:23:36 +0200,
Ivan Orlov wrote:
> +static int snd_utimer_ioctl_create(struct file *file,
> +				   struct snd_timer_uinfo __user *_utimer_info)
> +{
> +	struct snd_utimer *utimer;
> +	struct snd_timer_uinfo *utimer_info __free(kfree) = NULL;
> +	int err;
> +
> +	utimer_info = memdup_user(_utimer_info, sizeof(*utimer_info));
> +	if (IS_ERR(utimer_info))
> +		return PTR_ERR(no_free_ptr(utimer_info));
> +
> +	err = snd_utimer_create(utimer_info, &utimer);
> +	if (err < 0)
> +		return err;
> +
> +	utimer_info->id = utimer->id;
> +
> +	err = copy_to_user(_utimer_info, utimer_info, sizeof(*utimer_info));
> +	if (err) {
> +		snd_utimer_free(utimer);
> +		return -EFAULT;
> +	}
> +
> +	return anon_inode_getfd(utimer->name, &snd_utimer_fops, utimer, O_RDWR | O_CLOEXEC);

Wouldn't utimer be left unfreed if this returns an error?


thanks,

Takashi

