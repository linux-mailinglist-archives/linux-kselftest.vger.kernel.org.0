Return-Path: <linux-kselftest+bounces-46327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E6C7D46A
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23894E845F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4E2FD662;
	Sat, 22 Nov 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UZ9CZiWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948D02E8B8B;
	Sat, 22 Nov 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830798; cv=none; b=PfRYLOFYbtE/OGEjnGEa63/0/4d1WtV0NT0SQ8gAzZXIkeI1nzcXpOQYbBsHqdOgDgiMFOj0oCvzgnK2gXGGG9ze26/uV45Vwg4wnZydoNVSllZqY6aQA+3eKd2/PRxp8048n0nRr9nuh6JoRT5puwUCGsIeDHZMmoGktYn2vmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830798; c=relaxed/simple;
	bh=zVlfBuvSWTC8u1cxFlDc1diGCWQOUvi9vXBHqIirOyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBIibN9eeJm95zj1G0abyQ8Mwg0KmIlDA+m/KQSwvpiHmoXfMKMPLTKixri4p/zV/ZqxBWrdEWv+Z8Gkvk9m7edQSZ4QvQfTTbay2v8Abtajg3eUzo8FSWohDeKq0EcWai5nGQ78hEL5hKKeWL5uGQ+yTJ9nU+B0/nwWaV3VpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UZ9CZiWX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830791;
	bh=zVlfBuvSWTC8u1cxFlDc1diGCWQOUvi9vXBHqIirOyk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UZ9CZiWXTbY9CFnIpVXDrfayvZzkChvvZ4+xy8qPwpA8/6/sqr2wjNpvAHZwEAz4p
	 Bw6CNUMT0IH0RO2sopVeJApRdJp/F6rJfjNaXztwnj0Z+Ns6KNjMBGUAMazYUR5hVJ
	 ANbIdXUqmOOEH7f+Iz+homEsS8YWTU33E3RIX8iE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:16 +0100
Subject: [PATCH v2 10/13] selftests/nolibc: test compatibility of nolibc
 and kernel time types
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-10-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=1823;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zVlfBuvSWTC8u1cxFlDc1diGCWQOUvi9vXBHqIirOyk=;
 b=MDLh33pWyZGEiDAtsJjWAJzIn9EwSAjzSVJY0KDdV864nDWb7a2jP9JZhUO67hyX5oII7wJHh
 HLt0uoKJLi4Dq1cILKXEo6nMHdefFV2ZeZd6CGjgib5KBHkO0tvJz2B
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Keeping 'struct timespec' and 'struct __kernel_timespec' compatible
allows the source code to stay simple.

Validate that the types stay compatible.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3c5a226dad3a..3446d76a984e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1428,6 +1428,32 @@ int test_difftime(void)
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
@@ -1553,6 +1579,7 @@ int run_stdlib(int min, int max)
 		CASE_TEST(difftime);                EXPECT_ZR(1, test_difftime()); break;
 		CASE_TEST(memchr_foobar6_o);        EXPECT_STREQ(1, memchr("foobar", 'o', 6), "oobar"); break;
 		CASE_TEST(memchr_foobar3_b);        EXPECT_STRZR(1, memchr("foobar", 'b', 3)); break;
+		CASE_TEST(time_types);              EXPECT_ZR(1, test_time_types()); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.52.0


