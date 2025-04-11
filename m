Return-Path: <linux-kselftest+bounces-30553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7033BA85757
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF9637B25BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E994429CB56;
	Fri, 11 Apr 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvIMujju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/eKXaAF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294C29B23D;
	Fri, 11 Apr 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362117; cv=none; b=Oz8vvkV+gcOAo7U0tJT0dfOSHovWexqqAIC0XIqR3rBCePu72CSbPpXHAt4d91xnTsbn7c9487wn0p4wdPCTIkzm3TICxcmyYKez1cmaqvyp4Z4RzUZHCwB7hFdrBD92IORBvGujEv4WlqbZ4X5nhqLNPnKgPBZC2kkEoGxby2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362117; c=relaxed/simple;
	bh=yiN7932Hjz9o4Z41OyO0HMGRnPv3dGLSS2woL8P+hvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IG0jScTWadyes9eYBciVt2Aqv57Lt9mib4NP9ceYoZxZfaEeqXA5+ChhRaI/eJXQ+F8Wwe3bA8EJOUIs2luE04m5VbNhbbUmWR28C+v96AxUSte1bOexOXc4e+mJaKg9o8Dtq5cqHX9bL4Egey45GReNYaqkH9t/1zAnM2xVLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvIMujju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/eKXaAF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAotOumz5oayfyIPCgSJr46gLVPYeiQGTGFCJGRKFI=;
	b=ZvIMujjubApixJy7rr5FR81qwCnA3vDf2YE/Ow6y6OjGesyTnHeF9eyXSxemFLBP92fWwv
	5CWT8k+BC8AH3FjWbbcb4EwZ8hH159ctWGp0tVYUJNuBNxcrfS8MlLtfnus5yjRCZkMcwT
	VQggGbYTtI5F0YUTkEaUaFGcerBTd62BxmWFHLCyiwY2cmf8USpxZgZ9S+aE0v456T4FLw
	kL29LxgB03rpJKQsVgx7luNn6pVQm3ZYxKXlyvumNRa4pTiyZGFNfaGvNW6H/sh6wkKZNT
	O0EvquX8WrsWLcyw4/JJFzfbhjT4en+HbhJRQdVTJ3OTa5KsNYIWyCAQT4qe/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icAotOumz5oayfyIPCgSJr46gLVPYeiQGTGFCJGRKFI=;
	b=O/eKXaAFPcsT17sLxnbhgAc4X2ueXzKywlfdTVPaQnQBmLnvxR5i/aKH37QiSJiBnrY5DM
	6Lrekjbmzys5QjBQ==
Date: Fri, 11 Apr 2025 11:00:39 +0200
Subject: [PATCH v3 15/32] tools/nolibc: use intmax definitions from
 compiler
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-15-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=1199;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=yiN7932Hjz9o4Z41OyO0HMGRnPv3dGLSS2woL8P+hvA=;
 b=51S4s1eponHP+t43KCmD18QFJ84AdQoGvW5V6K/Zt6G3fZhHIj7pOLS2WgKF+l+fZ0Iw6KF4v
 fOy6XqNSSGeB9dCNhPnrtjFlT9hBqMYx9rrlFV4M7nVoleNvTkZpPye
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


