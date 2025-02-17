Return-Path: <linux-kselftest+bounces-26773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F69A3814B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259951898C31
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 11:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E021C162;
	Mon, 17 Feb 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONGDfXut";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gpiIGnMv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3F21A459;
	Mon, 17 Feb 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790045; cv=none; b=Wu56MZUldcf3ORkkol8/FvAWPHf6fQqdAnpQcAu4DTlMM5qRzf0Mwu/uZ7YmYZjGrjXnBD/EDBs3AYDcBRqZU3jlNOWSia6JmktN4HgXb1Hz98iWDIGf53gvog0Of9JbbDdHJO1UpWsTSaAeN2ljAKzBhdQKShPZ0H1dsyiKzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790045; c=relaxed/simple;
	bh=qQOtnhqjbowoR++2Gs0vMxIajpjUcYwkX+qFpvXJshM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uaOkBbFlbfhbvyZ9WfH3vplUKo1xY9LEYoLhcgukmRGYptGXLg9ERQ5iMC9fHtvkG1fvLv6Y1oR0T1j/a+UQI098XQxQFQhGZPUg+9i2moet0P8xEPF6JOggFjitjZRnbC+YfLEcE9M0RiGAV3/x7U2XcYJC0n9qMt/TBDdIJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONGDfXut; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gpiIGnMv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739790042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTa8C4WECe/JmINcH8JHCZeuSOeK2AhNliXotOoWH50=;
	b=ONGDfXutlPsptMbMJv0b3cQ8/AqBbddswe3f1+x5I+gRAK5MzhF3LM1kZHhGC4Itu4AMHv
	1qQsZud/4g+8aefsYzwvB4a1+7I2wyFDX+do7NyBBmzPWSr45dR3b+DjW+eG/s/hk66TwQ
	zgFb66by21AaVyXpe4SVtkfTH9G1neC5ugNuOEyhOmg23uMenMUYvvjiKhnm8gPzSc0tpa
	eGTj7NbAiQ1JF/euCZG+PtfqYD3fwJKmrCGWu8tyOpWbxDY/kI4qyjUtdhmGstpW2gjJ0X
	9YkQtW4RvwJ5CCQAltlz522O0CRBDmcIEhGN1fF/BWmHttPflwDoyYT/kuwz1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739790042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTa8C4WECe/JmINcH8JHCZeuSOeK2AhNliXotOoWH50=;
	b=gpiIGnMvHhcfubZVMnjoD5cDdhQbaLt4iDJKP4AK1UukjjNPLVGGSss/fVS5poF0c6swo5
	9e5d7oFYs52OAaAA==
Date: Mon, 17 Feb 2025 11:59:32 +0100
Subject: [PATCH 12/12] kunit: uapi: Validate usability of /proc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-kunit-kselftests-v1-12-42b4524c3b0a@linutronix.de>
References: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
In-Reply-To: <20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739790034; l=1757;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=qQOtnhqjbowoR++2Gs0vMxIajpjUcYwkX+qFpvXJshM=;
 b=Sk0sCINZHEGGMT3LpKGAEPlP2h61lYlX1X63SvD7xk0roo/+/E3TN8tSXGKAQ9vFoBLwYerNC
 F1ffVsrfNBbDlOCbhyxzQCOLAOi/Lv+Jjb4eFxHNIyH8gqu0ziJN4pu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show that the selftests are executed from a fairly "normal"
userspace context.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/kunit-uapi-example.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-uapi-example.c b/lib/kunit/kunit-uapi-example.c
index 4ec4b924f29b089cce9ca5b2b08a6ee0117b8ae9..f7376e524b4c76a9c6d474e6ace80a8e2517b84b 100644
--- a/lib/kunit/kunit-uapi-example.c
+++ b/lib/kunit/kunit-uapi-example.c
@@ -6,13 +6,51 @@
  * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
  */
 
+#ifndef NOLIBC
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#endif
+
 #include "../../tools/testing/selftests/kselftest.h"
 
+static void test_procfs(void)
+{
+	char buf[256];
+	ssize_t r;
+	int fd;
+
+	fd = open("/proc/self/comm", O_RDONLY);
+	if (fd == -1) {
+		ksft_test_result_fail("procfs: open() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	r = read(fd, buf, sizeof(buf));
+	if (r == -1) {
+		close(fd);
+		ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	close(fd);
+
+	if (r > 0 && buf[r - 1] == '\n')
+		buf[r - 1] = '\0';
+
+	if (strncmp("kunit-uapi-exam", buf, sizeof(buf)) != 0) {
+		ksft_test_result_fail("procfs: incorrect comm: %s\n", buf);
+		return;
+	}
+
+	ksft_test_result_pass("procfs\n");
+}
+
 int main(void)
 {
 	ksft_print_header();
 	ksft_set_plan(4);
-	ksft_test_result_pass("userspace test 1\n");
+	test_procfs();
 	ksft_test_result_pass("userspace test 2\n");
 	ksft_test_result_skip("userspace test 3: some reason\n");
 	ksft_test_result_pass("userspace test 4\n");

-- 
2.48.1


