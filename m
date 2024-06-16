Return-Path: <linux-kselftest+bounces-12019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315AA909C27
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12D9F1C20B92
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455B17E8E5;
	Sun, 16 Jun 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ShBVukf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N1PLYg+q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ShBVukf/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N1PLYg+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1A2941B;
	Sun, 16 Jun 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523279; cv=none; b=f5VO0WUwmHYG0TrPWJB4IDxOPYAzOaNI6ILY3VSqhBDfNBq3UEikUPlumtN6xiUT4bBCcrYumkj2GGH5TKAZqSh3QG4NLqO0ktg6zKpboGR7fW59vVd5tRHVPYsGOS0QnF4nO6vlkYB/sVKq7n3LoiwnHW6PQKR4FlrJoTFnNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523279; c=relaxed/simple;
	bh=SwaColnG8+NA5mzJiCzY2KsB18wTd7EwWwGioyjcJNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJj2TeeJGUWnwAsUTcI3k/oi7Q69mJ/S2H6qTZhiAyH3EibdKFN8+DBoUn3lz1jran/s0xQsh7jH5xxGZDncIftmbkBmMFLK6c9Qfu2lbteYIiPzD/kVmD+P73++vnNqtbi91/un9fRHFCGDN8pwt2oxNfytIlikIJTOhabXpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ShBVukf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N1PLYg+q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ShBVukf/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N1PLYg+q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 02E445CCBF;
	Sun, 16 Jun 2024 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvtarVlDPFvjlhozhdO7C2Qw7XUn6ZldtP0itrE1uEQ=;
	b=ShBVukf/DrtFSuQnpqxwp5hqAkta2efl2sN56Oa6sb6CWAouyeWf1qcD5XnT/5zY4IRPxV
	IMFmjNN3OuvACtFNLtrLXTsVLgKsv+ATZJV/yT9JDien3DemWlOXLbjVgTzBhzBu3/WV5h
	9lLoEM0Zb1GmHPlzqX2c5VTedtqmykk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvtarVlDPFvjlhozhdO7C2Qw7XUn6ZldtP0itrE1uEQ=;
	b=N1PLYg+qpL8XiaH7Pyv+dIsEO3H/Acoy8TrkUyzvrRxwyVm3e7UFbt0WBWCD8MUwIlzC4H
	05ooVgelFruP3tAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ShBVukf/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N1PLYg+q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvtarVlDPFvjlhozhdO7C2Qw7XUn6ZldtP0itrE1uEQ=;
	b=ShBVukf/DrtFSuQnpqxwp5hqAkta2efl2sN56Oa6sb6CWAouyeWf1qcD5XnT/5zY4IRPxV
	IMFmjNN3OuvACtFNLtrLXTsVLgKsv+ATZJV/yT9JDien3DemWlOXLbjVgTzBhzBu3/WV5h
	9lLoEM0Zb1GmHPlzqX2c5VTedtqmykk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvtarVlDPFvjlhozhdO7C2Qw7XUn6ZldtP0itrE1uEQ=;
	b=N1PLYg+qpL8XiaH7Pyv+dIsEO3H/Acoy8TrkUyzvrRxwyVm3e7UFbt0WBWCD8MUwIlzC4H
	05ooVgelFruP3tAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEF4E13AB9;
	Sun, 16 Jun 2024 07:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mI9GLYuVbmYVCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:34:35 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/6] ALSA: hda: Add input value sanity checks to HDMI channel map controls
Date: Sun, 16 Jun 2024 09:34:47 +0200
Message-ID: <20240616073454.16512-7-tiwai@suse.de>
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
X-Rspamd-Queue-Id: 02E445CCBF
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

Add a simple sanity check to HD-audio HDMI Channel Map controls.
Although the value might not be accepted for the actual connection, we
can filter out some bogus values beforehand, and that should be enough
for making kselftest happier.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdmi_chmap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index 5d8e1d944b0a..7b276047f85a 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -753,6 +753,20 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* a simple sanity check for input values to chmap kcontrol */
+static int chmap_value_check(struct hdac_chmap *hchmap,
+			     const struct snd_ctl_elem_value *ucontrol)
+{
+	int i;
+
+	for (i = 0; i < hchmap->channels_max; i++) {
+		if (ucontrol->value.integer.value[i] < 0 ||
+		    ucontrol->value.integer.value[i] > SNDRV_CHMAP_LAST)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -764,6 +778,10 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	unsigned char chmap[8], per_pin_chmap[8];
 	int i, err, ca, prepared = 0;
 
+	err = chmap_value_check(hchmap, ucontrol);
+	if (err < 0)
+		return err;
+
 	/* No monitor is connected in dyn_pcm_assign.
 	 * It's invalid to setup the chmap
 	 */
-- 
2.43.0


