Return-Path: <linux-kselftest+bounces-14978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E994B257
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2900D1F22BD7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5A1514F8;
	Wed,  7 Aug 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qPmPmHWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E477F1B;
	Wed,  7 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067521; cv=none; b=TPOfqGXWSr6tMaS7VFYrne9vzk1MMyuzu1xncArANCgzsaYnCzpB5UdDVUrnEw+KO6npddi9nwl7EmZM0f+qw1Ee9TBqcFo1HnLTy9m5cjOtPCQPa+zpwqNPNWoOC1RY0RojqZGLbYpT87WmOGdn8ZY1HGR6z6wUIx3h1D0q9PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067521; c=relaxed/simple;
	bh=V6RqjZoNDuMuFSrmOeoNBxIc8QHuAyFjHlyySjNVhEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Umcp/DEqi2Lyd28kv1HkFLjtbNRk92LvWHFhaz/8duqoRjYcY1cVbBKrhM+vWwCwGnPKo+GyyIuR4yxfe6qDcsqBfqVGAnjrHXD7h3GSzWjciWrLdDmF8GN69vayoudrOeBBYSCPHAhSlLHOubhfViXII59nIqe/yPIlpFm8k70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qPmPmHWk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=V6RqjZoNDuMuFSrmOeoNBxIc8QHuAyFjHlyySjNVhEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qPmPmHWkHV31tYw/01OHVKm8gxaYiHji2m9436HMQ8mxPryC/j9Dt8w+UaWq/6aWV
	 AiBzzB180dAUOxF7K0zHWO89e2P824YINo/Yn5QRHkRkG6CT3gRcAZtqZF3KCrKGbz
	 /Phwgb5C0wmC2cA4+N8PPCp+ZdZ15TXTtdN1iX1E=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:37 +0200
Subject: [PATCH v2 01/15] tools/nolibc: arm: use clang-compatible asm
 syntax
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-1-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1062;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=V6RqjZoNDuMuFSrmOeoNBxIc8QHuAyFjHlyySjNVhEE=;
 b=SglxSo77Hm5XgbvIdgPvPkKhRNORxL92uzEiid5Q4Ms3oJ9cm3F/JWmUpOFQmCjT8xqvRcw7T
 18GOTtzoq2aA+P486EUQqwmXfPCClo5NS1n82PTx+bCs9pPN9kyhuEK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The clang assembler rejects the current syntax.
Switch to a syntax accepted by both GCC and clang.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-arm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index cae4afa7c1c7..d1c19d973e55 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -188,8 +188,8 @@
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-		"mov %r0, sp\n"         /* save stack pointer to %r0, as arg1 of _start_c */
-		"and ip, %r0, #-8\n"    /* sp must be 8-byte aligned in the callee        */
+		"mov r0, sp\n"          /* save stack pointer to %r0, as arg1 of _start_c */
+		"and ip, r0, #-8\n"     /* sp must be 8-byte aligned in the callee        */
 		"mov sp, ip\n"
 		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);

-- 
2.46.0


