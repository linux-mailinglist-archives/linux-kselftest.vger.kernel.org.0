Return-Path: <linux-kselftest+bounces-38759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95003B21D00
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6988646608E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB02E540C;
	Tue, 12 Aug 2025 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPlqT3b8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m1IHNB2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4C2E2DCE;
	Tue, 12 Aug 2025 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977162; cv=none; b=iV+c5KhjZIfRDwwLmsMoyVqR96R2jU3o9rNYIhPye4WC64GoZbcCynpcwrYbsrJbjIy1WihTDkyCJRvEdjPZdtRgWFc7H9qVuLENDDQ8adt9iA2sZ0cHNIDFiTcOMmOPXrPQtRqW29pP2bH++ZTuOBMpdRnO+dLB6WYvoyCGoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977162; c=relaxed/simple;
	bh=462tCF8mGJkETKI+jaYejyOhp0vStB6ZJ8kzTN4Bmx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMZt/t2UcuB0lDj4M3euNvllcSOb8pLRIMMbrxDgzgX8VXawsIQ2ksadrVPNyVsO/QlvzKr+Xgj+wXR+An+RJX1zFAuGZY5s9xffBssIydVAA5xtNflXk6r2+7anlxCrOMfO0wMLYhv1iSa+adrlJhreG7DVSxyanBMZCx2zu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPlqT3b8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m1IHNB2+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paqhkyGhSs/0Q/CzUgBgb/bsN6VDHUKBy2HuF8Oujz8=;
	b=YPlqT3b8aj1negDGz7pRTRww70zM1R5ouhChTTv+YbAhIqlL2zxn7IK5JKg/sjuPUDQHC9
	4dyIVJy3ZInIO8vKSG2GYRQ6GG1lDdjx3n3LeqXlHu4MjaJJxBrF4xvw0LVQNTjkNzTNmQ
	PX+gHvmATjoUQyFfJKl6Euuu9zONYzLyWmCSsIGdzy59C9UPFfpoRnFnpdWppmPREUeVfm
	7Y28yZQSoHEUmg7AHThaZHwufNgzcLQerg+9T7yZvlIkPtkGH1I/sMbLIHBD2xF38Hnp/n
	/qpAEzQIwmcXntEZSk2L6LM9EHyxXNEj/3JyQB/+PHUcJB3rDrSrY8tdaoxZsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paqhkyGhSs/0Q/CzUgBgb/bsN6VDHUKBy2HuF8Oujz8=;
	b=m1IHNB2+Vw5ZMoTUEGwVtw9hrhGgqXUeCduGcYJHWepCE9iqXF6/jPqd0sos5weJrpq6iv
	9m7NKQkI1QicqxBw==
Date: Tue, 12 Aug 2025 07:39:08 +0200
Subject: [PATCH v2 7/8] selftests: vDSO: vdso_test_abi: Add tests for
 clock_gettime64()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-7-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=2655;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=462tCF8mGJkETKI+jaYejyOhp0vStB6ZJ8kzTN4Bmx4=;
 b=AQdP8rsPJECo0A3Z6uyyF1sHmWxvKFwKCrLTo7LfLKc/o8QDHcZs0jlxk/NywoSEv1KHC2mYC
 +6qbaoALPbVBX2YxA1uYhV/8aw7htvFfsewHGuUTbVp2gobY64XGOP8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To be y2038-safe, 32-bit userspace needs to explicitly call the 64-bit safe
time APIs. For this the 32-bit vDSOs contains a clock_gettime() variant
which always uses 64-bit time types.

Also test this vDSO function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 37 +++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index c25f09998b82d797d690228e6ff026150b28934b..238d609a457a281d802734b40d6a2c35ba7f6d72 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -26,8 +26,15 @@
 static const char *version;
 static const char **name;
 
+/* The same as struct __kernel_timespec */
+struct vdso_timespec64 {
+	uint64_t tv_sec;
+	uint64_t tv_nsec;
+};
+
 typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
 typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_gettime64_t)(clockid_t clk_id, struct vdso_timespec64 *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
 
@@ -70,6 +77,33 @@ static void vdso_test_gettimeofday(void)
 	}
 }
 
+static void vdso_test_clock_gettime64(clockid_t clk_id)
+{
+	/* Find clock_gettime64. */
+	vdso_clock_gettime64_t vdso_clock_gettime64 =
+		(vdso_clock_gettime64_t)vdso_sym(version, name[5]);
+
+	if (!vdso_clock_gettime64) {
+		ksft_print_msg("Couldn't find %s\n", name[5]);
+		ksft_test_result_skip("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+		return;
+	}
+
+	struct vdso_timespec64 ts;
+	long ret = VDSO_CALL(vdso_clock_gettime64, 2, clk_id, &ts);
+
+	if (ret == 0) {
+		ksft_print_msg("The time is %lld.%06lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+		ksft_test_result_pass("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+	} else {
+		ksft_test_result_fail("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+	}
+}
+
 static void vdso_test_clock_gettime(clockid_t clk_id)
 {
 	/* Find clock_gettime. */
@@ -171,11 +205,12 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
 
 	vdso_test_clock_gettime(clock_id);
+	vdso_test_clock_gettime64(clock_id);
 
 	vdso_test_clock_getres(clock_id);
 }
 
-#define VDSO_TEST_PLAN	20
+#define VDSO_TEST_PLAN	29
 
 int main(int argc, char **argv)
 {

-- 
2.50.1


