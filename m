Return-Path: <linux-kselftest+bounces-47772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B7CD304F
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 373D2301D5A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C0030EF9D;
	Sat, 20 Dec 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RdJmkLpB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F5309F04;
	Sat, 20 Dec 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238971; cv=none; b=MW3uCdseeqr0l5GgaqiWElH4A2z0wWkJ9eHXesfVLjJhHoy/Zf/RFGENwveDFaVeqcH4D9qWmqde0RIqOk80ULOHfY4ItbQnREGP1t1Z23C+7WPq07CymPS+wbPikgWemIC7awib+8wS261dkUpoSXZEjP0uzH2eoHPlP0mgGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238971; c=relaxed/simple;
	bh=VaV7ZtdbOh7bYLktiPrnDr7zKQToeR+YSeV54YdWR+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BVug9P5jFwt3CX1MMyKAalakotMZfRhT3rXcky543x6i89hwBalFP3u539TxoVcpQQ6So05RbePzdp4D9SkM0Gz7gFWa4XjySCbmggrmxAtT86suE4TBKuT/aL6pJlkJDdObKYlO+dW2CbfQFURp2bS9IgOvgRDptegVc2E9Fgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RdJmkLpB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238958;
	bh=VaV7ZtdbOh7bYLktiPrnDr7zKQToeR+YSeV54YdWR+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RdJmkLpBGk/RwaJlPGpR2Szp6+5pYAAZOLz8tB19h8GRqPikZwZhWW7UQk3mu9i5T
	 SCZbpttuzRSS3NidPFRoXYlsZrSzFKBRzYGH0XQxTmPHd8447hk0RVJeb5HtOGBerK
	 hJBbLw6TuLZic4QrXc6nn2rj9wnqpV5Rfl1rtwEw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:56 +0100
Subject: [PATCH v3 12/14] tools/nolibc: add compiler version detection
 macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-12-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1159;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=VaV7ZtdbOh7bYLktiPrnDr7zKQToeR+YSeV54YdWR+8=;
 b=EHRjHanx1JGt2BiCDg4P2yGw8bGGXIumw6LbYSW8DHR7IC60EfCIu01H8/xfvyUK/nJdDWurb
 c+sYW3f8fSKA6EKhoHE0pA9jalAFtdnQ0BmOgy7CbS/qatGb5Rbwl87
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some upcoming logic needs to depend on the version of GCC or clang.

Add some helper macros to keep the conditionals readable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 87090bbc53e0..c9ffd0496dae 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -47,4 +47,20 @@
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
 
+#define __nolibc_version(_major, _minor, _patch) ((_major) * 10000 + (_minor) * 100 + (_patch))
+
+#ifdef __GNUC__
+#  define __nolibc_gnuc_version \
+		__nolibc_version(__GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__)
+#else
+#  define __nolibc_gnuc_version 0
+#endif /* __GNUC__ */
+
+#ifdef __clang__
+#  define __nolibc_clang_version \
+		__nolibc_version(__clang_major__, __clang_minor__, __clang_patchlevel__)
+#else
+#  define __nolibc_clang_version 0
+#endif /* __clang__ */
+
 #endif /* _NOLIBC_COMPILER_H */

-- 
2.52.0


