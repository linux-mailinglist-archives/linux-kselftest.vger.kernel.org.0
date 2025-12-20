Return-Path: <linux-kselftest+bounces-47770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4FBCD3046
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA95C303CF6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59230E84B;
	Sat, 20 Dec 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EYUPb8VU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB03430BF72;
	Sat, 20 Dec 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238971; cv=none; b=T2SSMhHCHEyyKLObZDEVxpy4DRQViRMli1mPsoHkahmiAgq6TKsMndQjLHm+WuJ0UUgJpzwMT7Nrz3jtEz36zvJipQ5eCRi4CVawG4zMMfne7dI5hnoXOH6dQtHZ2bnMC8L5+2u9ykNyUaU2h34nz56D+MFChPH050eenxqkAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238971; c=relaxed/simple;
	bh=EC2fEZSIXJWQ9YW8xpxuEU0VYx6huxx/+xPGnxRLeFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mU2pJ6X4xB8Drw0yN91S/u8+CJGUK8gFauF7Q3hvFKu+ZYo4/TSTFNkVoOCCcY87G6wjPPqwpn2B1HCeRzUKDfx/D7i1GS+SpXwyLN3S4KnpVfpNp16RNaPJ+mv6OrPQ16+VysNLD8wdbUC1bZF4sbirfSGWUhKyj1KfGfnpDVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EYUPb8VU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238957;
	bh=EC2fEZSIXJWQ9YW8xpxuEU0VYx6huxx/+xPGnxRLeFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYUPb8VUj461NkkeRBZR2DeXLUakWYhzR3eilZSwDGxY0UHzCc7fB7IXu0essPWIH
	 WKKME3Ja1o0tnKBoepL8hVRcBl9JSEaTrYV9JkXOCt8JW5pa2ki0Htv1HmifOf8wot
	 nHGukXV33d+zLJyXobb6nVNzpcnGqJ1Srf04QdWQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:54 +0100
Subject: [PATCH v3 10/14] selftests/nolibc: test compatibility of nolibc
 and kernel time types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-10-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1859;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EC2fEZSIXJWQ9YW8xpxuEU0VYx6huxx/+xPGnxRLeFQ=;
 b=3ko0WBfV97djaugY+gWCQVbQUX8ThpCBTSrouQRQpLqgxSAcG3WzsGBTT/5jlF7Ty7NAM9x6n
 Ug4S2laNzIsBd5olOY7Zh5j5A6Zn5qc0B+4RnKZz2VwUUdw5wPmdZVL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Keeping 'struct timespec' and 'struct __kernel_timespec' compatible
allows the source code to stay simple.

Validate that the types stay compatible.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6888b20af259..72bcdbdbb2d3 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1430,6 +1430,32 @@ int test_difftime(void)
 	return 0;
 }
 
+int test_time_types(void)
+{
+	struct __kernel_timespec kts;
+	struct timespec ts;
+
+	if (!__builtin_types_compatible_p(time_t, __kernel_time64_t))
+		return 1;
+
+	if (sizeof(ts) != sizeof(kts))
+		return 1;
+
+	if (!__builtin_types_compatible_p(__typeof__(ts.tv_sec), __typeof__(kts.tv_sec)))
+		return 1;
+
+	if (!__builtin_types_compatible_p(__typeof__(ts.tv_nsec), __typeof__(kts.tv_nsec)))
+		return 1;
+
+	if (offsetof(__typeof__(ts), tv_sec) != offsetof(__typeof__(kts), tv_sec))
+		return 1;
+
+	if (offsetof(__typeof__(ts), tv_nsec) != offsetof(__typeof__(kts), tv_nsec))
+		return 1;
+
+	return 0;
+}
+
 int run_stdlib(int min, int max)
 {
 	int test;
@@ -1555,6 +1581,7 @@ int run_stdlib(int min, int max)
 		CASE_TEST(difftime);                EXPECT_ZR(1, test_difftime()); break;
 		CASE_TEST(memchr_foobar6_o);        EXPECT_STREQ(1, memchr("foobar", 'o', 6), "oobar"); break;
 		CASE_TEST(memchr_foobar3_b);        EXPECT_STRZR(1, memchr("foobar", 'b', 3)); break;
+		CASE_TEST(time_types);              EXPECT_ZR(1, test_time_types()); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.52.0


