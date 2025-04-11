Return-Path: <linux-kselftest+bounces-30541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC34A8573B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD749A630F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EAA298CA2;
	Fri, 11 Apr 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a/fTRq8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGm6WFo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF94C28FFD8;
	Fri, 11 Apr 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362111; cv=none; b=rtv69g5nM+FqEGCHqPHC9kE2R7D4CvhvXdGr+wmmSn18AQWCLhJTNHcW4rnzA1GNaP3zjbWgp6rHi5MPn6hDP5smi4c6zJA4h97/itbwZpE+VksaSc5SEX9DAx8RJBfluJ0xSGHeugUqQ4OkjxlAZEP8YG5TN0R8xrJkD+yfA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362111; c=relaxed/simple;
	bh=CkReCjorx7vJhS2pvgkt1IbcBluzvxPxy7odnUgPOyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H87ztNswFLVoV5Hq/Pq8r32aaIDQd7l1AgdUnc0QOzi6zyN98XM4LEGqrwbZtcZBOUZozsrQALExM9coDbXfc/jooxO21JR7L7pEUI0LqKcXdpVPKR5qIch6LPco/22d9WIwWSLyyPU1i9Of9soblRzLGudEBBSF9votAXTNrWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a/fTRq8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGm6WFo3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RboCJjwJSKbAAHccSZdmQVgKsM9gi3RLUt41m4jx2jA=;
	b=a/fTRq8cDMDBnzJjxFoejZzdq8cpGEGCzRx6m0RpxXha9IVZbsFLrjZpw3CDzWCtK3a5FS
	l6ErjXC4YpFuLt2QJ8KuDyzDMAnVfa5J6CpZTmATbRMq1850CB7bC/gqFKmS1k9QIsZJH7
	F2/QoO+EAfIbf/htQ6UR9nYU3UYYr2uOZsUAlbMbSluW5DMlqSj25A2faZZRUwIsvR4Xwn
	Hqk0vIrPWp+r+kpLGaXxzJ+JjqDja+EnkkEt0cIiPOcCcCF7VY2D2D11kPWYFYtPI+IJbr
	xX9gXsIy40b2SlvzvMya7hejN+sbHc2B55OXN3LSDZovj5cRZ2KOM+7do/DBcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RboCJjwJSKbAAHccSZdmQVgKsM9gi3RLUt41m4jx2jA=;
	b=BGm6WFo3OhQr6Lw2L6f2fUGsJhcZ/Lg1iuhZBk7pRH3R9oWxmw/OUV++czEUzGV3GG3t0A
	zyfjoJuOMegQJUCA==
Date: Fri, 11 Apr 2025 11:00:25 +0200
Subject: [PATCH v3 01/32] selftests: harness: Add kselftest harness
 selftest
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-1-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=8793;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CkReCjorx7vJhS2pvgkt1IbcBluzvxPxy7odnUgPOyo=;
 b=h1cG9FfeOn4xlf9NomzJO+rL1hbf9lA6Sand0740JkMzypCVXWAzFuErUN8k2T6NxAt04mGU2
 79V/U8CsrU8Bgvx223Sd7WbsbYUplHKJNvobwPzijluuFEbN3meSMuY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Add a selftest for the kselftest harness itself so any changes can be
validated.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 .../testing/selftests/kselftest_harness/.gitignore |   2 +
 tools/testing/selftests/kselftest_harness/Makefile |   7 ++
 .../selftests/kselftest_harness/harness-selftest.c | 129 +++++++++++++++++++++
 .../kselftest_harness/harness-selftest.expected    |  62 ++++++++++
 .../kselftest_harness/harness-selftest.sh          |  13 +++
 7 files changed, 215 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b82704950184bd71623ff41fc4df31e4c7fe87..9d5278df33c8b63b3b08155991b789b3a998f80e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21742,6 +21742,7 @@ F:	include/linux/seccomp.h
 F:	include/uapi/linux/seccomp.h
 F:	kernel/seccomp.c
 F:	tools/testing/selftests/kselftest_harness.h
+F:	tools/testing/selftests/kselftest_harness/
 F:	tools/testing/selftests/seccomp/*
 K:	\bsecure_computing
 K:	\bTIF_SECCOMP\b
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c77c8c8e3d9bdd8047c9cb7722c3830447e504e5..27592909a5969da009d71be6c8330fe6779e7354 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -48,6 +48,7 @@ TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
 TARGETS += kexec
+TARGETS += kselftest_harness
 TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
diff --git a/tools/testing/selftests/kselftest_harness/.gitignore b/tools/testing/selftests/kselftest_harness/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..e4e476a333c912602161448bc61787732a6fa2e2
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness/.gitignore
@@ -0,0 +1,2 @@
+/harness-selftest
+/harness-selftest.seen
diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..0617535a6ce424ff977e033b0a3a01c3117aefcf
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_GEN_PROGS_EXTENDED := harness-selftest
+TEST_PROGS := harness-selftest.sh
+EXTRA_CLEAN := harness-selftest.seen
+
+include ../lib.mk
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.c b/tools/testing/selftests/kselftest_harness/harness-selftest.c
new file mode 100644
index 0000000000000000000000000000000000000000..8d39e7a0b99c41a5d33edfe2dbf875cac04c098d
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.c
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
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.expected b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
new file mode 100644
index 0000000000000000000000000000000000000000..1aa6461db90d4e7cc0679f19b69aadf4032875ec
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.expected
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
diff --git a/tools/testing/selftests/kselftest_harness/harness-selftest.sh b/tools/testing/selftests/kselftest_harness/harness-selftest.sh
new file mode 100755
index 0000000000000000000000000000000000000000..fe72d16370fe5bc16706289ff4e1ff44db180017
--- /dev/null
+++ b/tools/testing/selftests/kselftest_harness/harness-selftest.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Selftest for kselftest_harness.h
+#
+
+set -e
+
+DIR="$(dirname $(readlink -f "$0"))"
+
+"$DIR"/harness-selftest > harness-selftest.seen || true
+
+diff -u "$DIR"/harness-selftest.expected harness-selftest.seen

-- 
2.49.0


