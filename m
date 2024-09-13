Return-Path: <linux-kselftest+bounces-17945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951597809C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C311EB2204C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD51DA61A;
	Fri, 13 Sep 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Clelwtnv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oZbfwViO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BB1D86DC;
	Fri, 13 Sep 2024 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232299; cv=none; b=tp7aLww1C6PIUoaBXpalsgOiWK8+T0jJe6TSFWK6abbVvUDNZdSdiNJY0POaoKx1vnuUuj7mg3VKPADfyZn/i0n37HL22Q0zOSGbFXtWedYqvSR8yxfUXeA2uupWCjj2i/3gPG2m5Ykkp87WwVuPHZJfQSfW051INA61e0Ta+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232299; c=relaxed/simple;
	bh=4vwtGD4yzne4fd3wxIdYe6RVC3k3AdOvPhNhb+z0Um4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gC6SW/uZXZzqlizl1/NUdh012nEcQWZVvO1R8uAqe2ZRIXCpeAj14d33+IfecxO5p2YUH8aftDlmYvoxllHKO2rxon0Zxne5m7gsvhKOqIc3wWw5B5gjXz2n3Te61ifaeGUfgZRxl3ePo5DszyzSaFqlxtImmnPTz2xxH6Zp0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Clelwtnv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oZbfwViO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB7611F45E;
	Fri, 13 Sep 2024 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726232295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK4taS9W1NPKU5v043D+Q3ycAtQ+7mI2j9dJHmLqz08=;
	b=ClelwtnvLErTY/LtIKhFq/i9qu67ovt/vt4Vmis7rCVm156TIuk5mVSQFr2z8Mkou3qZDy
	e3WcRe9uHyc8lFR8B3DnE0j1JlxXQe/nHkYYgv40ZW6I/VL4DYjdALW/HshfyejtmxmGAd
	xZvqHqoboLDiqhSSjmyZaRPZRNWXZu0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726232294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CK4taS9W1NPKU5v043D+Q3ycAtQ+7mI2j9dJHmLqz08=;
	b=oZbfwViOzqA0ihYi5LJFGl0qnBBiXzWMfoqsXk303DpTRqJTAaAGhUHcKHs3LUMxwit7WG
	Qf4J5RzRf4eo74dnp6I4WefPSuFx8+kcUXjKwR6RKwioUj5ON3n/mcjLefdl9TWYbF7nnH
	DPjYq4NKIV1LCw46iOCLSQLxQR1l0ok=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2A2F13999;
	Fri, 13 Sep 2024 12:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L0aIJOY25Ga2GQAAD6G6ig
	(envelope-from <mvetter@suse.com>); Fri, 13 Sep 2024 12:58:14 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH] selftests: livepatch: test livepatching a kprobed function
Date: Fri, 13 Sep 2024 14:58:11 +0200
Message-ID: <20240913125811.116410-1-mvetter@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The test proves that a function that is being kprobed and uses a
post_handler cannot be livepatched.

Only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be registered
to any given function at a time.

Signed-off-by: Michael Vetter <mvetter@suse.com>
---
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../selftests/livepatch/test-kprobe.sh        | 62 +++++++++++++++++++
 .../selftests/livepatch/test_modules/Makefile |  3 +-
 .../livepatch/test_modules/test_klp_kprobe.c  | 38 ++++++++++++
 4 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 35418a4790be..a080eb54a215 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh \
 	test-sysfs.sh \
-	test-syscall.sh
+	test-syscall.sh \
+	test-kprobe.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-kprobe.sh b/tools/testing/selftests/livepatch/test-kprobe.sh
new file mode 100755
index 000000000000..0c62c6b81e18
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-kprobe.sh
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE
+# Author: Michael Vetter <mvetter@suse.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_LIVEPATCH=test_klp_livepatch
+MOD_KPROBE=test_klp_kprobe
+
+setup_config
+
+# Kprobe a function and verify that we can't livepatch that same function
+# when it uses a post_handler since only one IPMODIFY maybe be registered
+# to any given function at a time.
+
+start_test "livepatch interaction with kprobed function with post_handler"
+
+echo 1 > /sys/kernel/debug/kprobes/enabled
+
+load_mod $MOD_KPROBE has_post_handler=true
+load_failing_mod $MOD_LIVEPATCH
+unload_mod $MOD_KPROBE
+
+check_result "% insmod test_modules/test_klp_kprobe.ko has_post_handler=true
+% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
+livepatch: failed to patch object 'vmlinux'
+livepatch: failed to enable patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
+% rmmod test_klp_kprobe"
+
+start_test "livepatch interaction with kprobed function without post_handler"
+
+load_mod $MOD_KPROBE has_post_handler=false
+load_lp $MOD_LIVEPATCH
+
+unload_mod $MOD_KPROBE
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "% insmod test_modules/test_klp_kprobe.ko has_post_handler=false
+% insmod test_modules/$MOD_LIVEPATCH.ko
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+% rmmod test_klp_kprobe
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+exit 0
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index e6e638c4bcba..4981d270f128 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -11,7 +11,8 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_state2.o \
 	test_klp_state3.o \
 	test_klp_shadow_vars.o \
-	test_klp_syscall.o
+	test_klp_syscall.o \
+	test_klp_kprobe.o
 
 # Ensure that KDIR exists, otherwise skip the compilation
 modules:
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
new file mode 100644
index 000000000000..49b579ea1054
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Marcos Paulo de Souza <mpdesouza@suse.com>
+// Copyright (C) 2024 Michael Vetter <mvetter@suse.com>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/kprobes.h>
+
+static bool has_post_handler = true;
+module_param(has_post_handler, bool, 0444);
+
+static void __kprobes post_handler(struct kprobe *p, struct pt_regs *regs,
+				unsigned long flags)
+{
+}
+
+static struct kprobe kp = {
+	.symbol_name = "cmdline_proc_show",
+};
+
+static int __init kprobe_init(void)
+{
+	if (has_post_handler)
+		kp.post_handler = post_handler;
+
+	return register_kprobe(&kp);
+}
+
+static void __exit kprobe_exit(void)
+{
+	unregister_kprobe(&kp);
+}
+
+module_init(kprobe_init)
+module_exit(kprobe_exit)
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Vetter <mvetter@suse.com>");
+MODULE_DESCRIPTION("Livepatch test: livepatch kprobed function");
-- 
2.46.0


