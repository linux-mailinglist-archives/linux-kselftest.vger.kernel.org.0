Return-Path: <linux-kselftest+bounces-32190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6BCAA7253
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1623B412F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4CB255F3C;
	Fri,  2 May 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mQNhKyca";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KM8aT++g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3056F255224;
	Fri,  2 May 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189628; cv=none; b=QkTG913yQIoHk7NzVn5Ce9v3WnztXm8o0oxaNX1roTK8mnfYBCMCyeDw+whHIC7J20rRj56dw2tYneH50PHrCCvKQ/9wFDFeX7hJRtgRvCZFwXlVNnMdHBUU4Pqjl5dqsjrXyDk57MXqx1W7BivpYcHw0tiRZmVz5tVf2zl6RF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189628; c=relaxed/simple;
	bh=k0Rw54EHU32O44Nm9USpxLtDZulKmyiApa7hB+du7l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlREAuCkWZKxeJp6WICE4dmKYE1PlODFT0BPeRmFId/rRT10dVylga0AxF06T1Gb1r4zBnTAvSy3i2PPl0hUOS93U926CcJtl9cI7Y1nYLusLGF8Ic1XxxM98xWbxGhrzn3FTQwId9OYqYgA4ar/dG60tr2a+pxnDueSTWBFP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mQNhKyca; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KM8aT++g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ5Wc7VoEeEFEXKY8GCFaOg4jL5AqEiDYCz7K/eX36k=;
	b=mQNhKycaTN0QliPO8GzC47HsmbA0y1XGTUZKjuSnIom+B6oGAxZI+VsV5clcKt4S+03C/4
	mnY/+m3UC+7wC5jB1UDRIvniBpWliGnbcPqSaT7gIIQNNQEkpIHNueAlIrFFNqLsgiIeuv
	0hf2CRRFLEwy7SWKkEz4dXztJskFEPnRa+aNfkttUhRfDgB5teIfEj8/0BsiP6+fyfIdBm
	uutClewqWgf5Mpd4nyK/oS8eI80FlGq9JgS4SynCQ7DaXwGzfWl+Pd9/BAyTnp5e81RiTK
	i4v60gBEDsF612dbDA7WVgT5vxldiDI8jMuNYPmuJwMjZMjpZLKFdf9j/dh2ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YQ5Wc7VoEeEFEXKY8GCFaOg4jL5AqEiDYCz7K/eX36k=;
	b=KM8aT++ga8rygHXvBktcCjFNIpffzJ1wldXVbMS9oRi9+BiltMg7vYGTl0+gSzk6cl6kn1
	ulNayHjH9gcDG1Aw==
Date: Fri, 02 May 2025 14:40:17 +0200
Subject: [PATCH 5/7] selftests: vDSO: vdso_test_getrandom: Drop some dead
 code
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-5-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1288;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=k0Rw54EHU32O44Nm9USpxLtDZulKmyiApa7hB+du7l0=;
 b=YKncfNZsJGp0Clfd/fp6DGhh1q6/+YNbhnGGp9Rbh5s0wqGvPWdPtnll8yBbt5W2SbqI8kr2j
 YVy6BvokCqaBkoTPsEnoUZ5wsK7cqWMLEen2Ox4smKeg5i2dN3cpW1r
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vgetrandom_put_state() and the variable ret in kselftest() are never used.

Drop the dead code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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


