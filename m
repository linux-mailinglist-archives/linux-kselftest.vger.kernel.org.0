Return-Path: <linux-kselftest+bounces-11942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1829D908C07
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C3B1F27B1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB7519AA41;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YbJtHLmb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3fBFN86N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YbJtHLmb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3fBFN86N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F8D1991B9;
	Fri, 14 Jun 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369229; cv=none; b=daqyxbxkmB3yQaIGUvBcPX80ilS7B2Sbr8Ebg09kzIgSYBeZHNHyF0sm62FVBpDvfs01QO22zZkd7sSjszBE5++358JtACJ+TqdW7/UqZ7C1fMmKBtAaSZYKKliqaO17arDh42fMr/DBupXJSanWVR/YHUGop9uD+10PI56YPD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369229; c=relaxed/simple;
	bh=Li8Q86IIel7loElKpSiC0v7dZha9mHyE+pCjFUohhGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7ttRC+ZVPVqGvlOlsB7sA/RmSKF7wLIoNEH/gAXDbY0cBvLOn08rYNcXqgOFOsnrBS7d4jdGkOC5+QLZCigx/0F5JraAIsskyGQyOGcTLRPUQFR9rz+FLoCBv0IzL9h3Xwzg9LDC5eAbXcDDOL/1Gp/4disH4sN4gKDnfCASGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YbJtHLmb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3fBFN86N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YbJtHLmb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3fBFN86N; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94E55337FF;
	Fri, 14 Jun 2024 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4r40IoY07C6m91tyhR/8RkBDYdaql61WuR3SCynXHA=;
	b=YbJtHLmbDv4CQF344LO4c6xiLxAue42KV9IgE1rU/mIGg0BYo8uCASq0tSiaXBOdQBbl25
	DIc5p9qHaIbAqVIDwSi0qP5N985tOWBFYLtDEov3/sWWLnxTodiT+6GcIzbx5k+w2/zW6l
	wFC7DLSBERWhl51ryHkRm3eRFABhstE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4r40IoY07C6m91tyhR/8RkBDYdaql61WuR3SCynXHA=;
	b=3fBFN86Nhh9S8mS+Rij9A0V62HTV05N9Hli0sQtbCww6kEbHG3MO0a7FptBkZV42Pj7RZB
	F2obXZi4wW82mTDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4r40IoY07C6m91tyhR/8RkBDYdaql61WuR3SCynXHA=;
	b=YbJtHLmbDv4CQF344LO4c6xiLxAue42KV9IgE1rU/mIGg0BYo8uCASq0tSiaXBOdQBbl25
	DIc5p9qHaIbAqVIDwSi0qP5N985tOWBFYLtDEov3/sWWLnxTodiT+6GcIzbx5k+w2/zW6l
	wFC7DLSBERWhl51ryHkRm3eRFABhstE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4r40IoY07C6m91tyhR/8RkBDYdaql61WuR3SCynXHA=;
	b=3fBFN86Nhh9S8mS+Rij9A0V62HTV05N9Hli0sQtbCww6kEbHG3MO0a7FptBkZV42Pj7RZB
	F2obXZi4wW82mTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68BF213AB5;
	Fri, 14 Jun 2024 12:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yIZcGMo7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:06 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 5/5] ALSA: chmap: Mark Channel Map controls as volatile
Date: Fri, 14 Jun 2024 14:47:27 +0200
Message-ID: <20240614124728.27901-6-tiwai@suse.de>
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

The values returned from Playback Channel Map and Capture Channel Map
controls may vary dynamically depending on the corresponding PCM
stream.  Mark those as volatile to indicate the values are unstable
and not suitable for testing.

Note that we may change the driver to return -EINVAL, but this would
bring other side effects, such as "alsactl restore" would start
receiving unexpected errors.  So we still keep returning 0 for those
invalid inputs.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6f73b3c2c205..071c67cbc479 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2556,6 +2556,7 @@ int snd_pcm_add_chmap_ctls(struct snd_pcm *pcm, int stream,
 	struct snd_kcontrol_new knew = {
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE |
 			SNDRV_CTL_ELEM_ACCESS_TLV_READ |
 			SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK,
 		.info = pcm_chmap_ctl_info,
-- 
2.43.0


