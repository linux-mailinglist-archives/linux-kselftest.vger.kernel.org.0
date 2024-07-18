Return-Path: <linux-kselftest+bounces-13884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C08934F67
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE324281C3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A40142E60;
	Thu, 18 Jul 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RZ1mL2MO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OaZegsP4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VJs4TWiB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gdGUfCbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0613D62E;
	Thu, 18 Jul 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314392; cv=none; b=qhcVTQ07U5h2csYl5U1OOqZpSUxjUzLel7h5yfXjgsqnKjVH5UIyHAgHyP/2H/PDJ8/oNNybT15wqZRZFIxK41RJpy75/J+AoZQqLSbO6sqoSGfngXnvzsYS/mS0Q9qua/RwNG5DTk88vfLEnpQRSzsSNdio5yZ71Kd60sDShAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314392; c=relaxed/simple;
	bh=82AS+Zf4CVHf1Vp9cEoNBDoDZNddG/48AXZ/c/Xq+eo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCCfxMRDgRKSCGTZjdu2EF6M4sbuIN369fkgsCbY2XvMDbc8dHDRokmsn0ppJYmFif7ElKDtepw7JKhqUi53kaAD6JS4+yJWR6mHBvFPAUdItLOiGwK8rVe49hFc3ImJRr73QOs8agNzT4OUaZ/IHeuVlTktPOfV/sppeVPFiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RZ1mL2MO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OaZegsP4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VJs4TWiB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gdGUfCbr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5776D21B09;
	Thu, 18 Jul 2024 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721314388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt1Kt4kEZPopJGh7fa66YbcOuxMjJWMWWaVrPr/IRrY=;
	b=RZ1mL2MO2LPuUXJYfLiCRtuq1w70IHUyIK+SwhuxCjFI4vvcdTs41vJKkVNTj09HeizsHv
	dJm3OAO8CSRlABUjuhjcHfIvzGq1CmsO57sr2Jf7kmpAq4nRkJEOPHQJoNnm9Gphy3iGbm
	4aFI0BqEJrmhhep0DlRpIatIr763xVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721314388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt1Kt4kEZPopJGh7fa66YbcOuxMjJWMWWaVrPr/IRrY=;
	b=OaZegsP462jZR3izfIF7VMnq6blF3gdSo/E/3B616AC0YGCdjTWI0GiTOKAbouhMeQ23WO
	BnkiW2Oy3nBcEDDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VJs4TWiB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gdGUfCbr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721314387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt1Kt4kEZPopJGh7fa66YbcOuxMjJWMWWaVrPr/IRrY=;
	b=VJs4TWiBKOShELnsPgO98gCqKihDNWBuGzs6GFWAlO+VDmV+78i/0DPSHJhm409RAq7q5+
	CKZGzNrnW2JJ1wHndyGWjeJcVQtavsvoWuhwqeCmKpz0lEmYT3rX90FPnuI9vtDvUG5csz
	VA7qaOuR0KlhWHDk43ZWl6/O1KmoL5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721314387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tt1Kt4kEZPopJGh7fa66YbcOuxMjJWMWWaVrPr/IRrY=;
	b=gdGUfCbrc3O4wPzc7JMbLLWp8Qo4RkEzyLP81E0TYsfBWxKhYVjqJOncvuHHt/16OGGZ2u
	QawsmEIn4Tc+90AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B9F9136F7;
	Thu, 18 Jul 2024 14:53:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BVuGAVMsmWaHIQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 14:53:07 +0000
Date: Thu, 18 Jul 2024 16:53:40 +0200
Message-ID: <87h6cmvjij.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kselftest/alsa: Diagnostic improvements
In-Reply-To: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
References: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 5776D21B09

On Tue, 16 Jul 2024 16:47:58 +0200,
Mark Brown wrote:
> 
> The first patch fixes unstable naming of tests due to probe ordering not
> being stable, the second just provides a bit more information.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Switch to using ID rather than longame.
> - Log the PCM ID too.
> - Link to v1: https://lore.kernel.org/r/20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org
> 
> ---
> Mark Brown (2):
>       kselftest/alsa: Use card name rather than number in test names
>       kselftest/alsa: Log the PCM ID in pcm-test

Applied both patches now.  Thanks!


Takashi

