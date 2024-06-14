Return-Path: <linux-kselftest+bounces-11937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3FE908C02
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F311F27A89
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBFE199249;
	Fri, 14 Jun 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgJrM/WN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/8j+A/I";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dgJrM/WN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/8j+A/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731E814A0BF;
	Fri, 14 Jun 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369228; cv=none; b=o7moclUxzdfME/0zmfVXkYRS4PviiGutuKW+c++SUbO+hJLnLYrciGXwoMDBoL7jJ/j3WUopWc/ovrUhC6wQp8lDe0NKTbhQRm4hNKfpfNmybkPR+8j3VhbAAzt73BKjvnaeDmVbehI1qJC+qep9Ny1sAoBAueCE86fAQYCjF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369228; c=relaxed/simple;
	bh=8O/389YY8eIsieEAP5SzxSqF5fbOiRY3qU4Msfv3R/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBkjCVgwzRaVEukPgpMS3foUrUOnQQJJYSBjVY+Z0eP1dzHY5IYrEnjr8h9bBz2S5plY4fVM+5GwuQCDojUGepFNSqckQZela5dMWR8UzX+O1IEe8p39K/d8yHBwnGhNiTMFE0NTVRlkwDhq52ZnBXHEFVFCR64+KjxNkG7Dukw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgJrM/WN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/8j+A/I; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dgJrM/WN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/8j+A/I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81610337F9;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFBzR4FMQd8uCxmqo7uJpJ2KW9LcHbelbc/spMbz+aQ=;
	b=dgJrM/WNN/biF29KF3oAfpY0EWvAPeEydv6y4m7oCsCFf8FMwRvV5DpxcOZV5OZp4ON79t
	mGB5hF5zm97y34TzVuA2yII6xS6j76jy1CpvZyYK5ZQvyplbw2xsjGK6THxhC4HWGVrezH
	0o58Ze5KzTz9U2RlaD3lKALFqfRgVG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFBzR4FMQd8uCxmqo7uJpJ2KW9LcHbelbc/spMbz+aQ=;
	b=J/8j+A/I0YFCZkAaatXoR+lQjUga/utSEEoO09WO1dRp931zYuWvWuLPoBOY6WJMWl70F1
	+KBJIzK69iXUg1Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFBzR4FMQd8uCxmqo7uJpJ2KW9LcHbelbc/spMbz+aQ=;
	b=dgJrM/WNN/biF29KF3oAfpY0EWvAPeEydv6y4m7oCsCFf8FMwRvV5DpxcOZV5OZp4ON79t
	mGB5hF5zm97y34TzVuA2yII6xS6j76jy1CpvZyYK5ZQvyplbw2xsjGK6THxhC4HWGVrezH
	0o58Ze5KzTz9U2RlaD3lKALFqfRgVG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kFBzR4FMQd8uCxmqo7uJpJ2KW9LcHbelbc/spMbz+aQ=;
	b=J/8j+A/I0YFCZkAaatXoR+lQjUga/utSEEoO09WO1dRp931zYuWvWuLPoBOY6WJMWl70F1
	+KBJIzK69iXUg1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F22513AB1;
	Fri, 14 Jun 2024 12:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OJQnEsk7bGYxMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:47:05 +0000
From: Takashi Iwai <tiwai@suse.de>
To: linux-sound@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/5] ALSA: some driver fixes for control input validations
Date: Fri, 14 Jun 2024 14:47:22 +0200
Message-ID: <20240614124728.27901-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.78
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Hi,

this is a patch set as a follow up of the thread about the errors
reported by kselftest mixer-test.  It changes HD-audio and vmaster
control behavior to return -EINVAL for invalid input values.

There is a change in kselftest itself to skip the write tests for
volatile controls, too.  It's for the channel map controls that can't
hold the stable values.


Takashi

===

Takashi Iwai (5):
  ALSA: vmaster: Return error for invalid input values
  ALSA: hda: Return -EINVAL for invalid volume/switch inputs
  ALSA: control: Apply sanity check of input values for user elements
  kselftest/alsa: mixer-test: Skip write tests for volatile controls
  ALSA: chmap: Mark Channel Map controls as volatile

 sound/core/control.c                      |  3 ++-
 sound/core/pcm_lib.c                      |  1 +
 sound/core/vmaster.c                      |  8 ++++++++
 sound/pci/hda/hda_codec.c                 | 23 ++++++++++++++++++-----
 tools/testing/selftests/alsa/mixer-test.c | 21 +++++++++++++++++++++
 5 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.43.0


