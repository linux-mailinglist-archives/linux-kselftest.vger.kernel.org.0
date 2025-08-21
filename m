Return-Path: <linux-kselftest+bounces-39526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D06DB2FF3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B66FA0600C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DE72D3748;
	Thu, 21 Aug 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ji1Aj9Pa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C62D0628;
	Thu, 21 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790839; cv=none; b=sd5C6j2FLOxfecQFD7XFleW05Kbp9UTvnC5qbW+fFgFBWYJLdHcv659Z4pvh6etDiC/EWmAEVfpHOTM2r5TC/FayecO1o9M+jjvXp5+Ql+bjD2g4NieiRaUiOYTMh1euDXelXBO4JRrTZPp+h1kow9Y/wz2OM3PLH+Zwx8ouC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790839; c=relaxed/simple;
	bh=cRhDVTvfEJS8mHqyTcbC6i1+gbWq4cwR+iPLEEiWZ2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dzeoZseTTp5831fTqoD0wC3kHZLpJ1UPy1SY1LcEBNDXHVDZbLpRcT+WK+sCTmZCcXZLJCayKf4IbpZenP3KdXQ9vfYAKukkgQKNHmIHvmrj2dDRF5erh9r5KD+b30jRbo4Yj2/qpIBs7kjniUFLeSITrMYOYdDKA+YuW86QRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ji1Aj9Pa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=cRhDVTvfEJS8mHqyTcbC6i1+gbWq4cwR+iPLEEiWZ2Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ji1Aj9Pa0KE62K23ADxtytlcMcvBm+5O2ouql4SWsL89MwWb4kYwh7AEW/+UVbqPD
	 Q+8kMooDZla8qO3e0gpR4gCvBbT1xdqiX0ZrvEw7G9e0rpqT+b8ZlEfIrXZvwPbOFz
	 QL/X8eTk33RbiTap9blAGyB2ToaDnk8+WDZ1NoNc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:33 +0200
Subject: [PATCH 2/7] tools/nolibc: remove __nolibc_enosys() fallback from
 *at() functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-2-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=3478;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cRhDVTvfEJS8mHqyTcbC6i1+gbWq4cwR+iPLEEiWZ2Y=;
 b=kg0N2hbwZuFGUCxNsEe83kmS1G/QpIW6Z9QwM10aCuWItg7whQvOvP4R04xEL+woy3GaMyT2I
 320/IAtY4YxC2r0SeXKjaQ1xryDceFFE7HUX3FVZRoYhqIDp4cI9+5B
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All architectures have had one of the real functions available since
Linux 2.6.12. The additional fallback to __nolibc_enosys() is superfluous.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 4e5389edda03a61e76ad0377213e8ef0a621d300..2b9c3bf697e74e80016606814fe21929512ca007 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -142,10 +142,8 @@ int sys_chmod(const char *path, mode_t mode)
 {
 #if defined(__NR_fchmodat)
 	return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
-#elif defined(__NR_chmod)
-	return my_syscall2(__NR_chmod, path, mode);
 #else
-	return __nolibc_enosys(__func__, path, mode);
+	return my_syscall2(__NR_chmod, path, mode);
 #endif
 }
 
@@ -165,10 +163,8 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 {
 #if defined(__NR_fchownat)
 	return my_syscall5(__NR_fchownat, AT_FDCWD, path, owner, group, 0);
-#elif defined(__NR_chown)
-	return my_syscall3(__NR_chown, path, owner, group);
 #else
-	return __nolibc_enosys(__func__, path, owner, group);
+	return my_syscall3(__NR_chown, path, owner, group);
 #endif
 }
 
@@ -569,10 +565,8 @@ int sys_link(const char *old, const char *new)
 {
 #if defined(__NR_linkat)
 	return my_syscall5(__NR_linkat, AT_FDCWD, old, AT_FDCWD, new, 0);
-#elif defined(__NR_link)
-	return my_syscall2(__NR_link, old, new);
 #else
-	return __nolibc_enosys(__func__, old, new);
+	return my_syscall2(__NR_link, old, new);
 #endif
 }
 
@@ -640,10 +634,8 @@ int sys_mkdir(const char *path, mode_t mode)
 {
 #if defined(__NR_mkdirat)
 	return my_syscall3(__NR_mkdirat, AT_FDCWD, path, mode);
-#elif defined(__NR_mkdir)
-	return my_syscall2(__NR_mkdir, path, mode);
 #else
-	return __nolibc_enosys(__func__, path, mode);
+	return my_syscall2(__NR_mkdir, path, mode);
 #endif
 }
 
@@ -662,10 +654,8 @@ int sys_rmdir(const char *path)
 {
 #if defined(__NR_rmdir)
 	return my_syscall1(__NR_rmdir, path);
-#elif defined(__NR_unlinkat)
-	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
 #else
-	return __nolibc_enosys(__func__, path);
+	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, AT_REMOVEDIR);
 #endif
 }
 
@@ -685,10 +675,8 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 {
 #if defined(__NR_mknodat)
 	return my_syscall4(__NR_mknodat, AT_FDCWD, path, mode, dev);
-#elif defined(__NR_mknod)
-	return my_syscall3(__NR_mknod, path, mode, dev);
 #else
-	return __nolibc_enosys(__func__, path, mode, dev);
+	return my_syscall3(__NR_mknod, path, mode, dev);
 #endif
 }
 
@@ -872,10 +860,8 @@ int sys_symlink(const char *old, const char *new)
 {
 #if defined(__NR_symlinkat)
 	return my_syscall3(__NR_symlinkat, old, AT_FDCWD, new);
-#elif defined(__NR_symlink)
-	return my_syscall2(__NR_symlink, old, new);
 #else
-	return __nolibc_enosys(__func__, old, new);
+	return my_syscall2(__NR_symlink, old, new);
 #endif
 }
 
@@ -929,10 +915,8 @@ int sys_unlink(const char *path)
 {
 #if defined(__NR_unlinkat)
 	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, 0);
-#elif defined(__NR_unlink)
-	return my_syscall1(__NR_unlink, path);
 #else
-	return __nolibc_enosys(__func__, path);
+	return my_syscall1(__NR_unlink, path);
 #endif
 }
 

-- 
2.50.1


