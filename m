Return-Path: <linux-kselftest+bounces-31767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8516A9F0F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFB63B3C5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFFA269D1B;
	Mon, 28 Apr 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dmb9pnfS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ShyGXnKj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216231DE2D8;
	Mon, 28 Apr 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844012; cv=none; b=o+/3wYdf52YczU8iwSeztTv8f93MmrOve2vQ7gKHvpbt2hygwOu8MNl3DMlfktpGBu563McYijNqnEZfNzzafva2JC2WZe9Vm1w5SIMpQuSocpGTDciBu1REFw9JWGSmB6jiu8c78p+XzLDmwTd/8r745kIWfIPZltJ16p+KTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844012; c=relaxed/simple;
	bh=Xp8uvOhEOR7fzrNm6CzmO37fl3vDnAQUpFelxCvuGQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlmYgcfvHFxSrs00vhhszyQWiUUCjVCBvnTEm9yvk5RB57bCKo3ShFujdJZSH4lsE6E/H+F0KU0tTxkDIHdM+TwMtKM4D2QD3/8/WDuQY6FqsplCtSZDMeIjlxB1b78e5OHQcFK/RjPKjxCqf6RVlpvRjb9tYGUeNirHsWe9UZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dmb9pnfS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ShyGXnKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olD03ixj73yylxhDK+TZykboubChwemnqnc4p5noK1c=;
	b=Dmb9pnfSPqi2SbQ4JR91LuqLzn1zFd2u5fQI17mbpWZm55uRv17Gtpw8bXPhht9U/L4NmV
	ocZOhyKEbD0ZJhgde0RMd5UWY8beU1Ay64WhTCElimJblxuRouWvSTGticaW8EHUcpCqZF
	34ktDF/7396bFE6JiwQA/j49yeipSrerBxRiT8qF9bhub8MdOr5adTOkOxZNmkrBOf+CHY
	oVVZ2qkNVvV8x3f9d5BhQDn42WMoLStkVgTFacU9GZvBdC2m+bjYex0vJnxxeSWpltNP70
	MHbfJQ4i+FCtGS6jJyE6Uo0w3ztFVwvix/Vv7ikq3hoRnso+6VsL95OcG2FE+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olD03ixj73yylxhDK+TZykboubChwemnqnc4p5noK1c=;
	b=ShyGXnKjP2Bzu8ASp8pB0930Vq26JbsvKq8NFgpXpPTknHRABrHc7iSfU/cefbb7jNY3CQ
	zPIbrqrs5rTLe+Ag==
Date: Mon, 28 Apr 2025 14:40:02 +0200
Subject: [PATCH v2 01/15] tools/nolibc: add strstr()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-1-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=2439;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Xp8uvOhEOR7fzrNm6CzmO37fl3vDnAQUpFelxCvuGQc=;
 b=j7/wUUWFWKiTQahLuqPUfMNRG/hoTvJCh1SqjZHGN4A4q301fmwUNt9byBWLOI7zrIZEjDM1g
 X6xrJzhYFcuA+HRCDwHCLJT3IyT7yK476D0jRKhZVMBm1cMWt+vugQL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h                | 20 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index febfd69789666e2445b82423a5f4df5e18a1c774..163a17e7dd38b48ba8d9218e10733b3600710477 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -292,6 +292,26 @@ char *strrchr(const char *s, int c)
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


