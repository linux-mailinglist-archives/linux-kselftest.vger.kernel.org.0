Return-Path: <linux-kselftest+bounces-48282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D525CF7E0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 11:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BB23029D10
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42633AD9A;
	Tue,  6 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dhdsYUER"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056C730DEB9;
	Tue,  6 Jan 2026 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696012; cv=none; b=Xgi72CV2fExkl5ePhv//jn2+wQYv94y2XMCc2dl5t4mwE2vhrrj8UDHE7VZzr8xUV4RU1MfDxvma+yN0NiWMoERZyvBOCYBPZKoQaAmQ9UHZxPqAct4r3jONkCkD98mj2VP5XsfhO5fmi77N0WTy7E/Xqyrm5w9yAjkwwt3u5Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696012; c=relaxed/simple;
	bh=hGJCo+EjvPcPuW3MoCJaQ5TuIIszdE/j4mlSqhWmU+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qUJcY44Rq+0Mwb8wbobfql4VSQTY6wxLEm5HG/MDoBTs1SeiLtY2esTLT1t3LYNR1qFHoNcSY0E+3q3SpScK6S/o4y/iXsonHPDezbY2T26s3VbcyoFxA7oO07FCpQRXteAUn006EnYnQVHNuNF+vAQXNgHUgBEBTouLvdCXUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dhdsYUER; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767696000;
	bh=hGJCo+EjvPcPuW3MoCJaQ5TuIIszdE/j4mlSqhWmU+U=;
	h=From:Date:Subject:To:Cc:From;
	b=dhdsYUERlmlesgxFI9RJ7iLOWaA7rDzlAuk23DgyF3JkTwZo9HJYjwXMICzmgmB98
	 Pu4x/4n62f2ObDEEHeA/EWJuz2Hhme+4qmHHcf1tEgMfodVmQpLoOklUzqMx/u1MEs
	 vh5bccnROQ954qGdye2BXuv/My6c2b6I6JMUWFzk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 06 Jan 2026 11:39:55 +0100
Subject: [PATCH v2] selftests/nolibc: always build sparc32 tests with
 -mcpu=v8
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-nolibc-sparc32-fix-v2-1-7c5cd6b175c2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHrmXGkC/32NTQ6CMBBGr0Jm7Zi2NPiz4h6GRVsGO4kppIOoI
 dzdygFcvpd871tBKDMJXKsVMi0sPKYC5lBBiC7dCbkvDEaZRmllMY0P9gFlcjnUBgd+ozX+fDH
 O66AGKMMpU9F79NYVjizzmD/7x6J/9m9u0aiRaqu9aoLv/al9EYtIiM94TDRDt23bFzvS/1q5A
 AAA
X-Change-ID: 20260104-nolibc-sparc32-fix-42b892ab1c0f
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767696000; l=1469;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hGJCo+EjvPcPuW3MoCJaQ5TuIIszdE/j4mlSqhWmU+U=;
 b=3x9l71MxyoXAFh1CUD991EW6IuyzyRTfcaY67PDwXnuNFAQBO7g5PuD374lXbS/arUUHTAkfM
 8I7fMYCT+8PADjHy2no3IFGJLZYQaetR2mkzj0Ix1+B5xM24BXI1ZnX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
SPARC builds. -mcpu=v9 generates instructions which are not recognized
by qemu-sparc and qemu-system-sparc.

Explicitly enforce -mcpu=v8 to generate compatible code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Use -mcpu=v8
- Link to v1: https://patch.msgid.link/20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index b17ba2f8fb46..f5704193038f 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -226,7 +226,7 @@ CFLAGS_mipsn32be = -EB -mabi=n32 -march=mips64r6
 CFLAGS_mips64le = -EL -mabi=64 -march=mips64r6
 CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
 CFLAGS_loongarch = $(if $(LLVM),-fuse-ld=lld)
-CFLAGS_sparc32 = $(call cc-option,-m32)
+CFLAGS_sparc32 = $(call cc-option,-m32) -mcpu=v8
 CFLAGS_sh4 = -ml -m4
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))

---
base-commit: 8c688f07d5d77d669a1cd67863e91a99fdbc8b6e
change-id: 20260104-nolibc-sparc32-fix-42b892ab1c0f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


