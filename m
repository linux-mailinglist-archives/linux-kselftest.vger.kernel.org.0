Return-Path: <linux-kselftest+bounces-14333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6D93E465
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081121C208A5
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F72CCC2;
	Sun, 28 Jul 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GtBMYezq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93D22EE5;
	Sun, 28 Jul 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161418; cv=none; b=Xlcj36oPYmNmKk1fw07ugJbUVrXXcctq1Px3KmOJ91nHq/VCsw6O9oz0C1+mglddvH6080rnq90H4svuJHRaA7gMitCCCwsjMMy+V3dFZ11cTOrBIvX7he/9DlkPh3fzQjB3UPKADBJ1YFG89oCuSIUVyUm1eYhzzZ472SEB4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161418; c=relaxed/simple;
	bh=zn9iXWwceqvz8uRN8Yt/9Xv1URTnsny/0GYBzVr0zFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MWqUlSDsSErtRyVZ191dDGZ6eTUbxk/e94LLAulfTfuFZy/9hGprLal6/DU36yREjgvFJNf2uyYyNO0C2xuFtN/3MUvB64Vh7OvLDfFlg5PLRV1taGsS+WWcLItme8JOa/5jbEgON+zlA98cMFZpLNTQJU6q190W8DPlCLIE2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GtBMYezq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=zn9iXWwceqvz8uRN8Yt/9Xv1URTnsny/0GYBzVr0zFM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GtBMYezq2amqYqZBbBqOjYRUKX0Ewf1NpjYDwaeF2UxTMkQcrbfNqXlvtnWA5jsvU
	 ZI5HYrMYboqor9lGKNuautEx+9yVMc8ttxyjf7PU9yUx1aYYpxElzo3/zdTuGHT1BW
	 OAFRZb7qLJWIkpmVZPDrnn+iCIChVLSh0aX6pb8g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:09:55 +0200
Subject: [PATCH 01/12] tools/nolibc: use clang-compatible asm syntax in
 arch-arm.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-1-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1062;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zn9iXWwceqvz8uRN8Yt/9Xv1URTnsny/0GYBzVr0zFM=;
 b=enN4XiLb0dsZ/7AxXdEWeQT7gNJKUT0res8jlSd+0S6wH7FcOOQA6jB85VU0RAfhucfHU4X1Y
 qYzUfvUMKy5Cjd2oWe9H6q8OezDnu4OChbD9z8+Lmqmy8jx8BwjLFu4
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
2.45.2


