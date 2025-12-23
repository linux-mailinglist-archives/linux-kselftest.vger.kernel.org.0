Return-Path: <linux-kselftest+bounces-47919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E5CD8544
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 08:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70B530181AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727830B52C;
	Tue, 23 Dec 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DGjnp63x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIKZadyE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A2308F03;
	Tue, 23 Dec 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473170; cv=none; b=mNLtMTxah8Iv9348xVWN0/ju1wq65rpBPv+HEsxd+aq45Y5iQf2qMEpFdabNbNzfZuQ2VdsYdE/A3eztswU0YxcmtConzWPyuq6gvrwSh1O25QlAYdZ7cNiysvzPla/8gukEjeFbpLrNHUaqS33HKe6IJRjpHKU3uufefWM604Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473170; c=relaxed/simple;
	bh=IhlJsJlp1zBklWKzws3h9OECAM068REwLIQfQ/1/XBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YOs6y4YVnWhlAjZwqDZrYtY5I58rfnADrqYBFeODP8gwPXtuxjmC0QHxyJP6vzSEYTMLCrb2iyDjMMTjMLiKgJZLjxgiOWkG2Vx+NOBRE7BwA8u2NQ4VWLmZqldQCqd7w58ebdAEiR2XwVRHepcFkeAhSevNMnD+kVgk841uz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DGjnp63x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIKZadyE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67PdeczaSRW/csFNxd099uybA45ukLvFMyBWzVQFWoY=;
	b=DGjnp63x9J2xF5JMJLPECLk3uok5cOKB5usb6vQxg1xbkQKyZ7lAj491/UF5adorihTjFS
	A52lddQ5iND+DjZnpMlEhDr/hZ2xfHkK2vNxmKw9sjLNQEEaups/NoGGgDoTdS/XEC6NCv
	cNfdDmRQvcQhE5pVnKRLZYDaK3x3C2qSgPz4C0zFUDrgCWSkevIC/3+MSlJqWOkonTWmnx
	lY74F4KnunbzTzX5St+Dlt9APPVCjnMQOlAA/cEh/GFBKinRxhP8jqI5H9oygC/fvjVKHm
	Izgk7VhcPrXR6Ti+3ZmGY6pZmyLjhcQeHFnuFLkyHP7sIBBECVql1KcUWwPC+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67PdeczaSRW/csFNxd099uybA45ukLvFMyBWzVQFWoY=;
	b=jIKZadyEdJA/NILHOtR5tRsncX1708ixcVpS30Y2i8qCBMIPKn35S044wY4TMNKQfgUFBC
	K4tkzVYICJ8QR5Bg==
Date: Tue, 23 Dec 2025 07:59:15 +0100
Subject: [PATCH 4/9] selftests: vDSO: vdso_test_abi: Add test for
 clock_getres_time64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-vdso-compat-time32-v1-4-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
In-Reply-To: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Russell King <rmk+kernel@armlinux.org.uk>, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473161; l=3097;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=IhlJsJlp1zBklWKzws3h9OECAM068REwLIQfQ/1/XBk=;
 b=xeX2munaLG7MWGHPIInB4SzeRrscFxo+r622nRd43SWYQppyA7t3HaQcNJPboykuDbZ4yD6uA
 diipSgp6KkaBWGnW+CdLf+orOZOEDAzfN+6qiy7Y6KkmJgs7eH3bDXt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some architectures will start to implement this function.
Make sure it works correctly.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 53 +++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index a75c12dcb0f1..b162a4ba9c4f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -36,6 +36,7 @@ typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
 typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
 typedef long (*vdso_clock_gettime64_t)(clockid_t clk_id, struct vdso_timespec64 *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_getres_time64_t)(clockid_t clk_id, struct vdso_timespec64 *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
 
 static const char * const vdso_clock_name[] = {
@@ -196,6 +197,55 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 	}
 }
 
+#ifdef __NR_clock_getres_time64
+static void vdso_test_clock_getres_time64(clockid_t clk_id)
+{
+	int clock_getres_fail = 0;
+
+	/* Find clock_getres. */
+	vdso_clock_getres_time64_t vdso_clock_getres_time64 =
+		(vdso_clock_getres_time64_t)vdso_sym(version, name[7]);
+
+	if (!vdso_clock_getres_time64) {
+		ksft_print_msg("Couldn't find %s\n", name[7]);
+		ksft_test_result_skip("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+		return;
+	}
+
+	struct vdso_timespec64 ts, sys_ts;
+	long ret = VDSO_CALL(vdso_clock_getres_time64, 2, clk_id, &ts);
+
+	if (ret == 0) {
+		ksft_print_msg("The vdso resolution is %lld %lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		clock_getres_fail++;
+	}
+
+	ret = syscall(__NR_clock_getres_time64, clk_id, &sys_ts);
+
+	ksft_print_msg("The syscall resolution is %lld %lld\n",
+			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);
+
+	if ((sys_ts.tv_sec != ts.tv_sec) || (sys_ts.tv_nsec != ts.tv_nsec))
+		clock_getres_fail++;
+
+	if (clock_getres_fail > 0) {
+		ksft_test_result_fail("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+	} else {
+		ksft_test_result_pass("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+	}
+}
+#else /* !__NR_clock_getres_time64 */
+static void vdso_test_clock_getres_time64(clockid_t clk_id)
+{
+	ksft_test_result_skip("%s %s\n", name[7], vdso_clock_name[clk_id]);
+}
+#endif /* __NR_clock_getres_time64 */
+
 /*
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.
@@ -208,9 +258,10 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	vdso_test_clock_gettime64(clock_id);
 
 	vdso_test_clock_getres(clock_id);
+	vdso_test_clock_getres_time64(clock_id);
 }
 
-#define VDSO_TEST_PLAN	29
+#define VDSO_TEST_PLAN	38
 
 int main(int argc, char **argv)
 {

-- 
2.52.0


