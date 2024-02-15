Return-Path: <linux-kselftest+bounces-4791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D345856C32
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED7D1B27918
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30313956F;
	Thu, 15 Feb 2024 18:12:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3A1386D3;
	Thu, 15 Feb 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020766; cv=none; b=acFNgWezsgKmi2HOSdu2Qk4BkowvMoMXygURiWZVbgi2sJBAWBOvg9yI7fWMUwkLV9OaYhGKYLxD5GZiIjfoHW4vHvYpmQX90WuEF83eH1Ulc0I9uBc9BGvu7OIzI4rNWlKISW6jHjZLNiTcjl4K+xlTLKh6kakAGjN+LwyPHew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020766; c=relaxed/simple;
	bh=/oVRt9J85nXIjb42Ew5A1lAd/g3N6kuHuj8z2sOBZ30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e51HBobAaj8LedVohBYpcKWOEZCI5mpFbhjloCBKbnBR72X6Brl20woKcpu8ysKobJSozp8rredySWvowZ5aG2UIhPi+QGRvNYcapEkLRXWfcicHgG2WuaKPX3iEKxevlfV681ZW4sA0klX7kkKRq6y3kPBHUkYvZC9e01Lo2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8681B1F8CD;
	Thu, 15 Feb 2024 18:12:41 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1320F1346A;
	Thu, 15 Feb 2024 18:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id z3IGMhhUzmXvVwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Thu, 15 Feb 2024 18:12:40 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 15 Feb 2024 15:12:20 -0300
Subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc@suse.com>
References: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
In-Reply-To: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708020755; l=1247;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=/oVRt9J85nXIjb42Ew5A1lAd/g3N6kuHuj8z2sOBZ30=;
 b=YduZ53j14sbJDbhmCGu4WTRZjknj6Xx1QU8RIrIyDhEQUzAt38wSKhIT6yVyu0HOtdP10BtSp
 FgMIbf8PKKFACY5KwcgUjCI3NIcgM9EtBpSF6FlbSSjAXyQOF/l/4U1
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8681B1F8CD
X-Spam-Level: 
X-Spam-Score: -4.00
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


