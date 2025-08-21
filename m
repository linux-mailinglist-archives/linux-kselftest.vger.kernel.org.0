Return-Path: <linux-kselftest+bounces-39529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0967B2FF41
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78E8AA3E6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC413570DD;
	Thu, 21 Aug 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="E7tpchI2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A9353362;
	Thu, 21 Aug 2025 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790842; cv=none; b=CWNcRcUoZksLw3J3qiSj1AqIksPo1p7Si0sJib0dxVf4Fmtv1OsOJt/HDkSVVvBEzS/fQmh50s+2WUnp42sJ5OYRwYamEoW07VhltNwV6UMA3ZF0LRbMzftNJJZ/sIN17+j5+l6mgsqCQl5G2VpYITndVIIY7eguXJg4MmNp4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790842; c=relaxed/simple;
	bh=q8eDqbBILV1czBvM5POhEnSq70A3azxubc0c65GrQKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVLOx3vQa6EHQ4GV1ZRAu2izq+ydC3ylWL7eEAOuXr3hVfIQrJLh6yNWJGo0ujvP4euDVhsjSHmQK/uYN1jsJyK+bCYwKF1UbQWh9vZStQPpoiOsRduRkoG/WQnEAM8x9O4DRdGMmANpb3o0utNJOLOiKeo175qb4XgW+4fr14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=E7tpchI2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=q8eDqbBILV1czBvM5POhEnSq70A3azxubc0c65GrQKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E7tpchI2nBpTyr+2NlCGg78PYwKvGYmLXU4Uyf9IURlN/qMjFhotSb2EBBZe5bxvo
	 peHSg2ztW64C706LhaLGnw2xczkfS89hB7/tnD9yKTbw0TJrC6cQv6ApWadoddU0WN
	 /lahqv/cFbpUQwhJV6YJe87P0NjBdeuB41TGBuRQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:36 +0200
Subject: [PATCH 5/7] tools/nolibc: fold llseek fallback into lseek()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-5-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=2033;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=q8eDqbBILV1czBvM5POhEnSq70A3azxubc0c65GrQKM=;
 b=VMu49a5Wy73r0fgc4zP29tox+EehdPaQ8G+k4voG279AOB1IPE6egnoEbJYZboZiVaYYqWHOj
 JibyB/ALf/sDEha4WbsUFrhO0NXKNF++R8g+lamKvC5+KVmDGyPro03
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Align the implementation of the fallback handling inside sys_lseek()
with the rest of nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 42 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index fc3c8a3d02e9a031aad2229a430c232eb60065b1..f31db0f471131f82389129989054e2b55a41a7cb 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -581,41 +581,27 @@ off_t sys_lseek(int fd, off_t offset, int whence)
 #if defined(__NR_lseek)
 	return my_syscall3(__NR_lseek, fd, offset, whence);
 #else
-	return __nolibc_enosys(__func__, fd, offset, whence);
-#endif
-}
+	__kernel_loff_t loff = 0;
+	off_t result;
+	int ret;
 
-static __attribute__((unused))
-int sys_llseek(int fd, unsigned long offset_high, unsigned long offset_low,
-	       __kernel_loff_t *result, int whence)
-{
-#if defined(__NR_llseek)
-	return my_syscall5(__NR_llseek, fd, offset_high, offset_low, result, whence);
-#else
-	return __nolibc_enosys(__func__, fd, offset_high, offset_low, result, whence);
+	/* Only exists on 32bit where nolibc off_t is also 32bit */
+	ret = my_syscall5(__NR_llseek, fd, 0, offset, &loff, whence);
+	if (ret < 0)
+		result = ret;
+	else if (loff != (off_t)loff)
+		result = -EOVERFLOW;
+	else
+		result = loff;
+
+	return result;
 #endif
 }
 
 static __attribute__((unused))
 off_t lseek(int fd, off_t offset, int whence)
 {
-	__kernel_loff_t loff = 0;
-	off_t result;
-	int ret;
-
-	result = sys_lseek(fd, offset, whence);
-	if (result == -ENOSYS) {
-		/* Only exists on 32bit where nolibc off_t is also 32bit */
-		ret = sys_llseek(fd, 0, offset, &loff, whence);
-		if (ret < 0)
-			result = ret;
-		else if (loff != (off_t)loff)
-			result = -EOVERFLOW;
-		else
-			result = loff;
-	}
-
-	return __sysret(result);
+	return __sysret(sys_lseek(fd, offset, whence));
 }
 
 

-- 
2.50.1


