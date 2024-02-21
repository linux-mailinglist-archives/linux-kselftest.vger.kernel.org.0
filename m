Return-Path: <linux-kselftest+bounces-5206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E238A85E465
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2F51C22D72
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B77584FDE;
	Wed, 21 Feb 2024 17:17:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E282D7B;
	Wed, 21 Feb 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535849; cv=none; b=KPcE+bU3b4ulW791Swx4+iBUAlPBf+SCOclVYwW26xUtD1hHnzXEqsUHgBp5JcdtGtfXmU2iFjEDoonG9oGOcBS9JPciD8UObPYVGg+wYfFikVcydrwM9SoIxUpIxBhWs/CHWFMG+6G5rMBJ+c8gzcV6bJ3pEV66ApUUosV/HIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535849; c=relaxed/simple;
	bh=4sRYEFsMr0x8AvEq/m65uPROo9JRLFixj6hIrz82inQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4ldHZ9PRQQACiZBOcxVZGOSa4Pu8dLQR2A86bjQNrCr07t2opDsXfo5sCDwASRAketz/vX6TXEx8zXX1e4h6+Bz+T2ShSR6W2A1coyz/aMdy2oMA70Cl3P9WGLD20sCHF36EBLw36FxWDebRoltzB/VRCQTZzpCHd8rYTmxe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D1DD22102;
	Wed, 21 Feb 2024 17:17:26 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0480813A25;
	Wed, 21 Feb 2024 17:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NDH0LiUw1mUfcQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 17:17:25 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 21 Feb 2024 14:17:06 -0300
Subject: [PATCH v2 4/4] selftests: lib.mk: Simplify TEST_GEN_MODS_DIR
 handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-lp-selftests-fixes-v2-4-a19be1e029a7@suse.com>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708535830; l=1959;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=4sRYEFsMr0x8AvEq/m65uPROo9JRLFixj6hIrz82inQ=;
 b=k6aiuIGTtALvQQFLvW+j9toVR32WNNHnB+49PPw7VA8Piw3BViCkI+7gk2tvRfCvK8nNHpNmf
 +GfzkX3mrywBQDOhYhJOj0Oc6/3/ZgsNF/dVbog8Tek694UPM3odrvF
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 7D1DD22102
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


