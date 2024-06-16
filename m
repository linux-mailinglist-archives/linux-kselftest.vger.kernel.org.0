Return-Path: <linux-kselftest+bounces-12016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CE0909C25
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06371C209ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A6178CC9;
	Sun, 16 Jun 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sB2rkaLY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c5DagRJ4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sB2rkaLY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="c5DagRJ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D02178CF2;
	Sun, 16 Jun 2024 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523278; cv=none; b=jFSiaD5LXWe/y/0tp0ht7ebdr7w+Udood2RAvSOprBX/RyWMIHRNxDpVi4O28QvppwuKKMxBHsBJt2UHDQlk5g/B9kFPa+033CbZRWq13izSk/wmYCIEFW2xeeTRbv95LricM0a2KN6AUsR1w5dxOu0ZXCodS262Lf7l0ZIMfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523278; c=relaxed/simple;
	bh=/Ce9566tcfILguU+BY2r/o1lpX2zpSDiCC5gijAJWTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hi0xug2PeDtyppMFC6OlWvNdunDbWYDJmruPqOpbDDcPrufFKECfVaCn6SRbpjB1I2k++murkujiIIO6OPYJsyMCqEFBGgi8SqXDWej3OfhyCHKaK7mQospSgkBDbEeKosRhL92JFyYQvaDaQVe7VnP0o7bnuIk1y3m1DEl65vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sB2rkaLY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c5DagRJ4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sB2rkaLY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=c5DagRJ4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79DB53506E;
	Sun, 16 Jun 2024 07:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtF003mZ1kzJMjnRxlwrBp4/g6dHssdJYK/M17rTu0=;
	b=sB2rkaLY04mCX6/SHUIvhmQuhYnpKf6fQSXRwffSD9nujLhHExvGalxrhf6UkcpYcBsliG
	WPk6guMevi8KWjfXE6EzfSVUhVnHW1zMtNmYeAoqIeehrX78D559hPnPtBIdw8AnO+NqEO
	5yehNSlWGk8UfOgOI7eHFqeZ5ukLYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtF003mZ1kzJMjnRxlwrBp4/g6dHssdJYK/M17rTu0=;
	b=c5DagRJ4wiSUQmdZgOx1ATTCIR3xJ1wBgWwSmgmr0YC0e8i9Q9wwm3oFKZZ2p17tk1TG9Z
	CKqGd6tlT7KQheAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sB2rkaLY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=c5DagRJ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtF003mZ1kzJMjnRxlwrBp4/g6dHssdJYK/M17rTu0=;
	b=sB2rkaLY04mCX6/SHUIvhmQuhYnpKf6fQSXRwffSD9nujLhHExvGalxrhf6UkcpYcBsliG
	WPk6guMevi8KWjfXE6EzfSVUhVnHW1zMtNmYeAoqIeehrX78D559hPnPtBIdw8AnO+NqEO
	5yehNSlWGk8UfOgOI7eHFqeZ5ukLYiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wtF003mZ1kzJMjnRxlwrBp4/g6dHssdJYK/M17rTu0=;
	b=c5DagRJ4wiSUQmdZgOx1ATTCIR3xJ1wBgWwSmgmr0YC0e8i9Q9wwm3oFKZZ2p17tk1TG9Z
	CKqGd6tlT7KQheAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4481F13AB9;
	Sun, 16 Jun 2024 07:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MIgLD4uVbmYVCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:34:35 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/6] kselftest/alsa: Fix validation of writes to volatile controls
Date: Sun, 16 Jun 2024 09:34:45 +0200
Message-ID: <20240616073454.16512-5-tiwai@suse.de>
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
X-Rspamd-Queue-Id: 79DB53506E
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

From: Mark Brown <broonie@kernel.org>

When validating writes to controls we check that whatever value we wrote
actually appears in the control.  For volatile controls we cannot assume
that this will be the case, the value may be changed at any time
including between our write and read.  Handle this by moving the check
for volatile controls that we currently do for events to a separate
block and just verifying that whatever value we read is valid for the
control.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20240614-alsa-selftest-volatile-v1-1-3874f02964b1@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/alsa/mixer-test.c | 45 +++++++++++++++--------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..dd74f8cc7ece 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -625,6 +625,21 @@ static int write_and_verify(struct ctl_data *ctl,
 		return err;
 	}
 
+	/*
+	 * We can't verify any specific value for volatile controls
+	 * but we should still check that whatever we read is a valid
+	 * vale for the control.
+	 */
+	if (snd_ctl_elem_info_is_volatile(ctl->info)) {
+		if (!ctl_value_valid(ctl, read_val)) {
+			ksft_print_msg("Volatile control %s has invalid value\n",
+				       ctl->name);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
 	/*
 	 * Check for an event if the value changed, or confirm that
 	 * there was none if it didn't.  We rely on the kernel
@@ -632,22 +647,20 @@ static int write_and_verify(struct ctl_data *ctl,
 	 * write, this is currently true, should that ever change this
 	 * will most likely break and need updating.
 	 */
-	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
-		err = wait_for_event(ctl, 0);
-		if (snd_ctl_elem_value_compare(initial_val, read_val)) {
-			if (err < 1) {
-				ksft_print_msg("No event generated for %s\n",
-					       ctl->name);
-				show_values(ctl, initial_val, read_val);
-				ctl->event_missing++;
-			}
-		} else {
-			if (err != 0) {
-				ksft_print_msg("Spurious event generated for %s\n",
-					       ctl->name);
-				show_values(ctl, initial_val, read_val);
-				ctl->event_spurious++;
-			}
+	err = wait_for_event(ctl, 0);
+	if (snd_ctl_elem_value_compare(initial_val, read_val)) {
+		if (err < 1) {
+			ksft_print_msg("No event generated for %s\n",
+				       ctl->name);
+			show_values(ctl, initial_val, read_val);
+			ctl->event_missing++;
+		}
+	} else {
+		if (err != 0) {
+			ksft_print_msg("Spurious event generated for %s\n",
+				       ctl->name);
+			show_values(ctl, initial_val, read_val);
+			ctl->event_spurious++;
 		}
 	}
 
-- 
2.43.0


