Return-Path: <linux-kselftest+bounces-11958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67838908F48
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17120B2C700
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B419D093;
	Fri, 14 Jun 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ppk1Gk2J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NBg+3l6r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ppk1Gk2J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NBg+3l6r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18251802DF;
	Fri, 14 Jun 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379420; cv=none; b=lNp3GxWaXVRUbdnjOBsk8jRU0sLDEcRYctT/d8+qzyvAwz2Scvce/p2nSEUMpHisAQHsuxyldOrOV1FRTXi8hwiYWeX2W37ChyyYTsjzrbTdMuMQRnSS/lcAYpWf1acsrA4UfM72ulPIq1shZKcXhzx3QDnpKi6HK0NySu47JeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379420; c=relaxed/simple;
	bh=HhL3CaW8fEJwIYD0X/S93jOWGJe5uzjDmfpNmThwKIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMOeCvuq/n6zg8+mL7eTVT6PA8Ua9sYRAdjUN07FEUDfJuUpvmM7lSHa5QYLLelSaits5nmuSbpXJGZUbCtp03HZqmgGbJJUobpIXUnfVd7G+E+o0nlNmW+Cd4g7nE1GpO5SKSOfXdy4s2KupvwFUAF5mldEFBamU/+ZIstE2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ppk1Gk2J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NBg+3l6r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ppk1Gk2J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NBg+3l6r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD8222286A;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi/3TisUivZiOUMMz1zWLCaPn56nPEUqT+yVdSj12tM=;
	b=Ppk1Gk2JDuZZv2+2XVO7fI2FePwfCsLgKAmrTeqUEhD7bXIYl77oNlfv1UE4VOLVQxjlSW
	uu+3cAkpeonGvFq2f5nQ3a3sc4kqgh751885Ijij1LMtIieJu2EU39chn1bi2yfiMoAs6J
	J0baHIUmdL5K4IxhAU/IYM8lfBVEYVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi/3TisUivZiOUMMz1zWLCaPn56nPEUqT+yVdSj12tM=;
	b=NBg+3l6rVN2pqHl7OCY3cGjCRS4n7+0vRGJwVcbNhy+pA/vtcAKvgBJ75XK4hrVm+t/NwL
	lPgIgJWfdkGsRlDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi/3TisUivZiOUMMz1zWLCaPn56nPEUqT+yVdSj12tM=;
	b=Ppk1Gk2JDuZZv2+2XVO7fI2FePwfCsLgKAmrTeqUEhD7bXIYl77oNlfv1UE4VOLVQxjlSW
	uu+3cAkpeonGvFq2f5nQ3a3sc4kqgh751885Ijij1LMtIieJu2EU39chn1bi2yfiMoAs6J
	J0baHIUmdL5K4IxhAU/IYM8lfBVEYVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wi/3TisUivZiOUMMz1zWLCaPn56nPEUqT+yVdSj12tM=;
	b=NBg+3l6rVN2pqHl7OCY3cGjCRS4n7+0vRGJwVcbNhy+pA/vtcAKvgBJ75XK4hrVm+t/NwL
	lPgIgJWfdkGsRlDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFE1713AB1;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4JzCKZhjbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 6/6] ALSA: hda: Add input value sanity checks to HDMI channel map controls
Date: Fri, 14 Jun 2024 17:37:15 +0200
Message-ID: <20240614153717.30143-7-tiwai@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Add a simple sanity check to HD-audio HDMI Channel Map controls.
Although the value might not be accepted for the actual connection, we
can filter out some bogus values beforehand, and that should be enough
for making kselftest happier.

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


