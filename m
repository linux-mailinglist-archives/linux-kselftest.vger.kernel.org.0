Return-Path: <linux-kselftest+bounces-4792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D86F856C34
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6FB28F006
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4713958E;
	Thu, 15 Feb 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KQpjfkGK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KQpjfkGK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF613957B;
	Thu, 15 Feb 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020768; cv=none; b=tvahn36Y8d0J9cp5EzbPmgLlDO9JvKg+ulaqN39h6z2AGmKVEl8yl1w2Pza5q8QogVida3zzWpGmlpCo/r6hxyCNWyi/kQ4AnKzZRycMN/XdgYzTFuLRhIaEhQtyvvWMUiVXwDAvna5uqU9aULCMsGwANMGdNGphD/+3VIiXr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020768; c=relaxed/simple;
	bh=4sRYEFsMr0x8AvEq/m65uPROo9JRLFixj6hIrz82inQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svJ9CC6d1/Xe2SGQZ/jWKKqrHl9UuoK0UIKTltNBhWl7as4fFvUBriIu2RJ0fg8tzmH6j5x3yQpGxs9AC5NvacrtLxbUcpvI1NsXSaTxJPG2L7HUZBs06luH1QIJQnG3vW0qn4dOgr/6GNE8kJwOa9AEmLtCTs0wiJADopelBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KQpjfkGK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KQpjfkGK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B37301F8C5;
	Thu, 15 Feb 2024 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708020764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9P8j5qWhDJz4Oep9mbgqw672iDvJafFPD4oyhUBddI=;
	b=KQpjfkGK5ng/v33n/Ir87kQIzKraqrPK5YGCGb+rZY6SrG6MPtnZxUD/Yo94axeOAzSvIh
	vO8XWdMxpZyMRfRRFRA5pyKq75AcN0BJMJTCdhZwRW2pFnmjn6r1fu94Uya7Ac6zEn22xE
	6vKcDHwbUarZGh1oQGPVAZkhUP65eqM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708020764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9P8j5qWhDJz4Oep9mbgqw672iDvJafFPD4oyhUBddI=;
	b=KQpjfkGK5ng/v33n/Ir87kQIzKraqrPK5YGCGb+rZY6SrG6MPtnZxUD/Yo94axeOAzSvIh
	vO8XWdMxpZyMRfRRFRA5pyKq75AcN0BJMJTCdhZwRW2pFnmjn6r1fu94Uya7Ac6zEn22xE
	6vKcDHwbUarZGh1oQGPVAZkhUP65eqM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BA371346A;
	Thu, 15 Feb 2024 18:12:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2QdrARxUzmXzVwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Thu, 15 Feb 2024 18:12:44 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 15 Feb 2024 15:12:21 -0300
Subject: [PATCH 2/3] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-lp-selftests-fixes-v1-2-89f4a6f5cddc@suse.com>
References: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
In-Reply-To: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708020755; l=1959;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=4sRYEFsMr0x8AvEq/m65uPROo9JRLFixj6hIrz82inQ=;
 b=zcZfYignRJgaR7E+a9UrQ2W5kHaC7C6bqwgG6KEBroOV/CxO0xVhtic0jk4F0RCX1ltxR9oHO
 mzz7XojaO0UA5mH1no0pEF4eCUnH6RxgScd4yoA+nnO42nuUvLrd9Mg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.20
X-Spamd-Result: default: False [-0.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

We don't need new targets only to run two make modules and make clean.
We can test if TEST_GEN_MODS_DIR is specified, and then run the
commands.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/lib.mk | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 286ce0ee102b..eddcd4a849dc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -58,8 +58,9 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
-	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
+all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
+	$(if $(TEST_GEN_MODS_DIR), \
+		$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR))
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
@@ -85,11 +86,6 @@ else
 	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
-gen_mods_dir:
-	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
-
-clean_mods_dir:
-	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
@@ -133,9 +129,11 @@ endif
 
 define CLEAN
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
+	$(if $(TEST_GEN_MODS_DIR), \
+		$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean)
 endef
 
-clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
+clean:
 	$(CLEAN)
 
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
@@ -166,4 +164,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir
+.PHONY: run_tests all clean install emit_tests

-- 
2.42.1


