Return-Path: <linux-kselftest+bounces-47771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A3CD304C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41AE9301C952
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Dec 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3780849C;
	Sat, 20 Dec 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="g+1LQ6z8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57130BF77;
	Sat, 20 Dec 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766238971; cv=none; b=Pryt8T+7M4vEPazu3jQEsPpf50NQ7zdzZKMxSG6RWW2/ggVXHVozRMiDtnL1nb6XFT9JORXnMdCu0yRmypQs7248kmxJtmdj16sZJAseZjNHwuFiIEuTM5XmBWf72NseHUfSEFTvw+J29fX7pFaEXf+OIwlr9Qiel8osR3VGWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766238971; c=relaxed/simple;
	bh=i7gXFdUcxSaPlmzDotOMDeqrjXsxKbyoPN9Zigx2uPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXMtJhX2+VpLse3aBjyO/4/nwxRgNEIcXYXLXxTE2VynTtwqp/jwVLfGkcy5jC0SzLSg6x5JD9nNQ0e567rkvTTpPUz4kdj+Lg5ZlxD+daAEQ+u1nE0vyuJbffFleukmaeaOVewpsWIeXq0+3c2tHrQtSJm8g1CFGw64qXgu0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=g+1LQ6z8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1766238958;
	bh=i7gXFdUcxSaPlmzDotOMDeqrjXsxKbyoPN9Zigx2uPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g+1LQ6z8lDKBxHGAqLyqiyZRh14V3qRts2U+1Ybj9ngmNZY8267D6Cmj4ZbXw5VaQ
	 uL9s/jphlMuJK14iNwpDVIzK+aZZA8PUBTuN+YdMsr5S89xj1cFD11hJrBSVfwzVz+
	 mTViWRoEwU2cbP1VqMFPHNyBF78lGF4TP4kwd7YY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 20 Dec 2025 14:55:57 +0100
Subject: [PATCH v3 13/14] tools/nolibc: add __nolibc_static_assert()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251220-nolibc-uapi-types-v3-13-c662992f75d7@weissschuh.net>
References: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
In-Reply-To: <20251220-nolibc-uapi-types-v3-0-c662992f75d7@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766238956; l=1008;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=i7gXFdUcxSaPlmzDotOMDeqrjXsxKbyoPN9Zigx2uPo=;
 b=rIWWFm9viyfQ9MA7oU0xGbs4BlDfo6hFjeDHKEYsUTiWL9glQVqBEo/UXhyOl+13vVerFRVEP
 v5IJiYndex2Aa5lO6H2s1vEfN1g8Nb7Ik3JT1cokfgmQ5PiaxJTGtxH
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a wrapper for _Static_assert() to use within nolibc.
While _Static_assert() itself was only standardized in C11,
in GCC and clang dialects it is also available in older standards.

Link: https://lore.kernel.org/lkml/20251203192330.GA12995@1wt.eu/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index c9ffd0496dae..a8c7619dcdde 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -63,4 +63,12 @@
 #  define __nolibc_clang_version 0
 #endif /* __clang__ */
 
+#if __STDC_VERSION__ >= 201112L || \
+	__nolibc_gnuc_version >= __nolibc_version(4, 6, 0) || \
+	__nolibc_clang_version >= __nolibc_version(3, 0, 0)
+#  define __nolibc_static_assert(_t) _Static_assert(_t, "")
+#else
+#  define __nolibc_static_assert(_t)
+#endif
+
 #endif /* _NOLIBC_COMPILER_H */

-- 
2.52.0


