Return-Path: <linux-kselftest+bounces-30201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCDCA7D4A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02740169CC1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A322A7E4;
	Mon,  7 Apr 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gf/C9680";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qUhP7tUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44935229B18;
	Mon,  7 Apr 2025 06:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008790; cv=none; b=Pzemy+yQZzogL68PEqhTPladzlU4sdvirQKtU+1j0TwcXLxbCK9n4HtXCymgFrh1gqo6EPLOYpJancYiglie5iBZPn5Y3JeZFuQaic6qUriBcraZ2gTrcAVK4fhZ6do5E7NmTVrXJs2kZ15dOEMuQMGmy+T45lYRf2pf5MlchbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008790; c=relaxed/simple;
	bh=yiN7932Hjz9o4Z41OyO0HMGRnPv3dGLSS2woL8P+hvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdYM8VtO6c7LgQaYcsLdq1iddtYHFK0kPX7PbGYPzlrs4bOCjPVg6R5iq2rxRvYgPRYJK01c5wh5Hmjel1q3la48iMePdmi/zZSies6yR21l3vAKzMrW57kX6KQcnSSwSwNRLc5T6/LlwP0OqV+Ncy9+0p1gzOKH+WDHggXkPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gf/C9680; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qUhP7tUO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744008787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAotOumz5oayfyIPCgSJr46gLVPYeiQGTGFCJGRKFI=;
	b=Gf/C9680+OH6UUbiuug16VtZiq6GQp+SjWCxR+Eo2N3/+4VptCPTJYHLoLk6+jf6EKP5WG
	thRF1TeuqygXwK5PwN1tuCvAI6lr5Ta7RigYTMFqlQZ+5APVXXL/0jxZ9izlC2YS2gmD/C
	IEHtPTthEJHCStZ/fK+7CBwFLoC9euaUy6UDvcWqvj5X+NEf6WEM6dK36p6h+kjv1+o7KT
	5VpGn9YizJ97a5C5XdefRzMaspDqhh8wYhpqEvZh81qEb4clKX6yVnAlaeEdHMbRD2ykeS
	9ySEe7hYHA++LG3jPPWHu8q95BkSCL1oQPH5Volr3e1RKJYO0GfaaRLWn03WVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744008787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAotOumz5oayfyIPCgSJr46gLVPYeiQGTGFCJGRKFI=;
	b=qUhP7tUOiQ/khFF6BIuKaGoliXb2X79spYpjZ0sBTiQaDKxyfLfD8OjQfaskN8nQtBBCEr
	JZpWHqFp4BRmpRBg==
Date: Mon, 07 Apr 2025 08:52:38 +0200
Subject: [PATCH v2 15/32] tools/nolibc: use intmax definitions from
 compiler
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-nolibc-kselftest-harness-v2-15-f8812f76e930@linutronix.de>
References: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
In-Reply-To: <20250407-nolibc-kselftest-harness-v2-0-f8812f76e930@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744008776; l=1199;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yiN7932Hjz9o4Z41OyO0HMGRnPv3dGLSS2woL8P+hvA=;
 b=rpojShlHV8Dp4sPfS0nEziqyHJYVCwc431dd4fc38z7bQoVqiY8T7FrHXslSuYvslrFStPIeK
 fD9kWXIiY1YDMCM3oIBX+IPIpHO/1v+fFLzMUE5LEbZ2D75AyER5sbz
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The printf format checking in the compiler uses the intmax types from
the compiler, not libc. This can lead to compiler errors.

Instead use the types already provided by the compiler.

Example issue with clang 19 for arm64:

nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uintmax_t' (aka 'unsigned long long') [-Werror,-Wformat]

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdint.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdint.h b/tools/include/nolibc/stdint.h
index cd79ddd6170e05b19945e66151bcbcf840028d32..b052ad6303c38f09685b645268dad1fa8848370d 100644
--- a/tools/include/nolibc/stdint.h
+++ b/tools/include/nolibc/stdint.h
@@ -39,8 +39,8 @@ typedef   size_t      uint_fast32_t;
 typedef  int64_t       int_fast64_t;
 typedef uint64_t      uint_fast64_t;
 
-typedef  int64_t           intmax_t;
-typedef uint64_t          uintmax_t;
+typedef __INTMAX_TYPE__    intmax_t;
+typedef __UINTMAX_TYPE__  uintmax_t;
 
 /* limits of integral types */
 

-- 
2.49.0


