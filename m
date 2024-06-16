Return-Path: <linux-kselftest+bounces-12013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E142909C22
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 09:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36CC1F22286
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 07:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27817920C;
	Sun, 16 Jun 2024 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F9ERzQrL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0x2aZ2RS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F9ERzQrL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0x2aZ2RS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490D1178CC8;
	Sun, 16 Jun 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523278; cv=none; b=KUAN6ThkDhUr8E9NOIvfWrxgbNa7Jxq7afTIG5iwULLYc6baQ7L7fUgr3o3EqcRaRvXLMLWWeo1/muN+ab4jFVnNE/iSzbQ5i9WdadLiMZJbYxR1nKXtwe5f6jiMyPY4WpBMgI97nR0s9s9nKA8OKs6L3lzS0KO/sKf/a+TSF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523278; c=relaxed/simple;
	bh=pZ2+zdAAE9XGNm1XAnZYR5NYPd45Xp7sBXcaDCj1O1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UjasZLX/9fmz5hCJFkMkIVwwLSA2oBm+NtZosZr2kxcmYt7jY2dYYDMuJnZDLplCB42w4OFKTOsIDfJ6OElVmMIiYmw0foRf8KsvIjgVbsJFRnIDqaBUbSyK0+rrD8mfHPPlyZOQG3EUubikwS7DNmQNGoz8BZ3/mnuXCxxDQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F9ERzQrL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0x2aZ2RS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F9ERzQrL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0x2aZ2RS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79F005CC95;
	Sun, 16 Jun 2024 07:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRiovNepa+SZcMQVSXD2NO/uI5Hz/xC+WVvkhcfpBLw=;
	b=F9ERzQrLAqSW35XQ6xMVETn6YaxbsndKfimQueBlSRW/BQkK60nrim1dk4t9hcau4zehnZ
	GNqb0G+bKhUYwkId8YsYi0V5Eo+btu9QJVQ0bXKuYitIjrm1dYpKFMQPLhIeq5kggNIedt
	0jtHT4A9g4ONnH1vymqPYZklTeQhU6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRiovNepa+SZcMQVSXD2NO/uI5Hz/xC+WVvkhcfpBLw=;
	b=0x2aZ2RSdbFWQPYEJ1QYH9qnwzCawuUHrbGq5F/BEZyLxN/ZOuM/c9VpFJFXtvuFTPE19J
	yAtxhddc6s2fbTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRiovNepa+SZcMQVSXD2NO/uI5Hz/xC+WVvkhcfpBLw=;
	b=F9ERzQrLAqSW35XQ6xMVETn6YaxbsndKfimQueBlSRW/BQkK60nrim1dk4t9hcau4zehnZ
	GNqb0G+bKhUYwkId8YsYi0V5Eo+btu9QJVQ0bXKuYitIjrm1dYpKFMQPLhIeq5kggNIedt
	0jtHT4A9g4ONnH1vymqPYZklTeQhU6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FRiovNepa+SZcMQVSXD2NO/uI5Hz/xC+WVvkhcfpBLw=;
	b=0x2aZ2RSdbFWQPYEJ1QYH9qnwzCawuUHrbGq5F/BEZyLxN/ZOuM/c9VpFJFXtvuFTPE19J
	yAtxhddc6s2fbTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38F8713AB9;
	Sun, 16 Jun 2024 07:34:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mWMDDIqVbmYVCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:34:34 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/6] ALSA: some driver fixes for control input validations
Date: Sun, 16 Jun 2024 09:34:41 +0200
Message-ID: <20240616073454.16512-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

Hi,

this is a v3 patch set as a follow up of the thread about the errors
reported by kselftest mixer-test.  It changes HD-audio and vmaster
control behavior to return -EINVAL for invalid input values.

There is a change in kselftest itself to skip the verification after
write tests for volatile controls, too.  It's for the channel map
controls that can't hold the stable values.

v2->v3:
* Replace with Mark's patch for kselftest
* Apply the validation for user controls in put callback instead

v1->v2:
* Skip only verification after write in kselftest
* Add sanity check to HDMI chmap write, too

v2: https://lore.kernel.org/r/20240614153717.30143-1-tiwai@suse.de
v1: https://lore.kernel.org/r/20240614124728.27901-1-tiwai@suse.de

Takashi

===

Mark Brown (1):
  kselftest/alsa: Fix validation of writes to volatile controls

Takashi Iwai (5):
  ALSA: vmaster: Return error for invalid input values
  ALSA: hda: Return -EINVAL for invalid volume/switch inputs
  ALSA: control: Apply sanity check of input values for user elements
  ALSA: chmap: Mark Channel Map controls as volatile
  ALSA: hda: Add input value sanity checks to HDMI channel map controls

 sound/core/control.c                      |  6 ++-
 sound/core/pcm_lib.c                      |  1 +
 sound/core/vmaster.c                      |  8 ++++
 sound/hda/hdmi_chmap.c                    | 18 +++++++++
 sound/pci/hda/hda_codec.c                 | 23 +++++++++---
 tools/testing/selftests/alsa/mixer-test.c | 45 +++++++++++++++--------
 6 files changed, 79 insertions(+), 22 deletions(-)

-- 
2.43.0


