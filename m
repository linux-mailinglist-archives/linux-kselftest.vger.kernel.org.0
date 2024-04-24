Return-Path: <linux-kselftest+bounces-8800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597F8B10F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 19:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4994B1C24DDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C022916E885;
	Wed, 24 Apr 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwclI1v0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F2A16E86F;
	Wed, 24 Apr 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979492; cv=none; b=lFFf9bOQQMP6wgd0d52zxUBQniqa0LCgzwhzbXRYwR+A4BSiwKKUbkGHVoaOwispRnLPNUWYda24t7vlLRvWAz92iE8+eJnDEJ99NGv0u/KTGK6jh5ct/72cyJ68eTA+6udVK8z77vCt0+IyE5R4RNM7YxEhbrJNDPLI2xy5tmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979492; c=relaxed/simple;
	bh=xQtYMXWzkLVGZHdWC5Izl0gg9cD9NA5pclKWj3MDh4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioriYm41qUVBH77xasKPJihYNrFSpA5Kc8sw03r+xltRBOPrs866IEtk1hvnK8BT0PY01e8etQF3fIy27VNGF/xhH5/n/nCO5DZlU36vOSYzloEPszmNDppAldPlTPuP9GvN1rq+vtyTjCJGMw6fHSrYAQk+CDhAacSRru7Zt1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwclI1v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9902BC4AF09;
	Wed, 24 Apr 2024 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713979492;
	bh=xQtYMXWzkLVGZHdWC5Izl0gg9cD9NA5pclKWj3MDh4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cwclI1v09jZJ0b3O31Np5kCOnR0XdE/gChAnWhzSlEpJ88ivq3AFFee7Vys3XnlKI
	 t/K7QLax1V4LtptTOh+sCuGwJi4csqeE4pxPo7Smog7zTCullCGY2ZePDPN+jpy7ht
	 dXpY04HyS1U7L3VuuPj4KYLT2UqI1mif0IjDwrx1a+Q3T38Lpe9A3Ve8tTFAYNSYx7
	 ZsxJY8uDPtmLhZuWlEnAQBKdR5jk682SrI27HoESavF+STnPRc3LL9ydPXY6CQZSPx
	 +5RTYinLqZOb4O+DN94j5JnhTG0CUErg1bESkLWQm6IoOoPBo7px/sBKZUZxtzCROy
	 b6wJ/QYjN8avA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 24 Apr 2024 10:24:11 -0700
Subject: [PATCH v2 08/10] selftests: timers: ksft_exit functions do not
 return
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-ksft-exit-int-to-void-v2-8-c35f3b8c9ca0@kernel.org>
References: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
In-Reply-To: <20240424-ksft-exit-int-to-void-v2-0-c35f3b8c9ca0@kernel.org>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Nathan Chancellor <nathan@kernel.org>, 
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
 jstultz@google.com, sboyd@kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11801; i=nathan@kernel.org;
 h=from:subject:message-id; bh=xQtYMXWzkLVGZHdWC5Izl0gg9cD9NA5pclKWj3MDh4U=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmaDnGK59ZZczbttlizzLcx9aPCwn7pT+zTIr64Pe5+l
 v5cZeucjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRE1sYfrN+txaojlnwqO3z
 4Wf3ZY6LshVej7O/ciX3iHCrw4XvbTcY/unwCxuL5VplHa/vu8F5+YJ/6M7aeIHc35IifPWqp0L
 1+QA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn"), ksft_exit_...() functions
are marked as __noreturn, which means the return type should not be
'int' but 'void' because they are not returning anything (and never were
since exit() has always been called).

To facilitate updating the return type of these functions, remove
'return' before the calls to ksft_exit_...(), as __noreturn prevents the
compiler from warning that a caller of the ksft_exit functions does not
return a value because the program will terminate upon calling these
functions.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: anna-maria@linutronix.de
Cc: frederic@kernel.org
Cc: tglx@linutronix.de
Cc: jstultz@google.com
Cc: sboyd@kernel.org
---
 tools/testing/selftests/timers/adjtick.c            |  4 ++--
 tools/testing/selftests/timers/alarmtimer-suspend.c |  4 ++--
 tools/testing/selftests/timers/change_skew.c        |  4 ++--
 tools/testing/selftests/timers/freq-step.c          |  4 ++--
 tools/testing/selftests/timers/leap-a-day.c         | 10 +++++-----
 tools/testing/selftests/timers/leapcrash.c          |  4 ++--
 tools/testing/selftests/timers/mqueue-lat.c         |  4 ++--
 tools/testing/selftests/timers/posix_timers.c       | 12 ++++++------
 tools/testing/selftests/timers/raw_skew.c           |  6 +++---
 tools/testing/selftests/timers/set-2038.c           |  4 ++--
 tools/testing/selftests/timers/set-tai.c            |  4 ++--
 tools/testing/selftests/timers/set-timer-lat.c      |  4 ++--
 tools/testing/selftests/timers/set-tz.c             |  4 ++--
 tools/testing/selftests/timers/skew_consistency.c   |  4 ++--
 tools/testing/selftests/timers/threadtest.c         |  2 +-
 tools/testing/selftests/timers/valid-adjtimex.c     |  6 +++---
 16 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 47e05fdc32c5..205b76a4abb4 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	adjtimex(&tx1);
 
 	if (err)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 4332b494103d..ad52e608b88e 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -173,6 +173,6 @@ int main(void)
 		timer_delete(tm1);
 	}
 	if (final_ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index 992a77f2a74c..4421cd562c24 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -89,8 +89,8 @@ int main(int argc, char **argv)
 
 	if (ret) {
 		printf("[FAIL]");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 4b76450d78d1..73b636f89fdc 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -257,7 +257,7 @@ int main(int argc, char **argv)
 	set_frequency(0.0);
 
 	if (fails)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 23eb398c8140..986abbdb1521 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -268,7 +268,7 @@ int main(int argc, char **argv)
 		if (ret < 0) {
 			printf("Error: Problem setting STA_INS/STA_DEL!: %s\n",
 							time_state_str(ret));
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 
 		/* Validate STA_INS was set */
@@ -277,7 +277,7 @@ int main(int argc, char **argv)
 		if (tx.status != STA_INS && tx.status != STA_DEL) {
 			printf("Error: STA_INS/STA_DEL not set!: %s\n",
 							time_state_str(ret));
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 
 		if (tai_time) {
@@ -295,7 +295,7 @@ int main(int argc, char **argv)
 		se.sigev_value.sival_int = 0;
 		if (timer_create(CLOCK_REALTIME, &se, &tm1) == -1) {
 			printf("Error: timer_create failed\n");
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		its1.it_value.tv_sec = next_leap;
 		its1.it_value.tv_nsec = 0;
@@ -366,7 +366,7 @@ int main(int argc, char **argv)
 		if (error_found) {
 			printf("Errors observed\n");
 			clear_time_state();
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		printf("\n");
 		if ((iterations != -1) && !(--iterations))
@@ -374,5 +374,5 @@ int main(int argc, char **argv)
 	}
 
 	clear_time_state();
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index f70802c5dd0d..8fd065eec904 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -87,7 +87,7 @@ int main(void)
 		tv.tv_usec = 0;
 		if (settimeofday(&tv, NULL)) {
 			printf("Error: You're likely not running with proper (ie: root) permissions\n");
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		tx.modes = 0;
 		adjtimex(&tx);
@@ -104,5 +104,5 @@ int main(void)
 		fflush(stdout);
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 7916cf5cc6ff..f3179a605bba 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -107,8 +107,8 @@ int main(int argc, char **argv)
 	ret = mqueue_lat_test();
 	if (ret < 0) {
 		printf("[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index c001dd79179d..07c81c0093c0 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -260,16 +260,16 @@ int main(int argc, char **argv)
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
 	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_itimer(ITIMER_PROF) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_itimer(ITIMER_REAL) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -281,10 +281,10 @@ int main(int argc, char **argv)
 	 * find a better solution.
 	 */
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_timer_distribution() < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	ksft_finished();
 }
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 6eba203f9da7..030143eb09b4 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -137,11 +137,11 @@ int main(int argc, char **argv)
 		if (tx1.offset || tx2.offset ||
 		    tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
 			printf("	[SKIP]\n");
-			return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
+			ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
 		}
 		printf("	[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("	[OK]\n");
-	return  ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
index 688cfd81b531..f7d978721b9e 100644
--- a/tools/testing/selftests/timers/set-2038.c
+++ b/tools/testing/selftests/timers/set-2038.c
@@ -128,6 +128,6 @@ int main(int argc, char *argv[])
 	/* restore clock */
 	settime(start);
 	if (ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index 8c4179ee2ca2..5b67462efcd6 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -61,9 +61,9 @@ int main(int argc, char **argv)
 		ret = get_tai();
 		if (ret != i) {
 			printf("[FAILED] expected: %i got %i\n", i, ret);
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..7ce240c89b21 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -278,6 +278,6 @@ int main(void)
 		ret |= do_timer_oneshot(clock_id, 0);
 	}
 	if (ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index 62bd33eb16f0..20daaf1782b7 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -102,9 +102,9 @@ int main(int argc, char **argv)
 	printf("[OK]\n");
 
 	set_tz(min, dst);
-	return ksft_exit_pass();
+	ksft_exit_pass();
 
 err:
 	set_tz(min, dst);
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 63913f75b384..c8e6bffe4e0a 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -70,8 +70,8 @@ int main(int argc, char **argv)
 
 	if (ret) {
 		printf("[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index 80aed4bf06fb..76b38e41d9c7 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -189,5 +189,5 @@ int main(int argc, char **argv)
 	/* die */
 	if (ret)
 		ksft_exit_fail();
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d13ebde20322..d500884801d8 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -320,10 +320,10 @@ int validate_set_offset(void)
 int main(int argc, char **argv)
 {
 	if (validate_freq())
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (validate_set_offset())
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

-- 
2.44.0


