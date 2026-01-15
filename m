Return-Path: <linux-kselftest+bounces-48997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C5D23325
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B687E314B41A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D74E1E25F9;
	Thu, 15 Jan 2026 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3+7FgoYD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ohre5fCq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC89336ED7;
	Thu, 15 Jan 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465813; cv=none; b=bmeh62jBVrybY4DzOrjPVCOkOW2pC7Ocx1W6GSvDscljYBfNFa6QzaroPO44B11IZY1Nfp7eeKDwut+zBJXU9uBfltyxF7azz9aJ1ccyxxc8m2nJnlkZfICecOd1oVq/4GcEHODCXPhNCCVLsNPczB8qE6Owy2f5Fk12qpUyTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465813; c=relaxed/simple;
	bh=ydZwWGcoYx1I3AmdibzMaVjYIyahHTfLDsQU637jyTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BX94oaPD3rRzDT6vFFDrckvB2mRWWvaYCqkeOj6WaQG6sUq0sn4Ku72xPLSIBnk7zN5x+xKjxF5qS4D/aUM11nnfr5QOo0SyWs2urQjNTcRIsviBkhbz1CBtlX8JcBwXuxHWn5Isj4gqWNa49fSI16QM1GblUKLYeuLQ6GNl05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3+7FgoYD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ohre5fCq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768465801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NG/+/K5ElBiBPbHqDiKqINE0JfCV/poKOET6u3GJLGY=;
	b=3+7FgoYDoK8IZtazIIpDTD6oIKABFnhQrEqTQl4Rbt2hHPPwLLg62ghWgnhgBAtgfYC6mQ
	+bdH12chCNzRTCk6VobCTOfbtTnjk5qfSp3vuwFc7XnnwoeObNg1agf0Szpu2XLpXXTO6J
	J+9SYb94xhLXrUeYw1yDfvM+buYNpX3xNXjNKb9B1/QbglEUWAFnlwG1NeJIP7s1GYOxN5
	cl5n/MZ0AaYHZYHkWQsT3URUQCXWKC1N5+DIpNMTR+F+S5EDruvyYLLGN38oy8iMiPTfqU
	4spxMr50mEyEO+UFyXzmLH3dn0RklGGgwSh4l9NwZ9bNdxVD3Xr/HrphsuOmOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768465801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NG/+/K5ElBiBPbHqDiKqINE0JfCV/poKOET6u3GJLGY=;
	b=Ohre5fCqbUw+lNtoRXhOJWQmOhVbU3QiVIq0PEDtac8akiHN0sU4w0QqT2HFauoYUJcJYU
	Fun14O4ci0e1izDQ==
Date: Thu, 15 Jan 2026 09:29:55 +0100
Subject: [PATCH 3/6] selftests: vDSO: vdso_test_correctness: Drop
 SYS_getcpu fallbacks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260115-vdso-selftest-cleanups-v1-3-103e1ccbfdc3@linutronix.de>
References: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
In-Reply-To: <20260115-vdso-selftest-cleanups-v1-0-103e1ccbfdc3@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465799; l=802;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ydZwWGcoYx1I3AmdibzMaVjYIyahHTfLDsQU637jyTY=;
 b=+V8hPy98B/twqJ4t1Qm2ZMhHVmfg8GVKNGy6o1A8UvmFguEklwL8Y/cak1xfZiYznbHusLXX1
 1e5asNCdbBTCLdMeXV7WmkNzngS06VM2EBoN0qqh0dXfG22EH9mb1ic
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These fallbacks are only valid on x86 and unused in the first place.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_correctness.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 055af95aa552..2a2d9b01a938 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -25,14 +25,6 @@
 
 static const char **name;
 
-#ifndef SYS_getcpu
-# ifdef __x86_64__
-#  define SYS_getcpu 309
-# else
-#  define SYS_getcpu 318
-# endif
-#endif
-
 #ifndef __NR_clock_gettime64
 #define __NR_clock_gettime64	403
 #endif

-- 
2.52.0


