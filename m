Return-Path: <linux-kselftest+bounces-48130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA22CF1166
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 15:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF6230198E7
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFE01FDA8E;
	Sun,  4 Jan 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gKDLp29L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857BC15ADB4;
	Sun,  4 Jan 2026 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767538677; cv=none; b=g3fmrD/WJOVXzFOrUy78cMSw1JPOYMOBRTG86YJlB+aGCKzy+nW3rUGMh1v76vZ4S0jDVA17jXTIiTKByd/GzH19yk8EqfZYW4oSKWqO4x3Ad055e8Ml+SiRE02WYrv8bnRT5Ez+hxcu7EbzO6zeFbUlwWNdLP8vWtPi+oKyyZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767538677; c=relaxed/simple;
	bh=nn0qobbKllM3XzSgkLoWVCxUcMSqD7NZ9+ahU8CphwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fyFrmP1ooAQ2CGz/se2ZBgyJHRZEDW+ewVJigwKM/bfz7TeTWP7qVj1GMSKU38ae9vdDoi9masyCBm15wnAgcCp3AyC+JevuvRmJD2GqzdyYhfldRAdVNppt2qHZbPt0W9DFXTlBHgCPT5NDfRZwF6hrc0O6cjJ24bRYBtBA5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gKDLp29L; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767538673;
	bh=nn0qobbKllM3XzSgkLoWVCxUcMSqD7NZ9+ahU8CphwY=;
	h=From:Date:Subject:To:Cc:From;
	b=gKDLp29L8N0WT0WgcNxr46h+cJ3tEri5i8ZEauyMuuBXG+k+ZifmSqvGZpBE2tJ96
	 fVjj/ro7GGtIPUQRB/frEurpMFUxdS/7k3m1tVNxkGivP7rO+nmies9Zv8HLYRwC9b
	 w7YN0o4APKAxIrHEJ5IVh4pODWb2pbDu+UreDnew=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Jan 2026 15:57:51 +0100
Subject: [PATCH] selftests/nolibc: drop NOLIBC_SYSROOT=0 logic
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260104-nolibc-nolibc_sysroot-v1-1-98025ad99add@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAO5/WmkC/y2MQQqAIBAAvxJ7TjArD30lIkq3WggNN6IQ/55Ep
 2EOMxEYAyFDV0QIeBGTd1mqsgCzTW5FQTY7KKm0rGQjnN9pNj9Gfjh4fwqLc61bpa2xNeT2CLj
 Q/X37IaUX1h8daGcAAAA=
X-Change-ID: 20260104-nolibc-nolibc_sysroot-deb36526dcd3
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767538673; l=2006;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nn0qobbKllM3XzSgkLoWVCxUcMSqD7NZ9+ahU8CphwY=;
 b=bLEyKy8U2ICElqOShTd4PoNv95AzgEVn0nEGX21Ck4GAdQvbWy2C4O8Nduf4ZSPxx9y1uy3SS
 9+PoXtFfmA8Djj/EXrpJcxM6ADkvHD/txXKg+t3IrzeM6mDTYq+7tqX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This logic was added in commit 850fad7de827 ("selftests/nolibc: allow
test -include /path/to/nolibc.h") to allow the testing of -include
/path/to/nolibc.h. As it requires as special variable to activate, this
code is nearly never used. Furthermore it complicates the logic a bit.

Since commit a6a054c8ad32 ("tools/nolibc: add target to check header
usability") and commit 443c6467fcd6 ("selftests/nolibc: always run
nolibc header check") the usability of -include /path/to/nolibc.h is
always checked anyways, making NOLIBC_SYSROOT=0 pointless.

Drop the special logic.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index f9d43cbdc894..b17ba2f8fb46 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -302,15 +302,9 @@ sysroot/$(ARCH)/include:
 	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone headers_check
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
-ifneq ($(NOLIBC_SYSROOT),0)
 nolibc-test: nolibc-test.c nolibc-test-linkage.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -nostdinc -static -Isysroot/$(ARCH)/include nolibc-test.c nolibc-test-linkage.c $(LIBGCC)
-else
-nolibc-test: nolibc-test.c nolibc-test-linkage.c
-	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
-	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h nolibc-test.c nolibc-test-linkage.c $(LIBGCC)
-endif
 
 libc-test: nolibc-test.c nolibc-test-linkage.c
 	$(QUIET_CC)$(HOSTCC) -o $@ nolibc-test.c nolibc-test-linkage.c

---
base-commit: 9d16b22b17ddfd27df1da6088a962a72658f46d1
change-id: 20260104-nolibc-nolibc_sysroot-deb36526dcd3

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


