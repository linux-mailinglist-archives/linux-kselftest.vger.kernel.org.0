Return-Path: <linux-kselftest+bounces-9146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015558B7AF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9C1F2316C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963F770F6;
	Tue, 30 Apr 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFEOmLD0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFA1EB46;
	Tue, 30 Apr 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489531; cv=none; b=NqHUFvBD0WmPDnh3PgtjnzW8NXPBJoj1iaMQitN2YS5GcyoSnymLXA6lMwbRSvUl5pDmGVVTQnWhxZbEkh6o6heYhnBgJ3XGj1l/1wqsHWBMyfR6EMwXJwuOLOYH+s1C915lkzIJpvJGQwYM0A0AMMnTjpQ+vfQRlQhLXxab/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489531; c=relaxed/simple;
	bh=sCt+UxI6TBfl++E09vA5VsETPBmweRbT9e1f9cXJ1PY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfc5NtxH8HTvCrgNoWGubBJmk+V9+1OOuhsRvpL7+KIqPLOT3bMNoUC6ywqmyrplGbB8wDRL5W2Xg2Bb4FsE8WNfhJWBJpOvvDwkoZDiMH6KlbE5aK+FmjhbAe03U9K5hzPuNpFD6/DvabsYUxX4lSFqZdT34BypqPRVgOI1lZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFEOmLD0; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so7380468e87.1;
        Tue, 30 Apr 2024 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714489528; x=1715094328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9/NJrpLsDgUKZ/eCQi2fHZjMr6fY5Jto/wmaPqbXGY=;
        b=GFEOmLD0E7Jj8rq/PFaH2hT7WBC1GPGcj/kvIBhxdT/77teSnKettF/IGnSiqRY0mH
         0YAecGyZiwzPJmdbv4wMu296kaDZHz9D8PdU7hDmYnaengjtdbE6LlYnN6ew/A10LHeJ
         kg4NqTyCznzBFtViGEZk8wE5KLpVboZWEBzk++OKIATsRKHgsFXaIdctAtsv0Vwxgx8s
         a06e8I92PLKVAPV3XrO2PJxjkNCg7RmcgWJLAB1Mb8hHip7k/VqqgodlhDRNapSkDA5g
         oMMTgEe5wwhImmmukD1OgGceWDLNqRl2SllrXlaERTgvhygvQ/rBRct5ix51TjtPSOjI
         nQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714489528; x=1715094328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9/NJrpLsDgUKZ/eCQi2fHZjMr6fY5Jto/wmaPqbXGY=;
        b=m7TY3jHehwDCMvWhuu3H3XM7/x3lbfaS5/o02GgPsJkqG5o138IJ+eyI0ySwwdNiH7
         ikd0YhK9+p9CV6F0bICkbcb7c9EWoScai2tzjxfKTsBjqDah9yc6Xx1FUKsxcpaWx84p
         1Cmj5wN1/7qbFiDwwp0u5J2fwYrJdP2mpV2TkQtSlpbOnZHfZgdVYfSXJnsMYu8VsMmk
         fv9OAQmWpdOBBm1re/jZlh7g/Gw1RFr+x3gIMVSEwVGH1QkK3URT3Kd1hINVF+piFzBi
         ccbCSUuqxuHIDoQlr4TtKNCo9RJ+kOjvPjzk632s8lu842mDdwFTVZA9rGaqQ6D8Hxlh
         riLw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/GrzgMzthz/y4pyj7ES9hPY0EXF3TZCPSHysEkDEENWMGXuV2dRByPDX9bFpyNT5Pb/MOSRawhzFXbZgh6wtBQ5kTRrjhBHcSwXYVkml
X-Gm-Message-State: AOJu0YyLLhd/BrB5eMGKlrm/X9or32tVxwmfON5efaSe9De/EY578Hp7
	X3l+SbxYQq1sxbups82f2qaj5VzRw49bKdoV3XWJMdhmuxtksw==
X-Google-Smtp-Source: AGHT+IH/OjrEvEtGCEtdKjMQgds5qVp8wVj3v4WWkPEuMpB+GcbTYq4DDv4WxL9wTC6IqWj27esR4Q==
X-Received: by 2002:a05:6512:b96:b0:51d:497e:83d6 with SMTP id b22-20020a0565120b9600b0051d497e83d6mr7055010lfv.20.1714489527700;
        Tue, 30 Apr 2024 08:05:27 -0700 (PDT)
Received: from localhost.localdomain ([85.89.127.166])
        by smtp.gmail.com with ESMTPSA id q15-20020ac246ef000000b00518ee8c7c1fsm4511533lfo.176.2024.04.30.08.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 08:05:27 -0700 (PDT)
From: Shengyu Li <shengyu.li.evgeny@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shengyu Li <shengyu.li.evgeny@gmail.com>
Subject: [PATCH] selftest/tty: Use harness framework in tty
Date: Tue, 30 Apr 2024 23:05:08 +0800
Message-Id: <20240430150508.82467-1-shengyu.li.evgeny@gmail.com>
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
 .../testing/selftests/tty/tty_tstamp_update.c | 48 ++++++-------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/tty/tty_tstamp_update.c b/tools/testing/selftests/tty/tty_tstamp_update.c
index 9e1a40f5db17..cdaa6a15ee65 100644
--- a/tools/testing/selftests/tty/tty_tstamp_update.c
+++ b/tools/testing/selftests/tty/tty_tstamp_update.c
@@ -9,7 +9,7 @@
 #include <unistd.h>
 #include <linux/limits.h>
 
-#include "../kselftest.h"
+#include "../kselftest_harness.h"
 
 #define MIN_TTY_PATH_LEN 8
 
@@ -42,65 +42,45 @@ static int write_dev_tty(void)
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
-	    st1.st_mtim.tv_sec == st2.st_mtim.tv_sec) {
+	ASSERT_NE(st1.st_atim.tv_sec, st2.st_atim.tv_sec) {
+		ksft_print_msg("tty timestamps not updated\n");
+	}
+	ASSERT_NE(st1.st_mtim.tv_sec, st2.st_mtim.tv_sec) {
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


