Return-Path: <linux-kselftest+bounces-30537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CECFA85735
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A716F9A6041
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396482980BA;
	Fri, 11 Apr 2025 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KdgZ6DD8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrUc3rHd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B2293478;
	Fri, 11 Apr 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362110; cv=none; b=EPigVoNhXqMK8xYQL+GIHix3CrnnTyqg3eRkQEwSHmLBFz2QbeMfwDMJKzrb8BFnbbqytL89rEN+YK+F6Vbrm4rbN68W1gfMZzSqwci3raM1xTKuAtWsmpEqWhv5O9b01OzIaJP616NxALPa5dTOIQG3SFuk+CC34NoNcZe3VhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362110; c=relaxed/simple;
	bh=jGKlKoofOPJIAZx1RxcX4p7LfMYOyHoN+Nx2/9d9seQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3a6IEAeRByEk43SLjrk7w3QtDpoXN1FKJat4k9L5c0StuB3XyOUXWUXG3Tim8N6c794kRq1N85vtd7Oc9D3PH0awYw/nUkj/3WyDF91K027CcYM7PacOjYTxNKhiCT+H4wYv/5Pxx/4DfkMPiYN7xof//i+6suR0zS20e9pcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KdgZ6DD8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrUc3rHd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744362106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLj0ETsEs/I2mut8MoZZYVz5W4X+4bN5Q7Nlryt1VEQ=;
	b=KdgZ6DD8bCWkBMBa/MtVkzTx/Qy53mrG7UGCY4MGLQSqpaEJi/CaWe/tw2rYTFcHi7Xe1P
	OMFtlI3PiuZTiI/l1BK4yvwOVMVxA+ARzh0PsVNbc0elSzwh/waHVk5L/Ry+RbOEbx/lyC
	ila9497X9Ahh+8dsUJ354gb4V8M89iH5Lzzy2iT3qkUn+ajXu11hT5d814AnRZWDdmJ/uB
	y08MN2rkQ9HT+X/Yu/bbnuNO3ReMP1MCMgd35m0qDUM8WwkY8LwBqznlsXtGv6ExaRyzKT
	GuYUl7NiCTnHm1bW/GY6sqQEI8tW1s6o2Ksw02Km4/voA9kMYvDQrIuSocemwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744362106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLj0ETsEs/I2mut8MoZZYVz5W4X+4bN5Q7Nlryt1VEQ=;
	b=FrUc3rHdPs5SpaBvgWpYgyMphDwQs6SfV6DetCpt5CtfnpaR2efoAQef8Awoy9oBXHDIaB
	jdNJu7Wr8u74s+BQ==
Date: Fri, 11 Apr 2025 11:00:26 +0200
Subject: [PATCH v3 02/32] selftests: harness: Use C89 comment style
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250411-nolibc-kselftest-harness-v3-2-4d9c0295893f@linutronix.de>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744362103; l=842;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jGKlKoofOPJIAZx1RxcX4p7LfMYOyHoN+Nx2/9d9seQ=;
 b=JA0b04Xx84JihNi3xbQ2Xf/AUiNA1hy1Fb9zwOX/yqj/PNAT3GSJZ20xs5Q8N1LQZYDGRJXgT
 Z/KjAcI2iugBrMvDPuz6XtavKwa59su6Yk8p1jsgiBQn3me20fD9kek
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All comments in this file use C89 comment style.
Except for this one. Change it to get one step closer to C89
compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 666c9fde76da9d25fe6e248a7f2143c113473fe1..bac4327775ea65dbe977e9b22ee548bedcbd33ff 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -983,7 +983,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	}
 
 	t->timed_out = true;
-	// signal process group
+	/* signal process group */
 	kill(-(t->pid), SIGKILL);
 }
 

-- 
2.49.0


