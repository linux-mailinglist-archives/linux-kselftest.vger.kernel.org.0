Return-Path: <linux-kselftest+bounces-2918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A087982C4E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 18:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF3F1F24D14
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCA1AAAD;
	Fri, 12 Jan 2024 17:44:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FC17C92;
	Fri, 12 Jan 2024 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F52D1FCE4;
	Fri, 12 Jan 2024 17:43:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDD03136A4;
	Fri, 12 Jan 2024 17:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qtgSJV56oWUDPgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Fri, 12 Jan 2024 17:43:58 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 12 Jan 2024 14:43:50 -0300
Subject: [PATCH v6 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-send-lp-kselftests-v6-1-79f3e9a46717@suse.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
In-Reply-To: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
To: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705081432; l=5532;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=DxYGIqHdO8SS/+GxeCGTh9/b0o40/vuzOtxjLfRVJMg=;
 b=EdhtFoslvfRkUt9r5V/KOwll2qb7l2XoolCpIRb1wBvBKXY3oTsiSyilVvWVWA1HcpYHsR/DM
 oLnFEsbd7k/B1A7ZR3s5/EMjN7bb3cyigYpm+Tf9YTcJKry1Z3rNTU+
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4F52D1FCE4
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
a directory containing kernel modules that will be used by
selftest scripts.

The modules are built as external modules for the running kernel.
As a result they are always binary compatible and the same tests
can be used for older or newer kernels.

The build requires "kernel-devel" package to be installed.
For example, in the upstream sources, the rpm devel package
is produced by "make rpm-pkg"

The modules can be built independently by

  make -C tools/testing/selftests/livepatch/

or they will be automatically built before running the tests via

  make -C tools/testing/selftests/livepatch/ run_tests

Note that they are _not_ built when running the standalone
tests by calling, for example, ./test-state.sh.

Along with TEST_GEN_MODS_DIR, it was necessary to create a new install
rule. INSTALL_MODS_RULE is needed because INSTALL_SINGLE_RULE would
copy the entire TEST_GEN_MODS_DIR directory to the destination, even
the files created by Kbuild to compile the modules. The new install
rule copies only the .ko files, as we would expect the gen_tar to work.

Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/dev-tools/kselftest.rst |  4 ++++
 tools/testing/selftests/lib.mk        | 26 +++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index ab376b316c36..7f3582a67318 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -245,6 +245,10 @@ Contributing new tests (details)
    TEST_PROGS, TEST_GEN_PROGS mean it is the executable tested by
    default.
 
+   TEST_GEN_MODS_DIR should be used by tests that require modules to be built
+   before the test starts. The variable will contain the name of the directory
+   containing the modules.
+
    TEST_CUSTOM_PROGS should be used by tests that require custom build
    rules and prevent common build rule use.
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index aa646e0661f3..0d8b7db92715 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -54,11 +54,15 @@ endif
 # TEST_PROGS are for test shell scripts.
 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
 # and install targets. Common clean doesn't touch them.
+# TEST_GEN_MODS_DIR is used to specify a directory with modules to be built
+# before the test executes. These modules are cleaned on the clean target as well.
 TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
+TEST_GEN_MODS_DIR := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
 
-all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
+all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) \
+	$(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
@@ -71,8 +75,8 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
-		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
+	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS_DIR)" != "X" ]; then \
+		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
@@ -84,11 +88,22 @@ else
 	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
 
+gen_mods_dir:
+	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
+
+clean_mods_dir:
+	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
+
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
 	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
 endef
 
+define INSTALL_MODS_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH)/$(INSTALL_LIST))
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST)/*.ko $(INSTALL_PATH)/$(INSTALL_LIST))
+endef
+
 define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
@@ -97,6 +112,7 @@ define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(notdir $(TEST_GEN_MODS_DIR))) $(INSTALL_MODS_RULE)
 	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
 endef
 
@@ -122,7 +138,7 @@ define CLEAN
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
 endef
 
-clean:
+clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
@@ -153,4 +169,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir

-- 
2.42.1


