Return-Path: <linux-kselftest+bounces-28166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA34A4D477
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6D1889475
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B971FCF74;
	Tue,  4 Mar 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHujb//n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZV9fPS+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD01FBEB3;
	Tue,  4 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072281; cv=none; b=o4i55imxnHIQk+WmdVNC0OAkbJfkuqyZEcmAwMAB67O1ft87ZZ6k3nfhbXwqa9BDAMcLzGm6AfvSPQiO+Zo45HJE9fzLfs6wjfKw3yV094qsKVkVgzStqN8c4iQFJpYeso6NXXg9zXRRKT4iPduJhTa7VWLo8KJLk8A9FXY4gkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072281; c=relaxed/simple;
	bh=dS++BGRUZ8SyBKb8wrBLyLZJ16G6+M6eh/EHuTJW21M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FILU2BDHELybl1os9jgN95VLzWUsb+rmrD/qziBN/dlJcir12P4mFLZ/ZTtDN+WGWpaqK3D9dcnX8Ph5gUt7vGQIWe1xoJB31wo/ZEM88wCZ+TDXK/HhlEhRMx4w8VwCY9+nKR64PIF+5IYEg1bN9WtUidwqRKXqHEsfi0kVoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHujb//n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZV9fPS+c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhj9O/bQAXH7Ixrn4zEe0m9E2qHXDCFbSeY2nHcL8ss=;
	b=GHujb//nwN0ap7Dn8LqsWs/k5aG3Pna/SLGixCpvB1cC2kr35SwS9BbonempJcBAudfB+2
	VUHI3gc3IDYIxtpgKwxvBG0ztCspy4WjgKxRSA5dTaBPZG/K7U7Unq2E2PC5nmoLRMBxbM
	WxCp8NaqRtWh8KabK4heu+2RbHFMlTT9b/JZ8NV8fAIl2W3rIjy8Cz66uTMKwnFnoQ1oSE
	ilGVxMuTH3I0WBnKs5aOzioINBJeGKioOCd6TCTVIe5rbo5xYweX/QgqZp8oIKTieZPSG1
	rS33PGE2AqRYF3CA/SZXsJZE5paAzTmYHJeeRPlIDr0aejMAZo0ihbGlDkz1sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mhj9O/bQAXH7Ixrn4zEe0m9E2qHXDCFbSeY2nHcL8ss=;
	b=ZV9fPS+caiLrSUiTQmKmqN3euaLYtnBGyaP+lsuZjcpOGWB/5r0VXveMQ0gCsomLnaqnoB
	6e6kxjHvLb/zbhCg==
Date: Tue, 04 Mar 2025 08:10:48 +0100
Subject: [PATCH 18/32] tools/nolibc: add tolower() and toupper()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-18-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=2172;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dS++BGRUZ8SyBKb8wrBLyLZJ16G6+M6eh/EHuTJW21M=;
 b=A0T7CIeiH6BRy9KRrOkb20Zy9rX0C7YMyWvpDQ/nB5nDmMnUdbsKuO7aQUSV2PHgogr/UHYL6
 1DaQ1G8VHyKB+UHAo8APcHMrkB+f7teAOj3jr2wNeUy+Ol3vuqM69Lu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The kselftest harness uses these functions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/string.h                | 17 +++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  5 +++++
 2 files changed, 22 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index ba84ab700e3001a7d105e1c9e40c01bf45db9d8c..f0d335f0e467ec870066811289dfd11e46e60a92 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -289,6 +289,23 @@ char *strrchr(const char *s, int c)
 	return (char *)ret;
 }
 
+static __attribute__((unused))
+int tolower(int c)
+{
+	if (c >= 'A' && c <= 'Z')
+		return c - 'A' + 'a';
+	return c;
+}
+
+static __attribute__((unused))
+int toupper(int c)
+{
+	if (c >= 'a' && c <= 'z')
+		return c - 'a' + 'A';
+	return c;
+}
+
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3c0431e9917acf57e94dc3f7a8347762e6a5335a..7eb7f3fb067553cccefefdaa2ccfc81af281336b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -40,6 +40,7 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <limits.h>
+#include <ctype.h>
 #endif
 #endif
 
@@ -1264,6 +1265,10 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strerror_EINVAL);         EXPECT_STREQ(is_nolibc, strerror(EINVAL), "errno=22"); break;
 		CASE_TEST(strerror_int_max);        EXPECT_STREQ(is_nolibc, strerror(INT_MAX), "errno=2147483647"); break;
 		CASE_TEST(strerror_int_min);        EXPECT_STREQ(is_nolibc, strerror(INT_MIN), "errno=-2147483648"); break;
+		CASE_TEST(tolower);                 EXPECT_EQ(1, tolower('A'), 'a'); break;
+		CASE_TEST(tolower_noop);            EXPECT_EQ(1, tolower('a'), 'a'); break;
+		CASE_TEST(toupper);                 EXPECT_EQ(1, toupper('a'), 'A'); break;
+		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.48.1


