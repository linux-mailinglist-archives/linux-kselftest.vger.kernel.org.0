Return-Path: <linux-kselftest+bounces-26136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03CA2E070
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647093A5F59
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Feb 2025 20:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E401E32BE;
	Sun,  9 Feb 2025 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kKArsENq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C371E2847;
	Sun,  9 Feb 2025 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739132848; cv=none; b=n+V321D5BmbPnnZURU7v2jZ1+Og9wBMIHvolEjDNxuuNs3iCLzRdyckmwFXm8qA9LqMMVN0muYKIfv+4V1a3UkTNMv9Eahmcha3QKT/fa7KLAA3hdFqPyrehhr0qu8VOgqbMIosw48sZZtFmrL6fB7H/7C3OtbTD7B7lbHWqcto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739132848; c=relaxed/simple;
	bh=YNKEjTClg6tWy+D1g15zHkrPsd+OULb6yiDU7924Efg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l08Jrjl2M62+R1ZUyTgf30dzUTossZQ6Lo5tiIwaD9uzeSafjKuNQRPib5mekUzElgwipsLDVEjmzclVugALqZ8D4isBtroa24w9755wC9+tWtH1499YrbUS+tdKF46PJGAH63FYT+2EKa3vtjgnf8GNr1qxlDrkkvgU8xEM7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kKArsENq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739132837;
	bh=YNKEjTClg6tWy+D1g15zHkrPsd+OULb6yiDU7924Efg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kKArsENqzae29GFwWFDSXWb4bopWKoSZ198DIA9x/IErqjZaDC7jl+FtN5QPf7Q/t
	 JBs42zw5But9JpAqALu4SCrS7P6ZeCReQFd+MCwgDG4guog/AnPJvDBEyEI4fkNZY0
	 EPsU+1q8cs0nUjOcP+GL7bVyLb62KTPU3EKWzj30=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 09 Feb 2025 21:27:13 +0100
Subject: [PATCH v2 2/2] Revert "selftests: kselftest: Fix build failure
 with NOLIBC"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250209-nolibc-scanf-v2-2-c29dea32f1cd@weissschuh.net>
References: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
In-Reply-To: <20250209-nolibc-scanf-v2-0-c29dea32f1cd@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739132836; l=1327;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YNKEjTClg6tWy+D1g15zHkrPsd+OULb6yiDU7924Efg=;
 b=CXkafB+LbXOtimbxyOVjEmNpRnMIv12SGz/h80n2RslGHBfFzbnvzFHLbTtEEbx2pwfKa3Y7M
 ONNZGPmHplPCEsJKcyHp/pE2XzHAtLlGrmHXBV1l4whmNPDAXZR9oQ3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

This reverts commit 16767502aa990cca2cb7d1372b31d328c4c85b40.

Nolibc gained support for uname(2) and sscanf(3) which are the
dependencies of ksft_min_kernel_version().

So re-enable support for ksft_min_kernel_version() under nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/kselftest.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index cdf91b0ca40fbdc4fb825b86d4dc547b5afa673c..c3b6d2604b1e486af5a224a11386f75fe0a83495 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -444,10 +444,6 @@ static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...
 static inline int ksft_min_kernel_version(unsigned int min_major,
 					  unsigned int min_minor)
 {
-#ifdef NOLIBC
-	ksft_print_msg("NOLIBC: Can't check kernel version: Function not implemented\n");
-	return 0;
-#else
 	unsigned int major, minor;
 	struct utsname info;
 
@@ -455,7 +451,6 @@ static inline int ksft_min_kernel_version(unsigned int min_major,
 		ksft_exit_fail_msg("Can't parse kernel version\n");
 
 	return major > min_major || (major == min_major && minor >= min_minor);
-#endif
 }
 
 #endif /* __KSELFTEST_H */

-- 
2.48.1


