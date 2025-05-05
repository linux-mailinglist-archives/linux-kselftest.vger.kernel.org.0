Return-Path: <linux-kselftest+bounces-32371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE7AA9720
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC397A7408
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F525DB12;
	Mon,  5 May 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Guh4Kkmx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIUSFRMT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6925A337;
	Mon,  5 May 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458176; cv=none; b=XQEuXVK7VB4JNbVhnbPqL3ZeKAKKyArKjbtoV3okqpxWMx5GyvDmDbzHwmp1qCrQ4EcFBoUkGQtmV/cJV1/+CUy1DwA12tQWS2w8u5/FVgfFHPubkhxWJAXaNekdpV2MTNdOQu4LHU4VncMqh2kQlOyEVUCl28dC0ObSHyQHpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458176; c=relaxed/simple;
	bh=IgAv7u92b6nUp1dIoS5UQU29guGSB5ifPJxUKWCgMlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y90s5I21DxXKVtB6szquxRGiHVoxkd+5mYjm7LZkBt4895VhMt+fmAvhbkv/bX7foWfW1SAoflYJQxiZ9HW9A5lkOvvvJmdMkmvFm6JVwZ/OUs81+ZK0+2tlMfNXZ+Wm51PcWDGp0F/tcPVr6eKgWudHe1xXThxDClgKuuv/mX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Guh4Kkmx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIUSFRMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746458173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmAYGefQspjxqgFvHq08P1lvZ4L89NIXaIMkIe2Mb+Q=;
	b=Guh4KkmxF/IzNHCBFacQLH/PnGVpoG7mhuO+wvkhoBlM6+dWgnEc4UBRaj15zrTnRqJOar
	V1R3JZEV2r1phHnqHls0E86QFhgrFboxBhjC6Rj0/PuM0x8uNym84ZK08mIGogceiV8QMK
	256SAmW8Lv9OwlhWU0wkfyekbgmKGRO9QOPmrTuJIfXcHHYADL6N4ZWjOwmUK9FhNdAWEq
	VtudER7pcyeRKNlh5YZJgpxm3pW8mOYhku3SXDJNpD76nvkWUZ1DB+jSaloMtoJp143ITX
	N6bEoX63XPZ8kD/8w3yhwZ/OtlK1ArPp6+h7RER0DM96W9gCx/Qei8LSLMtLhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746458173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cmAYGefQspjxqgFvHq08P1lvZ4L89NIXaIMkIe2Mb+Q=;
	b=MIUSFRMTNCt79e3dzLnbyGOa3BrDUElDwSNp/7jj1/NamQdyqbw9KTq8Ugv60UHs2xw42k
	k4QpHbzkUvW/2EBg==
Date: Mon, 05 May 2025 17:15:22 +0200
Subject: [PATCH v4 04/14] selftests: harness: Mark functions without
 prototypes static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-nolibc-kselftest-harness-v4-4-ee4dd5257135@linutronix.de>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
In-Reply-To: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Mark Brown <broonie@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746458170; l=2358;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IgAv7u92b6nUp1dIoS5UQU29guGSB5ifPJxUKWCgMlc=;
 b=/mmVq7ew3UzSTb7vLgQwpi7UV1YdurIkN57ULYLVPsnGyTisUzcpAHMzctOdnY5mShak322Sm
 YN+LqwkcJgLBQ+VOfa1YdZHSvkFUALj2DfD/4MN2+xdhkZyueW5O1QQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

With -Wmissing-prototypes the compiler will warn about non-static
functions which don't have a prototype defined.
As they are not used from a different compilation unit they don't need to
be defined globally.

Avoid the issue by marking the functions static.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kselftest_harness.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2b350ed60b2bf1cbede8e3a9b4ac5fe716900144..5822bc0b86a3c623fd34830fb8b541b27672a00b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -258,7 +258,7 @@
  * A bare "return;" statement may be used to return early.
  */
 #define FIXTURE_SETUP(fixture_name) \
-	void fixture_name##_setup( \
+	static void fixture_name##_setup( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -307,7 +307,7 @@
 	__FIXTURE_TEARDOWN(fixture_name)
 
 #define __FIXTURE_TEARDOWN(fixture_name) \
-	void fixture_name##_teardown( \
+	static void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
 		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
 		const FIXTURE_VARIANT(fixture_name) \
@@ -987,7 +987,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
 	kill(-(t->pid), SIGKILL);
 }
 
-void __wait_for_test(struct __test_metadata *t)
+static void __wait_for_test(struct __test_metadata *t)
 {
 	struct sigaction action = {
 		.sa_sigaction = __timeout_handler,
@@ -1205,9 +1205,9 @@ static bool test_enabled(int argc, char **argv,
 	return !has_positive;
 }
 
-void __run_test(struct __fixture_metadata *f,
-		struct __fixture_variant_metadata *variant,
-		struct __test_metadata *t)
+static void __run_test(struct __fixture_metadata *f,
+		       struct __fixture_variant_metadata *variant,
+		       struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
 	char test_name[1024];

-- 
2.49.0


