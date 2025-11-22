Return-Path: <linux-kselftest+bounces-46328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC36C7D473
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 18:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32DC7354C94
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF232FE566;
	Sat, 22 Nov 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="toRCeuFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA22F28E5;
	Sat, 22 Nov 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830799; cv=none; b=fxA3UksOW3uR9T9ac65mV1rH2k9mE9JsE8FikbyYXXhdBnlQYodukF7ZtfPVlNToXZpbSh9ojLo6TGMcFihLxHPpPomcd6Fd7RfEmnchNuaJ7F3xuTuU8mFExQCZxxHvJA2MKxsVjF92mKkNdrFVD/oI6hNBNYJM7H4BHJ/SLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830799; c=relaxed/simple;
	bh=LDTQ2RXtrLnWulNZC+qrUzz1Cvpm1f33+iPtPhUBWZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkpekXnW5GNDfS1Jh1Qtav7Aq7Be4R4qrP2QjSqlI5a2DUF6m6MQMMZUxAkLY3uCBm369v0sG1y3DKtnv1TX7ekIX3evnIAf7LQKYomDg2Zh7bPeaUm2HgLhHiTUn/OGHlCrieZRrDtMPBapXFo5mz+jKIRlDskWbF4ihR9z8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=toRCeuFK; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1763830792;
	bh=LDTQ2RXtrLnWulNZC+qrUzz1Cvpm1f33+iPtPhUBWZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=toRCeuFKY439+3lUGk9Y5voH7L94hoHL61yl9Ac4M6eq4A0ZPxnogDl6RA+GYJcvW
	 rGQ7CqYI+ZiwXM2iZGSlrsaOZofcKv0jYGJThQHAqKzZnEdQhSZO/vNm5XSl3zzm40
	 SR8Et0UN2+s9MJsezshhVnV2Zwy1DHdd6mI4W5IQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Nov 2025 17:59:18 +0100
Subject: [PATCH v2 12/13] tools/nolibc: add __nolibc_static_assert()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-nolibc-uapi-types-v2-12-b814a43654f5@weissschuh.net>
References: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
In-Reply-To: <20251122-nolibc-uapi-types-v2-0-b814a43654f5@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763830790; l=863;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LDTQ2RXtrLnWulNZC+qrUzz1Cvpm1f33+iPtPhUBWZQ=;
 b=nRhboJj7ujvw2RpN7XPuVyznOCYENiBYlGf2DP7r1nqdfl75R2tjjtmEm0jG1sCp4UUXSOc+e
 c6nr7Kt7HscD329ezbnkzuUeAlv4OzjZxzDiBlJ9mSTnKdJaxzfS9ia
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a wrapper for _Static_assert() to use within nolibc.
While _Static_assert() itself was only standardized in C11,
in GCC and clang dialects it is also available in older standards.

If it turns out that _Static_assert can't be used in some contexts,
this wrapper can be adapted.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 87090bbc53e0..ef247e916552 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -47,4 +47,6 @@
 #  define __nolibc_fallthrough do { } while (0)
 #endif /* __nolibc_has_attribute(fallthrough) */
 
+#define __nolibc_static_assert(_t) _Static_assert(_t, "")
+
 #endif /* _NOLIBC_COMPILER_H */

-- 
2.52.0


