Return-Path: <linux-kselftest+bounces-45556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9353C58A94
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC94D5015F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8413563F3;
	Thu, 13 Nov 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBqO4yEB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/UP3j5af"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12A355035;
	Thu, 13 Nov 2025 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047875; cv=none; b=gQyL+lBTyx1m7olBkMgdQ994FdBhx5q/yUhzgy7T+QuXHbrQu8TUNBjSW6Qn1m+6Zb+9Mc9xXmJuHd3/QIUF78ReTUL5IS7QincqQp92JBEMHBr/ikjFESDgOCpYV9TdZhcXEak1hF+FJDnYjIVu3r6PkABMMspyeHBCBPwhfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047875; c=relaxed/simple;
	bh=TK3kDMdKI7t7x2lzP/yrgs3XhFSrM6UorVFO2YD8btE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3ip6zHT0YY+ENuvzFml24hxe+NKc+q5dD/ImLvFi+XFYH31m2ohdLjGoCVLJ9FkBEDLYNHRlinFkWfR9m4nSbIxtcsHmdMqRqDjaD3nwGF0ub1JiuN9dZSBwUGlENv+XB2X4fTxQlgrca8jifdApJnuCukvOXA7gZhwpQBTt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBqO4yEB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/UP3j5af; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763047872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZFSs81AIopxVpJk23vsXnUXNlQYUu8F0A7B4CVaEBE=;
	b=cBqO4yEBWMtMvzSwaRiBc3j1aa9vS6c4eP2KB0WyIyUC7NhneRw36H/h57JnXbEhyJc8dM
	cojD/AUTZZ6VmXR6IticxNQFdgxFqnTevq/xVZZ7Ke7FtpzRtzwkYvYQ0VFV/Hioob0iBH
	hhvhfz8AJdnzeSHIhHFkjiyimkd7cf1dxxKyzMUTTnz7RpdMfIgwlIf3PnS/Syj6ap7zDt
	Li6194V0Fq9J0KrSr4lnKTv4NiGdIGgJVVmfjp4rr46FG2eojODN5yWZaDBExdl4kjNl0R
	9K3kO5wgvIfmUOmapdG2kM1lCcyDS88wxpjutEziVDUcMjuAVXNKOR0fVfZxVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763047872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZFSs81AIopxVpJk23vsXnUXNlQYUu8F0A7B4CVaEBE=;
	b=/UP3j5afozy/Ol/0KfuT6Tlpok1H1DMR3/BQX5zlD78CSqjC8IFSFfFdTW7/TbSwxbHplY
	0Ng5r4lwZqUadoBw==
Date: Thu, 13 Nov 2025 16:30:23 +0100
Subject: [PATCH v2 07/14] selftests: vDSO: vdso_test_abi: Validate return
 value of syscall(clock_getres)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251113-vdso-test-types-v2-7-0427eff70d08@linutronix.de>
References: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
In-Reply-To: <20251113-vdso-test-types-v2-0-0427eff70d08@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763047863; l=1274;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=TK3kDMdKI7t7x2lzP/yrgs3XhFSrM6UorVFO2YD8btE=;
 b=eeHGGgJt+gpM1IhzcBzDHm+KY3Wx4fTV35i3di87gmYvJyLmaJ3jnkIkXo8vv3VSScVnmlhdZ
 +WuY82so5weBeDZbq5sYXMVMSrTBQ2SIYY4gfpX2jolL09PAqZW6NGb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If the system call failed the output memory is not usable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 7826d9c10ccaf313dc003e8959d9eb84b2cda874..ff142b3b9075b18e60a46b77492d285e9937fa71 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -168,12 +168,15 @@ static void vdso_test_clock_getres(__kernel_clockid_t clk_id)
 	}
 
 	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
+	if (ret == 0) {
+		ksft_print_msg("The syscall resolution is %lld %lld\n",
+				(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);
 
-	ksft_print_msg("The syscall resolution is %lld %lld\n",
-			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);
-
-	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec))
+		if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec))
+			clock_getres_fail++;
+	} else {
 		clock_getres_fail++;
+	}
 
 	if (clock_getres_fail > 0) {
 		ksft_test_result_fail("%s %s\n", name[3],

-- 
2.51.0


