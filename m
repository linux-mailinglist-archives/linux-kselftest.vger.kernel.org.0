Return-Path: <linux-kselftest+bounces-11939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB99908C04
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF55D1C227B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64236199E90;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0ByNGzr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bEC7lQES";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A0ByNGzr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bEC7lQES"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4519645D;
	Fri, 14 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369229; cv=none; b=oyBkeey65C89eeE6KhbEqo4eueQCFPpn9Qas9I2VCqePL/DzV7rk2W3tb0wG12LJRHvuEsbG4INpMl6WcOuBW/jB8lfKZ+yvmXLlPsNkrns3KMHBXo6GfoHyq8f/c4ASRlCWavISe6t9MyQ1XGHZ0A1rQ56+mh6GO3k0OM1Eblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369229; c=relaxed/simple;
	bh=MeJrCVvMIPktTSQH7Hu/dNYm3TzDEwvq64XMzLn9hVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cxb3aNoQk6S09qOOResTrCDESU4ni0FepcflYGxNTaQj0sp/LwnoxslmaZ5cWXinAKyfpMAkEDBc0WsHr/dctxg2neGJTBjhxq85JmZrXf6ozG2t6fMX+LqjDVyeDZuq/JdKTYwlPuWxnPnknvoopMqGWX8tH9AIBA2Un+ltU0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0ByNGzr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bEC7lQES; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A0ByNGzr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bEC7lQES; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B6FAE204C9;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3rD0UBBiB4fwDr7WCsD3zCQa/HdNNWqxiGafHFqAQo=;
	b=A0ByNGzrwVfJq8ys03b52yPyIheQhYSXR8EIXnp6/1UJR/UqnulSZTUWlNJgc80Ybcv9hz
	yNmFRWnD5t2eH1oehEtmGmS2j+VFVJNgMk+9Ws+Zw9XKd4vFC2Nu/ueHVDzIsx2sHXX4Nn
	u8r5CXdDj5a1qDqz29uBXe6Mq2pEQto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3rD0UBBiB4fwDr7WCsD3zCQa/HdNNWqxiGafHFqAQo=;
	b=bEC7lQESGafuXnnMfL/JdATdh6EuyOvQl2FowLY0DBpNR7Yyt8KpWT3QeUEm8Tx5EJiIo1
	rfVkPOBZ+Pfbf8BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A0ByNGzr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bEC7lQES
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3rD0UBBiB4fwDr7WCsD3zCQa/HdNNWqxiGafHFqAQo=;
	b=A0ByNGzrwVfJq8ys03b52yPyIheQhYSXR8EIXnp6/1UJR/UqnulSZTUWlNJgc80Ybcv9hz
	yNmFRWnD5t2eH1oehEtmGmS2j+VFVJNgMk+9Ws+Zw9XKd4vFC2Nu/ueHVDzIsx2sHXX4Nn
	u8r5CXdDj5a1qDqz29uBXe6Mq2pEQto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3rD0UBBiB4fwDr7WCsD3zCQa/HdNNWqxiGafHFqAQo=;
	b=bEC7lQESGafuXnnMfL/JdATdh6EuyOvQl2FowLY0DBpNR7Yyt8KpWT3QeUEm8Tx5EJiIo1
	rfVkPOBZ+Pfbf8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86E4913AB5;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EDjPH8k7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:05 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] ALSA: vmaster: Return error for invalid input values
Date: Fri, 14 Jun 2024 14:47:23 +0200
Message-ID: <20240614124728.27901-2-tiwai@suse.de>
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
X-Spamd-Result: default: False [-2.96 / 50.00];
	BAYES_HAM(-2.95)[99.79%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B6FAE204C9
X-Spam-Flag: NO
X-Spam-Score: -2.96
X-Spam-Level: 

So far the vmaster code has been tolerant about the input values and
accepts any values by correcting internally.  But now our own selftest
starts complaining about this behavior, so let's be picky and change
the behavior to return -EINVAL for invalid input values instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
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


