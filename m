Return-Path: <linux-kselftest+bounces-5205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B455F85E462
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB30E1C22C8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8814A8593A;
	Wed, 21 Feb 2024 17:17:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6385923;
	Wed, 21 Feb 2024 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535847; cv=none; b=N1PYkOgh+hJPAaA7a/3YTF1AYnyPXxeGFw1VbCECGe6TxsEZSG+aYvh/wPQRd1O7tjyhaTSJe5VrfKVI+8dpMnLGHt09tb/dZnYSYh0nTfcAcWVZF3QC0URR0W6fbwyuRDlR+xo8OQAtZuJpCFrcK/2st83SmAl1Ya7E8SsqWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535847; c=relaxed/simple;
	bh=/oVRt9J85nXIjb42Ew5A1lAd/g3N6kuHuj8z2sOBZ30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XY8NlBpbMOnyLZa9QTWo4zUVt9Njx1fmJYJCiBbLVb+wAMtcc2pYQkHnm4fviVeFnhcJp9J2F30ZiqHlyrYZl7RzIWebEshUULb8sHns5WGykclEPJxzhyRkNftaHJCS9NwwjfRO+bSgADuYzjDF0SuvsHIHLNfd/Ah/kXkLZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 517531FB73;
	Wed, 21 Feb 2024 17:17:23 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D2CEE13A25;
	Wed, 21 Feb 2024 17:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CvCdJSIw1mUbcQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 17:17:22 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 21 Feb 2024 14:17:05 -0300
Subject: [PATCH v2 3/4] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-lp-selftests-fixes-v2-3-a19be1e029a7@suse.com>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708535830; l=1247;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=/oVRt9J85nXIjb42Ew5A1lAd/g3N6kuHuj8z2sOBZ30=;
 b=kwJuKPHcJm3are3nXOWsN5KVb0sSlHQg9wSH6Hq7Fy65NGToMKeDvQGCzGl04KfZTT6b17dzJ
 G4Baf1x9fGsChkCAp3eu9qILMcCO9LxTjGg0JKNZ2Ofhk5gIs2UptyI
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 517531FB73
X-Spam-Flag: NO

The directory itself doesn't need have path handling, since it's only to
mean where is the directory that contains modules to be built.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/lib.mk | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 0d8b7db92715..286ce0ee102b 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -54,12 +54,9 @@ endif
 # TEST_PROGS are for test shell scripts.
 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
 # and install targets. Common clean doesn't touch them.
-# TEST_GEN_MODS_DIR is used to specify a directory with modules to be built
-# before the test executes. These modules are cleaned on the clean target as well.
 TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
-TEST_GEN_MODS_DIR := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
 
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
 	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)

-- 
2.42.1


