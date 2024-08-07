Return-Path: <linux-kselftest+bounces-14981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F0194B25B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFD4283865
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6F154445;
	Wed,  7 Aug 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D/bl4Z1Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024E143726;
	Wed,  7 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067521; cv=none; b=mvSMQojSNBa+4qJiB77cAzVoG7H/EqTEj2j1uYBGbUziufEktPwlCsYrmIJHqSksf7y/7kWRvuUu1nOShOtdTeAR5vuIWfRS//yQ3rB0dSEP/K1g0TMECM6lea+AScvgXzlskniD3+slcbjMTcFvC+yc5GP4mTVLGHEyrL2bcU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067521; c=relaxed/simple;
	bh=JRCvIrZeKoGVVB+qDpKkq3lkyi1JWg3z/lIZUBJjdYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2ZUm0bwYJb1b0le1A2Rv65JYwo/hFpKws8fBPDQsEeYD6jZ2+LOwmSP2g/yT4/LcesU+I3+DbxuSVfl3WXKUWHd9i2BCGquXRMIxIG9YGt9oVJacpMStXZBzs/fZ5kq6mBLq+nhiHQ/t68YX0vaQHy1dtNUz0ff/Yz29AuIKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D/bl4Z1Y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=JRCvIrZeKoGVVB+qDpKkq3lkyi1JWg3z/lIZUBJjdYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D/bl4Z1YYcOictd/WxDrOmtc3spGqJk3hzQvdTja+dQio+c2zf2L1eVuHLTHHA3O/
	 oxYZRpgNXso8s7aOA85XoWr9+p0intCp6jgS7cuesddQGE2VTtlxHCWQaCACSAmDrx
	 1euZkRBt5gOh+rHis2VvuBwAiJqKzNjEaGEaDH18=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:40 +0200
Subject: [PATCH v2 04/15] tools/nolibc: compiler: introduce
 __nolibc_has_attribute()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-4-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=2153;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JRCvIrZeKoGVVB+qDpKkq3lkyi1JWg3z/lIZUBJjdYc=;
 b=/wkLMiuYSIsaYuJj9fz3BErBSruqQeuvNOAEZt+IjrO2AoqL3/w6BTw1s2wbd4chX9JoX//r5
 JdoEqsirtMIBIxyAf7hryQMtbPZSbfKj0WpB0bxiVlkij/+VpfKpvS7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Recent compilers support __has_attribute() to check if a certain
compiler attribute is supported.
Unfortunately we have to first check if __has_attribute is supported in
the first place and then if a specific attribute is present.
These two checks can't be folded into a single condition as that would
lead to errors.

Nesting the two conditions like below works, but becomes ugly as soon
as #else blocks are used as those need to be duplicated for both levels
of #if.

    #if defined __has_attribute
    #  if __has_attribute (nonnull)
    #    define ATTR_NONNULL __attribute__ ((nonnull))
    #  endif
    #endif

Introduce a new helper which makes the usage of __has_attribute() nicer
and migrate the current user to it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index beddc3665d69..1730d0454a55 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -6,20 +6,22 @@
 #ifndef _NOLIBC_COMPILER_H
 #define _NOLIBC_COMPILER_H
 
+#if defined(__has_attribute)
+#  define __nolibc_has_attribute(attr) __has_attribute(attr)
+#else
+#  define __nolibc_has_attribute(attr) 0
+#endif
+
 #if defined(__SSP__) || defined(__SSP_STRONG__) || defined(__SSP_ALL__) || defined(__SSP_EXPLICIT__)
 
 #define _NOLIBC_STACKPROTECTOR
 
 #endif /* defined(__SSP__) ... */
 
-#if defined(__has_attribute)
-#  if __has_attribute(no_stack_protector)
-#    define __no_stack_protector __attribute__((no_stack_protector))
-#  else
-#    define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
-#  endif
+#if __nolibc_has_attribute(no_stack_protector)
+#  define __no_stack_protector __attribute__((no_stack_protector))
 #else
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
-#endif /* defined(__has_attribute) */
+#endif /* __nolibc_has_attribute(no_stack_protector) */
 
 #endif /* _NOLIBC_COMPILER_H */

-- 
2.46.0


