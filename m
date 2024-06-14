Return-Path: <linux-kselftest+bounces-11955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE903908EFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8551C24E4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35219CD0F;
	Fri, 14 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j/xGVcfI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+J8jYVC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j/xGVcfI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p+J8jYVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A81802CF;
	Fri, 14 Jun 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379419; cv=none; b=qoI4jGN46g9Kq1A9AKoy/b6TFwr2s14wcAcJhqq2W52r8UeqQngkY4vRIudIECptoexTximO6vgRy9lk0sGZQOaLVkVujAy2+XsQQ+L+VT5HO8aqpdizEbZGTPV2pK//zfBQ+5vVmUA7LTOLS12lDkteoiz0+w1mkmulA8e0zOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379419; c=relaxed/simple;
	bh=wqmTBb0yg2Iq2mWVJqKWGa3A/CsIyioF8Xc5PzN4kdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgls5zazS6rbbLGzo14piv4dx0s0pEPD8o/AstD67sGSlWuRm+vJehZ+K/m9iRtY6PfneSAkYRDwtemZnqDp8uRL5MZ0mpEvNzJNKXjajFvyS84DIZWH8NwIXjx65pQIlRjYi555z/yWFxpIwbu7uIKILYZ3b6WfwXJM3K7qRHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j/xGVcfI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+J8jYVC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j/xGVcfI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p+J8jYVC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 753562063F;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwfK0rqWgBsFgQ4ZXZWrRPfeKLni9Acfbte7VJx00kQ=;
	b=j/xGVcfIvkiRauLKT7pu1fbGpV+/YooHgmbM0O5lSM/z5pkkJInEz8Onk+Mfzjtswv7N1p
	d2dv+qBjh1x1V6BBtH9Lly50RU/Pi9LWehuXPmsJKPl1pUhsYQsYVuSNwjJBj17RDRizsi
	c9CnzpHQBMujXTL5jNiIDL3ROTDPHJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwfK0rqWgBsFgQ4ZXZWrRPfeKLni9Acfbte7VJx00kQ=;
	b=p+J8jYVCRyyu7dKkZdd25A6a4f4OYKzuWGB1BV9HU4LtnN4gVTj83mTpbxOSMa8asmpohG
	3p1/zIDM9SE0boBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="j/xGVcfI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p+J8jYVC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwfK0rqWgBsFgQ4ZXZWrRPfeKLni9Acfbte7VJx00kQ=;
	b=j/xGVcfIvkiRauLKT7pu1fbGpV+/YooHgmbM0O5lSM/z5pkkJInEz8Onk+Mfzjtswv7N1p
	d2dv+qBjh1x1V6BBtH9Lly50RU/Pi9LWehuXPmsJKPl1pUhsYQsYVuSNwjJBj17RDRizsi
	c9CnzpHQBMujXTL5jNiIDL3ROTDPHJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379416;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwfK0rqWgBsFgQ4ZXZWrRPfeKLni9Acfbte7VJx00kQ=;
	b=p+J8jYVCRyyu7dKkZdd25A6a4f4OYKzuWGB1BV9HU4LtnN4gVTj83mTpbxOSMa8asmpohG
	3p1/zIDM9SE0boBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47DC613AB1;
	Fri, 14 Jun 2024 15:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2M1dEJhjbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/6] kselftest/alsa: mixer-test: Skip write verification for volatile controls
Date: Fri, 14 Jun 2024 17:37:13 +0200
Message-ID: <20240614153717.30143-5-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
X-Rspamd-Queue-Id: 753562063F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The control elements with volatile flag don't guarantee that the
written values are actually saved for the next reads, hence we can't
verify the written values reliably.  Skip the verification after write
tests for those volatile controls for avoiding confusion.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/alsa/mixer-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..c98167818319 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -616,6 +616,10 @@ static int write_and_verify(struct ctl_data *ctl,
 	if (!snd_ctl_elem_info_is_readable(ctl->info))
 		return err;
 
+	/* Skip the verification for volatile controls, too */
+	if (snd_ctl_elem_info_is_volatile(ctl->info))
+		return err;
+
 	snd_ctl_elem_value_set_id(read_val, ctl->id);
 
 	err = snd_ctl_elem_read(ctl->card->handle, read_val);
-- 
2.43.0


