Return-Path: <linux-kselftest+bounces-22474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279349D6D3A
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 10:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC08161936
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D74154BE3;
	Sun, 24 Nov 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GphnfVxO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dX8shJI6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J0R43e2h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V0FKBugA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862D136E;
	Sun, 24 Nov 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732440689; cv=none; b=LV4erlO/XdmEjZ4ruknLB+nU50OxvRULEnBrG4A4vFVsgrlwnuE1C34KumDJpk8+O05ub2aPIL7AKsKdQt+IM3l7nAls0hUFC3Vb/oOm6WG/4zLYfU+zfVz3pOcPo0JCGfMB/nRC7zEAxQp3iQj5mnORkVqaZ6FUXZ6RMVVGBnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732440689; c=relaxed/simple;
	bh=YPqilw9yYd2GmOANvWfHeInm06ngBxI3LRBTko32h4U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yelnk+n746vfq4rc/8ytsOgcipHRSIya/ER+2W+J6JFIQpXYPdDpD4DpbBIFFSJzPdgLwfyCzzGGPQY1FD4OXtBCZOmbL0ae11u/FKa0gllU5erxJRzbgyyhBKXrzMRaNLXrPuVLKuNxo1KnWCagU92RkeBSV8nxlhNKv5AO4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GphnfVxO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dX8shJI6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J0R43e2h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V0FKBugA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC1041F38C;
	Sun, 24 Nov 2024 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732440686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od8IB9awbZbStuZfgilDp1scLZOCSBcZ87FDMrb9G4Q=;
	b=GphnfVxOSqQc9NWcRsOKurTCaYUiUDuH3jRwS2pabgqHBqFZKvCCvObzuF3bSB7Ihg4+Gq
	JhKixjP1/10b09H2iUzOFOpXkMzaJhrSrFP219kTDlWwv5Xh+n02lYgj7ubzY5TQWfv02v
	vh9rwNhRLGVWGaxomtVfDz7+3uUPPns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732440686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od8IB9awbZbStuZfgilDp1scLZOCSBcZ87FDMrb9G4Q=;
	b=dX8shJI67B/S6PRNXSQMKZ6U13dSUihwb7wsZZrsYssCTQ+cOZPqDv+7StcHTUpjwn+woQ
	h6JqaCQgsSYiCXAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J0R43e2h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V0FKBugA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732440685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od8IB9awbZbStuZfgilDp1scLZOCSBcZ87FDMrb9G4Q=;
	b=J0R43e2hV5eLivPbyEDpkbckyan2RMfhF3G7UfaFQW8IqELnnDjWxK6sMPwOiUEGGPXUV0
	qjYE+bJowDRqSwQKnQpQjQueVBfC82Pw+qHTrtGt2jVyiMG1J24qu7GPji6JWglBS+3kWx
	KE3KvoE/CLmUO+jNEnTJc131IhN2lIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732440685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=od8IB9awbZbStuZfgilDp1scLZOCSBcZ87FDMrb9G4Q=;
	b=V0FKBugAm7Hw9F7YdQ9v9ffFSYIWgWpFjeRiXzbaR6iYMDpPycn0DuGEPyx/TZczCZ0zZ8
	UF2Vz5V/8EHqroCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9041413676;
	Sun, 24 Nov 2024 09:31:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLu8IW3yQmc6dgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 24 Nov 2024 09:31:25 +0000
Date: Sun, 24 Nov 2024 10:31:25 +0100
Message-ID: <87serhyo42.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH for-next v3] selftests/alsa: Add a few missing gitignore files
In-Reply-To: <20241122073600.1530791-1-lizhijian@fujitsu.com>
References: <20241122073600.1530791-1-lizhijian@fujitsu.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: CC1041F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 22 Nov 2024 08:36:00 +0100,
Li Zhijian wrote:
> 
> Compiled binary files should be added to .gitignore
> 
> 'git status' complains:
> Untracked files:
> (use "git add <file>..." to include in what will be committed)
>      alsa/global-timer
>      alsa/utimer-test
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Thanks, applied now.


Takashi

