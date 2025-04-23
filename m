Return-Path: <linux-kselftest+bounces-31405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4AA98F3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D5717CFA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94C6284B2F;
	Wed, 23 Apr 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bD2OSUXq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otOppsYY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610928469B;
	Wed, 23 Apr 2025 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420502; cv=none; b=C/MkMgZEinLwT2oXWn+dTqOjba3xIxLBQrtTsUo4O8iZC7X89BR3eKhH37lTcZOTPL/E9ZevK7s1B65t4sNv4ewX/H2Pw/9wGvI3roYrOjKe2K+UlEZEHuCdAd2XcgW273OmQLyA0m8ZFCZoFPUaFkrGA1uEK1KAj1aMPJrx/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420502; c=relaxed/simple;
	bh=jX6My3jcrxavMP5EesEhuX0EJNp3o2ftH7MFb8jfw3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJQiKYtcrRnz9vmFQEA1NeznYfOWQlly7VW+Fl3cubHgleNAooTbO2+VPcT+ODPnVAkNi6V0KYJjZJGkWPPkRTmUxVJGkL7+NT2aMcPeI+JrXal6bpu6NkzSEJ/FYEkJGWzoi1k36zhQTpV5XAYgmTKYP0SECgRj2S+wpKajz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bD2OSUXq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=otOppsYY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYPtxUj1uqJvzEWy6ALyMeU9sbBmbB2jbaGAAmmgheY=;
	b=bD2OSUXqcGq5XNElXb5siEgtCK/VPvjKDe/8oXg6AMPttkVAQbxr1TkU6Ffn90BGYMfWtw
	lJEhZgLmWo4HUtH+ipCVJGl4tHhWcKr9+g4ELvi8QLUa47kEU7X6aD3tlVplbX+BbDOHxa
	JYII3cOEi9Uxp5KONA/XEnCGtLdDWmarVVuZESaNI5p9us1/5xo2RtPc/3W5QOnwq8Ohjb
	GHYcwXVnDN0rI4tAdlbA/5yfYsQM+9jpvfCevN4Qj8QkkxzuPlfEc0K2PBd6tVMdm5qyOZ
	HSiych4xQbOQ5QpAxy9r+nH4ZxvistiONvlVmYYtH28+hmdfyC2/MDova172RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYPtxUj1uqJvzEWy6ALyMeU9sbBmbB2jbaGAAmmgheY=;
	b=otOppsYYEUbPfIY2g7WlTXN73NsSn207jWqBGXHg9zOGNBqYRGz2XYcJPAMIrUJeBzAetD
	exDqQ+LdJL+QToCA==
Date: Wed, 23 Apr 2025 17:01:31 +0200
Subject: [PATCH 01/15] tools/nolibc: add strstr()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-1-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=2403;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jX6My3jcrxavMP5EesEhuX0EJNp3o2ftH7MFb8jfw3g=;
 b=ioqG/7hgeKH6ZECd/6WrFY0NZRK82KCFNKZ5B1pnkO53UfP3/W0GtZFAmNplOAuFv+08AsxPH
 Dh9F1dzQ8uQD+0lmbCuEypmvv6qAiJaWwz95GgQz02ZWTPnA1ST9eYY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/string.h                | 20 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f0d335f0e467ec870066811289dfd11e46e60a92..b7b2b93bc90c9330dec7186d45c18fd3f24373d0 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -289,6 +289,26 @@ char *strrchr(const char *s, int c)
 	return (char *)ret;
 }
 
+static __attribute__((unused))
+char *strstr(const char *haystack, const char *needle)
+{
+	size_t len_haystack, len_needle;
+
+	len_needle = strlen(needle);
+	if (!len_needle)
+		return NULL;
+
+	len_haystack = strlen(haystack);
+	while (len_haystack >= len_needle) {
+		if (!memcmp(haystack, needle, len_needle))
+			return (char *)haystack;
+		haystack++;
+		len_haystack--;
+	}
+
+	return NULL;
+}
+
 static __attribute__((unused))
 int tolower(int c)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1ad0db92f0ed47f708363b2e558717fa0e686b8f..3e15a25ccddf5135db1f59bce1eefdff2ffe57f6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1211,6 +1211,9 @@ int run_stdlib(int min, int max)
 		CASE_TEST(strlcpy_2);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 2), buf, 3, "b"); break;
 		CASE_TEST(strlcpy_3);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 3), buf, 3, "ba"); break;
 		CASE_TEST(strlcpy_4);          EXPECT_STRBUFEQ(is_nolibc, strlcpy(buf, "bar", 4), buf, 3, "bar"); break;
+		CASE_TEST(strstr_foobar_foo);  EXPECT_STREQ(1, strstr("foobar", "foo"), "foobar"); break;
+		CASE_TEST(strstr_foobar_bar);  EXPECT_STREQ(1, strstr("foobar", "bar"), "bar"); break;
+		CASE_TEST(strstr_foobar_baz);  EXPECT_PTREQ(1, strstr("foobar", "baz"), NULL); break;
 		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
 		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
 		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;

-- 
2.49.0


