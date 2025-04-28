Return-Path: <linux-kselftest+bounces-31777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B49AA9F105
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8AA1880703
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D626FD9C;
	Mon, 28 Apr 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fChPIF4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQC7BTt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F726D4F3;
	Mon, 28 Apr 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844018; cv=none; b=CReh8ez1fpuvVbX+X+8S66Kl1G6SUhbjF2KGV5uW12GT2aZXztekbI6+dV8XJRwX56XglOZjLFOTvpVqqD5hYxC1l+OaEcscG7skqlFAcvwhzigeMK/uh1D9QpoHr4ZTrCl67LGvBGAQQgLcVIiAI22VAnj7pE6bFO64tl4qhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844018; c=relaxed/simple;
	bh=TSTWz+qX8Q+FXXbscSdm+0zq+oKFJszOahA9pWCFjRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vE3NpXi7eOzmFsZKakwaSFm7Z9ZiWqW3kukBGAUyCKKKayshWf2Zt8lkoVbPHmbpobpD/qR8OEUJOOVHCDzLZxqmWIHQICpxI3jViEfJXbN9o9DCGRUZKUZAN+1mi0TXvYXdIXjwePbJ6ICO4x3AhzDSjxb4+uSWmDdJn5UD4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fChPIF4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQC7BTt9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/M4ZkI+BDRIkqDPmauaPsLvEjDOe/PrNi79VD9UYdC8=;
	b=fChPIF4IKQVqMgMriTg58aAa7W1USbuqhpVrJfdt+7j/NNtg1BjufcyxKTIIhZ3CvwwCtb
	GCSZSDZ6eU37KCnKwrJvjG47hB+SpWnNXLBjlgYpMaVjEgevPBOYiwVw6clJETwe8g8J+O
	lOF0YqGuUrSalkvlcJ4YOi8qbKJvn0Db0zJvPG0AUhPN2ZD02V+dg42P0Qp5QOx1GUOrXg
	fKLSUEEda9bH/7vNyzjvWdUF12s3KNtvN4x3yfZ1yubdHNhpxQWkaFSNQVkp6G4P6YezFF
	pI/o0L94Jken9T4DLTiyHuKr3VCzpUerI6p8wU/3Wk5OBDKKuHWQjYy1V986jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745844014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/M4ZkI+BDRIkqDPmauaPsLvEjDOe/PrNi79VD9UYdC8=;
	b=GQC7BTt9AR823hiZg67sb3sexIsyv13KHIZweb1qRbFgA3IfOd+T2A/v4KwFnhY/cptMCZ
	Z2L+fy8b8jJfElAQ==
Date: Mon, 28 Apr 2025 14:40:12 +0200
Subject: [PATCH v2 11/15] tools/nolibc: add difftime()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-nolibc-misc-v2-11-3c043eeab06c@linutronix.de>
References: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
In-Reply-To: <20250428-nolibc-misc-v2-0-3c043eeab06c@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745844007; l=1897;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TSTWz+qX8Q+FXXbscSdm+0zq+oKFJszOahA9pWCFjRc=;
 b=rrb7NY0/ZIzXbP4KBbbjj8MzQYalESyvLQu9QATKWTc4Re64kUA8vodDo0+Fin/U5c+28v9Ym
 DmvAUoDiahdAIi5lMT6K71aMr35y1t2stqMPbmPitu/WQADkbd0BGqN
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/time.h                  |  7 +++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index 48f602b661b300a0bfbac5a231315fc95727c04e..fc387940d51f389d4233bd5712588dced31ae6e5 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -108,6 +108,13 @@ int clock_settime(clockid_t clockid, struct timespec *tp)
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
index d73125c41096fd208b7b8719e61efa2da9865673..665d7631fbc6e9ecae469a4b143440ec0a43d4aa 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1304,6 +1304,17 @@ int run_syscall(int min, int max)
 	return ret;
 }
 
+int test_difftime(void)
+{
+	if (difftime(200., 100.) != 100.)
+		return 1;
+
+	if (difftime(100., 200.) != -100.)
+		return 1;
+
+	return 0;
+}
+
 int run_stdlib(int min, int max)
 {
 	int test;
@@ -1426,6 +1437,7 @@ int run_stdlib(int min, int max)
 		CASE_TEST(toupper_noop);            EXPECT_EQ(1, toupper('A'), 'A'); break;
 		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
 		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
+		CASE_TEST(difftime);                EXPECT_ZR(1, test_difftime()); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.49.0


