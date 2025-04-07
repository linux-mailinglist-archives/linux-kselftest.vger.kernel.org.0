Return-Path: <linux-kselftest+bounces-30232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78958A7D69C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 09:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCDAE1885E36
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84F22B8C2;
	Mon,  7 Apr 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RVJtXjbw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="muD2AkzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA1229B37;
	Mon,  7 Apr 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011789; cv=none; b=pgcVRkCdtvk0AwsApj61ouK6jEXYKf4RmvaYj+QkKY98pXDxox/+v4JuqIYNRpu9ImCP19XNRWUoBBMChKR2qTJ33GHMik6ED5dz0YzQM1Ftcsh3zDVjD85L4FDlLODmM6wo360tBbbiiamVAoQWLb24TLTzq4hCIYxB8R2EOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011789; c=relaxed/simple;
	bh=Xu0nGb1RBd1CDhyD0m7yCE3cioNquNLySTJFGTDwjao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0KQmyMLG3BH8eX5t3Dxdb1/rxXhY7YQPor2oambFViVBGmNJnfjq5CqpDqSTpYRd8eh3t5BuUoHEDL21k9SWdRr8tGV6oWTjUrGhdeoeVxBj9pAq+lk0vmLPxHp1T9Jr5glJWwe3qPw+hnDNJ17NUrGppJN0SqFd6sHex0Xz6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RVJtXjbw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=muD2AkzR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh2unyChEPBf9y7CX/RyBwfskSXNSGnqSQiwlf+aj58=;
	b=RVJtXjbwy7sozind3uDpXZ4nMXH19nxGBDnFxlf2qZ5bawYGkIAmc4G9hM1Kx5gz+nfp2f
	TCG49yZb6ECoLcr1tSqaQCo4BpH2MclAOXlhJIR7e9tSO7vW7IgUakh03Pyuoo4QSAx/Lk
	8xoLgvWl3DMabRfNqL30TiMHGHh3lNIpRQpzUnq4vMl4SBlXtzvERa27DvH5w8ssfiA6ig
	CRgwoIOy/eGz1Bnkn4AXa3FL5khH2Tjt9ZoUQiAhob1tLxmHwcFexiUcDZn5E60XwMvgEQ
	whS99NQavWc3JwywfirrRZeOh4SaxZNpCmPnAvQFpe+KgLZOjvgr0P/3+AHyzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fh2unyChEPBf9y7CX/RyBwfskSXNSGnqSQiwlf+aj58=;
	b=muD2AkzRJwItNBC+oQNRwwODIMyO4dMt1xuUZ2OqMSAKU8Tcbyy76kUgbVQsCHKjsxgKCT
	sgP9XK6XYWiyybCg==
Date: Mon, 07 Apr 2025 09:42:48 +0200
Subject: [PATCH v2 11/11] kunit: uapi: Validate usability of /proc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-kunit-kselftests-v2-11-454114e287fd@linutronix.de>
References: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
In-Reply-To: <20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744011776; l=1637;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Xu0nGb1RBd1CDhyD0m7yCE3cioNquNLySTJFGTDwjao=;
 b=9+Ci04x9JPHWfBiiC85eaitNDlilTzJtZJ7o0CBVN3RWJtjvGW+OUEyH06U2XAd4V8XpX5u8Q
 G1PdRLPg325C8zFfrPvccqNtmTdS1mG4GzXWe6c2tH38ic27egE5NLB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show that the selftests are executed from a fairly "normal"
userspace context.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/kunit-example-uapi.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uapi.c
index 4ce657050dd4a576632a41ca0309c4cb5134ce14..d121c4620716aadddc38a1d5845e4b51e721fb67 100644
--- a/lib/kunit/kunit-example-uapi.c
+++ b/lib/kunit/kunit-example-uapi.c
@@ -8,13 +8,47 @@
  * This is *userspace* code.
  */
 
+#ifndef NOLIBC
+#include <fcntl.h>
+#endif
+#include <unistd.h>
+#include <string.h>
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
+	close(fd);
+
+	if (r == -1) {
+		ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (r != 16 || strncmp("kunit-example-u\n", buf, 16) != 0) {
+		ksft_test_result_fail("procfs: incorrect comm\n");
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
2.49.0


