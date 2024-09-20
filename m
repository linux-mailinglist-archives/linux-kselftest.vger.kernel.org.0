Return-Path: <linux-kselftest+bounces-18165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E2397D501
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 13:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959FE285E43
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0814EC42;
	Fri, 20 Sep 2024 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qwAxjpUi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qwAxjpUi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F2145A0B;
	Fri, 20 Sep 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833402; cv=none; b=S9i/4pnpxpT/Lcp9Dwt38YhVs9c7Kri0Pm7OnZhSSpqXDQM9PqYVwbBTxTHIY2RpZtfzZ+expcnAsDq8iWAgkSVRR1t0Li914vw6P1bBnOMMWlIMzxsYIBWTx2y2r/zpzVbH2EeAhBA0TI+RmDB/Fbnupgb/oplQQHJpFYSyZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833402; c=relaxed/simple;
	bh=ejbfZDTrtgPLbpNQf8BnIxQAVk+ATH3Ft0uOjX7wB/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0tkloHRzGoo7ZwbpBvH5QnDoPVb306TdJJvReyNbbGBYRSkvxR+uOWRgSY2JcjizROkv0sMWxvjQnY9aMi2SzLlDC4SAKZI3/PZyIc0Y98iPOw1LUjjj0fGVzoyvHcBApujMQX26vVkuk/iIh9esPfP0WJl0wpMV3CEQXzQ/4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qwAxjpUi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qwAxjpUi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92FEF20A64;
	Fri, 20 Sep 2024 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5ILLK5BglYmUJKtc1zDVh8Db0fB24WRM+7jNPrnS50=;
	b=qwAxjpUi2Ev6zS7utLbBd87JsA4j9KiMOxAm3jHPY8to4C0JlbO3Cs9jo8yKBUljgLJNf3
	6djGWZ85AK9pRZ18D9eM6/ZgkX6OteR7WHPWPVoa7bUntAnT9D0OL0pxfVBq4x5i+Z5Ivk
	LArXSAmEpOi2RJaj4xV+a0ZNiP5b+f0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qwAxjpUi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5ILLK5BglYmUJKtc1zDVh8Db0fB24WRM+7jNPrnS50=;
	b=qwAxjpUi2Ev6zS7utLbBd87JsA4j9KiMOxAm3jHPY8to4C0JlbO3Cs9jo8yKBUljgLJNf3
	6djGWZ85AK9pRZ18D9eM6/ZgkX6OteR7WHPWPVoa7bUntAnT9D0OL0pxfVBq4x5i+Z5Ivk
	LArXSAmEpOi2RJaj4xV+a0ZNiP5b+f0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BB013AE1;
	Fri, 20 Sep 2024 11:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOk6D/Zi7WbdHwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Fri, 20 Sep 2024 11:56:38 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v3 3/3] selftests: livepatch: test livepatching a kprobed function
Date: Fri, 20 Sep 2024 13:56:31 +0200
Message-ID: <20240920115631.54142-4-mvetter@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240920115631.54142-1-mvetter@suse.com>
References: <20240920115631.54142-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92FEF20A64
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
2.46.0


