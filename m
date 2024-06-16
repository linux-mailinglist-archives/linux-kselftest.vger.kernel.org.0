Return-Path: <linux-kselftest+bounces-12015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C22909C24
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A551F224D4
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0B17C9F6;
	Sun, 16 Jun 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zp0o5oA/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zqMzCaWQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zp0o5oA/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zqMzCaWQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18A178CDF;
	Sun, 16 Jun 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523278; cv=none; b=mb5iL94qKIvwd9PTQn2qqDDbWFvaD4mkxdzzVXwSD4APiVfOtMsi/tdKpHu0kFvSzWJ3OUMIWMhAyvip813Em28V0hM857c9UwKxM8BRvM3ihlvds7www2zkqTcGXdI75M3FsjvyXjmawlp9uOt+moJISbTyK/KkuA1vun8e3WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523278; c=relaxed/simple;
	bh=jhHFFFxw+TQY8tMMgflq+/MItjuQAQ7L4GPqyFiQCSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYVrjRdH9pISwJQjxkdfmHPuspQUkVGQNdX/I07mIm3S3FWxzpPJZyfQzsFcyPeKQ8N3hXUeVL1ErpBsbPkHjb+eb2mm3FXGHolXOMVyKcVkShNpmUt+CeKhsFCZX9SlZxuoyyAA3ZY/Mog+Kd3+oyJgwAmMivqx/SWtDNa+Q2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zp0o5oA/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zqMzCaWQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zp0o5oA/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zqMzCaWQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 057EA3506C;
	Sun, 16 Jun 2024 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/949HUx6nZDACgffMOe488Rg+F1Zwk2M5jAJ2WOsB34=;
	b=zp0o5oA/J1jraVXKAb5sM319KV8YKvN7cIiUu6yPw932Ro/hDm4u2kmvOX+/cEwmBsL2x+
	NWAp61Zlp05tDUGcaeaIwb/wS4imaKs1e7xYYit6OS2pWXy28jKj9ATuUoODsU5aGkJzHc
	7NtciDoUcIdxWIZtZeu5c4+wA0FweCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/949HUx6nZDACgffMOe488Rg+F1Zwk2M5jAJ2WOsB34=;
	b=zqMzCaWQEet7xwuaMmVJI93d9m7yAEbw0g/WEANx+I4HDLS8q7FUSUF+JZoExAg4Vk9LV0
	qQB26g+Le6gJ9JAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zp0o5oA/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zqMzCaWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/949HUx6nZDACgffMOe488Rg+F1Zwk2M5jAJ2WOsB34=;
	b=zp0o5oA/J1jraVXKAb5sM319KV8YKvN7cIiUu6yPw932Ro/hDm4u2kmvOX+/cEwmBsL2x+
	NWAp61Zlp05tDUGcaeaIwb/wS4imaKs1e7xYYit6OS2pWXy28jKj9ATuUoODsU5aGkJzHc
	7NtciDoUcIdxWIZtZeu5c4+wA0FweCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/949HUx6nZDACgffMOe488Rg+F1Zwk2M5jAJ2WOsB34=;
	b=zqMzCaWQEet7xwuaMmVJI93d9m7yAEbw0g/WEANx+I4HDLS8q7FUSUF+JZoExAg4Vk9LV0
	qQB26g+Le6gJ9JAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC86013AB9;
	Sun, 16 Jun 2024 07:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0IDDLIqVbmYVCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:34:34 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/6] ALSA: hda: Return -EINVAL for invalid volume/switch inputs
Date: Sun, 16 Jun 2024 09:34:43 +0200
Message-ID: <20240616073454.16512-3-tiwai@suse.de>
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
X-Rspamd-Queue-Id: 057EA3506C
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

So far the HD-audio driver has been tolerant about the input values
and accepts any values by correcting the amp volume and switch values
internally.  But now our own selftest starts complaining about this
behavior, so let's be picky and change the behavior to return -EINVAL
for invalid input values instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 325e8f0b99a8..3dd1bda0c5c6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1496,7 +1496,7 @@ update_amp_value(struct hda_codec *codec, hda_nid_t nid,
 	/* ofs = 0: raw max value */
 	maxval = get_amp_max_value(codec, nid, dir, 0);
 	if (val > maxval)
-		val = maxval;
+		return -EINVAL;
 	return snd_hda_codec_amp_update(codec, nid, ch, dir, idx,
 					HDA_AMP_VOLMASK, val);
 }
@@ -1547,13 +1547,21 @@ int snd_hda_mixer_amp_volume_put(struct snd_kcontrol *kcontrol,
 	unsigned int ofs = get_amp_offset(kcontrol);
 	long *valp = ucontrol->value.integer.value;
 	int change = 0;
+	int err;
 
 	if (chs & 1) {
-		change = update_amp_value(codec, nid, 0, dir, idx, ofs, *valp);
+		err = update_amp_value(codec, nid, 0, dir, idx, ofs, *valp);
+		if (err < 0)
+			return err;
+		change |= err;
 		valp++;
 	}
-	if (chs & 2)
-		change |= update_amp_value(codec, nid, 1, dir, idx, ofs, *valp);
+	if (chs & 2) {
+		err = update_amp_value(codec, nid, 1, dir, idx, ofs, *valp);
+		if (err < 0)
+			return err;
+		change |= err;
+	}
 	return change;
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_put);
@@ -2149,15 +2157,20 @@ int snd_hda_mixer_amp_switch_put(struct snd_kcontrol *kcontrol,
 	int change = 0;
 
 	if (chs & 1) {
+		if (*valp < 0 || *valp > 1)
+			return -EINVAL;
 		change = snd_hda_codec_amp_update(codec, nid, 0, dir, idx,
 						  HDA_AMP_MUTE,
 						  *valp ? 0 : HDA_AMP_MUTE);
 		valp++;
 	}
-	if (chs & 2)
+	if (chs & 2) {
+		if (*valp < 0 || *valp > 1)
+			return -EINVAL;
 		change |= snd_hda_codec_amp_update(codec, nid, 1, dir, idx,
 						   HDA_AMP_MUTE,
 						   *valp ? 0 : HDA_AMP_MUTE);
+	}
 	hda_call_check_power_status(codec, nid);
 	return change;
 }
-- 
2.43.0


