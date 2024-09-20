Return-Path: <linux-kselftest+bounces-18166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5BA97D504
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 13:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6451C2365A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371E14F121;
	Fri, 20 Sep 2024 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u2OOvz9B";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u2OOvz9B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9872914D6EE;
	Fri, 20 Sep 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833403; cv=none; b=df7lWEbZyXygCxo2GkXQKvfYg5ULaCMJkIhrRv3NepmBWp20Egej7iaFxUG4AW2BLwhTviR8DVHWYHHJT1oVW8zvQVf/zhE2tjUjXHoxE+XQeq77z7oAEAOjwDGM6yydsBEXhoG+QRFeoOqVvp+oyw59e+RmIFRa8mNNPg7qGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833403; c=relaxed/simple;
	bh=8H+erQ1HqadjhMVioL0hwVWRUTsfsIHFV5Yb8bx6JiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ey43KyN5g3kUfHpXWTRJqMkIBgV1cM5CTRaMlTcwdVfQC8/PXAbkPZ9iAfmQbD+ZFEu2hcaUWmD9xnXtUo3zzOqQo+HbZxnyiuTKdN1YnfUGFoNvxIuFz5Qn2Ud2V6zT5f8WtAh0hFYAyMPwUTHYv8+NC24Tv242RFlBhqdF5qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u2OOvz9B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u2OOvz9B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EADD33A37;
	Fri, 20 Sep 2024 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=inyu8WpIlzG2DuQjZTZgTs1aahX51cTPQiYCRAod0Iw=;
	b=u2OOvz9BKt1/88RtPHPNTRGX4X1mfi/2sI7/PsCadPYZH0Khl23VMy7icNxrtOOg3KRGcv
	30gA0z4Pr1Z7TykFT/xMWNx/xDBzwOOVd1yaQQspwB3agq8LW+uEEqp4ml7cQgveLtKoE3
	gN9usHn7S+YJazjEdPrkJQbw9ekRQWI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u2OOvz9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=inyu8WpIlzG2DuQjZTZgTs1aahX51cTPQiYCRAod0Iw=;
	b=u2OOvz9BKt1/88RtPHPNTRGX4X1mfi/2sI7/PsCadPYZH0Khl23VMy7icNxrtOOg3KRGcv
	30gA0z4Pr1Z7TykFT/xMWNx/xDBzwOOVd1yaQQspwB3agq8LW+uEEqp4ml7cQgveLtKoE3
	gN9usHn7S+YJazjEdPrkJQbw9ekRQWI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9F7613AE1;
	Fri, 20 Sep 2024 11:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJO1LvFi7WbdHwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Fri, 20 Sep 2024 11:56:33 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v3 0/3] selftests: livepatch: test livepatching a kprobed function
Date: Fri, 20 Sep 2024 13:56:28 +0200
Message-ID: <20240920115631.54142-1-mvetter@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EADD33A37
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This patchset adds a test for livepatching a kprobed function.

Thanks to Petr and Marcos for the reviews!

V3:
Save and restore kprobe state also when test fails, by integrating it
into setup_config() and cleanup().
Rename SYSFS variables in a more logical way.
Sort test modules in alphabetical order.
Rename module description.

V2:
Save and restore kprobe state.

Michael Vetter (3):
  selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
  selftests: livepatch: save and restore kprobe state
  selftests: livepatch: test livepatching a kprobed function

 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 13 +++-
 .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  3 +-
 .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
 5 files changed, 114 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c

-- 
2.46.0


