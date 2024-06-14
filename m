Return-Path: <linux-kselftest+bounces-11940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B9908C05
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01351C2227F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F80199EB9;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qa2vuHKW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cEXAk6xn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qa2vuHKW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cEXAk6xn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB321990C7;
	Fri, 14 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369229; cv=none; b=hTAqVQyz0J36lRp4kuIw+7pc3CMqd6wOyxUcIGestnJSLrVrz6KrpIhXzGU/EiK9HXnUU0tC1J+LEE/EC3tKFuOTZCziVKB75Iarb91ZKAdsU+ZOipbKKXr7W6bZCpUmvponmc9gtHNL4Dt8wCQ6UVhKy9uxrKuRd93geJFS/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369229; c=relaxed/simple;
	bh=nc5RSxlJz/19yCGJlbD8cO5juxumVMtSIYyQzApOhgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNIcKEe0exeP6zQNtEVc3oAeb83F9O8WJOVzz0zby4iSt6p1hxrGFD5YFtDpH53mDne+KcUPo0qguw9q6Gxc4wauELQmiobIUoBnaEGrTF1Th39brHH+lIMp46ZIyQ9EHE9VbwneQm1QvexLmRCV0QI12yFn1DrHHUpuUfRqM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qa2vuHKW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cEXAk6xn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qa2vuHKW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cEXAk6xn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26EB5337FC;
	Fri, 14 Jun 2024 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fuGpBnMyoj+jvxlc8VWO7goEQAGNucd9xmvtJaLV3g=;
	b=qa2vuHKWVNKWPBxwm4u+/BR/uOira/pqbHAH01bdWJMX5ta3LYQSJrpZ44U7SCB3Qkt78z
	ZJkk7YisQw+TRcUhStKwYzW/1YDAxgQVu0i9lRXzc/2SPuE71ZsLl9+DIrebk+o0CAsJ1L
	ckVdvfq803T8KFvLPz8g+88rbcFd73k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fuGpBnMyoj+jvxlc8VWO7goEQAGNucd9xmvtJaLV3g=;
	b=cEXAk6xn/ty9K7uWj7kZs0Oq6zYOXgJTx3iuIMLqzpAzAl3u3Xn+I1VMApLAv6S2OpTA53
	RXCA2EvXSy6g9pDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fuGpBnMyoj+jvxlc8VWO7goEQAGNucd9xmvtJaLV3g=;
	b=qa2vuHKWVNKWPBxwm4u+/BR/uOira/pqbHAH01bdWJMX5ta3LYQSJrpZ44U7SCB3Qkt78z
	ZJkk7YisQw+TRcUhStKwYzW/1YDAxgQVu0i9lRXzc/2SPuE71ZsLl9+DIrebk+o0CAsJ1L
	ckVdvfq803T8KFvLPz8g+88rbcFd73k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fuGpBnMyoj+jvxlc8VWO7goEQAGNucd9xmvtJaLV3g=;
	b=cEXAk6xn/ty9K7uWj7kZs0Oq6zYOXgJTx3iuIMLqzpAzAl3u3Xn+I1VMApLAv6S2OpTA53
	RXCA2EvXSy6g9pDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE83213AB5;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WEsZOck7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:05 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] ALSA: control: Apply sanity check of input values for user elements
Date: Fri, 14 Jun 2024 14:47:25 +0200
Message-ID: <20240614124728.27901-4-tiwai@suse.de>
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


