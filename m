Return-Path: <linux-kselftest+bounces-9150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596218B7C9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1411D284021
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ADC17556B;
	Tue, 30 Apr 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk00TC7e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF017554A;
	Tue, 30 Apr 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714493910; cv=none; b=PxdVd5ZTwucxWmb2YLUctchOAd/7wuVSVzloITWJV1NK+psYLNW/3qIsa5jl9S9N0nKOCMgyAXAkclnc1Y8kgx1ZiwLVfHWBlGX2RL6w21uGDNBRUyPp1KQFPyM+gamgKy8rrhFDX7VejKBh/Rtxl6upUPaiMIfdh6yABRRnAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714493910; c=relaxed/simple;
	bh=FgwjJavQPmCr4Uma1Gdk0DdLXVv/m2W6UiOEQyQRyAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GOdMeCq1eBeMfMSbDIyJ4BShUUzSHbYANcNrw+FlqdVay1IC7HtVzfGPN1XKd8sWWdqgSaln52yZMgCAalcAG83uATSUxuUBBTWLW+9tkYCk4Xgteqy1ULw5zGAjPvwPmU8hySQ+KcyNePrvdigAjDYjpGNssgPOScjP8Z9LqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk00TC7e; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51acb95b892so7342081e87.2;
        Tue, 30 Apr 2024 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714493907; x=1715098707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihixI6RMsHOfuF8JLFiOaVxAB8bSPFRLgoOamZYf0og=;
        b=kk00TC7e/vxOHcaioSfKFwLqsGEMU6ouIfth6MGMjaeiLXEtbg6S61Ug0y20kbulPY
         o2Nx1r68ctnA3iBcGlRhO3q7leFhyY1whBa/Dqnaaxt3PzyZ5/gqKdYaoeOTtPHGsUVm
         JvhviCEpLaAiGKtI5WoIEt04NdfrWyxsHLVN/8U4jXk9lHTBQj99rvgWVxE69XJeDwaW
         8FtYNEOwnTbE4WB7tRWinxHSPaO1VGkbhpduGrfEw0CRu64yEmFrZIDxoHrsl+ehdkaK
         TJRdnqGoYec1yDKhAyHStVCx4bXOXEbpsZCKpvgQhglIacYKpwAm/DVLvfEdTNHtEgE0
         XvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714493907; x=1715098707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihixI6RMsHOfuF8JLFiOaVxAB8bSPFRLgoOamZYf0og=;
        b=Vazsgt5Ds/Ixxcw9osek+3J5n6GcawDjDB1JFY+rqp4dgKHlzN6uzu0DPcOxcwoMW3
         K4kTA8mEfxQff4p73R+kKpu4ctDRTQ3G4sS9XzOKE4ly80t/NpS34eu2DCXAVcIMXYHP
         LQ47QUSbkf1cyLJiWyxZzqyQsd0gpo+jI6yUbNJwWLC3i0nv+s43WQYcAaqgakAM33Dr
         C0domdN2ojwGzQ/nCQGZVryRM+aiQkUJ9WytRKOHeIkIsnTItVSccNw5nDTzQDtgYJf2
         8zB63LRjuuNhJuv3Fbwph9sad4vL72QIq2uKZTEKthfaaEYSIrlJDDFlC+BDdFaL7w3q
         nozg==
X-Forwarded-Encrypted: i=1; AJvYcCWfX1lGhkhtPWkouku/E5S/50OsIE4KmftQED0geVtuHvefRQKGEzNyAsI2fiC38P1chqLQ4P/Alwu5SpkQKwW2WMCqrDdi7cgmQNHfqqqd
X-Gm-Message-State: AOJu0YyRaNa7SX2xADuPB5D6xmOqRO6MkUclwnr4hMHwVbg7E1M4XY7n
	er3wFaIfrF/KXVKJLF0lJMhyZFH9AKt4T4tbXoQa5sd9g9iwDQ==
X-Google-Smtp-Source: AGHT+IFhpKpqvEvA9MQYqNn2ZiIYuIom0wYGfYni4FlOWP6207lZzjdcM1KF7KTlHecN+WObVRpq3Q==
X-Received: by 2002:a05:6512:2210:b0:51d:33de:aaec with SMTP id h16-20020a056512221000b0051d33deaaecmr10475456lfu.8.1714493906228;
        Tue, 30 Apr 2024 09:18:26 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id t12-20020a19910c000000b005139b9f1162sm4631757lfd.281.2024.04.30.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:18:25 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org,
	msekleta@redhat.com,
	gregkh@linuxfoundation.org,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH v2] selftest/tty: Use harness framework in tty
Date: Wed,  1 May 2024 00:18:07 +0800
Message-Id: <20240430161807.96050-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly, this one is based on automated tools and a very 
small percentage of manual modifications to automatically refactor 
the version that uses kselftest_harness.h, which is logically clearer.

Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---

v2: Fixed the last Assert
---
 .../testing/selftests/tty/tty_tstamp_update.c | 44 +++++--------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
index 9e1a40f5db17..5894022eb879 100644
--- a/tools/testing/selftests/tty/tty_tstamp_update.c
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <linux/limits.h>
 
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 #define MIN_TTY_PATH_LEN 8
 
@@ -42,65 +42,43 @@ static int write_dev_tty(void)
 	return r;
 }
 
-int main(int argc, char **argv)
+TEST(tty_tstamp_update)
 {
-	int r;
 	char tty[PATH_MAX] = {};
 	struct stat st1, st2;
-	int result = KSFT_FAIL;
 
-	ksft_print_header();
-	ksft_set_plan(1);
-
-	r = readlink("/proc/self/fd/0", tty, PATH_MAX);
-	if (r < 0) {
+	ASSERT_GE(readlink("/proc/self/fd/0", tty, PATH_MAX), 0) {
 		ksft_print_msg("readlink on /proc/self/fd/0 failed: %m\n");
-		goto out;
 	}
 
 	if (!tty_valid(tty)) {
-		ksft_print_msg("invalid tty path '%s'\n", tty);
-		result = KSFT_SKIP;
-		goto out;
-
+		ksft_print_msg("SKIP: invalid tty path '%s'\n", tty);
+		exit(KSFT_SKIP);
 	}
 
-	r = stat(tty, &st1);
-	if (r < 0) {
+	ASSERT_GE(stat(tty, &st1), 0) {
 		ksft_print_msg("stat failed on tty path '%s': %m\n", tty);
-		goto out;
 	}
 
 	/* We need to wait at least 8 seconds in order to observe timestamp change */
 	/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbf47635315ab308c9b58a1ea0906e711a9228de */
 	sleep(10);
 
-	r = write_dev_tty();
-	if (r < 0) {
-		ksft_print_msg("failed to write to /dev/tty: %s\n",
-			       strerror(-r));
-		goto out;
+	ASSERT_GE(write_dev_tty(), 0) {
+		ksft_perror("failed to write to /dev/tty");
 	}
 
-	r = stat(tty, &st2);
-	if (r < 0) {
+	ASSERT_GE(stat(tty, &st2), 0) {
 		ksft_print_msg("stat failed on tty path '%s': %m\n", tty);
-		goto out;
 	}
 
 	/* We wrote to the terminal so timestamps should have been updated */
-	if (st1.st_atim.tv_sec == st2.st_atim.tv_sec &&
+	ASSERT_FALSE(st1.st_atim.tv_sec == st2.st_atim.tv_sec &&
 	    st1.st_mtim.tv_sec == st2.st_mtim.tv_sec) {
 		ksft_print_msg("tty timestamps not updated\n");
-		goto out;
 	}
 
 	ksft_print_msg(
 		"timestamps of terminal '%s' updated after write to /dev/tty\n", tty);
-	result = KSFT_PASS;
-
-out:
-	ksft_test_result_report(result, "tty_tstamp_update\n");
-
-	ksft_finished();
 }
+TEST_HARNESS_MAIN
-- 
2.25.1


