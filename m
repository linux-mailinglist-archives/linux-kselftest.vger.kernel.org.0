Return-Path: <linux-kselftest+bounces-44305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC4C1BF4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F369419C38FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9C33DED3;
	Wed, 29 Oct 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KNZiG9sO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4097033A02D;
	Wed, 29 Oct 2025 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753890; cv=none; b=sPqclafHBCcXha8SBLNqIbhnE9XZ+3oXCb/tie+2Kn4fjoNLbnZUF5oYM/7/h1aRrFW05S7g7J1Rk/um46Xs4CneNXOTUc6M+fBhyI/VfOH54iyIfFH/tuOLMU22TkOCIhX1WG7iFD9NmFdoIUz79LzOsO1kS5C7YsnuMHffYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753890; c=relaxed/simple;
	bh=SI3TbuSQP75RVTmoH4id+zokk+4VkSRTlXS313nQyGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4k4SPlYfiwp97CxO/57ReK53nWdDWezKUnU/duG2e6t8PsmpbNZHlL3Sp4cerrChIdWvLSm/b3iVjxUKbTCS5lG1s7ChZMsZTihiXZJaNpK3QA5jiahTNXvS2xaydHESzLISJ59uekdkRcFetOLuVOMIbeDN3JsQGDXr2AX5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KNZiG9sO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761753882;
	bh=SI3TbuSQP75RVTmoH4id+zokk+4VkSRTlXS313nQyGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KNZiG9sOMSgYMM2LezULBnkieo33xKgmmr7vMUhCcvaWGjrryGMDNpQI5UL8vEPAv
	 S5wkcTGP0I+4oV/oXpiUUI5v2aDlD/kZiOZs7aprAlSlncrVDSnAnSjz/UbClp8VCG
	 UZyL3acu5egkwxMU/AhkpOgqWNK1UFUGEq6Hgq2E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 Oct 2025 17:02:53 +0100
Subject: [PATCH 03/12] tools/nolibc: prefer the llseek syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251029-nolibc-uapi-types-v1-3-e79de3b215d8@weissschuh.net>
References: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
In-Reply-To: <20251029-nolibc-uapi-types-v1-0-e79de3b215d8@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761753881; l=984;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=SI3TbuSQP75RVTmoH4id+zokk+4VkSRTlXS313nQyGs=;
 b=iz4yzbcAdS4ljjBwCUIQhSAuwK7up126KF0F0B6noZ5SpVNfqAx5wQM9DDk4FnOtF+ErENeui
 CIx6nAc/CMiDpEeQnS4IZlirlujS25VnzPmZVuiUOMkasMBopjnMpuy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Make sure to always use the 64-bit safe system call
in preparation for 64-bit off_t on 32 bit architectures.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 321a3bd16ff4..58cd2bb0f6ce 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -592,9 +592,7 @@ int link(const char *old, const char *new)
 static __attribute__((unused))
 off_t sys_lseek(int fd, off_t offset, int whence)
 {
-#if defined(__NR_lseek)
-	return my_syscall3(__NR_lseek, fd, offset, whence);
-#else
+#if defined(__NR_llseek)
 	__kernel_loff_t loff = 0;
 	off_t result;
 	int ret;
@@ -608,6 +606,8 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 		result = loff;
 
 	return result;
+#else
+	return my_syscall3(__NR_lseek, fd, offset, whence);
 #endif
 }
 

-- 
2.51.1.dirty


