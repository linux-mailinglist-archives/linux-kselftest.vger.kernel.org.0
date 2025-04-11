Return-Path: <linux-kselftest+bounces-30556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B11A8575C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A381BC09A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842382BD58D;
	Fri, 11 Apr 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbYFVp5u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpTTvUh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92329CB3C;
	Fri, 11 Apr 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362119; cv=none; b=YRucuI9/dWjJQ/DTO5BQJpvVlhbiZkKaWk0jmuFZCi3WPguuErPac2CahGDjKlX1zE4oi90SxAfrN0gP+motP8bHeFZJrMzIa1Mzwrnec8dKI5xoCkSxYykI2FU8mraaZt7YbS1pJTRBxGzJTLExbp8tY/LxunIm2hei9bDh4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362119; c=relaxed/simple;
	bh=57F0YmhSlN4tFYcLaIwl/LaPNC82JeponEq16ncbsHI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bD0qVKl6t/J+4K1HzZ/lg0is6I8yD1DQ7LTE6J4JtX5OUBxtViHjwZgyg/cNI42KNPKyIB7URS+wprpA2cCZbLldlRDuB7ydH6aM6Qr6MyCDqzHMSo+T1cRS9r6PVtKgJ1CH69U9zCjJJzKjF2uzKSWtGn3N0oKieIzUfJJI//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbYFVp5u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpTTvUh0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm7NpzwzHwG5QyiMDAKDL8vf/JWws+fnKfEgWpTx3s=;
	b=LbYFVp5uR9JvM8j18xi31KyucTVrMCU2tgjxWngOwBBENFGMDBO5TBnjc/UjElUZFrLrly
	PxLN3A4KwQll9qaXNGzdKh1jZPDfGcpPQNxW8x4u46eXdbNf0beKyjNMGIkN4msAp3D8dr
	XBvuq8s77IvMtG1BlpEeS7vSTjFWku7DylCDd85X/GLaWjOcXzlTykMEMGLXy1ulpd7j9h
	VSKy9j/bkfqWSWvHnB0tA0m7a2pW4ZR/nAcIkIWhAqW/VYyCq2V6pdQjzLeP5LbJD6HnOR
	SOs7Ocd3EREozU1OebRhg53QAR5iLyVCCWYCJBc6r44px8N6PLtM7erM5F7vQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCm7NpzwzHwG5QyiMDAKDL8vf/JWws+fnKfEgWpTx3s=;
	b=fpTTvUh0FtlhRPqeCRLaQbfZ6l1+mTHWduZZpNk1RJwVWfkg+e3Yi7WoFaE/Z9N7NWMOAY
	O0Lj5gSlSa37yECw==
Date: Fri, 11 Apr 2025 11:00:43 +0200
Subject: [PATCH v3 19/32] tools/nolibc: add _exit()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-19-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=912;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=57F0YmhSlN4tFYcLaIwl/LaPNC82JeponEq16ncbsHI=;
 b=CxlqKJ0GWfBQTx9yR7EeAsp7d69aTZGd6t2kTPVbGLZQGu2uwmV/NmnazmPYg8nbOZ3tqGLuG
 lKF6WKrWGwMBXteoHCGRm8C1p73sgnglnIDSUCtjIqTH/8cKMd01zND
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

_exit() is the faster variant of exit(), skipping all cleanup actions.
As nolibc does not perform any cleanup anyways, the implementation is
trivial.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/sys.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index b04d83a7ec50cad7beb32198d9d47bd9d5873f69..f52e1953020945fb2902d47ad5f7a8e7c2c1c290 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -301,11 +301,17 @@ void sys_exit(int status)
 }
 
 static __attribute__((noreturn,unused))
-void exit(int status)
+void _exit(int status)
 {
 	sys_exit(status);
 }
 
+static __attribute__((noreturn,unused))
+void exit(int status)
+{
+	_exit(status);
+}
+
 
 /*
  * pid_t fork(void);

-- 
2.49.0


