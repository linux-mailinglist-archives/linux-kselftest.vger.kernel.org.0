Return-Path: <linux-kselftest+bounces-28162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68CFA4D46B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6401E18982D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A231FC104;
	Tue,  4 Mar 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BSw6nG/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKJoKaOU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454D1FBC83;
	Tue,  4 Mar 2025 07:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072279; cv=none; b=GKP/a7zPs4Nurrr9zkao+eAvUEjW/eCp8bzbEfhPse66ohOOWzc9iu2Ryp1PlT4ZWd9nBZNGsswTF5g+WDkwyvtz2DTE4nT9lmlXDxWOIVVTs2VTN3N31ixYyZ0TepIkLjd01gYOElprLXhtMmBPKUUXqBB1lB/m9BmQ/VLmZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072279; c=relaxed/simple;
	bh=YuawXTXPtFgUFMRpzW8n3wgQKSBAfb6YSFrI/BnPNHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o69cL/PXj09nfi0XxCBIx+0RCc7mkNirn4V1wMFbi+emHf0k77EH9ac1FcLICVHEqQN5fFwj35N6MCw82NPCSEBDQqpJklXRUWMlOVfcbbpkOyTgmKiR7SvO/cD9HTSDGCf/TWK5emUkSzhTcAYod0oZkkqYV+GaUaHIln84CuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BSw6nG/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKJoKaOU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741072276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Lr5GtGgyp8TCjq2I9oOgDOri0+yBJFKfoAA8wjXqsc=;
	b=BSw6nG/t2hEAVB0T1979yyjOk6/zJFgPP0gVCgHO5Vkxbv37y+yQyBMDKmAIfuKymWiwEp
	DoG7TQYP0IxWS140EMbJ+zqSLqd9KfscdnUJozcCxtPeYD6yw0AHvZElAt3M4jE8Q7zFTW
	w9D1dGH9caXsOmvE9+mUgJZIAuELwj7DzFtgkhaIctF4/sZ53JFC2DBaI62EIyjqczCVEc
	h4PbkzwRBhgaU6AD8bUpGNWmg8FfPw9oy19FLejnXhXZ1mhcYzzXuwa0tLjqG0nlOwrzsj
	iJUKuuv0AxQmFphbJWGddZrNZlZ6jl9KJltQJ4ibMc6aIpLNVYPHhYncJWT26w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741072276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Lr5GtGgyp8TCjq2I9oOgDOri0+yBJFKfoAA8wjXqsc=;
	b=WKJoKaOU3yYyk6PqYNVYBG2o2QZMyA/bMraKwyZ/wiTWrpXt1LMxpjh0VkDbJxHkNMRe/d
	0WzOtlUWI3W10VBQ==
Date: Tue, 04 Mar 2025 08:10:45 +0100
Subject: [PATCH 15/32] tools/nolibc: use intmax definitions from compiler
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-nolibc-kselftest-harness-v1-15-adca7cd231e2@linutronix.de>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741072266; l=1163;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=YuawXTXPtFgUFMRpzW8n3wgQKSBAfb6YSFrI/BnPNHc=;
 b=H8bIr+Zr3iZreClJlFPNWV2UmBBOQitoUAOZwPJKhougt7LUsx7bCfhX1F92hx/hydBkEgdo+
 hCgw+oUsCLdDNTESvJviVWUQIvRmoCUaN6wqOrUzu50YYWpCLcjz6Df
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The printf format checking in the compiler uses the intmax types from
the compiler, not libc. This can lead to compiler errors.

Instead use the types already provided by the compiler.

Example issue with clang 19 for arm64:

nolibc-test.c:30:2: error: format specifies type 'uintmax_t' (aka 'unsigned long') but the argument has type 'uintmax_t' (aka 'unsigned long long') [-Werror,-Wformat]

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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
2.48.1


