Return-Path: <linux-kselftest+bounces-25549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7B2A25561
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 10:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED7516687B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1AD201017;
	Mon,  3 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DfC6KsHR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rA+hLWr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CC1FFC75;
	Mon,  3 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738573528; cv=none; b=JvPpVc5q3Beu8zBebnBE9THNwrTksCOsr3yoS9xwkisyheaONiZr0mDejQg5fn6/bbr75CnBiEcfR38S1QJSn4PP2nE5DgaefBuY9MhvhJTGogTy7ZrcDyrFdiSQ+2oVOwRzUGgj3y2wCkk41CHrDixi//cx49ZYo9VcgwG/aHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738573528; c=relaxed/simple;
	bh=k6VUcueMsds64a4Z4MA/57EnupYZZoqU0G2BNVcipcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNII41uPxMSM8B9P4LgXEvBt3T87N3+NDzGl55caT5uiXmG4burh3Y2UF228WlGN2/QcmSiB6Cr8BKAILOJPK3zVWAuz4MUvA1+SKbqEdFov5vMM0Vzh7pFx6pSCU9qDvQsxh6Ovb3xk1jrUGNShV29NpnHwg1X5guaSoJqK77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DfC6KsHR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rA+hLWr6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738573525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQYQpcPfp6ErdUhcd4g1hQR7rxemGi27GYxhVGxGLIM=;
	b=DfC6KsHRJsJQPxHeNvNfWqqvAjHu5L4PMF/ZKBcNWpdNF41CWDQjwSQNr3ItUnSwcNAjEf
	XVBhU3TlZRaqxVtk9Z9rhlXaqxNZYDZ8jnwhOO7E++JyAzOXg1lTCcqXQGwxDtkl8kKN2/
	QnJYH59ZagNcROQM6YvD82ObUKy0TQ90JldyJiANnr5zmkgEaXSUKuO4W207CB9MH1r9ha
	f0mClQYJ/AEKwkQK4Wwag5u4dkRUiG3q+JCunW1NOXO+X7Rb5/v8WewcRPMClCmRjRdkz1
	f0/XO1RBnDWXdPeCGK7kDIQLVCHrk5U7GGQbFQWs/D43QL2XZUSk0i59hLqpcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738573525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQYQpcPfp6ErdUhcd4g1hQR7rxemGi27GYxhVGxGLIM=;
	b=rA+hLWr6BMpQWLvEovR3V0jSYbK1RbwTORd27NAuWuAvtIbg3xiRJd/+xwABegsrk7+Z2V
	h/Hq6/0YkxIYZnCg==
Date: Mon, 03 Feb 2025 10:05:14 +0100
Subject: [PATCH 13/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-parse_vdso-nolibc-v1-13-9cb6268d77be@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
In-Reply-To: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738573516; l=756;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k6VUcueMsds64a4Z4MA/57EnupYZZoqU0G2BNVcipcM=;
 b=VNnbvj9POxcSn3A13xo7ug3s412wmbrg96lC38H2tnhmDK285wBgMT1/UX6qO+TUEE2TdHrBV
 d4lNdSDjftsB4ikN+Hj4kSbgObC8Xve+4WVgIxIeGYyX6Y2VtnqQFEc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

nolibc does not provide this header, instead its definitions are
available unconditionally.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 902b8f9984a1f70049d46bcd4f199df24f507dcb..6ea1d7cca6a3da910097630e8237a3a6daa0cd06 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -18,7 +18,9 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
+#ifndef NOLIBC
 #include <limits.h>
+#endif
 #include <linux/auxvec.h>
 #include <linux/elf.h>
 

-- 
2.48.1


