Return-Path: <linux-kselftest+bounces-36580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA94AF9633
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424451CA6705
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F342877D5;
	Fri,  4 Jul 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YQsUH1Zm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D119D8AC;
	Fri,  4 Jul 2025 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641533; cv=none; b=O520HZMo+usRkteu9Mu8KDl70HhzFHfA8QbUHXFpNoV+soxSx9vLWyKvzkYsm1DrPALOo+bl9i93JPrEFgezeGFNLbbYi2eym9tzYbh+Cv4GyoUoZhgc/e82VR2ntvDCjl2OFUAYQHGM791ia0xoqN9By4ltoP8LIIIK9+8JP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641533; c=relaxed/simple;
	bh=j+RakyHfBrc5c31QGIaVZaaPgN5WHp7gFZxGVt0DHLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ycio9IsIrqZGBhuz6WRpA+ROye2scqKYDwsk/t0yQqetzGgVPq6llATEMr9K7kbUjdhWmQOLo5BKBw3taRjT8VIyuY6H+bdp6BFwtTiHoWL09YSsQAJSqRld6pJS6MM2rdE1R+Z/ks1u5OzqFH8k4SMCYnqJr3WaCefAOCTeddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YQsUH1Zm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y6+NkMRepGY1gqY9rbInC2ai3AVkY+ZEWltP4xkiMBU=; b=YQsUH1Zmxt1ovqzpCYxCKIAX4L
	VbCpggpnzXSOwmF+tZmOWCLSyi3yt9NVyn2x77+FbaXwJDt9u0EH1n1cYyTTvvoD6iE/09j3nQ7Kf
	zCBFUPxOyeOx8tRm2BtUD8RgKQliL1exB9nvWkgqOdJkmEQjsEixuEvoUEXZdSGFoSdorV7SJkFsO
	Xmnp/8JpJq2QYIYvzR/C22msiu/4Xj5uHxb+/2gbFQlkQoRaSYwSqwdQ9V34c93qXUaMrzH7+IGbo
	jvocn/FB1tSTFh5b/97uKS7oKqzfQ9r2mGeRk8lKOlDP/PcZVUPzABdi74uRYNC4FQteFMxapuCUI
	xIGdpsDw==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyh-00CTWt-T9; Fri, 04 Jul 2025 17:05:28 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:05 -0300
Subject: [PATCH 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-1-c0ff4f24c4e1@igalia.com>
References: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
In-Reply-To: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
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
 tools/testing/selftests/kselftest.h         | 13 +++++++++++++
 tools/testing/selftests/kselftest_harness.h | 13 +++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604b1e486af5a224a11386f75fe0a83495..c1851125de9cfdcdf3b11249572ebfb0751727f6 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -104,6 +104,7 @@ struct ksft_count {
 
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
+static bool ksft_debug_enabled;
 
 static inline unsigned int ksft_test_num(void)
 {
@@ -175,6 +176,18 @@ static inline __printf(1, 2) void ksft_print_msg(const char *msg, ...)
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
2.49.0


