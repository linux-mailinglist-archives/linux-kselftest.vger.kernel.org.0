Return-Path: <linux-kselftest+bounces-32189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45AAA7250
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D0B1BC4523
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70990255F29;
	Fri,  2 May 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOXeZhed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W/1vO61B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C62550C4;
	Fri,  2 May 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189628; cv=none; b=CbVUw0FB6dwIdFQ+Tg+RmlLES7bTTa/0aVsEuckmwObqMiK66S3iGOw+hfgcZnznce3PmSn8RUzCWbuVfJY2x2qpshYlrqPhzZftbXhzLdKHmt66iNuYIHVle5mqM3mZ17YfawOrJ99qRBU3ff5FKif7ctX6BwBOf6zOYvIzS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189628; c=relaxed/simple;
	bh=UyHvFVVFIQaACX+qJSkumHzAA5s8RoR7qJuwMjG3Jn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agFKRpTvetqjnJpASHf6teq8WP6yKc/C8PpfEMmrxkmGTOPxFr1aXNyH7yDrUpjukhUtbWRsbJoF4Snp4sTy1QxyT4CXc5IABOBkaS1F4LPxwtodzgHFIn21o7M0iK0+55HfKyCo5ij+fs0maGs0cZwZMIZhk/GoA4yBU2Ufie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOXeZhed; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W/1vO61B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746189625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gTyejjiOXqZR1KvHS5h4rCHXHVNbRv5z/P+yXY/7bY=;
	b=ZOXeZhed5Zo8wfRXuSMheY2XSWA2ytELUXQANep9FI6idCdV4GdttXNBHrXDIlmZFPGNa0
	HCfIJa1pzuXlJvHJR0PwCD9Ms54cw/7ErMbE0VaIzwiXerDWJCmzUbKIQPCWiiJ3J4Vmlc
	Kf4GYoFrouJ/HEDZ2Coy0yPU7c23wa4Bgs2e/z4mU6MZtMQBjiQSfDaEED/jBpnbXiuAoS
	tJ39i0jNTjibjy8uJbXNb/o+K98uTIVnrLwFv48PZDieztq3jyHJipJqRfc8k/K8T/bdTP
	tbXEX7Fw+CLo9mo9GFd/RBev/dPnMow5iHihfw9tZ9HAjIt9tYVsv9m8R+JwUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746189625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5gTyejjiOXqZR1KvHS5h4rCHXHVNbRv5z/P+yXY/7bY=;
	b=W/1vO61BhCo18iGV3Q22efdHoGWJC5Abc3nNm0QLFnKxq1WfCcLfZxl2Ze8LbmQ0Rvd12J
	m3FQvQF56ex3iLAA==
Date: Fri, 02 May 2025 14:40:18 +0200
Subject: [PATCH 6/7] selftests: vDSO: vdso_test_getrandom: Always print TAP
 header
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250502-selftests-vdso-fixes-v1-6-fb5d640a4f78@linutronix.de>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746189620; l=1322;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=UyHvFVVFIQaACX+qJSkumHzAA5s8RoR7qJuwMjG3Jn4=;
 b=9qT/Futo28wFjs7mdtWWrEGbOMb+sP+5BuR3Shv2iYLdxm3Nr5cLuAEoiHdJFu9aF8M/7IqG3
 s731c2UNdcXBvztxsiftC53lHoBoqPEWug5q8kKmLgSfZ3/a6QpPRIE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The TAP specification requires that the output begins with a header line.
If vgetrandom_init() fails and skips the test, that header line is missing.

Call vgetrandom_init() after ksft_print_header().

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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


