Return-Path: <linux-kselftest+bounces-32322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB00AA8F4A
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCD169D32
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1541FDE09;
	Mon,  5 May 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcZthQrU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9KFB5+oL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694AE1FBC91;
	Mon,  5 May 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436798; cv=none; b=S9mJrKOZYJ7MgVGBcYzwmmuQX2JRlciXzB90JZKbD1rEO8fxJj4Nag0r19yfYe/oZsjdXR3/QuddYI25sllh2GzJNN5l4B2dyZSuxmZ/jYsrfa+deCFl9lqN/C31l4jp8EtO/gFENLZFgOKqTJK9qBDfTsWacLRMvpHBO3JchfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436798; c=relaxed/simple;
	bh=cxHEGn3tPKliGKbaFKHQWUGc8P9QKk6Hye+vt7qgNJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGSh91iSyp4doKXIzYTWfsYEze9n84SkasZkYypUVlvWuUSqEq7omngVIy6r99ZPg4s0RTVGKEXzBxuUuHhvlhCkjeW8p96uFPnAOOvemjRHfENOUKAK7MECrV1LDyv/GK+jhpUdyQ/96k/EC/jSM3SRcnevAxaKS6jOq2CZmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcZthQrU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9KFB5+oL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDW0PZHCiGvBphD7V/nCe9wsSYuC9r/BQCQX6s4mLdY=;
	b=kcZthQrU9d6uBMs8/a8RX8teatYV0FprWtSSJG5BVD9nNeCMc5o2sChCoWmCHGyONaNudP
	1zny02arA8AMm+oVLuzdgJmq2BO36ScBz5p2wJ0yq09SMsvWDh1602UF5XxV+JHL49kidj
	v59b94tNAoiBIw9nyToZUaK5Bg3AeOjHE9pqL/TASBzz6UDVMYScgkby+6laJ2NVpcbcXY
	f/erNHXtCDqeU6ioPHuyF2OK7XRT6P2fv7Gp4oK+u9sgqvOg7MHjxF6VwY0ndYyG+I/nd/
	9rkSsh4uWyfVHNVZAPQTX5rlrGE/uQkH2WTBywneHVF38H212xL4sbO91SuNoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDW0PZHCiGvBphD7V/nCe9wsSYuC9r/BQCQX6s4mLdY=;
	b=9KFB5+oLt9p3kFaN4qt+X7fdwde43rzsxEbaRqeggR58HBrVtfGHb7K1Fg04eH7UgtPpRV
	oQI1jbiH00zyhJAg==
Date: Mon, 05 May 2025 11:19:38 +0200
Subject: [PATCH v2 4/8] selftests: vDSO: vdso_test_getrandom: Drop some
 dead code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-4-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1351;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cxHEGn3tPKliGKbaFKHQWUGc8P9QKk6Hye+vt7qgNJQ=;
 b=nY1AeZ1JVgGbFdV0OPa/+r9vqXD9H7Lgs97hD5C6DYCPe1814XVgRWgEAhSRVkjnRt6t8yiEf
 0ksjvuWh6FCDCXX6wvR2oZsZDaRz6x4HfYFYgJRA52TGuUV/6M691m+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vgetrandom_put_state() and the variable ret in kselftest() are never used.

Drop the dead code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index f36e50f372f935e6d4da3175c81e210653bdce1d..b0e0d664508a38d6dde9df0a61ec8198ee928a17 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -100,15 +100,6 @@ static void *vgetrandom_get_state(void)
 	return state;
 }
 
-static void vgetrandom_put_state(void *state)
-{
-	if (!state)
-		return;
-	pthread_mutex_lock(&vgrnd.lock);
-	vgrnd.states[vgrnd.len++] = state;
-	pthread_mutex_unlock(&vgrnd.lock);
-}
-
 static void vgetrandom_init(void)
 {
 	const char *version = versions[VDSO_VERSION];
@@ -264,7 +255,7 @@ static void kselftest(void)
 	}
 	for (;;) {
 		struct ptrace_syscall_info info = { 0 };
-		int status, ret;
+		int status;
 		ksft_assert(waitpid(child, &status, 0) >= 0);
 		if (WIFEXITED(status)) {
 			ksft_assert(WEXITSTATUS(status) == 0);

-- 
2.49.0


