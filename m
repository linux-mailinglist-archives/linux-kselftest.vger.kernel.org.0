Return-Path: <linux-kselftest+bounces-2272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E081A5A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA641C22719
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377FA4645E;
	Wed, 20 Dec 2023 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUUWN6PQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oUUWN6PQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF846535;
	Wed, 20 Dec 2023 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54D411F83D;
	Wed, 20 Dec 2023 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703091206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bowR7VTv0DP9Zwvvuc76K5HhtGrhPhlCbmsYd4zANDM=;
	b=oUUWN6PQlKgNAqWrl2+EfsqaO9QF8G/2sLA0cd1t1QW8GfA6SXsTV7E0GJ2ape2r3rXngx
	TO0PBogPy6p+NuiqyY9nBCEayy1KYq7LEso0JLB5Vy+6rT+OI6e4yfn1cSKyPpixg2Z74I
	nDRH2KdeV/pCl5pyl+2ExycgWSu8meY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703091206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bowR7VTv0DP9Zwvvuc76K5HhtGrhPhlCbmsYd4zANDM=;
	b=oUUWN6PQlKgNAqWrl2+EfsqaO9QF8G/2sLA0cd1t1QW8GfA6SXsTV7E0GJ2ape2r3rXngx
	TO0PBogPy6p+NuiqyY9nBCEayy1KYq7LEso0JLB5Vy+6rT+OI6e4yfn1cSKyPpixg2Z74I
	nDRH2KdeV/pCl5pyl+2ExycgWSu8meY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D377413722;
	Wed, 20 Dec 2023 16:53:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4L3HIgUcg2V/SQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 20 Dec 2023 16:53:25 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 20 Dec 2023 13:53:12 -0300
Subject: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
In-Reply-To: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703091199; l=4750;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=7aSXvLR/NeW1yOAkbvMqXIcbput29MVpoSQ3ccB2cy0=;
 b=Kaej+YHwR4OPMDedsWA7d1qhh7Uj70EktwPkwbsl8tOpHNnWw3Sq3SN59uT2zZxN5nZ+vSADL
 mIrGpFX/PFZCVIq8zDxTAuwKL0CA0o0bDVE5Yy7SwUPv5Q6ckUymabL
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-7.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL64puoyk87hsyf83pd56xsc3m)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
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

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 Documentation/dev-tools/kselftest.rst |  4 ++++
 tools/testing/selftests/lib.mk        | 20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

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
2.42.1


