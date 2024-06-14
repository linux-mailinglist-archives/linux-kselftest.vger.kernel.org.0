Return-Path: <linux-kselftest+bounces-11956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C845908EFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A678B2B383
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39D719D065;
	Fri, 14 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Zf9/kL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="saCTgKZd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i5Zf9/kL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="saCTgKZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FF19B5A0;
	Fri, 14 Jun 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379419; cv=none; b=bAwx2uDIJSrW+3faZc42O/QLBIb14XTpz1ShmfuFZ2i8QpfNjAzD1AndSrb8Z1KCBK+WTFVUWCnsL+0+Jp6wHqKmTiDrmMulPrFdQ15NA9gkLgSADL2U5IMOb5m3r9jUzPiuyEZoFE/adLzVWTCEabbg4JGvyhN/4IUcs6lMKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379419; c=relaxed/simple;
	bh=oEXcl7uZTmrbBKkBkSJry3DmM9KI3mi9XsRAkK7VSb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTi7aEVEfGP+MoEFKLJYkrT+5vSF2MDBNFPMFyRLbM344j1sLMJofNSUIs0JwXNviwKAKQYxfpW4xzQYxhtqhydT7BSpIxcORPl6paOnk+wYrp+Akcy3Y64Z2nPzqgL6CcGCODtU2fVy7fGmtndr4eoas6wLx/RueGnBombagyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Zf9/kL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=saCTgKZd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i5Zf9/kL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=saCTgKZd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 433AF2063E;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKcSdFK/k+y9ps2EP7BQhMbyq7gYbxfGauuX6w+y5Us=;
	b=i5Zf9/kLjL3c+Pna/IcTlmTV1mJKbqg88tXdoh/dR+OCABE7cGM2nski9557GItgBF+vy5
	zItJbVZxtwkgz1nK7t7R8T/WpStgtwsiepcECIXgOuuiHzyYS/oeJcHgftc8HKmB/el4bx
	Sf1zeolWE4dOpRkI1Lba202IXXytvtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKcSdFK/k+y9ps2EP7BQhMbyq7gYbxfGauuX6w+y5Us=;
	b=saCTgKZd+gdF2FvG0Km1AmwkRXNhkEpOWueAL7p/lbBa4pv1MGaWVHXKoUrT29tJYVxglH
	Z1nI+6/uq/5t52Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="i5Zf9/kL";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=saCTgKZd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKcSdFK/k+y9ps2EP7BQhMbyq7gYbxfGauuX6w+y5Us=;
	b=i5Zf9/kLjL3c+Pna/IcTlmTV1mJKbqg88tXdoh/dR+OCABE7cGM2nski9557GItgBF+vy5
	zItJbVZxtwkgz1nK7t7R8T/WpStgtwsiepcECIXgOuuiHzyYS/oeJcHgftc8HKmB/el4bx
	Sf1zeolWE4dOpRkI1Lba202IXXytvtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vKcSdFK/k+y9ps2EP7BQhMbyq7gYbxfGauuX6w+y5Us=;
	b=saCTgKZd+gdF2FvG0Km1AmwkRXNhkEpOWueAL7p/lbBa4pv1MGaWVHXKoUrT29tJYVxglH
	Z1nI+6/uq/5t52Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CD8913AB5;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KHHnAZhjbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/6] ALSA: control: Apply sanity check of input values for user elements
Date: Fri, 14 Jun 2024 17:37:12 +0200
Message-ID: <20240614153717.30143-4-tiwai@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 433AF2063E
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Although we have already a mechanism for sanity checks of input values
for control writes, it's not applied unless the kconfig
CONFIG_SND_CTL_INPUT_VALIDATION is set due to the performance reason.
Nevertheless, it still makes sense to apply the check for user
elements despite of its cost, as that's the only way to filter out the
invalid values; the user controls are handled solely in ALSA core
code, and there is no corresponding driver, after all.

This patch enables the input value validation for user control
elements no matter whether CONFIG_SND_CTL_INPUT_VALIDATION is set or
not.  The kselftest will be happier with this change, as the incorrect
values will be bailed out now with errors.

For other normal controls, the check is applied still only when
CONFIG_SND_CTL_INPUT_VALIDATION is set.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index fb0c60044f7b..50890983d7e2 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1317,7 +1317,8 @@ static int snd_ctl_elem_write(struct snd_card *card, struct snd_ctl_file *file,
 	snd_ctl_build_ioff(&control->id, kctl, index_offset);
 	result = snd_power_ref_and_wait(card);
 	/* validate input values */
-	if (IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) && !result) {
+	if ((IS_ENABLED(CONFIG_SND_CTL_INPUT_VALIDATION) ||
+	     (vd->access & SNDRV_CTL_ELEM_ACCESS_USER)) && !result) {
 		struct snd_ctl_elem_info info;
 
 		memset(&info, 0, sizeof(info));
-- 
2.43.0


