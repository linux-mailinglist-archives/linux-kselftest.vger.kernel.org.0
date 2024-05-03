Return-Path: <linux-kselftest+bounces-9436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16F8BB665
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10C41C23AD1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F9454BD8;
	Fri,  3 May 2024 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhHxz1k+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846253B784;
	Fri,  3 May 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714772992; cv=none; b=bpqRFNiUsorB6DNALghZxQtFqTm62moaQenG6hfajFUFJsM89wmvuft0mTbYBsZoCX5esGgGWlJm0J/yCwviuHvFBCQg0ssTZEX6Qrc4Pip8/ODjbrwU3We5ja78oiBCxHWC8u/wjWUXOP/MCQqLJ5Pg8iVgj+RNfiKd7JH1k7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714772992; c=relaxed/simple;
	bh=X4kmR0xiIyDeidCxSztdvZIwN0uUuHACUv2KrlHTe+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1cToTAefEqVW/Pvwyxagej6jbtRGbtcX34oUUnkTZssmpZqx9NVr629XnRxtrjr73l7mq3DGCe2pHNzP+B7MpGqV+avJyaLvwFB/cvw4AJvDsbWerJ2BNjkA4InBIqNGDR9g7xKAp/j+UwwHN6J/vqRGWpNpdWBAwvZrhTJtQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhHxz1k+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso153883e87.2;
        Fri, 03 May 2024 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714772988; x=1715377788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlZollT1gOZua+vc5EUjkck1LZKTdgRuDHZhxuS980Q=;
        b=FhHxz1k+N5BI3eZQ6qmxWgT8nL9oherB3vNElBuYtJWSlvBB8h0pqRNO5XHGIR/XH2
         61w9UGAXaPjTKrqmYDV2MrXTWzxRNd31rV8secnMN9004jZPEI6WZXeYNqX46qTvWYvn
         zmmUfKY2CcF9wURtFYRpsHrG7IN5hwzKK1wrvivCpjisR1xS3eXwEGWKH6B8xxVR+BGc
         9sMRcjXTodEJI43xryZn5vY8d8EKdo9GJweiqy0YJc25wgX7EUAY36421JGC/SoVsnkI
         9LKFOSr6QxuD6jfuh+njI4BlX7MoVZk/kmefOGGxYSDWf6coCtjtwh9BwvCWn7JF0WL8
         ODqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714772988; x=1715377788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlZollT1gOZua+vc5EUjkck1LZKTdgRuDHZhxuS980Q=;
        b=jwuC/zrgmUAqtrk6jmUQwxpcE/FxMg2MCAOrG8wNfzI5B3YKmhwO6BitrWq1WkIBIn
         HWpUcpoWp5sSaU12Qz+tpht4cSIQW4SI2SUmEq8dIAUJPUBIXeGN9NQNH58qzdMTv4Ad
         ABf17B+hG3EMuCoYo69f4Ifp5FXfFzkDZvuEk+QIPd6jMyALjmCEatBhi27Oj+ZXdY+2
         RPqBPEuapVGphtNrx99bgmTh8dsB629bvq6B7nmLopbKJzVYHoJeuRRjqfufLdYoayPE
         FBkNBkbql+q3jhqtEZNTjagiweLssHh/tdm0GMgUb47ewIlLPLxTj2gRbh91zfcYu9Ix
         PsPw==
X-Forwarded-Encrypted: i=1; AJvYcCWUR9eoLAdZu0usaWu9f/n8QRAq0HW5dlHu5/fEEb0ptNARDwdjgysVb0Fka0h9R/lFePW1zEDUhj7xkIqnReMz6h4W+h4isD42lJgs8Kwu
X-Gm-Message-State: AOJu0YwBMciT1ueNE6CfkAEdIGHFI+XPX5g4ri606xRMlN4P31tHE1Ic
	35pYQZYuNZ9CgR26N6sOgf4CPPOl3+Wjvo0LjaFyDRGbtif+DU8WWY53tw==
X-Google-Smtp-Source: AGHT+IEsq0U2UcJUm/Rl0/LiI4aTH+eIIakOfDCYcu/FbOV7zN2OxXAExAVxjAm4IhjHpJbbUn4CUA==
X-Received: by 2002:ac2:4844:0:b0:51d:4383:9e59 with SMTP id 4-20020ac24844000000b0051d43839e59mr3070473lfy.0.1714772988237;
        Fri, 03 May 2024 14:49:48 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id j26-20020a19f51a000000b0051928b6916dsm665547lfb.94.2024.05.03.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:49:47 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH v3] selftest/tty: Use harness framework in tty
Date: Sat,  4 May 2024 05:49:20 +0800
Message-Id: <20240503214920.20857-1-shengyu.li.evgeny@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kselftest_harness.h to simplify the code structure by eliminating 
conditional logic. Enhance diagnostics by directly printing relevant info, 
such as access and modification times, upon test failure. Reflecting 
common I/O optimizations, the access time usually remains unchanged, while 
the modify time is expected to update. Accordingly, these elements have 
been logically separated.

Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
---

v3: Explain the need for refactoring
v2: Fixed the last Assert
---
 .../testing/selftests/tty/tty_tstamp_update.c | 49 +++++++++----------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
index 0ee97943dccc..38de211e0715 100644
--- a/tools/testing/selftests/tty/tty_tstamp_update.c
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <linux/limits.h>
 
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 #define MIN_TTY_PATH_LEN 8
 
@@ -42,47 +42,42 @@ static int write_dev_tty(void)
 	return r;
 }
 
-int main(int argc, char **argv)
+TEST(tty_tstamp_update)
 {
 	int r;
 	char tty[PATH_MAX] = {};
 	struct stat st1, st2;
 
-	ksft_print_header();
-	ksft_set_plan(1);
+	ASSERT_GE(readlink("/proc/self/fd/0", tty, PATH_MAX), 0)
+		TH_LOG("readlink on /proc/self/fd/0 failed: %m");
 
-	r = readlink("/proc/self/fd/0", tty, PATH_MAX);
-	if (r < 0)
-		ksft_exit_fail_msg("readlink on /proc/self/fd/0 failed: %m\n");
-
-	if (!tty_valid(tty))
-		ksft_exit_skip("invalid tty path '%s'\n", tty);
+	ASSERT_TRUE(tty_valid(tty)) {
+		TH_LOG("SKIP: invalid tty path '%s'", tty);
+		_exit(KSFT_SKIP);
+	}
 
-	r = stat(tty, &st1);
-	if (r < 0)
-		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+	ASSERT_GE(stat(tty, &st1), 0)
+		TH_LOG("stat failed on tty path '%s': %m", tty);
 
 	/* We need to wait at least 8 seconds in order to observe timestamp change */
 	/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fbf47635315ab308c9b58a1ea0906e711a9228de */
 	sleep(10);
 
 	r = write_dev_tty();
-	if (r < 0)
-		ksft_exit_fail_msg("failed to write to /dev/tty: %s\n",
-				   strerror(-r));
+	ASSERT_GE(r, 0)
+		TH_LOG("failed to write to /dev/tty: %s", strerror(-r));
 
-	r = stat(tty, &st2);
-	if (r < 0)
-		ksft_exit_fail_msg("stat failed on tty path '%s': %m\n", tty);
+	ASSERT_GE(stat(tty, &st2), 0)
+		TH_LOG("stat failed on tty path '%s': %m", tty);
+
+	/* Validate unchanged atime under 'relatime' to ensure minimal disk I/O */
+	EXPECT_EQ(st1.st_atim.tv_sec, st2.st_atim.tv_sec);
 
 	/* We wrote to the terminal so timestamps should have been updated */
-	if (st1.st_atim.tv_sec == st2.st_atim.tv_sec &&
-	    st1.st_mtim.tv_sec == st2.st_mtim.tv_sec) {
-		ksft_test_result_fail("tty timestamps not updated\n");
-		ksft_exit_fail();
-	}
+	ASSERT_NE(st1.st_mtim.tv_sec, st2.st_mtim.tv_sec)
+		TH_LOG("tty timestamps not updated");
 
-	ksft_test_result_pass(
-		"timestamps of terminal '%s' updated after write to /dev/tty\n", tty);
-	return EXIT_SUCCESS;
+	TH_LOG("timestamps of terminal '%s' updated after write to /dev/tty",
+	       tty);
 }
+TEST_HARNESS_MAIN
-- 
2.25.1


