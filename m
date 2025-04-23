Return-Path: <linux-kselftest+bounces-31416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E76A98F91
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673151B80BCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B859B28BA8E;
	Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9VTdJx9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPiHloiK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DA28469B;
	Wed, 23 Apr 2025 15:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420508; cv=none; b=lYw49MPbIwiNhfynNMM23cfBpQuGbhb1z2KZp6xpDbiLTURIOhq+bnBi3B+GPdtXBXvpHjGLY/gPSMtbXPavaURna7NqkaYtk8yNASKcfCRU01izyaOkkaeZqhTlJQnb1W4LS77S9yOwl+rywa3XJnc1wqtNUcNMPc8pNzA0SvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420508; c=relaxed/simple;
	bh=vxoT92of/rlazXwaV9YXlg1WYXN/+U03gMMmCD+41y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C64vwQ1TIk8v+MOYqH2qUjacqrwa8uTthZSTDZjbMu4QjClqcawh/46WD06oOg4j1xmuNG/LeNgm94Eh6L1pjt962Zxa42F6UWkgc3sI0W3qArFKyTDMsFqu+AvbuKlGEWvPaYy1Y8ovtlDHzGajwsXdZOharLzGJpz5Nd4JHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9VTdJx9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPiHloiK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKJi5obWY5ETMlVCxwTzt0WlZX9v+939EY9af8zla/8=;
	b=f9VTdJx9wewfT1biawm7CSSNtiIXwWVlKbF3na10U54NbCBV+u8kI+Rmny2iwA3Kdl0uWP
	5cMfIzxUx9jNkUFOAUFcWP9tEXGjeW8qfaUm0BdsHXpKhLx0W4Aju4VmvsnSf/cDShdUU+
	fYwnGzNQAiyppNkuuaLjOJG3JL2cIRPNchBeoVlF6vIjtmwdkyKna+7iUJc4XXi3wkGduL
	IG5t+RP6IqqJHoQgmz+v4gFhBI+0xM9HKkwLY8z9s12hfQdBN08adHOHKY1hCQCPZQNiB1
	RsqPoCeh+KX2aedqbsohmqy4XNzjKeGCTX+skNF4XxE4cODU97XqmCAWm9lv4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKJi5obWY5ETMlVCxwTzt0WlZX9v+939EY9af8zla/8=;
	b=aPiHloiKog+oNTX5cL0sR44zKc7UgtstArQr8TJgYBhfAgzVbU0lpmvwn9y83TfuIBc/MF
	x0rABOUTWaNxp/CA==
Date: Wed, 23 Apr 2025 17:01:41 +0200
Subject: [PATCH 11/15] tools/nolibc: add difftime()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-11-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=1567;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=vxoT92of/rlazXwaV9YXlg1WYXN/+U03gMMmCD+41y8=;
 b=0JCWS5hFZRx4Av49TwqS3Jo6OqH6tDeA4kYh2G+y46p1j2JB3a1TNbKQgh20tVRfYF+yLAVV8
 S/S/CDpfMx2Da3xrBIQq+JQ7ZILMdWXGysklEkDP2wl7IY1eQdIV9lC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/time.h                  | 7 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 28a1549adb14e2087fa8fbdb7e9c35e1c3f22c2a..760133c574ece97165e3bba5616a387deaf07aff 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -105,6 +105,13 @@ int clock_settime(clockid_t clockid, struct timespec *tp)
 }
 
 
+static __inline__
+double difftime(time_t time1, time_t time2)
+{
+	return time1 - time2;
+}
+
+
 static __attribute__((unused))
 time_t time(time_t *tptr)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index aed71de4b4f3dd1f183c7fc25e5a5cee466600ed..fd8bab42e75157967658690005bc9142360fc135 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1423,6 +1423,7 @@ int run_stdlib(int min, int max)
 		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
 		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
 		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
+		CASE_TEST(difftime);                EXPECT_EQ(1, difftime(200., 100.), 100.); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


