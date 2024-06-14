Return-Path: <linux-kselftest+bounces-11957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1424F908EFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136AE1C2514B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130751802CF;
	Fri, 14 Jun 2024 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mHxKXWxI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KPecQxBO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mHxKXWxI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KPecQxBO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDD3B1AB;
	Fri, 14 Jun 2024 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379420; cv=none; b=L04h47PLo8BCbmsW/RzkpVSSnQG8qhPXoLxDU7iRZGTyipxtVucmaia/PhmdN+X1ba1jEqnlGhtNJcRZBXcfGFg0HcH6EkTQ3WlWN4HsS+CTp8wk3ocrLP8nKdUxHuMV0dZzbwoRqcuoh90totEJLC4QH2q/C9AIPQ/N2Y+cxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379420; c=relaxed/simple;
	bh=QeO5On+GiAI3IpqJmJUkztuf3OYNJlt8aK69Bq+/pkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qx5ahirZrS013tWDrJki4EcEqBlVKye9gnpOdHh/sxVn3QBzWB/KR+RvNBuBye6MB3iXo7ynKyAAKASusyQOCfPrWc8n6gd1/ieMiSfObhF1pshZnrO53WmAWthnFRQ4CuJR8bTaS3UWLZUizQYhYXODOeTU67aFifAGX7r1IQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mHxKXWxI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KPecQxBO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mHxKXWxI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KPecQxBO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB1DA2285C;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyjBY4cnsbHVbl3obsodL0KpjflriZ5NqAnoc6bhaTg=;
	b=mHxKXWxI+NO6gj9vEGod0VSsnrekrNXy1UdqDWWTwLNuhQgu5cvgvV8uZQZI15eHcZqGvv
	lyneKV9oIcQUs9CPxG0VSVMuW7vW7nILSLwvF1rcls+uv/A6QwkuU0I8uTdSp9hEhtsXO8
	CM7lME8Xn5HkoactmKzDN0/1cE3HwWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyjBY4cnsbHVbl3obsodL0KpjflriZ5NqAnoc6bhaTg=;
	b=KPecQxBOEvJg0NjOG+joiqYRVAnz0fTTQ8vd9sjxnRM4gbnOnbzRyugn4Y9M1iRcS+kyIS
	RvK5woz8vrqxtdCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyjBY4cnsbHVbl3obsodL0KpjflriZ5NqAnoc6bhaTg=;
	b=mHxKXWxI+NO6gj9vEGod0VSsnrekrNXy1UdqDWWTwLNuhQgu5cvgvV8uZQZI15eHcZqGvv
	lyneKV9oIcQUs9CPxG0VSVMuW7vW7nILSLwvF1rcls+uv/A6QwkuU0I8uTdSp9hEhtsXO8
	CM7lME8Xn5HkoactmKzDN0/1cE3HwWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyjBY4cnsbHVbl3obsodL0KpjflriZ5NqAnoc6bhaTg=;
	b=KPecQxBOEvJg0NjOG+joiqYRVAnz0fTTQ8vd9sjxnRM4gbnOnbzRyugn4Y9M1iRcS+kyIS
	RvK5woz8vrqxtdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C4B813AB5;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8E36HJhjbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/6] ALSA: chmap: Mark Channel Map controls as volatile
Date: Fri, 14 Jun 2024 17:37:14 +0200
Message-ID: <20240614153717.30143-6-tiwai@suse.de>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
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
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
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


