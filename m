Return-Path: <linux-kselftest+bounces-8865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15E78B2607
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421751F2127E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156C14D2A5;
	Thu, 25 Apr 2024 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pHvvMuiB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571814C58E;
	Thu, 25 Apr 2024 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061400; cv=none; b=c0gXfOFeDXZ9fMSgLAlifgbRk8W7TqlRf39Y+4REmCZgIgVrTWyCcZWNL1+lvolN3p08l6nAEY12JfRsvUz26X7nKjJOEP0a0WC6yrl87Y0DqwovqWnQ+ySI2ra9DQ5XocvA6bdqTl+QMWizPEyDT136a2Dnu3dobrIcWMAYITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061400; c=relaxed/simple;
	bh=8tM3DH8oxEqa4sOJHdQ9/tQtwJ1j7MGZxLZSkBO70pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scW2P3qupbvin1A8VyUnZ+bEiSSqYRfb6m1sfmcI6hyJbtcCHWVDAUKAKCJj1536b3Tei0JiTqA+wnENpEN97UQgkE5QtupdhJ+izzzFScjWkhjP2yFkWQSEcp0niJ5GqrbfBLAFU3/lQdnM7EEJDOCoYihvabrM599aKdy/xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pHvvMuiB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714061393;
	bh=8tM3DH8oxEqa4sOJHdQ9/tQtwJ1j7MGZxLZSkBO70pI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pHvvMuiBHc0et/KIiwysnGMYMpvUMebecoj/ymo1Tyo0WJceyFQcVywUfJmyRdoJl
	 FuEzvZmwPug9NlfjChEGBugWL5y3NeGFH2r5N4NTMHCcJPmvH5hI2TryKNAFuvGNmB
	 /C0kg/75CkLHP2Q4knBeGj32AAsQnrHSkcUvaDDU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 25 Apr 2024 18:09:26 +0200
Subject: [PATCH 1/2] tools/nolibc: add limits for {u,}intmax_t, ulong and
 {u,}llong
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240425-nolibc-strtol-v1-1-bfeef7846902@weissschuh.net>
References: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
In-Reply-To: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714061393; l=1268;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8tM3DH8oxEqa4sOJHdQ9/tQtwJ1j7MGZxLZSkBO70pI=;
 b=63sr3XikAp5KBx6TgGfCxWFCGkN61MfltSj9ZTXvR9fB1AZ+ROBxWLoIZw2Ax/mbT3iet/b+F
 bOntliogisAD2OwMHbo287uR5xOGRC412oMO9sGAE9DhbIxVtl1XtDx
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

They are useful for users and necessary for strtol() and friends.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/stdint.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index 6665e272e213..cd79ddd6170e 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -96,6 +96,10 @@ typedef uint64_t          uintmax_t;
 #define UINT_FAST32_MAX  SIZE_MAX
 #define UINT_FAST64_MAX  UINT64_MAX
 
+#define INTMAX_MIN       INT64_MIN
+#define INTMAX_MAX       INT64_MAX
+#define UINTMAX_MAX      UINT64_MAX
+
 #ifndef INT_MIN
 #define INT_MIN          (-__INT_MAX__ - 1)
 #endif
@@ -110,4 +114,19 @@ typedef uint64_t          uintmax_t;
 #define LONG_MAX         __LONG_MAX__
 #endif
 
+#ifndef ULONG_MAX
+#define ULONG_MAX         ((unsigned long)(__LONG_MAX__) * 2 + 1)
+#endif
+
+#ifndef LLONG_MIN
+#define LLONG_MIN         (-__LONG_LONG_MAX__ - 1)
+#endif
+#ifndef LLONG_MAX
+#define LLONG_MAX         __LONG_LONG_MAX__
+#endif
+
+#ifndef ULLONG_MAX
+#define ULLONG_MAX         ((unsigned long long)(__LONG_LONG_MAX__) * 2 + 1)
+#endif
+
 #endif /* _NOLIBC_STDINT_H */

-- 
2.44.0


