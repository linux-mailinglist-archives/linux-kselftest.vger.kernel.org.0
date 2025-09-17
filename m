Return-Path: <linux-kselftest+bounces-41780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E751CB81F64
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B238721051
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAE3126AF;
	Wed, 17 Sep 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Up/BQdzi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459831197F;
	Wed, 17 Sep 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144217; cv=none; b=GPmIQ16EMpMXQlBxorADzCT5zMIOCGX8AU1lwWswJdawPyL845ecOSeohtDNhmmwyL6SyzBBwiKjxmFNe/ixMYH6KBcxrH6kW9FruZPC+zt9J+/NmiZM5IiCCCAjqxUO4/4zTTBNkzEAgXPa3PJc6wXjcxno64LEnzjB5gYBcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144217; c=relaxed/simple;
	bh=684wNoj1MWEdeMobB+YxiUgzPPpaWFF1mzncYo2aXPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uU+J62/HkZk+x7U7r0haN/gVK14Xvhfx/4chCc5SEbyX7crf+J6a2Y/1el1dDFqMENluQeQSZUFdq2O+rD1mLf//2oY8DZedNwuiyjZTYZAOycVOq60ulx6OwkUdU5rmDcEZjVZsDmkeF3JU3K6Qyxe2UfIvY4n+GOCTB2T27Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Up/BQdzi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3P5HtVQ2Tt3lBmmjFmS96/9Icqhu8ftHeTOFI/efAlQ=; b=Up/BQdziiUcXVTFXWZ3Ls9je4z
	aTyN45XR+wHSJFAaH3zKSzEbqGLRwrCBRSonafuY5KvL7FyH7k58f9fe5BA1H2BGbZa2+KEKYX0GY
	ukFtqJNOOOpkhF2lEfVFN6UKm/w4JsZedINMbpcCW36rXEVlVhGMObJMX61KCYfa7aN0Sx+uEus3w
	A2CT8+OlWN4LDUFpzkJ9sZt2StYHIgWmFkwEP4ly9lP8gL6VIcPywoLxg3UCChMyWmI1AoJwFBqJJ
	LtdF2XPId3uRgvMRUB3n4x1FekUNo6fAOQsk+wx+1E6nKTZ0YDt5M0TOQOHTUd03xZqdmiXXotUFZ
	tbapch0w==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzck-00CsMq-6Q; Wed, 17 Sep 2025 23:23:34 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:54 -0300
Subject: [PATCH v3 15/15] selftests/futex: Remove logging.h file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-15-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Every futex selftest uses the kselftest_harness.h helper and don't need
the logging.h file. Delete it.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/testing/selftests/futex/functional/Makefile |   3 +-
 tools/testing/selftests/futex/include/logging.h   | 148 ----------------------
 2 files changed, 1 insertion(+), 150 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index bd50aecfca8a31d9545be1e44295594dc9eab6be..490ace1f017e8635a4bc2a414220f7657a9d8f85 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -8,8 +8,7 @@ LDLIBS := -lpthread -lrt -lnuma
 
 LOCAL_HDRS := \
 	../include/futextest.h \
-	../include/atomic.h \
-	../include/logging.h
+	../include/atomic.h
 TEST_GEN_PROGS := \
 	futex_wait_timeout \
 	futex_wait_wouldblock \
diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/selftests/futex/include/logging.h
deleted file mode 100644
index 874c69ce5cce9efa3a9d6de246f5972a75437dbf..0000000000000000000000000000000000000000
--- a/tools/testing/selftests/futex/include/logging.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/******************************************************************************
- *
- *   Copyright © International Business Machines  Corp., 2009
- *
- * DESCRIPTION
- *      Glibc independent futex library for testing kernel functionality.
- *
- * AUTHOR
- *      Darren Hart <dvhart@linux.intel.com>
- *
- * HISTORY
- *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
- *
- *****************************************************************************/
-
-#ifndef _LOGGING_H
-#define _LOGGING_H
-
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <linux/futex.h>
-#include "kselftest.h"
-
-/*
- * Define PASS, ERROR, and FAIL strings with and without color escape
- * sequences, default to no color.
- */
-#define ESC 0x1B, '['
-#define BRIGHT '1'
-#define GREEN '3', '2'
-#define YELLOW '3', '3'
-#define RED '3', '1'
-#define ESCEND 'm'
-#define BRIGHT_GREEN ESC, BRIGHT, ';', GREEN, ESCEND
-#define BRIGHT_YELLOW ESC, BRIGHT, ';', YELLOW, ESCEND
-#define BRIGHT_RED ESC, BRIGHT, ';', RED, ESCEND
-#define RESET_COLOR ESC, '0', 'm'
-static const char PASS_COLOR[] = {BRIGHT_GREEN, ' ', 'P', 'A', 'S', 'S',
-				  RESET_COLOR, 0};
-static const char ERROR_COLOR[] = {BRIGHT_YELLOW, 'E', 'R', 'R', 'O', 'R',
-				   RESET_COLOR, 0};
-static const char FAIL_COLOR[] = {BRIGHT_RED, ' ', 'F', 'A', 'I', 'L',
-				  RESET_COLOR, 0};
-static const char INFO_NORMAL[] = " INFO";
-static const char PASS_NORMAL[] = " PASS";
-static const char ERROR_NORMAL[] = "ERROR";
-static const char FAIL_NORMAL[] = " FAIL";
-const char *INFO = INFO_NORMAL;
-const char *PASS = PASS_NORMAL;
-const char *ERROR = ERROR_NORMAL;
-const char *FAIL = FAIL_NORMAL;
-
-/* Verbosity setting for INFO messages */
-#define VQUIET    0
-#define VCRITICAL 1
-#define VINFO     2
-#define VMAX      VINFO
-int _verbose = VCRITICAL;
-
-/* Functional test return codes */
-#define RET_PASS   0
-#define RET_ERROR -1
-#define RET_FAIL  -2
-
-/**
- * log_color() - Use colored output for PASS, ERROR, and FAIL strings
- * @use_color:	use color (1) or not (0)
- */
-void log_color(int use_color)
-{
-	if (use_color) {
-		PASS = PASS_COLOR;
-		ERROR = ERROR_COLOR;
-		FAIL = FAIL_COLOR;
-	} else {
-		PASS = PASS_NORMAL;
-		ERROR = ERROR_NORMAL;
-		FAIL = FAIL_NORMAL;
-	}
-}
-
-/**
- * log_verbosity() - Set verbosity of test output
- * @verbose:	Enable (1) verbose output or not (0)
- *
- * Currently setting verbose=1 will enable INFO messages and 0 will disable
- * them. FAIL and ERROR messages are always displayed.
- */
-void log_verbosity(int level)
-{
-	if (level > VMAX)
-		level = VMAX;
-	else if (level < 0)
-		level = 0;
-	_verbose = level;
-}
-
-/**
- * print_result() - Print standard PASS | ERROR | FAIL results
- * @ret:	the return value to be considered: 0 | RET_ERROR | RET_FAIL
- *
- * print_result() is primarily intended for functional tests.
- */
-void print_result(const char *test_name, int ret)
-{
-	switch (ret) {
-	case RET_PASS:
-		ksft_test_result_pass("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_ERROR:
-		ksft_test_result_error("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_FAIL:
-		ksft_test_result_fail("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	}
-}
-
-/* log level macros */
-#define info(message, vargs...) \
-do { \
-	if (_verbose >= VINFO) \
-		fprintf(stderr, "\t%s: "message, INFO, ##vargs); \
-} while (0)
-
-#define error(message, err, args...) \
-do { \
-	if (_verbose >= VCRITICAL) {\
-		if (err) \
-			fprintf(stderr, "\t%s: %s: "message, \
-				ERROR, strerror(err), ##args); \
-		else \
-			fprintf(stderr, "\t%s: "message, ERROR, ##args); \
-	} \
-} while (0)
-
-#define fail(message, args...) \
-do { \
-	if (_verbose >= VCRITICAL) \
-		fprintf(stderr, "\t%s: "message, FAIL, ##args); \
-} while (0)
-
-#endif

-- 
2.51.0


