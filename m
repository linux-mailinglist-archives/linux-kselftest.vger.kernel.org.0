Return-Path: <linux-kselftest+bounces-20051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7779A2E1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A53283323
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492802281FE;
	Thu, 17 Oct 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ooAh9CGt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ooAh9CGt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AC17C230;
	Thu, 17 Oct 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195311; cv=none; b=CckBn6o2N5aDEkg70V9OzQk1diPFg8c/lOyCKyAekqP3hcWei0bkYNd8oe1D25NL6YYiHNaaZPG/uM5K3UD/BIFOdAOVwJrKUBbcxO9QUjuXYsrcxheuocUA3PJbSPHy+76BUBw+pyI95O7NAyPl2jLuOujCqtmlDCq9TG+Rne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195311; c=relaxed/simple;
	bh=F+5SIgDh7sx3OpogruobjRVcQAZu/VN4n+Yvvck/Ld4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkOWF6L3GjMV4XLxPuzdVFYrnVPnlBcv000oSGv8vyrQqj20OfrfDqzsFsA6tfj83qe6NiLMcZZah4twU2Xz1A6TS8IfYzelEks0NUdBTZJWOBhB71vsOV0gvfdJcvoHe3Fscw1B+JPKEtqoy2ipfudN1eKNJmD+ZbI5xenpPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ooAh9CGt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ooAh9CGt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B24EF1FD4D;
	Thu, 17 Oct 2024 20:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729195304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgL0r7SWp454uJAbukTAw+YZKN8C7TvJfxFAcxCZ8hU=;
	b=ooAh9CGtK00UC6+Zzm9M3VdjmJxevvm7mde7URyNWZQJyZTTtYdYnVuP5UyKA+qgm7Wa1U
	TFwbNOnInag1Xh2VX+WKJfWJjBX+6ChKkp0s3Aud/u1+YII8nJPjkaqGJYQzOWFgznFdLC
	ExYgWDnROGKgV1JMsZGl7JpKZJF5BH0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729195304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EgL0r7SWp454uJAbukTAw+YZKN8C7TvJfxFAcxCZ8hU=;
	b=ooAh9CGtK00UC6+Zzm9M3VdjmJxevvm7mde7URyNWZQJyZTTtYdYnVuP5UyKA+qgm7Wa1U
	TFwbNOnInag1Xh2VX+WKJfWJjBX+6ChKkp0s3Aud/u1+YII8nJPjkaqGJYQzOWFgznFdLC
	ExYgWDnROGKgV1JMsZGl7JpKZJF5BH0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90B2213A9A;
	Thu, 17 Oct 2024 20:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LFJIihtEWf1AwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Thu, 17 Oct 2024 20:01:44 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v5 3/3] selftests: livepatch: test livepatching a kprobed function
Date: Thu, 17 Oct 2024 22:01:32 +0200
Message-ID: <20241017200132.21946-4-mvetter@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
References: <20241017200132.21946-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The test proves that a function that is being kprobed and uses a
post_handler cannot be livepatched.

Only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be registered
to any given function at a time.

Note that the conflicting kprobe could not be created using the
tracefs interface, see Documentation/trace/kprobetrace.rst.
This interface uses only the pre_handler(), see alloc_trace_kprobe().
But FTRACE_OPS_FL_IPMODIFY is used only when the kprobe is using a
post_handler, see arm_kprobe_ftrace().

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
index 000000000000..115065156016
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
+echo 1 > "$SYSFS_KPROBES_DIR/enabled"
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
index e6e638c4bcba..939230e571f5 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -6,11 +6,12 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_callbacks_demo.o \
 	test_klp_callbacks_demo2.o \
 	test_klp_callbacks_mod.o \
+	test_klp_kprobe.o \
 	test_klp_livepatch.o \
+	test_klp_shadow_vars.o \
 	test_klp_state.o \
 	test_klp_state2.o \
 	test_klp_state3.o \
-	test_klp_shadow_vars.o \
 	test_klp_syscall.o
 
 # Ensure that KDIR exists, otherwise skip the compilation
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
new file mode 100644
index 000000000000..67a8d29012f6
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
+MODULE_DESCRIPTION("Livepatch test: kprobe function");
-- 
2.47.0


