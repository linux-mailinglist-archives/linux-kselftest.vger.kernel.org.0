Return-Path: <linux-kselftest+bounces-32325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AB6AA8F50
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B941897B2C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 09:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE013201004;
	Mon,  5 May 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAOPXiUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WcL3FKfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2E1FF7C8;
	Mon,  5 May 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436801; cv=none; b=quByZT+7XcOOANtMkEd2SGpH3py9U3fs4E0ZlfdppLUWdz7WMP5EMrbV173znVWv8hg8RviUwqB9kndD2iFYJTu6UWh0XaweEbsHUNhy/Nf79KbJEBzZIsfMTxu4o6jkARV3iAeOpJbCjLu2kPIyYjP/tkHuoXNQQlrttH0kFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436801; c=relaxed/simple;
	bh=LrPMG95dKgGbiAYQg277cmPat1A7mSTaBb/d6Yl1tek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Im/BAOeezW638RTUT/XyZMRNqDD8GKjgDt9QKagpm/urem84cvFCjDbD4igxoz8Z4jGZMD9KUU6YrgAKfUXqgJQjG0MxtVcYyIZOu2neNihRsHR5QUjI/UvssAij37iWphYQRRCwCyU4Dtwflr4h1YsajU9LBxzpThDUyF3UwmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAOPXiUo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WcL3FKfp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746436798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJZ10Yp7MhEsztXardnZ3o9+hUAS27m0b/3zN5qur1k=;
	b=xAOPXiUoI2MhMPOtq8rrkZE6QCpU5ZP2rJVkPNn3vApdYSzV0hE7URMrUoXCHcQGP7u1gP
	km3fCZvrj/yHmcgLT3OC01/MDFbagklj8s7QiCsRQf6VYccDXWptuZxL4AOKsgBqSXZzWD
	LjJBIbbSK+kxf7U5AIkl0r5ZyZS2GouNayo3yneE8xOXUyN3fNwtvNntpJXm5E8cHmlVUx
	q3x/GolmCRZqWEtGVCxoHbJ4Jq3DzweZ2IxoDN5tdK9MKM9XZdA/v6Es42krJ3FUVeMIyv
	J29meIqSDu4lNYhgOv0X8wJKZs4ZPRXCUSBJUV+WqHa6zVeWcT/UCKHtQX36pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746436798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJZ10Yp7MhEsztXardnZ3o9+hUAS27m0b/3zN5qur1k=;
	b=WcL3FKfp6TSG7plDcg6UFqcTg5sWOxbI2PU8B0V8ilbfz7cfij2qC31EVkGGDxSrYHTIA/
	TpSonREFmdBf2LBQ==
Date: Mon, 05 May 2025 11:19:42 +0200
Subject: [PATCH v2 8/8] selftests: vDSO: vdso_test_getrandom: Always print
 TAP header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-selftests-vdso-fixes-v2-8-3bc86e42f242@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
In-Reply-To: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746436782; l=1385;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LrPMG95dKgGbiAYQg277cmPat1A7mSTaBb/d6Yl1tek=;
 b=Zq9lwnymbRFL3MumdIS/RIacWiN5xqEs/2BpmchWcv0vHw+kUICQ6xcdDG/OCrLmeABpZwfvr
 0DQU6WhXgWSBIStR8km05J+kbmhVgwGzqQZ4cKS5HyeduqD+7SCJP87
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The TAP specification requires that the output begins with a header line.
If vgetrandom_init() fails and skips the test, that header line is missing.

Call vgetrandom_init() after ksft_print_header().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index b0e0d664508a38d6dde9df0a61ec8198ee928a17..01892d8e65d754d0353f7df2b63910d5be8cd1bc 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -232,6 +232,7 @@ static void kselftest(void)
 	pid_t child;
 
 	ksft_print_header();
+	vgetrandom_init();
 	ksft_set_plan(2);
 
 	for (size_t i = 0; i < 1000; ++i) {
@@ -285,8 +286,6 @@ static void usage(const char *argv0)
 
 int main(int argc, char *argv[])
 {
-	vgetrandom_init();
-
 	if (argc == 1) {
 		kselftest();
 		return 0;
@@ -296,6 +295,9 @@ int main(int argc, char *argv[])
 		usage(argv[0]);
 		return 1;
 	}
+
+	vgetrandom_init();
+
 	if (!strcmp(argv[1], "bench-single"))
 		bench_single();
 	else if (!strcmp(argv[1], "bench-multi"))

-- 
2.49.0


