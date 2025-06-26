Return-Path: <linux-kselftest+bounces-35886-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B280BAEA63B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9344E017C
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC42E9751;
	Thu, 26 Jun 2025 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbVi+jKC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D222CCA9;
	Thu, 26 Jun 2025 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750965391; cv=none; b=mVc820pMBnQgUlLPBJFiJyXmF5oSIGf19Sv9lkNYeEiP6+POTh89tkMH2C1zmbjFgXEWQhUlNyAn2E/PxyHvjpBL74CZilnAWDl83LraxDpkKFEHG53ewnov6VqLrH/QSDiEDQdUUaZkj8MxnvRWyWz6UcyK6RTIgoFAyqQ66yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750965391; c=relaxed/simple;
	bh=h3+wCYKb+e64nlS7ZiGvNL4qU/lPfezz6///qDSCFIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+tWyZEIybMYtjz+QRaBXI3AeOkhhCpNKYeM9Y//Vhnfbui255jxZcPcWa2w4aISmtKDxfpmIJuCnDparbEcrwcIj8A/JO78t2dbt0pcwgH344YqVZFw/aCFR9ZodsMIoAyfP7e6JO7UG71s6HVFGJMBpCNp7oDmByiCilEwiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbVi+jKC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235a3dd4f0dso10795735ad.0;
        Thu, 26 Jun 2025 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750965389; x=1751570189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kEGLkVDliz6D9cLYESQeH89M3mbRzJDwNUogp0ZBAxw=;
        b=SbVi+jKCW+QnSy2zK/mE1FD7qdiIbvphuJbq2azklufESSW764cyMSb+vj5Wck56ja
         S6oezmhWV5tq/nAytzouaRV49lwsVVT2qtB6qAM/p8vVhfDBSLoRcSXI/HBo5p2cXiUg
         ggG8Fbe5tAMCBZcVLoKTT46NSnqK92VCw9g6aLOIC8DB+G1pYJkSbcwa3QBeOYENPvsl
         AjzHU2v5H5U0WUTzWTUgiKVbsS+PL1T7XlfWjJdyhKEPutGCCQfiiyIBxPJE2NjqmA+P
         pyurnyr3yIj1CE3+O06uZQgbWdRT/Za4TjiH0aH4up4FsS/sKLZZhiE57PzZpFqJM1wi
         ZpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750965389; x=1751570189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEGLkVDliz6D9cLYESQeH89M3mbRzJDwNUogp0ZBAxw=;
        b=FPzdbCiBd+35vRnft8XyovoZv8VsWTxEHUUfRxk7EEQ+WOCVGtNu4Z+BBB3k8WYp5c
         JYk5UZu2sgrcMKhCQ6oqRKgyG13ivDimwYeoHEk2p5zPPEabMSSInhham5p5TlPfZ9N4
         VyFTzn5vEg9TMLbzbvEmw9tiv3iKWasTV6Is4VO+qxtVbeF9MrFIq3QV7AXlin0xlZaM
         V/8+puS7kBLD95LDFLx+wxuMra6AUGZP9aWPTebRLovshj3G+cIUeRy9bDEObjR8kgMQ
         HcDpWa5aujdRFuOnGZwQl8eeST4ydA6U23jKv2Wk+ay5wbWMndQX61gTl4mfRij74+An
         xUAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcEmFZTmH66NodX7yB/gKll8gAw8UnrohE3XaGmalyOapPulOxY2P6ZHLn6eepg9pyIWrxM6GTGQ8364s=@vger.kernel.org, AJvYcCW9u3yrgoJBT20F4MOoicyMxgfMsuyuGbdg5ts7tLww9klclqf1nZSKRYu1oqftDfwK0AVtFXTGOQ9NNcqfPJHw@vger.kernel.org
X-Gm-Message-State: AOJu0YzOq7ZNSmvAVtBM6FucO6R+Si2w7MIp/otUr8rUGLNfOQnnnBwz
	KN/Ac61ovVHPUhoXmNie4m3kqwmGs6wgtsLuudCMl0DQzbhZvhX1sZPz
X-Gm-Gg: ASbGncszNMNBGEaK+G0C34ZHXww1n8nZl13kOl3oHc3kY2nvTW6BDt+B4uROF9tgMeE
	jMAht6sDYnJmH5p5v/LH3qXWiExqC4EMWPSOIYvi23TwRWrw7bU81QU+C4JUPF6NF+5rjbM1Mpq
	aOxKMrZ4fMuENKtKxbx1q1ioQaYnzNjdVl86F+xYeZuC4zs0wcWneAirqoT9eFAnQeTSZxBwSE5
	IwXqbLdHP/2HK1FnpD2vKHdCGTQp6L/mrq9bJXZXvwQasjLCmeX9qrFfgOtBb4rxdcv3rGvVoOR
	XW+qSP11ptsY+ZmKQ318Rl2irmY7xZIYF+SZf+SJxh57WBoN1uz7GlkRP8K0Iio9
X-Google-Smtp-Source: AGHT+IGZJiK7V87UN2yeGD2QBj1W9kV1b1WZgMlsenEy/ueEwohDtG/9+5bGugIvGv5i43iGmzj+jA==
X-Received: by 2002:a17:902:ce8e:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23ac3cf546dmr7602755ad.5.1750965389212;
        Thu, 26 Jun 2025 12:16:29 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:203c:1dca:e60c:1243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe4245d2sm4038765ad.199.2025.06.26.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 12:16:28 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: shuah@kernel.org
Cc: yifei.l.liu@oracle.com,
	zhujun2@cmss.chinamobile.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] selftests: breakpoints: use suspend_stats to reliably check suspend success
Date: Thu, 26 Jun 2025 12:16:26 -0700
Message-ID: <20250626191626.36794-1-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The step_after_suspend_test verifies that the system successfully
suspended and resumed by setting a timerfd and checking whether the
timer fully expired. However, this method is unreliable due to timing
races.

In practice, the system may take time to enter suspend, during which the
timer may expire just before or during the transition. As a result,
the remaining time after resume may show non-zero nanoseconds, even if
suspend/resume completed successfully. This leads to false test failures.

Replace the timer-based check with a read from
/sys/power/suspend_stats/success. This counter is incremented only
after a full suspend/resume cycle, providing a reliable and race-free
indicator.

Also remove the unused file descriptor for /sys/power/state, which
remained after switching to a system() call to trigger suspend [1].

[1] https://lore.kernel.org/all/20240930224025.2858767-1-yifei.l.liu@oracle.com/

Fixes: c66be905cda2 ("selftests: breakpoints: use remaining time to check if suspend succeed")
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 .../breakpoints/step_after_suspend_test.c     | 41 ++++++++++++++-----
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index 8d275f03e977..8d233ac95696 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -127,22 +127,42 @@ int run_test(int cpu)
 	return KSFT_PASS;
 }
 
+/*
+ * Reads the suspend success count from sysfs.
+ * Returns the count on success or exits on failure.
+ */
+static int get_suspend_success_count_or_fail(void)
+{
+	FILE *fp;
+	int val;
+
+	fp = fopen("/sys/power/suspend_stats/success", "r");
+	if (!fp)
+		ksft_exit_fail_msg(
+			"Failed to open suspend_stats/success: %s\n",
+			strerror(errno));
+
+	if (fscanf(fp, "%d", &val) != 1) {
+		fclose(fp);
+		ksft_exit_fail_msg(
+			"Failed to read suspend success count\n");
+	}
+
+	fclose(fp);
+	return val;
+}
+
 void suspend(void)
 {
-	int power_state_fd;
 	int timerfd;
 	int err;
+	int count_before;
+	int count_after;
 	struct itimerspec spec = {};
 
 	if (getuid() != 0)
 		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
-	power_state_fd = open("/sys/power/state", O_RDWR);
-	if (power_state_fd < 0)
-		ksft_exit_fail_msg(
-			"open(\"/sys/power/state\") failed %s)\n",
-			strerror(errno));
-
 	timerfd = timerfd_create(CLOCK_BOOTTIME_ALARM, 0);
 	if (timerfd < 0)
 		ksft_exit_fail_msg("timerfd_create() failed\n");
@@ -152,14 +172,15 @@ void suspend(void)
 	if (err < 0)
 		ksft_exit_fail_msg("timerfd_settime() failed\n");
 
+	count_before = get_suspend_success_count_or_fail();
+
 	system("(echo mem > /sys/power/state) 2> /dev/null");
 
-	timerfd_gettime(timerfd, &spec);
-	if (spec.it_value.tv_sec != 0 || spec.it_value.tv_nsec != 0)
+	count_after = get_suspend_success_count_or_fail();
+	if (count_after <= count_before)
 		ksft_exit_fail_msg("Failed to enter Suspend state\n");
 
 	close(timerfd);
-	close(power_state_fd);
 }
 
 int main(int argc, char **argv)
-- 
2.43.0


