Return-Path: <linux-kselftest+bounces-44987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE5C3BFB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18FF3350F68
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A321CC7B;
	Thu,  6 Nov 2025 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f66Fpu9i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nalym2pI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C306221710;
	Thu,  6 Nov 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442150; cv=none; b=WWfmv4hYDoUAx4dW3y6mM4bG1aYMc76ruAIC+J/5OBpcn5GwuNZDf/FDPr5usgIVk9v7VMwJ9K5HyeMTp/pclxhQZ6zdPcKVq1mksUT1wQrOa7hl4RBvyPc/wFGnrgPPQDLlZvGVB1kXsQ8xUSeQwMqUPPJlRfC50wx7E+K/baQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442150; c=relaxed/simple;
	bh=z8xPK1xx2fHBuulHSZ+SUNXDsHyaPEkSvnfMOIEyqLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fk1NUkwebkcXvUjYXvMlPsNmcDz1aT6IVcKCObRItZXp5UUFZo/Vi62pqtYtP2UUz31Xgx+SJ+MgpfgA+oPDSrQuGC5nG21Aon7qCRyTvhxR3SJQqNGU2ffigiogk4GGniCt2A4/PZI82oEcgi2fTXsm49ikVRfKahANhi6NBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f66Fpu9i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nalym2pI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762442144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLtSr+8LhzfirA2IeYphIZSTtuh+t2UY0R29gTgnx2c=;
	b=f66Fpu9iI7qYCUAcxeLkPDJQka5ofnOR3fk8877ekacG3k8F0SFEamntJTIKQo3wjM+QAx
	clG5BYAJ+S2jWLYm8Up3EWrciAhHxueUzSK0mWGIxfiImcnzhsvwvGIvAcE+d2ExOj6MzQ
	2sGyX5LQ1tnSxk7pzBAjUvBG3KyhmQb14NOqvsgMc6TkCp/4qWFad4l+BPY6JLfDTAeyxj
	CaVHwV1Tp2HMPaSM0kWjYstbJUoEmHD77ffqQYvlHF1cRGm8fNA1x81nJKf3fg8N1G0E5H
	06oPr41izmyezU8VpRUwcpPScmFxnBP9+4GFhTVV+WCB1i7QwxTkzNPGTNiiiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762442144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CLtSr+8LhzfirA2IeYphIZSTtuh+t2UY0R29gTgnx2c=;
	b=nalym2pISJYniLhFOn8EOk8mFkZws4ifsvfRh2KW6S+dfy6AoC7Ex43+XS1lzyeTPxIRq7
	XPL8Sn1/XVTpYZCw==
Date: Thu, 06 Nov 2025 16:15:24 +0100
Subject: [PATCH] selftests: timers: nanosleep: Add tests for return of
 remaining time
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251106-nanosleep-rtmp-selftest-v1-1-f9212fb295fe@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAIu7DGkC/x3MQQqDQAxG4atI1g0YO1XoVUoXYv/YgI7DZJCCe
 PcOLr/Fewc5ssHp2RyUsZvbFivk1tD0HeMMtk81dW33kFYCxzFuvgCJc1kTOxYt8ML9JEHlPgT
 tlWqdMtR+1/n1Ps8/Fwv/zGkAAAA=
X-Change-ID: 20251014-nanosleep-rtmp-selftest-6c14f1374f6f
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762442143; l=2406;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=z8xPK1xx2fHBuulHSZ+SUNXDsHyaPEkSvnfMOIEyqLs=;
 b=pZ1o3IleRjU7WOnxQtlgxC0VjWmOuwFPYu3FT4jzWSXYGcbRYz4mXUnPjTWUnvf2HlrFtJ4iz
 2BL7QuCXP6NB8OU4hCRvJqxpSqYsWQc/GKWmxYo16tQt/h9VzLr/tLb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If interrupted by a signal clock_nanosleep() returns the remaining time
into the structure pointed to by the rmtp parameter. So far this
functionality was not tested by the timer selftests.

Extend the nanosleep selftest to cover this feature.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/timers/nanosleep.c | 55 ++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 252c6308c5698f9094b8bdc39c284077b5d55531..10badae13ebeb8d596839d5aab1a5161526eeaa9 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -116,6 +116,56 @@ int nanosleep_test(int clockid, long long ns)
 	return 0;
 }
 
+static void dummy_event_handler(int val)
+{
+	/* No action needed */
+}
+
+static int nanosleep_test_remaining(int clockid)
+{
+	struct timespec rqtp = {}, rmtp = {};
+	struct itimerspec itimer = {};
+	struct sigaction sa = {};
+	timer_t timer;
+	int ret;
+
+	sa.sa_handler = dummy_event_handler;
+	ret = sigaction(SIGALRM, &sa, NULL);
+	if (ret)
+		return -1;
+
+	ret = timer_create(clockid, NULL, &timer);
+	if (ret)
+		return -1;
+
+	itimer.it_value.tv_nsec = NSEC_PER_SEC / 4;
+	ret = timer_settime(timer, 0, &itimer, NULL);
+	if (ret)
+		return -1;
+
+	rqtp.tv_nsec = NSEC_PER_SEC / 2;
+	ret = clock_nanosleep(clockid, 0, &rqtp, &rmtp);
+	if (ret != EINTR)
+		return -1;
+
+	ret = timer_delete(timer);
+	if (ret)
+		return -1;
+
+	sa.sa_handler = SIG_DFL;
+	ret = sigaction(SIGALRM, &sa, NULL);
+	if (ret)
+		return -1;
+
+	if (!in_order((struct timespec) {}, rmtp))
+		return -1;
+
+	if (!in_order(rmtp, rqtp))
+		return -1;
+
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	long long length;
@@ -150,6 +200,11 @@ int main(int argc, char **argv)
 			}
 			length *= 100;
 		}
+		ret = nanosleep_test_remaining(clockid);
+		if (ret < 0) {
+			ksft_test_result_fail("%-31s\n", clockstring(clockid));
+			ksft_exit_fail();
+		}
 		ksft_test_result_pass("%-31s\n", clockstring(clockid));
 next:
 		ret = 0;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251014-nanosleep-rtmp-selftest-6c14f1374f6f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


