Return-Path: <linux-kselftest+bounces-12014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F226F909C23
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0DE1F223CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB117B41E;
	Sun, 16 Jun 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hCL1xJR+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bGb5lDpM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hCL1xJR+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bGb5lDpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567B178CC9;
	Sun, 16 Jun 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523278; cv=none; b=tv+f80D8bldeQ3xubnPjwkBrlg/DWaFYZH3MPBr5IcM4d8/+juBCVDGv2ei6dW0gFo2G4+oGyW01iUj5Na9YNwVW9o2i+WXb5Z6e1m6QF+LFlacwScix7Lv4dbcgpU0NC4bwuerj0MJgh2yADpQa26EkPgfnT6WnNvlrcv9KS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523278; c=relaxed/simple;
	bh=w/IWp6nSo64sVIfX4UwPn3vOfavqx0Ypo3pzKZ2Tr1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8LpzsslfyurP8Kj1NOGrEks2gNqg3Q3EPeZ7R2TvevwraOnlfiauQD+uMvrF8+K74GtNbA7k1111yPnnz1gX1ZsYOQLQW/oa33Qov4JvnB6hAN852Tw5IXwIRu4uyVCykV9YS0J2EdAc0Y1o9xRChNfonWX87vOL/dDvzDO8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hCL1xJR+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bGb5lDpM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hCL1xJR+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bGb5lDpM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8DF85CCBE;
	Sun, 16 Jun 2024 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=hCL1xJR+2Lxf91hfbj7fNsyePUh9XOOY++dMoAXFJWiIIYbTr7nWUWGedw4N2a4pF8psDv
	KY6KzNoiCMs0OZpAKpWR92nwAKewzwgkHgYQdmkvrYjeDGe/DZ5HyytZuKGhjT1ziadDYL
	ESaMjsthvy/Gj1WUZfYPR+CJ/9I/jGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=bGb5lDpMHGuLoDLr4a9IX/L5E/14+AyTqnTsRAY0KsR1rTy6A/3yocV7xR8jTfs+9XfNoq
	AgveAjALZifXvLBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hCL1xJR+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bGb5lDpM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=hCL1xJR+2Lxf91hfbj7fNsyePUh9XOOY++dMoAXFJWiIIYbTr7nWUWGedw4N2a4pF8psDv
	KY6KzNoiCMs0OZpAKpWR92nwAKewzwgkHgYQdmkvrYjeDGe/DZ5HyytZuKGhjT1ziadDYL
	ESaMjsthvy/Gj1WUZfYPR+CJ/9I/jGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEwFJHDU5Fva9mbGeUjJ0f/3QZ/OGfA9VGgdBIwLBCE=;
	b=bGb5lDpMHGuLoDLr4a9IX/L5E/14+AyTqnTsRAY0KsR1rTy6A/3yocV7xR8jTfs+9XfNoq
	AgveAjALZifXvLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BB0F13ABC;
	Sun, 16 Jun 2024 07:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AFPWHIqVbmYVCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:34:34 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/6] ALSA: vmaster: Return error for invalid input values
Date: Sun, 16 Jun 2024 09:34:42 +0200
Message-ID: <20240616073454.16512-2-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616073454.16512-1-tiwai@suse.de>
References: <20240616073454.16512-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B8DF85CCBE
X-Spam-Flag: NO
X-Spam-Score: -5.01
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


