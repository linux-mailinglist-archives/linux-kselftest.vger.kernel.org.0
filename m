Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2137DD77E
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjJaVLT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344711AbjJaVLT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 17:11:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7AE4;
        Tue, 31 Oct 2023 14:11:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB9A1F74C;
        Tue, 31 Oct 2023 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698786675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=733zuLlM37zhgegj/Aa3vANdwzR7I3IGxmEe2YYzTF0=;
        b=UW6PIVACAQKyS0Zxdm8Qpoh1UOm7wJRcxItQlfxLDclA+UDNegWTLOVmt+9Ryuc4eZOMe0
        cgwplNiFOYltHDyv4KEU3FLIZf6mw/0r3Q0Y7WjCHgJP0Tn11IFmPNrf9EVFXqt1KdPrkf
        3ZPoUVHu9KLa4hrWDHk7Wf7pHDNO524=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 881C7138EF;
        Tue, 31 Oct 2023 21:11:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q5mjEnJtQWXWWgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 31 Oct 2023 21:11:14 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
Date:   Tue, 31 Oct 2023 18:10:51 -0300
Subject: [PATCH v3 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-send-lp-kselftests-v3-1-2b1655c2605f@suse.com>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
In-Reply-To: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698786668; l=4750;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Jag/lvrJcOjzASumYTCyZXP1V0dWxSS+ekxFXqM8RXg=;
 b=PHtutqsT9XFnYWbUJFgej+pZBli8wFjCKc5z9NUmLgJGDtn4i+SlpCgOlvQY2043RcvxewB5H/Ed
 Fv53R5mOB3g7GSJPAaIOzPQiJUw3BH2nahgtYp5uS+YgxrUgcH0i
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/dev-tools/kselftest.rst |  4 ++++
 tools/testing/selftests/lib.mk        | 20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index deede972f254..736c671c47b6 100644
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
index 118e0964bda9..6c7c5a0112cf 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -70,12 +70,15 @@ KHDR_INCLUDES := -isystem $(KHDR_DIR)
 # TEST_PROGS are for test shell scripts.
 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
 # and install targets. Common clean doesn't touch them.
+# TEST_GEN_MODS_DIR is used to specify a directory with modules to be built
+# before the test executes. These modules are cleaned on the clean target as well.
 TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
+TEST_GEN_MODS_DIR := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
 
 all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
-     $(TEST_GEN_FILES)
+     $(TEST_GEN_FILES) $(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
 
 kernel_header_files:
 	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
@@ -105,8 +108,8 @@ endef
 
 run_tests: all
 ifdef building_out_of_srctree
-	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
-		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
+	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS_DIR)" != "X" ]; then \
+		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
@@ -118,6 +121,12 @@ else
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
@@ -131,6 +140,7 @@ define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(TEST_GEN_MODS_DIR)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
 endef
 
@@ -156,7 +166,7 @@ define CLEAN
 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
 endef
 
-clean:
+clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
 	$(CLEAN)
 
 # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
@@ -187,4 +197,4 @@ $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
 endif
 
-.PHONY: run_tests all clean install emit_tests
+.PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir

-- 
2.42.0

