Return-Path: <linux-kselftest+bounces-30187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05191A7D488
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C9A3ABFD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195BE225405;
	Mon,  7 Apr 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jt4tp3Gd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npUPD208"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FC211A39;
	Mon,  7 Apr 2025 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008783; cv=none; b=auLnCVDb9QBuS3y/0tu1WjOyeCNRVQa5SkQSA/ocbGE6gjhF8vf1sMctTuCdQnV5AAEJqyiPr4iZ8eKRY1l6DTaFarU7rEiDOm1eyuV79XQumgsR16SYo2NVIAcG3IG9ziEmI7Y2jjAHD8lIP/OJQqR/STy8mU/NRYiqj3cFMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008783; c=relaxed/simple;
	bh=IbF3dpnbmDMqynvxHeCn++RKSL483IkiGlufXOYi80g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khjRjMmR6dTCu4nPrKRY5hmk/CpfvywCSKPW8O8DFqyxcTuJbz223cz7nS6Pc3M3RdB6sV7HoAEmIUaeQKUqSI7royOT0O9kOesk6vlMqrnPNdOayize7Gcw/FcPESNfJ6a6pnUDLQVzUjcwsCSNt9j/gO9anGYEji0jIKd6YUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jt4tp3Gd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npUPD208; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/CF9Pf6s9VZiCzyI0O7TZZkfoFNszIhPXCLoc65GcE=;
	b=Jt4tp3GdDcN9ha6tI+qm0VijAzPG7lwxdW5//SjYJE7yZMZCoVxkw/x9aqZPxyPcNjPwdc
	gNVC69CkL24iP9QzSn00F3HB6oWH/kIz8sU4W4mP/TA/Nea9onCQ/KP3akpiLpAgwDS6ot
	8fFOV2jc/u4fa4Nw/kcxTbk/KufqBJwRHS08RGCtLXNwwCrUkbpINI1jaHe2XMi5Ewdc8k
	BJbm3hY+firmisF7Cawzz2iTkqQGu1aZzVVRQEP8rQbG5kSx+ouEP8qL3xp5lv5L22ToN5
	kc1KIYPRemnvjD/KTxqm0bXZj10mwb2ZH4+MGnW9QRSNEDYk61M/5VEpYunEFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/CF9Pf6s9VZiCzyI0O7TZZkfoFNszIhPXCLoc65GcE=;
	b=npUPD208aRLvMjW5QCqty4uLxh4FLzgqgzurOU30fsAVRi1nyl1sd5VI6RfD2L0Qhhuhte
	KeIqoh5iNXrmMAAQ==
Date: Mon, 07 Apr 2025 08:52:24 +0200
Subject: [PATCH v2 01/32] selftests: harness: Add harness selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-1-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=8071;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IbF3dpnbmDMqynvxHeCn++RKSL483IkiGlufXOYi80g=;
 b=SBsBbKZurUN3do7JpyLZaXjULL+AKmFtwrlo6Q6lwCeqgRZkDsLu+WTysEfeB3zXkQOGVGFrO
 WAuxHvgWN91AhQKCtG0yPU2CRI06CPFh52X3V5IIAOlC+Xehir9Ixv1
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a selftest for the harness itself so any changes can be validated.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/kselftest/.gitignore       |   1 +
 tools/testing/selftests/kselftest/Makefile         |   6 +
 .../testing/selftests/kselftest/harness-selftest.c | 129 +++++++++++++++++++++
 .../selftests/kselftest/harness-selftest.expected  |  62 ++++++++++
 .../selftests/kselftest/harness-selftest.sh        |  14 +++
 6 files changed, 213 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c77c8c8e3d9bdd8047c9cb7722c3830447e504e5..3ce071eefa86af59aadd1df7972fdf3bf6e01d52 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -48,6 +48,7 @@ TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
 TARGETS += kexec
+TARGETS += kselftest
 TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
diff --git a/tools/testing/selftests/kselftest/.gitignore b/tools/testing/selftests/kselftest/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..9aab194e8ea25a2c5ccc116f9f728b8afd0c51c4
--- /dev/null
+++ b/tools/testing/selftests/kselftest/.gitignore
@@ -0,0 +1 @@
+/harness-selftest
diff --git a/tools/testing/selftests/kselftest/Makefile b/tools/testing/selftests/kselftest/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..2f2933553dbc47014d9dfe0b4bd8ad3bc36e38c2
--- /dev/null
+++ b/tools/testing/selftests/kselftest/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS_EXTENDED := harness-selftest
+TEST_PROGS := harness-selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/kselftest/harness-selftest.c b/tools/testing/selftests/kselftest/harness-selftest.c
new file mode 100644
index 0000000000000000000000000000000000000000..8d39e7a0b99c41a5d33edfe2dbf875cac04c098d
--- /dev/null
+++ b/tools/testing/selftests/kselftest/harness-selftest.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+
+#ifndef NOLIBC
+#include <sys/resource.h>
+#include <sys/prctl.h>
+#endif
+
+/* Avoid any inconsistencies */
+#define TH_LOG_STREAM stdout
+
+#include "../kselftest_harness.h"
+
+TEST(standalone_pass) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	EXPECT_EQ(0, 0);
+	TH_LOG("after");
+}
+
+TEST(standalone_fail) {
+	TH_LOG("before");
+	EXPECT_EQ(0, 0);
+	EXPECT_EQ(0, 1);
+	ASSERT_EQ(0, 1);
+	TH_LOG("after");
+}
+
+TEST_SIGNAL(signal_pass, SIGUSR1) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	TH_LOG("after");
+	kill(getpid(), SIGUSR1);
+}
+
+TEST_SIGNAL(signal_fail, SIGUSR1) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 1);
+	TH_LOG("after");
+	kill(getpid(), SIGUSR1);
+}
+
+FIXTURE(fixture) {
+	pid_t testpid;
+};
+
+FIXTURE_SETUP(fixture) {
+	TH_LOG("setup");
+	self->testpid = getpid();
+}
+
+FIXTURE_TEARDOWN(fixture) {
+	TH_LOG("teardown same-process=%d", self->testpid == getpid());
+}
+
+TEST_F(fixture, pass) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	TH_LOG("after");
+}
+
+TEST_F(fixture, fail) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 1);
+	TH_LOG("after");
+}
+
+TEST_F_TIMEOUT(fixture, timeout, 1) {
+	TH_LOG("before");
+	sleep(2);
+	TH_LOG("after");
+}
+
+FIXTURE(fixture_parent) {
+	pid_t testpid;
+};
+
+FIXTURE_SETUP(fixture_parent) {
+	TH_LOG("setup");
+	self->testpid = getpid();
+}
+
+FIXTURE_TEARDOWN_PARENT(fixture_parent) {
+	TH_LOG("teardown same-process=%d", self->testpid == getpid());
+}
+
+TEST_F(fixture_parent, pass) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	TH_LOG("after");
+}
+
+FIXTURE(fixture_setup_failure) {
+	pid_t testpid;
+};
+
+FIXTURE_SETUP(fixture_setup_failure) {
+	TH_LOG("setup");
+	self->testpid = getpid();
+	ASSERT_EQ(0, 1);
+}
+
+FIXTURE_TEARDOWN(fixture_setup_failure) {
+	TH_LOG("teardown same-process=%d", self->testpid == getpid());
+}
+
+TEST_F(fixture_setup_failure, pass) {
+	TH_LOG("before");
+	ASSERT_EQ(0, 0);
+	TH_LOG("after");
+}
+
+int main(int argc, char **argv)
+{
+	/*
+	 * The harness uses abort() to signal assertion failures, which triggers coredumps.
+	 * This may be useful to debug real failures but not for this selftest, disable them.
+	 */
+	struct rlimit rlimit = {
+		.rlim_cur = 0,
+		.rlim_max = 0,
+	};
+
+	prctl(PR_SET_DUMPABLE, 0, 0, 0, 0);
+	setrlimit(RLIMIT_CORE, &rlimit);
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/kselftest/harness-selftest.expected b/tools/testing/selftests/kselftest/harness-selftest.expected
new file mode 100644
index 0000000000000000000000000000000000000000..1aa6461db90d4e7cc0679f19b69aadf4032875ec
--- /dev/null
+++ b/tools/testing/selftests/kselftest/harness-selftest.expected
@@ -0,0 +1,62 @@
+TAP version 13
+1..9
+# Starting 9 tests from 4 test cases.
+#  RUN           global.standalone_pass ...
+# harness-selftest.c:16:standalone_pass:before
+# harness-selftest.c:19:standalone_pass:after
+#            OK  global.standalone_pass
+ok 1 global.standalone_pass
+#  RUN           global.standalone_fail ...
+# harness-selftest.c:23:standalone_fail:before
+# harness-selftest.c:25:standalone_fail:Expected 0 (0) == 1 (1)
+# harness-selftest.c:26:standalone_fail:Expected 0 (0) == 1 (1)
+# standalone_fail: Test terminated by assertion
+#          FAIL  global.standalone_fail
+not ok 2 global.standalone_fail
+#  RUN           global.signal_pass ...
+# harness-selftest.c:31:signal_pass:before
+# harness-selftest.c:33:signal_pass:after
+#            OK  global.signal_pass
+ok 3 global.signal_pass
+#  RUN           global.signal_fail ...
+# harness-selftest.c:38:signal_fail:before
+# harness-selftest.c:39:signal_fail:Expected 0 (0) == 1 (1)
+# signal_fail: Test terminated by assertion
+#          FAIL  global.signal_fail
+not ok 4 global.signal_fail
+#  RUN           fixture.pass ...
+# harness-selftest.c:49:pass:setup
+# harness-selftest.c:58:pass:before
+# harness-selftest.c:60:pass:after
+# harness-selftest.c:54:pass:teardown same-process=1
+#            OK  fixture.pass
+ok 5 fixture.pass
+#  RUN           fixture.fail ...
+# harness-selftest.c:49:fail:setup
+# harness-selftest.c:64:fail:before
+# harness-selftest.c:65:fail:Expected 0 (0) == 1 (1)
+# harness-selftest.c:54:fail:teardown same-process=1
+# fail: Test terminated by assertion
+#          FAIL  fixture.fail
+not ok 6 fixture.fail
+#  RUN           fixture.timeout ...
+# harness-selftest.c:49:timeout:setup
+# harness-selftest.c:70:timeout:before
+# timeout: Test terminated by timeout
+#          FAIL  fixture.timeout
+not ok 7 fixture.timeout
+#  RUN           fixture_parent.pass ...
+# harness-selftest.c:80:pass:setup
+# harness-selftest.c:89:pass:before
+# harness-selftest.c:91:pass:after
+# harness-selftest.c:85:pass:teardown same-process=0
+#            OK  fixture_parent.pass
+ok 8 fixture_parent.pass
+#  RUN           fixture_setup_failure.pass ...
+# harness-selftest.c:99:pass:setup
+# harness-selftest.c:101:pass:Expected 0 (0) == 1 (1)
+# pass: Test terminated by assertion
+#          FAIL  fixture_setup_failure.pass
+not ok 9 fixture_setup_failure.pass
+# FAILED: 4 / 9 tests passed.
+# Totals: pass:4 fail:5 xfail:0 xpass:0 skip:0 error:0
diff --git a/tools/testing/selftests/kselftest/harness-selftest.sh b/tools/testing/selftests/kselftest/harness-selftest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..bf691adf0b41aaedb2fbc5f06add9fd1d5689044
--- /dev/null
+++ b/tools/testing/selftests/kselftest/harness-selftest.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for kselftest_harness.h
+#
+
+DIR="$(dirname $(readlink -f "$0"))"
+
+TMPFILE="$(mktemp)"
+trap 'rm "$TMPFILE"' EXIT
+
+$DIR/harness-selftest > "$TMPFILE"
+
+diff -u "$DIR"/harness-selftest.expected "$TMPFILE"

-- 
2.49.0


