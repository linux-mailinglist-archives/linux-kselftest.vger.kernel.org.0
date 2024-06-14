Return-Path: <linux-kselftest+bounces-11938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD18908C03
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3731F27AD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B7199E8C;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PgkvcUEP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CO0Ce26k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aiQR7ABp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f/ckpIf7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED86196D80;
	Fri, 14 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369229; cv=none; b=eGuvwCjPE60Yd9z18n0jGF6LNQqQCeo/VfWitcosOMkI2nrsznR+CGInT9f4q7x1Gp4Eq6XlcwYV2+6HDGGPeJYNzhmyF2+6nAg2OnJEfJaBzMgZGSY7GNMHS+z4Uq6gtlgYSWC3DyRG/HUthvKWyHwNVeauxV1KXgTqmUNpjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369229; c=relaxed/simple;
	bh=z5bY5N3g+5re4gRtj2iJY/pN+tinHZeFUELmpRx8904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv6pIC7oHp3uOTbs04PJFZtCUFV9bGx3EZ0ltbsNEvdzEUkWCPzX6EPdqILjs3EsxgKwk2ABEHKdyHLnkJw2THu1IP4o9O4qSPAEzQ5Sb0p0k3yzFuYveUIWH+FbfvUta7YZADmbzqzPNIJjUtXL6prdWdPxDxLk1Mcc7aTdNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PgkvcUEP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CO0Ce26k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aiQR7ABp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f/ckpIf7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9A30337FA;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9Qwt3lCVOFdtC2z4kfL60uM7ul27YPCg9xUdo77z/A=;
	b=PgkvcUEPnHOC3aAz2M+oTfAsqMxljICxe3RK0+8rmfQieATqSa4hgy3flNvX6aLZ4SVoDo
	/CfrwYOW0m5TMn64BJ/pBRdtBe5Q8ye4HhE3uxJ1Jlw94MqofxXGqKVvCKvl6az8xmymX2
	fCCrm0Qep7iZQSKda1xISqbQsC8jzso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9Qwt3lCVOFdtC2z4kfL60uM7ul27YPCg9xUdo77z/A=;
	b=CO0Ce26k+c7ZrEh1xuUjXhz69yju6Gim5gcNv8fAbFdj5VRAaPHVuznOBmVS8EPSHpa3ec
	rs7GMzNNXJvUQUDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9Qwt3lCVOFdtC2z4kfL60uM7ul27YPCg9xUdo77z/A=;
	b=aiQR7ABpChH0SrnE9XNQK19/bB9mtG98I1qkzTDe6pTMmIFKoDHz9YOs8bs4YolFhzjtv5
	u0r2Kyfa9D9533U5w6CdWQnA8uqerinjmanZuCGDc68kcbljIMKcMBFte8J6qlBYXpJSs6
	9FVglm5Ke7oAmhN9cpCjIQREIoM2WeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9Qwt3lCVOFdtC2z4kfL60uM7ul27YPCg9xUdo77z/A=;
	b=f/ckpIf7IVjmaqKWkIGzhp4hqylLjo8oArhFtUmDcgYxT2b8vRIKgOQW7Z3PpgBoL5n8Yk
	PmhSp9ZiVHE05hAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD41F13AB1;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PXfLMk7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:05 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] ALSA: hda: Return -EINVAL for invalid volume/switch inputs
Date: Fri, 14 Jun 2024 14:47:24 +0200
Message-ID: <20240614124728.27901-3-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614124728.27901-1-tiwai@suse.de>
References: <20240614124728.27901-1-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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

So far the HD-audio driver has been tolerant about the input values
and accepts any values by correcting the amp volume and switch values
internally.  But now our own selftest starts complaining about this
behavior, so let's be picky and change the behavior to return -EINVAL
for invalid input values instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
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


