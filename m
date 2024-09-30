Return-Path: <linux-kselftest+bounces-18599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D32989E75
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96392887B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D210C18A92F;
	Mon, 30 Sep 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F41znBbQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KNm76x2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED59188735;
	Mon, 30 Sep 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688795; cv=none; b=Vu8FLwqwdevT9N42Rsc+ccazHp0fhJwXUQ/lcnz2s/+SF+XgLThYcuVtw0oWt/wMqd3yquLuTtk7be0mpEN+7+RBxHY8QTllyBKYtwIRsBwFmADjgG1mcGhH3PkxRWL3sASO9qbypKxURoJ/u8gPdA+e6ol9aNeY6+f1dDORRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688795; c=relaxed/simple;
	bh=O9h6C3ZwQUoyVyj5PFov8xKcEhunSZ63XE6XNnNhnnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CI7lGsgOJtOoX4bk4jHcvyJ9SREb+r2VT0V8pf+TZtcVSTXKV9+uOP8u0VaLngwQLMGjZZ2Lqq5+rKVGFe05HoEvud+HqM7/n3x+bOtZPmlpb7HvUr7AUWO6l8NK82x0PfHJ+jNAGrausPLfgtyt0QP2hUupXmSMzADv2izGveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F41znBbQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KNm76x2+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E70B321A4A;
	Mon, 30 Sep 2024 09:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eyYpXuidrmPzRLE+tOr+SL2jb0nj+nByne39beqTlV4=;
	b=F41znBbQTBEYg/X1XenfjKZVt5Sr804sqs2rC6e8Ugz5JnZ6WdLbRMBWEFhgQPIivcBrby
	84U2zSER8aC1MjnPxBKamflBTDyTwZWzvly6VXpNgG9De8FOvRtJf+9AU23MgPuibxO4iP
	OC/Y1v/aiRmDHX33+Z7Ook+rXbL3u2g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KNm76x2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eyYpXuidrmPzRLE+tOr+SL2jb0nj+nByne39beqTlV4=;
	b=KNm76x2+mvqfkFIo97fp12Nhhu5aWyd2oia/yLUO9by6ZJcHAape1i8/hmAJRhlsUNN2NE
	Dwz2Gz8SnqVjfh6SP/VUhdrY3CyKhsV6XYJaqD9O1OWeypQV0/rdTN6Ak4G/l0Hx4QuVkK
	/J3RGoZN4rbGwXaYg0NOr/3/XJCz4Z4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A7D1A136CB;
	Mon, 30 Sep 2024 09:33:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xhy1Jldw+mayMAAAD6G6ig
	(envelope-from <mvetter@suse.com>); Mon, 30 Sep 2024 09:33:11 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v4 0/3] selftests: livepatch: test livepatching a kprobed function
Date: Mon, 30 Sep 2024 11:33:05 +0200
Message-ID: <20240930093308.65103-1-mvetter@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E70B321A4A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Thanks to Miroslav, Petr and Marcos for the reviews!

V4:
Use variable for /sys/kernel/debug.
Be consistent with "" around variables.
Fix path in commit message to /sys/kernel/debug/kprobes/enabled.

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
 .../testing/selftests/livepatch/functions.sh  | 19 ++++--
 .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  3 +-
 .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
 5 files changed, 117 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c

-- 
2.46.1


