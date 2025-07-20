Return-Path: <linux-kselftest+bounces-37714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E743EB0B8B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28167177EC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C257522B594;
	Sun, 20 Jul 2025 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dTjDz/Sd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA5B229B02;
	Sun, 20 Jul 2025 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050554; cv=none; b=pMIC2XpH6PIXlHO/lb45xa/ifoGv7NTwo94+eEKbAvW4hlP2zl+pSfBdMO4cZ8aiY81mjEZQmSXH8UlKmYT+foqZaTrFkfQEkH5+eeSmyhe7Fhbj0OgS7WQzZiSvZJpWuVpzLVExUHiXbkzQNr9W7LB4Qnk70ONAm/hx+1Dea4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050554; c=relaxed/simple;
	bh=AFmdDtN93AWpeL4SyIL9tqeMBmxaVRSurT8mPUheOrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KLgs/RN9L2PN2rL9GEherdbXzbWHznstOoRQA7L/ufTcjoyyLfBzu9HqCy/nl6OcHDoCa5A/n8vzOkgWCpXryLwLNM/+ZdGbSH5VL8/YbBHwpkRRDulL3Jb1A6HoBtbafdGsCOA8Xhk8CCCFxlrfRyEc2hG6k0pqBcAswZxqFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dTjDz/Sd; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S0QF9mt70w+w7iAGsdoekW2bSLatUNvYvevM7UKuPP0=; b=dTjDz/SdFY+e2ol98cNWCQWBgw
	JihSXBg2ufsL3jNKj+Hlh0GTgVcwgbsvZpRYHY0MIphdlPawusGF9OSdk7q8EirO5Mwup6m9SoP8j
	8eLAeQxRd1IwASSkZg6kXKS4gvEctzcww5cl6VXVP6UQQQS2SP8xaaixoz+sOA3X8IGF4XV38EDYf
	SmYwlBPA9Zjmu7MyG7OR45fvVGtdNxHll/R8dtV82gPJ/FW8SkIHleVT4O9vDNE8PogW0dKY6YKrD
	3GyGjpx6guqd7+/N1mqsq0awD3KF8crmU6S/fuC8fhGZRly/RjdF8NAXgcM56+axahDvXHRTjGtpR
	jalAhpvA==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcWq-001Sqt-VL; Mon, 21 Jul 2025 00:29:09 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:28:59 -0300
Subject: [PATCH v2 01/15] selftests: kselftest: Create ksft_print_dbg_msg()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-1-1f9bcb5b7294@igalia.com>
References: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
In-Reply-To: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
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
2.50.1


