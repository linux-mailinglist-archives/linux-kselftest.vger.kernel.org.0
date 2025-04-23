Return-Path: <linux-kselftest+bounces-31414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8223AA98F94
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4DC8E12EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 15:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD9D28B4F3;
	Wed, 23 Apr 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oaTU8fkf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J+J0MAUb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72C289359;
	Wed, 23 Apr 2025 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420507; cv=none; b=cCeIravX1Tato2Wbavgc8hXpfhKqGLaRattUEMROmw9dErmMeqixenQ6JgJ0OFmp8Dn/rloMsi6oXbpWwp8ST6SEkat8uKS71E9k5BVLPKNL7B3hCPNjxcpVhdCEfrqdtrLrT3iXLIfg3Dn23b5OYTPHzpFyb4TmCXDROLqcqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420507; c=relaxed/simple;
	bh=AYXbn4NX9XeIVkNZl12qqF/W5pwE5oN1B2T0jDTP9Hw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oMaa7dHalAAgdtRAXc4xwvlXyi12CopoFg8totRBaCfnvXMiOu3yXJNlr0AAv5DTa3sXO0CwaHtf/IOEsv6QP+wgDrEXb8buzwV7fqgPPyocdg6eKQ3SujDOOdw52L1ulL9fPuEkAUtdCuC4mHGOoCiPl4MUhp7wd231L4TdEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oaTU8fkf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J+J0MAUb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745420504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQbT0qvKJrdNXKvpl0h1tlyZlalWotnaZqnnxZBEhvw=;
	b=oaTU8fkfdKvQeCRwt4/T3DajDImT697wENohpSawCYAuNOOA5OCaxmHA0thRRA0pyBFZWR
	ueTrPPesd5c1wrB4pumFfkc3sgaqV5HLdKk1sSpylm+SlEQ8/jdyxF9hR8jBymJEv/XVWx
	hpMp72rspqbXZc1oSDJa7iJaFObz/ZncjLbKzHvDXPfScM5K9Oeke/oZkVfq93dtKataNr
	WtfWq4Exi1809BMJZ3N7p/+/F51yuCfkXxRKfZCGvra2hOMhcOM+Es7CC9LNKjsOsgKlVE
	6+AudiH+IwoCXn825Xx6xjYjN8rqAY1E0X4ouFaqvZAlBfOcCnqJjCREe5+UYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745420504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQbT0qvKJrdNXKvpl0h1tlyZlalWotnaZqnnxZBEhvw=;
	b=J+J0MAUbRh3We3LoQxXrAxXM3chzxK/U9ueSNtFqSVglRkdKnLx9AHyb2zHzkf5U8KhvEj
	htPPNpkHPBiLmLCg==
Date: Wed, 23 Apr 2025 17:01:39 +0200
Subject: [PATCH 09/15] tools/nolibc: add timer functions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250423-nolibc-misc-v1-9-a925bf40297b@linutronix.de>
References: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
In-Reply-To: <20250423-nolibc-misc-v1-0-a925bf40297b@linutronix.de>
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745420497; l=6398;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AYXbn4NX9XeIVkNZl12qqF/W5pwE5oN1B2T0jDTP9Hw=;
 b=PWbTs4g65BX5Wbuv4a9vLyGN51Op/RIxrC3fQ+K9BjoGnpHjaHZmue/VpAaxGWCDFQkzPc0Bc
 ls1fvkcZv90CFVsPLZCt9VDAplCsnYjvqpv3CUg+s8KCM6nrxdGNnd0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This is used in various selftests and will be handy when integrating
those with nolibc.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/time.h                  | 86 ++++++++++++++++++++++++++++
 tools/include/nolibc/types.h                 |  1 +
 tools/testing/selftests/nolibc/nolibc-test.c | 51 +++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/tools/include/nolibc/time.h b/tools/include/nolibc/time.h
index fb330628a59ad8a8b2b01c027b861472888ddee4..28a1549adb14e2087fa8fbdb7e9c35e1c3f22c2a 100644
--- a/tools/include/nolibc/time.h
+++ b/tools/include/nolibc/time.h
@@ -12,6 +12,7 @@
 #include "types.h"
 #include "sys.h"
 
+#include <linux/signal.h>
 #include <linux/time.h>
 
 static __inline__
@@ -117,6 +118,91 @@ time_t time(time_t *tptr)
 	return tv.tv_sec;
 }
 
+
+/*
+ * int timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid);
+ * int timer_gettime(timer_t timerid, struct itimerspec *curr_value);
+ * int timer_settime(timer_t timerid, int flags, const struct itimerspec *new_value, struct itimerspec *old_value);
+ */
+
+static __attribute__((unused))
+int sys_timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid)
+{
+	return my_syscall3(__NR_timer_create, clockid, evp, timerid);
+}
+
+static __attribute__((unused))
+int timer_create(clockid_t clockid, struct sigevent *evp, timer_t *timerid)
+{
+	return __sysret(sys_timer_create(clockid, evp, timerid));
+}
+
+static __attribute__((unused))
+int sys_timer_delete(timer_t timerid)
+{
+	return my_syscall1(__NR_timer_delete, timerid);
+}
+
+static __attribute__((unused))
+int timer_delete(timer_t timerid)
+{
+	return __sysret(sys_timer_delete(timerid));
+}
+
+static __attribute__((unused))
+int sys_timer_gettime(timer_t timerid, struct itimerspec *curr_value)
+{
+#if defined(__NR_timer_gettime)
+	return my_syscall2(__NR_timer_gettime, timerid, curr_value);
+#elif defined(__NR_timer_gettime64)
+	struct __kernel_itimerspec kcurr_value;
+	int ret;
+
+	ret = my_syscall2(__NR_timer_gettime64, timerid, &kcurr_value);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_interval, &curr_value->it_interval);
+	__nolibc_timespec_kernel_to_user(&kcurr_value.it_value, &curr_value->it_value);
+	return ret;
+#else
+	return __nolibc_enosys(__func__, timerid, curr_value);
+#endif
+}
+
+static __attribute__((unused))
+int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
+{
+	return __sysret(sys_timer_gettime(timerid, curr_value));
+}
+
+static __attribute__((unused))
+int sys_timer_settime(timer_t timerid, int flags,
+		      const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+#if defined(__NR_timer_settime)
+	return my_syscall4(__NR_timer_settime, timerid, flags, new_value, old_value);
+#elif defined(__NR_timer_settime64)
+	struct __kernel_itimerspec knew_value, kold_value;
+	int ret;
+
+	__nolibc_timespec_user_to_kernel(&new_value->it_value, &knew_value.it_value);
+	__nolibc_timespec_user_to_kernel(&new_value->it_interval, &knew_value.it_interval);
+	ret = my_syscall4(__NR_timer_settime64, timerid, flags, &knew_value, &kold_value);
+	if (old_value) {
+		__nolibc_timespec_kernel_to_user(&kold_value.it_interval, &old_value->it_interval);
+		__nolibc_timespec_kernel_to_user(&kold_value.it_value, &old_value->it_value);
+	}
+	return ret;
+#else
+	return __nolibc_enosys(__func__, timerid, flags, new_value, old_value);
+#endif
+}
+
+static __attribute__((unused))
+int timer_settime(timer_t timerid, int flags,
+		  const struct itimerspec *new_value, struct itimerspec *old_value)
+{
+	return __sysret(sys_timer_settime(timerid, flags, new_value, old_value));
+}
+
 /* make sure to include all global symbols */
 #include "nolibc.h"
 
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 08c9fdd1c7991656aabca5dd4dd363da45e00dd8..3528782670bca23fc9eb0323eb5af3100a037855 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -199,6 +199,7 @@ struct stat {
 };
 
 typedef __kernel_clockid_t clockid_t;
+typedef int timer_t;
 
 /* WARNING, it only deals with the 4096 first majors and 256 first minors */
 #define makedev(major, minor) ((dev_t)((((major) & 0xfff) << 8) | ((minor) & 0xff)))
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7eb69971667a196cb0855d156e3e18085851de7d..6af55a04e3c6bcea4e09c941778ffd1f3b186690 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -902,6 +902,56 @@ int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_timer(void)
+{
+	struct itimerspec timerspec;
+	struct sigevent evp;
+	timer_t timer;
+	int ret;
+
+	evp.sigev_notify = SIGEV_NONE;
+
+	ret = timer_create(CLOCK_MONOTONIC, &evp, &timer);
+	if (ret)
+		return ret;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = 1000000,
+	};
+	ret = timer_settime(timer, 0, &timerspec, NULL);
+	if (ret)
+		goto err;
+
+	timerspec = (struct itimerspec) {
+		.it_value.tv_sec = -1,
+		.it_value.tv_nsec = -1,
+		.it_interval.tv_sec = -1,
+		.it_interval.tv_nsec = -1,
+	};
+	ret = timer_gettime(timer, &timerspec);
+	if (ret)
+		goto err;
+
+	errno = EINVAL;
+	ret = -1;
+
+	if (timerspec.it_interval.tv_sec || timerspec.it_interval.tv_nsec)
+		goto err;
+
+	if (timerspec.it_value.tv_sec > 1000000)
+		goto err;
+
+	ret = timer_delete(timer);
+	if (ret)
+		return ret;
+
+	return 0;
+
+err:
+	timer_delete(timer);
+	return ret;
+}
+
 int test_uname(void)
 {
 	struct utsname buf;
@@ -1183,6 +1233,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
+		CASE_TEST(timer);             EXPECT_SYSZR(1, test_timer()); break;
 		CASE_TEST(uname);             EXPECT_SYSZR(proc, test_uname()); break;
 		CASE_TEST(uname_fault);       EXPECT_SYSER(1, uname(NULL), -1, EFAULT); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;

-- 
2.49.0


