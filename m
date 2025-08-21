Return-Path: <linux-kselftest+bounces-39527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF6B2FEF0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8273A4E62C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FC52D46AC;
	Thu, 21 Aug 2025 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oSG85jo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094132D0C73;
	Thu, 21 Aug 2025 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790839; cv=none; b=FHL311OUDvjntnoyesG1Sox1pJg6MpQWTlP7d8e/uBSzCj+nvn84WGCrv43z/rr7vLQ375cM0ZD8sv4y7fgVdljHiCIB2I84pSPnd2ltBwBafMam3Q37mZVNbY5UTsH2GE9wbwLABn9IpVQjTMWtVZwqD+Y0G0Y2gVpYRmUp0bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790839; c=relaxed/simple;
	bh=Q57fMOSIHmitf0RgmFKEHgmC2mjuTNIw+xrEbPhFM0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5x+Je3IY8P0YxxYpNeEN2FKES2Dxsmju6+5W77OP31Q+EHvwurg7QhaNM2LFnDCsswqwjFpajbaQC11Zo5UCQ6+AIhB/fj67rYLZyyq3vRNSU7E8yBTintIi54Ggmnlq1e8XypzkSsU0KbfOZ/1AViI14323LJuGzoMrRkp9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oSG85jo5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755790835;
	bh=Q57fMOSIHmitf0RgmFKEHgmC2mjuTNIw+xrEbPhFM0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oSG85jo53WxZgChcG3vNCa8gPefb1cturzLp9fcUP98upOiFiroLPHpHpgE38s2QB
	 gqX4zuyIOYV3okHTd69KK+maRfMpns8+JCInjuIUn4DzlXTkVnLnmPwtgZIyG/CsgJ
	 4q8kZgGaxstJA8CEJjfkA68GgkE0l+6ORojsh/h8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Aug 2025 17:40:35 +0200
Subject: [PATCH 4/7] tools/nolibc: remove __nolibc_enosys() fallback from
 fork functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-nolibc-enosys-v1-4-4b63f2caaa89@weissschuh.net>
References: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
In-Reply-To: <20250821-nolibc-enosys-v1-0-4b63f2caaa89@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755790835; l=1260;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Q57fMOSIHmitf0RgmFKEHgmC2mjuTNIw+xrEbPhFM0A=;
 b=Jj4T58dHtrOBuyLoxgHvWb7fDfeE6kTlbVgRDvn6fIGP5YcQbg/u386kNVBZ8TQh6ak/SuV7Y
 XyieRAHMi+7DaJKjka98snqABIVCEl0ZB62dI4HElo+w7UIqKKzcXjL
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All architectures have one of the real functions available.
The additional fallback to __nolibc_enosys() is superfluous.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/sys.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 9c4fa7efc1d606f18a5a92b0a3dd9ad7b9b4521b..fc3c8a3d02e9a031aad2229a430c232eb60065b1 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -321,10 +321,8 @@ pid_t sys_fork(void)
 	 * will not use the rest with no other flag.
 	 */
 	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
-#elif defined(__NR_fork)
-	return my_syscall0(__NR_fork);
 #else
-	return __nolibc_enosys(__func__);
+	return my_syscall0(__NR_fork);
 #endif
 }
 #endif
@@ -341,7 +339,7 @@ pid_t sys_vfork(void)
 {
 #if defined(__NR_vfork)
 	return my_syscall0(__NR_vfork);
-#elif defined(__NR_clone3)
+#else
 	/*
 	 * clone() could be used but has different argument orders per
 	 * architecture.
@@ -352,8 +350,6 @@ pid_t sys_vfork(void)
 	};
 
 	return my_syscall2(__NR_clone3, &args, sizeof(args));
-#else
-	return __nolibc_enosys(__func__);
 #endif
 }
 #endif

-- 
2.50.1


