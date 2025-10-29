Return-Path: <linux-kselftest+bounces-44314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73697C1BEF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15A9B34637E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BC351FB6;
	Wed, 29 Oct 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="J37vsX4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C634E75C;
	Wed, 29 Oct 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753895; cv=none; b=APfOdJLxRTlPFdn2K3OnSe0eiDrGj736rruBgwBQxQyCL6hk1ImEMnjq8+SYGX0yhnLF4hhNRrVd6e8gR3E6+J3x5YDAKntEP3NyXpHqK3RUSvbWucTHPmMfvcemwihAk6Ks/JJemIAPXd4w0YPUCF2rm3upouyOc1LW5ZXk38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753895; c=relaxed/simple;
	bh=Xskionb2PcR414Z75FW3KOvbbP0TvJOyf6vfN5M92qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V1UurJb9vERHNS997AYvstqSOp9IlK23235Uedfc5o39aEXJJSqvltoMC0E/fyzxogRcKba1bbsG7Iut2nRdfnanIIWwtJ0xQuYRrUIZxrC1QEdxYrerQBAy2zOfOuDQGYccQse7LwB5AJDLwBGnbJBCXchdJE+C8PZU7sud0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=J37vsX4r; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753885;
	bh=Xskionb2PcR414Z75FW3KOvbbP0TvJOyf6vfN5M92qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J37vsX4rqOKuAZrq20/TRcWtG4lDWu4HMLVZ+Rr9/GDzKYLfBtZyYtjUbXwbI2nCA
	 nZeGo2Ex4jMScNJFjuNBkyz0zBuM1Gnh4i2lIDJG9og1GSLtMl6/J1NXuzhanvGEZz
	 LQavqCEh5ZzI+0Cq2rKAAOx6JleMgUxAZ+EZEpMk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:03:01 +0100
Subject: [PATCH 11/12] selftests/nolibc: test compatibility of timespec and
 __kernel_timespec
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-11-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=1502;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xskionb2PcR414Z75FW3KOvbbP0TvJOyf6vfN5M92qk=;
 b=NsKeGqgYc4wRlQV5xW6JZhzqS5fq7123BjspZOc9wGeX9svq2mUPuCioos7AQQvxznGOO20N0
 X6ys+MfvClCABMCh1KfcHNxiZ1V0LthJKruIsG9w3ecSD7yOSH7fZGy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Keeping 'struct timespec' and 'struct __kernel_timespec' compatible
allows the source code to stay simple.

Validate that the types stay compatible.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index f1d6d6c766dd..938af8d6e2bf 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1428,6 +1428,23 @@ int test_difftime(void)
 	return 0;
 }
 
+int test_timespec(void)
+{
+	struct __kernel_timespec kts;
+	struct timespec ts;
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
+	return 0;
+}
+
 int run_stdlib(int min, int max)
 {
 	int test;
@@ -1551,6 +1568,7 @@ int run_stdlib(int min, int max)
 		CASE_TEST(abs);                     EXPECT_EQ(1, abs(-10), 10); break;
 		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
 		CASE_TEST(difftime);                EXPECT_ZR(1, test_difftime()); break;
+		CASE_TEST(test_timespec);           EXPECT_ZR(1, test_timespec()); break;
 
 		case __LINE__:
 			return ret; /* must be last */

-- 
2.51.1.dirty


