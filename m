Return-Path: <linux-kselftest+bounces-11954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8829908EF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0EB28929C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498519CCFC;
	Fri, 14 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PY7c0Fuh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVaQyxYg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PY7c0Fuh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVaQyxYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F303319ADBE;
	Fri, 14 Jun 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379419; cv=none; b=XKJlEhjfr1RrR1nu/kg2HF0wdW++7Pw+Jm11bO4GxNTq7th7oDML6GBsaR63aNYfhk5u+LYQ45jRCE+WoxfPYSAvH2iz8czSMpGAFpfg4ZzEAXS/aDLxsEY962OxKi2UvsJ+300ZcffLGTiyxKgy+Vqr0ibmxIZD2EDzbZXk5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379419; c=relaxed/simple;
	bh=w/IWp6nSo64sVIfX4UwPn3vOfavqx0Ypo3pzKZ2Tr1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY/stt9VwMUeVTWQaneeWhjimbn2eoFm8Jx6b1lLSXfoSocYEGLQZ67Cpm3zGuyo/CardxgYpSQhb1edpMsszqT1mBEtqtDuN0zW/dEsWC2F9vdttr6KccU68MgtbxxuchC8fLV5p+P4z9DpVwbGSLfk6T1gvzkEq6feSq2YbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PY7c0Fuh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVaQyxYg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PY7c0Fuh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVaQyxYg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C713D2063D;
	Fri, 14 Jun 2024 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=PY7c0Fuh8G29cw7GcwsqJANWQ2DTrOJ0PgE+blvzxjEZookki8CVSBmHN5pCFMmz40bjUf
	EPhBv9+XHefyDrXPR33FGhZU/D3pl2ehdJHJksmGdTLBs5IfVeE63gDKDvAR6iCe9P5YbJ
	sxdVUzEot6t27iflsLCFU5fDM3KC/wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=UVaQyxYgaiQIZJXp4zeILPJPpgx5evXZ/Ep/GHuOs8zNf0Ic4ntjparpkL5t4K8eYX3Ei7
	YX/XW0q7/It9w5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=PY7c0Fuh8G29cw7GcwsqJANWQ2DTrOJ0PgE+blvzxjEZookki8CVSBmHN5pCFMmz40bjUf
	EPhBv9+XHefyDrXPR33FGhZU/D3pl2ehdJHJksmGdTLBs5IfVeE63gDKDvAR6iCe9P5YbJ
	sxdVUzEot6t27iflsLCFU5fDM3KC/wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=UVaQyxYgaiQIZJXp4zeILPJPpgx5evXZ/Ep/GHuOs8zNf0Ic4ntjparpkL5t4K8eYX3Ei7
	YX/XW0q7/It9w5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A15913AB5;
	Fri, 14 Jun 2024 15:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAcmJJdjbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:55 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/6] ALSA: vmaster: Return error for invalid input values
Date: Fri, 14 Jun 2024 17:37:10 +0200
Message-ID: <20240614153717.30143-2-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614153717.30143-1-tiwai@suse.de>
References: <20240614153717.30143-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

So far the vmaster code has been tolerant about the input values and
accepts any values by correcting internally.  But now our own selftest
starts complaining about this behavior, so let's be picky and change
the behavior to return -EINVAL for invalid input values instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/vmaster.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 04a57f7be6ea..c657659b236c 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -198,6 +198,12 @@ static int follower_put(struct snd_kcontrol *kcontrol,
 	err = follower_init(follower);
 	if (err < 0)
 		return err;
+	for (ch = 0; ch < follower->info.count; ch++) {
+		if (ucontrol->value.integer.value[ch] < follower->info.min_val ||
+		    ucontrol->value.integer.value[ch] > follower->info.max_val)
+			return -EINVAL;
+	}
+
 	for (ch = 0; ch < follower->info.count; ch++) {
 		if (follower->vals[ch] != ucontrol->value.integer.value[ch]) {
 			changed = 1;
@@ -365,6 +371,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
 	new_val = ucontrol->value.integer.value[0];
 	if (new_val == old_val)
 		return 0;
+	if (new_val < master->info.min_val || new_val > master->info.max_val)
+		return -EINVAL;
 
 	err = sync_followers(master, old_val, new_val);
 	if (err < 0)
-- 
2.43.0


