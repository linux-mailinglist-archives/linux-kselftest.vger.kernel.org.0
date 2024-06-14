Return-Path: <linux-kselftest+bounces-11952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5465908EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 17:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EF61C21CEE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786C119B5BA;
	Fri, 14 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kg1Uy0rB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1DbdGZ0b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kg1Uy0rB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1DbdGZ0b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD519AD4B;
	Fri, 14 Jun 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379419; cv=none; b=NcHBD+Ckw9zTk5U+MiN5xVbEWs/0SDWdRG9wO1pcGKDXind+HbHTtVMSkRKeskA2YgG9hn6kfNa1+xxDFkTmIDRV7RwgUm6Fv2RyjKU1c1isR4wkgnp22hBLFExiztMH7ZpauyUaARRD4G9pYI073PRs6bTgF7c3dvKPv4mKOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379419; c=relaxed/simple;
	bh=CrgLt8b6qM/H1ihWgT2si76/6XUjOy4gqqVTxXQg7Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdMwhH8qmPJK3NYY532eMhDe3WkQJG22SccFp2eD6+T8ZjCOLt+mrGhSM6pqfl7PQe0HGOOWRrXek3mFJEvX5R/EBwuMnepIB/Pr4/h9jKmUHka6joImDPF/3iBsic/OU+6eoSS6D4KSNRTcO5T5/2r9XE1dFr+7YzAqjquxGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kg1Uy0rB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1DbdGZ0b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kg1Uy0rB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1DbdGZ0b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A26632284B;
	Fri, 14 Jun 2024 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC7pzFl0U/Sbh3KBnuWe4FfCvmWdB1/OkuEYYRm4JVc=;
	b=Kg1Uy0rBh6SWEl69Muqr6doSyMBXqXt46tG9+VKttjoUn4hGcfOxDDQkcI/N0Ifm6byOcA
	A1pSamfA9qds2jgVJPVUP2kS8ObGSZksYzC7jzgzfgTkEwAM+MVYmc1L5xBNSBcy6bPsCn
	4sGZUUWw+HuqZoi5qkF0YnPfl1Ee2zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC7pzFl0U/Sbh3KBnuWe4FfCvmWdB1/OkuEYYRm4JVc=;
	b=1DbdGZ0bHCPvLM8ChDvSVyCks2qFmQC3DyUOh6kaTRXe2wj+xauzSTt9iX6cvrnHr3y44m
	r0Oek46kL6Z4icDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718379415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC7pzFl0U/Sbh3KBnuWe4FfCvmWdB1/OkuEYYRm4JVc=;
	b=Kg1Uy0rBh6SWEl69Muqr6doSyMBXqXt46tG9+VKttjoUn4hGcfOxDDQkcI/N0Ifm6byOcA
	A1pSamfA9qds2jgVJPVUP2kS8ObGSZksYzC7jzgzfgTkEwAM+MVYmc1L5xBNSBcy6bPsCn
	4sGZUUWw+HuqZoi5qkF0YnPfl1Ee2zM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718379415;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cC7pzFl0U/Sbh3KBnuWe4FfCvmWdB1/OkuEYYRm4JVc=;
	b=1DbdGZ0bHCPvLM8ChDvSVyCks2qFmQC3DyUOh6kaTRXe2wj+xauzSTt9iX6cvrnHr3y44m
	r0Oek46kL6Z4icDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6533F13AB1;
	Fri, 14 Jun 2024 15:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5AI4F5djbGZQZAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 15:36:55 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/6] ALSA: some driver fixes for control input validations
Date: Fri, 14 Jun 2024 17:37:09 +0200
Message-ID: <20240614153717.30143-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi,

this is a revised patch set as a follow up of the thread about the
errors reported by kselftest mixer-test.  It changes HD-audio and
vmaster control behavior to return -EINVAL for invalid input values.

There is a change in kselftest itself to skip the verification after
write tests for volatile controls, too.  It's for the channel map
controls that can't hold the stable values.

v1->v2:
* Skip only verification after write in kselftest
* Add sanity check to HDMI chmap write, too


Takashi

===

Takashi Iwai (6):
  ALSA: vmaster: Return error for invalid input values
  ALSA: hda: Return -EINVAL for invalid volume/switch inputs
  ALSA: control: Apply sanity check of input values for user elements
  kselftest/alsa: mixer-test: Skip write verification for volatile
    controls
  ALSA: chmap: Mark Channel Map controls as volatile
  ALSA: hda: Add input value sanity checks to HDMI channel map controls

 sound/core/control.c                      |  3 ++-
 sound/core/pcm_lib.c                      |  1 +
 sound/core/vmaster.c                      |  8 ++++++++
 sound/hda/hdmi_chmap.c                    | 18 ++++++++++++++++++
 sound/pci/hda/hda_codec.c                 | 23 ++++++++++++++++++-----
 tools/testing/selftests/alsa/mixer-test.c |  4 ++++
 6 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.43.0


