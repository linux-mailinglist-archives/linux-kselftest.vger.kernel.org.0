Return-Path: <linux-kselftest+bounces-28150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9F8A4D453
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A965F1896313
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77471F76B5;
	Tue,  4 Mar 2025 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2uC4DEku";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nrw6wdu5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E11F4E2F;
	Tue,  4 Mar 2025 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072272; cv=none; b=kPIrWdGwbb9rFJ5FartkXaC4ylmQ5kFJzr2RSZJPMmBtyWmnZxgtOmpWbEIbwWK3+wIOFHAgqcaBjtINfa0Yd6chksf1+XXX/XlbkoQyUbpUB/JdhC3EyyfSZNSkjkmzTKwcXGv/S19w2RGml1Z87vK1uvpba4ZdZrAmMveYako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072272; c=relaxed/simple;
	bh=5E53xutj7i2avw8mFb+DigExVkA7zqotHlVeTrlc3hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qe0C4ZuckLB9ltOSbJLUholsSgJFc5W1uW/BLSK1kAc8ExFnZJ2NWCYwQ3FAUvZh2QXxJ29j39oz+g9KQldC85mz7suTkk82Lpt1Rvrudihbm97ZFtTMqe00qSCBOjwMKdvzkrDq3jvpQqV5xpsN1gWKqZ7lx4aIrJAOy+IYwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2uC4DEku; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nrw6wdu5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbv4A12A6jXVb6GKM0Y5XVn83MHnBukUqH/KkZzQ2zU=;
	b=2uC4DEku9RlPlztQ24hBDq12OqD5zGm3wV4wCw9EvOiy/qdm8tkl0yXopdvcsjEJrV2oKs
	xlRTORduLJwhcWwUbeJBfBt+Klm07d4v5SJ2GO5LwEzQO3ZPdfy4uKUQu3xIyzLSAqT8zT
	PzCo1PBeS47rSPPHxsitZWSMIi+D/bE5hmSNUA9hHy8ClYQzxOd5l5yOjzBfTHhf7nfIUa
	bcrky83BtWuJotZa+t8QD2bdIhMeQMQPy2lxGgEb/xb7aWlRXXVzay2xvUeIErT9visySQ
	qbQk0eTvD0Y8OR2bN3OK5hKB6EfW3jtoo7bAP0t89fn8pLyq0sxzpWyVVGf62A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbv4A12A6jXVb6GKM0Y5XVn83MHnBukUqH/KkZzQ2zU=;
	b=Nrw6wdu5YAaZybmcEPqg3o46wzU+3CM+mBifEVZfQ3CaSupgxyV+cRbFRaERn7OZDMm4ev
	QoCqkTjMrhO4hmDA==
Date: Tue, 04 Mar 2025 08:10:31 +0100
Subject: [PATCH 01/32] selftests: harness: Add harness selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-1-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=8071;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5E53xutj7i2avw8mFb+DigExVkA7zqotHlVeTrlc3hc=;
 b=9a0Kvr7LG843JuYaUFMcjafyj9tvK/NS1DmEx82SsEBpYBGNNqgErq36fvAx9q/OMIv1HPv+H
 c+Fd44vvZI3BT31ejEAp/sf34tS1D59BZX4wgjHZ/VstifMzP1wH9Kv
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
index 8daac70c2f9d2c41be51f421b9c1e27eeee8bede..bea454100f4fef1c2c225ea82004bd52c6e6a397 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -47,6 +47,7 @@ TARGETS += ipc
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
2.48.1


