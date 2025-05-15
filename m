Return-Path: <linux-kselftest+bounces-33132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08CEAB9054
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6541BA765A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF6D29B8E1;
	Thu, 15 May 2025 19:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GIuOmgQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDAB29B772;
	Thu, 15 May 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339107; cv=none; b=n8ima8LKbc+sUskWdd6iY2XdcNtmF7Mq45TuwFWQsmkxUzQ2m3oCerw64gpo2kyLqfpD4Dzko7+M1Dp24XTO1icK+4qY5s4MVPO3BUYQ5mkZN7L1XJgET58VwZ8QhXhK31EYhaCacCbePlByPGnfzmHZohZdHAqqzIkF3IvD2S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339107; c=relaxed/simple;
	bh=KfGk8Rm9Bva09mPYGVIxj6/MXGN0IuCeh7vn1dPO4Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dzpd49Mw8Aal0WFg0qZz8pXDtCY+X74RZGZ6BuRLs+Upw+EezcRe7qW1xb9BtRX2LQQvdzHtH17VR3aveVOY6mSCI2nw07OC9g2J3TTpaPFFYGPReW1xyIeY7ifbWV+KujVxNzNLgB49/juPmJZr9s2PgocNdsCAaEDmc2g0v6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GIuOmgQ6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747339094;
	bh=KfGk8Rm9Bva09mPYGVIxj6/MXGN0IuCeh7vn1dPO4Ek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GIuOmgQ6jHcHq2keKFMv2//7sFWE4ByeDkGjvwuqxE+nxNPn5QDOQbpoUFjYWSCrN
	 h8LrE9YJ2s2Sj5NPytbGOPSOfFJfdg4/H8DiZZT6X2VfLGPKs/BRjJdVJgEQYNCOF0
	 cZoy0gJsn4eJY++kwxQT6val4tj1/H4LI5axjo4U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 15 May 2025 21:57:55 +0200
Subject: [PATCH 9/9] selftests/nolibc: drop include guards around standard
 headers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250515-nolibc-sys-v1-9-74f82eea3b59@weissschuh.net>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
In-Reply-To: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747339091; l=1110;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KfGk8Rm9Bva09mPYGVIxj6/MXGN0IuCeh7vn1dPO4Ek=;
 b=oydlvGkP4MN2UtdJcpZdE0AfFI8UId+JF33/0A37+gWEpZ2VpfmC0BK8wtzgsENyfeMDHgOyv
 EnomZLXfiUBD7Xss+xGM6Pv70AmwXU5wyLl3tO/zxg1hEBK+BX8UZgk
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Nolibc now provides all the headers required by nolibc-test.c.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 0391c7d01380ea2f20d1d07497ea1964bcb6a9f4..dbe13000fb1ac153e9a89f627492daeb584a05d4 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -9,12 +9,9 @@
  *   $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
  *   $(CC) with default libc                    => NOLIBC* never defined
  */
-#ifndef NOLIBC
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#ifndef _NOLIBC_STDIO_H
-/* standard libcs need more includes */
 #include <sys/auxv.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
@@ -43,8 +40,6 @@
 #include <unistd.h>
 #include <limits.h>
 #include <ctype.h>
-#endif
-#endif
 
 #pragma GCC diagnostic ignored "-Wmissing-prototypes"
 

-- 
2.49.0


