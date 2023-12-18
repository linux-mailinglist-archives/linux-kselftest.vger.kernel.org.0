Return-Path: <linux-kselftest+bounces-2127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B698167DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 09:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9061C1F230AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9553F9E9;
	Mon, 18 Dec 2023 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FkuIEQ58";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V5FKqn0U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FkuIEQ58";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V5FKqn0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24267101C0;
	Mon, 18 Dec 2023 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1292E1FDD6;
	Mon, 18 Dec 2023 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702887341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpRAY0f2FAOPI4UWLjCI5IZOG6gRJlZ6RgjX2ZvWEhI=;
	b=FkuIEQ58Gcqx9jF37xIYYZMHewjruuMXV2Q6ZXugFw6x/r5MNXnldJu1DeNQqqa0IWqEgY
	lqtc4Ira25yaJhd0oMG8QUGvRUszY9L5ycxmPQBJ8vMgF3Ph96CmsItJsK03X2UpwcQPLs
	J/OmFJnuRgombHJjLH/KSsy/5NBbPyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702887341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpRAY0f2FAOPI4UWLjCI5IZOG6gRJlZ6RgjX2ZvWEhI=;
	b=V5FKqn0U5561j1AUndhAQnPAUm6nfyrS9PYCSbVtMGS+je1UhGz5KSkIPPM5j4gInV02Le
	iRcrLgk9vFvVMSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702887341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpRAY0f2FAOPI4UWLjCI5IZOG6gRJlZ6RgjX2ZvWEhI=;
	b=FkuIEQ58Gcqx9jF37xIYYZMHewjruuMXV2Q6ZXugFw6x/r5MNXnldJu1DeNQqqa0IWqEgY
	lqtc4Ira25yaJhd0oMG8QUGvRUszY9L5ycxmPQBJ8vMgF3Ph96CmsItJsK03X2UpwcQPLs
	J/OmFJnuRgombHJjLH/KSsy/5NBbPyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702887341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bpRAY0f2FAOPI4UWLjCI5IZOG6gRJlZ6RgjX2ZvWEhI=;
	b=V5FKqn0U5561j1AUndhAQnPAUm6nfyrS9PYCSbVtMGS+je1UhGz5KSkIPPM5j4gInV02Le
	iRcrLgk9vFvVMSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFE7613454;
	Mon, 18 Dec 2023 08:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pKPILKz/f2UzYQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 18 Dec 2023 08:15:40 +0000
Date: Mon, 18 Dec 2023 09:15:40 +0100
Message-ID: <87edfkylhv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: alsa: fixed a print formatting warning
In-Reply-To: <20231217080019.1063476-1-ghanshyam1898@gmail.com>
References: <20231217080019.1063476-1-ghanshyam1898@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FkuIEQ58;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V5FKqn0U
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.28)[89.86%]
X-Spam-Score: -2.79
X-Rspamd-Queue-Id: 1292E1FDD6
X-Spam-Flag: NO

On Sun, 17 Dec 2023 09:00:19 +0100,
Ghanshyam Agrawal wrote:
> 
> A statement used %d print formatter where %s should have
> been used. The same has been fixed in this commit.
> 
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>

Thanks, applied now.


Takashi

