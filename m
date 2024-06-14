Return-Path: <linux-kselftest+bounces-11941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B82908C06
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0525B1F27B0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973D199EB5;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="InKAxofO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JhPgbewn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="InKAxofO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JhPgbewn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBA19923E;
	Fri, 14 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369229; cv=none; b=ieatPoycAi5ysF4CHSYzBL8OXikh2GPKjWeKYYBKTaQcTQ2i2MlW8dTE4YGIU9IeZRTQFg6pLxjivOsAzG42pSBb9c7BMW4KchZmIyk7vbcrpINm8DHkqHTaAhrsoe4oOu52cBN0AHysO9vhlkRzKZGztdxsUHWDiIjy1PU0GJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369229; c=relaxed/simple;
	bh=beh4tnX7MXVqAyxfWvOWrGjk31/eY32PNY47MX3Z5NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrlX8a0yXBjDjYrCtJLUKcCHPPKYW05/j/Mb1s7BmHs4m+TJGMqTD9+A5Tu8t5gU49qj1fXqfvN06chI6w9wliOduU5xxajN4Eq/eHhKx9XDvtgStKi/chtHTLQ3QdiJlGVKLLjj+naaOl1IT4+asaR9KXk778SnBfQdX1sB1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=InKAxofO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JhPgbewn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=InKAxofO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JhPgbewn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61602337FD;
	Fri, 14 Jun 2024 12:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u1VuVpEB9ug4lUHbTdVi7yYvusiqrU54jEtlU1TlLc=;
	b=InKAxofOKJEKQE9BJI3PFonyJ26UhCEbkDU7ADfiUCnQxdFk0LsEZaUhADekg21cfRYzHI
	tDeS1MpgjppjoB9CnyGJTmDByyLQFW1GXunmPnccJiItwpLWLXYCDGd2zr8edvuNQQ42MA
	39JDf6AlrNDHrw1HFhYbgEprUjm9jrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u1VuVpEB9ug4lUHbTdVi7yYvusiqrU54jEtlU1TlLc=;
	b=JhPgbewn8xc1dl4EElmiEgwddWli01dMXMDbIGrhxS5gfvPERDowvbX0B/pqx2TudQ6jX4
	+57oBG0nSigUPkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u1VuVpEB9ug4lUHbTdVi7yYvusiqrU54jEtlU1TlLc=;
	b=InKAxofOKJEKQE9BJI3PFonyJ26UhCEbkDU7ADfiUCnQxdFk0LsEZaUhADekg21cfRYzHI
	tDeS1MpgjppjoB9CnyGJTmDByyLQFW1GXunmPnccJiItwpLWLXYCDGd2zr8edvuNQQ42MA
	39JDf6AlrNDHrw1HFhYbgEprUjm9jrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9u1VuVpEB9ug4lUHbTdVi7yYvusiqrU54jEtlU1TlLc=;
	b=JhPgbewn8xc1dl4EElmiEgwddWli01dMXMDbIGrhxS5gfvPERDowvbX0B/pqx2TudQ6jX4
	+57oBG0nSigUPkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 305D313AB1;
	Fri, 14 Jun 2024 12:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EmXCso7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:06 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/5] kselftest/alsa: mixer-test: Skip write tests for volatile controls
Date: Fri, 14 Jun 2024 14:47:26 +0200
Message-ID: <20240614124728.27901-5-tiwai@suse.de>
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
	BAYES_HAM(-3.00)[99.98%];
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

The control elements with volatile flag don't guarantee that the
written values are actually saved for the next reads, hence they
aren't suitable for the standard mixer tests.  Skip the write tests
for those volatile controls for avoiding confusion.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/r/1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/alsa/mixer-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..3c9a45fb5a29 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -702,6 +702,13 @@ static void test_ctl_write_default(struct ctl_data *ctl)
 		return;
 	}
 
+	if (snd_ctl_elem_info_is_volatile(ctl->info)) {
+		ksft_print_msg("%s is volatile\n", ctl->name);
+		ksft_test_result_skip("write_default.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
 	err = write_and_verify(ctl, ctl->def_val, NULL);
 
 	ksft_test_result(err >= 0, "write_default.%d.%d\n",
@@ -827,6 +834,13 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
 		return;
 	}
 
+	if (snd_ctl_elem_info_is_volatile(ctl->info)) {
+		ksft_print_msg("%s is volatile\n", ctl->name);
+		ksft_test_result_skip("write_valid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
 	switch (snd_ctl_elem_info_get_type(ctl->info)) {
 	case SND_CTL_ELEM_TYPE_BOOLEAN:
 		pass = test_ctl_write_valid_boolean(ctl);
@@ -1039,6 +1053,13 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
 		return;
 	}
 
+	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
+		ksft_print_msg("%s is volatile\n", ctl->name);
+		ksft_test_result_skip("write_invalid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
 	switch (snd_ctl_elem_info_get_type(ctl->info)) {
 	case SND_CTL_ELEM_TYPE_BOOLEAN:
 		pass = test_ctl_write_invalid_boolean(ctl);
-- 
2.43.0


