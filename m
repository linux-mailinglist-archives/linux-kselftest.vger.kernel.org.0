Return-Path: <linux-kselftest+bounces-41765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03EB81F07
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FB7522723
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26666302159;
	Wed, 17 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n+bjVVqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F132749CE;
	Wed, 17 Sep 2025 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144189; cv=none; b=p7fXn0m9n4yHK0s2Bq7Y1sV2g7MUJInibqspYEoronjsnKFwLYy4zB3rgkZRwVF8Nsr1++wRYjScCXPp+bkBfLYbRu9rRyDoGGnyqzmc/pWTC6NmqW5pFTluqVcTT9w1Fu5wpKkKdmJBKhyERpqBtcwK2dIiG337f9zsNo173sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144189; c=relaxed/simple;
	bh=otSik+JnSkPnr4TEEejhUGJeE4ZX3swssBkOB7WXF9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caQ0Zfp6XoB3Rr5rwXr31w6V2cxTVj6+hyldVtbCu9OSxZ+XGCWyCzcInN2bPzigZuH+wJFIq1koCbqtQnM1DFnFZLU7FbbJJ74voKPsDC2OJmmGfdFYuQs6FdhRMsYOoe3WCXctYE1Xh6ZsN43cNtTQM0aDGLekF2aFHgU3Qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n+bjVVqf; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7MnV56UP6V8cQnSkVSRXAg5Em6U9ykJi8OOAtSFWsgY=; b=n+bjVVqf5+ik6ac7aS43YfvCAh
	yTZoNNpJY9B8eaFW6Sz9O/2NgEXwgN0Zu4oJo1IArzzHn9ZeVLv3LQQ3nhZIWD3z45xmAGeYVNMYI
	ITEyylYYWwaOKWLIvoeR2mjOQH869kIYR60TN9Kiw4yFmzwkO3JV2DmJ/ZvVkjXtmcSJQtTDrADDR
	pFqAIt1MJqZMNY3c79sCarMf0ZYM1Mc3WJsmZHpnVfxHJ1Q3F2c84ZfCIfIta26O2MvUZDSKZCtYU
	LpeHHYHxzmGw7QyplVBGLTzOeANfxqYTa+k+Bgeawg65AL2ByztGBEV5VSsgAvfJ+jI1E/PTmGvQd
	yjs4Zupw==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzc8-00CsMq-Lz; Wed, 17 Sep 2025 23:22:56 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:40 -0300
Subject: [PATCH v3 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-1-306b373c244d@igalia.com>
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

Create ksft_print_dbg_msg() so testers can enable extra debug messages
when running a test with the flag -d.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/testing/selftests/kselftest.h         | 14 ++++++++++++++
 tools/testing/selftests/kselftest_harness.h | 13 +++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e486af5a224a11386f75fe0a83495..8deeb4b72e7338abde47e2369a9728c3eb29907b 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -54,6 +54,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
@@ -104,6 +105,7 @@ struct ksft_count {
 
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
+static bool ksft_debug_enabled;
 
 static inline unsigned int ksft_test_num(void)
 {
@@ -175,6 +177,18 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
 	va_end(args);
 }
 
+static inline void ksft_print_dbg_msg(const char *msg, ...)
+{
+	va_list args;
+
+	if (!ksft_debug_enabled)
+		return;
+
+	va_start(args, msg);
+	ksft_print_msg(msg, args);
+	va_end(args);
+}
+
 static inline void ksft_perror(const char *msg)
 {
 	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db995d7197ed1f55bd9cc657669df9bd3..ffefd2704ca8f60f329b5d85870253fe26c61b52 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1091,7 +1091,7 @@ static int test_harness_argv_check(int argc, char **argv)
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hlF:f:V:v:t:T:r:")) != -1) {
+	while ((opt = getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) != -1) {
 		switch (opt) {
 		case 'f':
 		case 'F':
@@ -1104,12 +1104,16 @@ static int test_harness_argv_check(int argc, char **argv)
 		case 'l':
 			test_harness_list_tests();
 			return KSFT_SKIP;
+		case 'd':
+			ksft_debug_enabled = true;
+			break;
 		case 'h':
 		default:
 			fprintf(stderr,
-				"Usage: %s [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]\n"
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
 				"\t-h       print help\n"
 				"\t-l       list all tests\n"
+				"\t-d       enable debug prints\n"
 				"\n"
 				"\t-t name  include test\n"
 				"\t-T name  exclude test\n"
@@ -1142,8 +1146,9 @@ static bool test_enabled(int argc, char **argv,
 	int opt;
 
 	optind = 1;
-	while ((opt = getopt(argc, argv, "F:f:V:v:t:T:r:")) != -1) {
-		has_positive |= islower(opt);
+	while ((opt = getopt(argc, argv, "dF:f:V:v:t:T:r:")) != -1) {
+		if (opt != 'd')
+			has_positive |= islower(opt);
 
 		switch (tolower(opt)) {
 		case 't':

-- 
2.51.0


