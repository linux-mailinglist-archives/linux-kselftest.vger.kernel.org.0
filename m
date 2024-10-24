Return-Path: <linux-kselftest+bounces-20555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545349AECBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7DEE1F22A1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C6C1F81AE;
	Thu, 24 Oct 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLWSww/Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF11F80C3
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788934; cv=none; b=V17QkrGGoMa32g9zHOSHky9sNbx0B9kcVVfPDyPHA+xxfyFG9PM2cpPzzNgHiGb+Ok8fTba7/5Y1kV835PW+PD5Vr7iz4cMSBjxgad8HBevs73pdk35B/C0NXJQ5xoQ7JgJHzfeSEZUhUkAC4huQVKfJAMMUu55Gq0YjZhYDBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788934; c=relaxed/simple;
	bh=eLk9DnjwYUighE0iYEt8H3h8YBFG5NSuRgaO8lDKgzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UK45GUDi1VSg11enFHkyqGusIySqyxHhG/+ZXojZXEbzdoE8loTYgIIuTKaL1Gsv+7DANjUFqYbWamr19YlHqFH6ZLNPDvJU2VqOEEk//eYeM6zwo9aRM5c0hXaDyjaOZORzTdzVynd4ZIocOpKnXrx8q2tbpo/01ex7icp8DAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLWSww/Y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so918612a91.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2024 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788931; x=1730393731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eevhDzdCE/ZTj1eNsgYl4TEHf9uXE1aqifwdMlg8WCA=;
        b=dLWSww/YzVoP3R724sD/OPMWitdiDqDWNiWNtftOe7kZpzhqoWACY21fM8jmZrMnJm
         xQgbuhU7H1VhK9sifKpSSsz+edoWCOuVGQ2+ndBGPXKpWXJxceBvKucxIWRVtJZlOeig
         HGYhDhylINEsZ9wk0RWnWX59KVW6m20kA6vJFL8g584UY7a8wjh0FMmOSKcDAqWyUL7Q
         CceXTsUONqYAlw04g3bXrq8ujupbg94YgTTJMaIs0KkKcQiqk9Ar6HmF9JSg8CF92lxo
         OKljCRXGO46dCSwOnck91zw9gHPZOTF7MlxuulsaFALSOQWorHq/5Y1vy+lsk9bRWtvV
         RUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788931; x=1730393731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eevhDzdCE/ZTj1eNsgYl4TEHf9uXE1aqifwdMlg8WCA=;
        b=V8mZfIyrTZtleKLBm8dwk9l9JHQdB/VwKimsg/YDxHDrDHBvBiquEQhW2RIDwDewnO
         h4VfubcsuuqOaOj93IgZ62yhLohbT5kzuydivS30KHdUhS3xKqiduj8QY2HULUkpudoN
         OlOe+dqGXNXsLzMANdE2rkYHvv5AAk376Rn5l+kyn7hbxourweDy+JRd+M+rV5sNo83o
         RjFkUXyJQwc4KsRWVDuMtwBaaf/hVF546Xl0yN6bjZbCZH/T12sytxt/69tunrjiBKVb
         w9N9Vi/ba+VEnB4/kcKAtOtckUKTt3jRQedWXlwkusi3PvJAhxs7GLlchxtO1NQumGQE
         JenQ==
X-Gm-Message-State: AOJu0Yxy/SAsN/NQrkhuaaJ9yjBXegTeWUSFqjgERQbKCbSfqyCZ0hVE
	W9A5TImozFq9JrAMZ17pKJGLRFBs3rMLGTUnIqoYSKI3L74uPVUM
X-Google-Smtp-Source: AGHT+IEjVs0x4twk0WWK/+qEUTcMAPINKqsT0FUadD/Sidd+OOyYSC90sR2Ioeqr/uXnJKmRvqN1yg==
X-Received: by 2002:a17:90b:23d1:b0:2e3:b168:70f5 with SMTP id 98e67ed59e1d1-2e76b60be7emr6697864a91.21.1729788931451;
        Thu, 24 Oct 2024 09:55:31 -0700 (PDT)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e5c894dsm1724266a91.57.2024.10.24.09.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:55:31 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	selftests@ellerman.id.au,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] selftests: Add kselftest framework to the testfile
Date: Thu, 24 Oct 2024 22:25:20 +0530
Message-Id: <20241024165520.948936-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the existing test that checks
for `open(O_TMPFILE)` and `linkat()` behaviors in
mount namespaces to use the kselftest framework.

This includes the following changes:

- Replaced direct error handling with
 `ksft_test_result_*` macros for better reporting
  of test outcomes.

- Added `ksft_print_header()` and `ksft_set_plan()`
 to structure test outputs more effectively.

- Introduced the helper function `is_unshare()` to
  handle unshare-related checks.

- Improved the test flow by adding more detailed pass/fail
  reporting for unshare, mounting, file opening, and linking
  operations.

- Skips the test if it's not run as root, providing an
  appropriate Warning.

Test logs:

Before change:

- Withou root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
 TAP version 13
 1..1
 ok 1 # SKIP This test needs root to ru

- With root
 TAP version 13
 1..1
 ok 1 unshare(): we have a new mount namespace.
 1..2
 ok 2 mount(): Root filesystem private mount: Success
 1..3
 ok 3 mount(): Mounting tmpfs on /tmp: Success
 1..4
 ok 4 openat(): Open first temporary file: Success
 1..5
 ok 5 linkat(): Linking the temporary file: Success
 1..6
 ok 6 openat(): Opening the second temporary file: Success
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 72 +++++++++++++++----
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..26dea19c1614 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,45 +23,89 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
-int main(void)
-{
-	int fd;
+#include "../kselftest.h"
 
-	if (unshare(CLONE_NEWNS) == -1) {
+static int is_unshare(int flag)
+{
+	if (unshare(flag) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_fail("error: unshare, errno %d\n", errno);
+			return -1; // Return -1 for failure
 		}
 		fprintf(stderr, "error: unshare, errno %d\n", errno);
+		return -1;
+	}
+
+	return 0; // Return 0 for success
+}
+
+int main(void)
+{
+	int fd;
+
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Check if test is run as root
+	if (geteuid()) {
+		ksft_test_result_skip("This test needs root to run!\n");
 		return 1;
 	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
+
+	if (is_unshare(CLONE_NEWNS) == 0) {
+		ksft_test_result_pass("unshare(): we have a new mount namespace.\n");
+	} else {
+		ksft_test_result_fail("unshare(): failed\n");
 		return 1;
 	}
 
+	ksft_set_plan(2);
+
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
+		ksft_test_result_fail("mount(): Root filesystem private mount: Fail %d\n", errno);
+		return 1;
+	} else {
+		ksft_test_result_pass("mount(): Root filesystem private mount: Success\n");
+	}
+
+	ksft_set_plan(3);
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
+		ksft_test_result_fail("mount(): Mounting tmpfs on /tmp: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("mount(): Mounting tmpfs on /tmp: Success\n");
 	}
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	ksft_set_plan(4);
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
+		ksft_test_result_fail("openat(): Open first temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("openat(): Open first temporary file: Success\n");
 	}
+
+	ksft_set_plan(5);
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
+		ksft_test_result_fail("linkat(): Linking the temporary file: Fail %d\n", errno);
+		close(fd); // Ensure fd is closed on failure
 		return 1;
+	} else {
+		ksft_test_result_pass("linkat(): Linking the temporary file: Success\n");
 	}
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	ksft_set_plan(6);
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
+		ksft_test_result_fail("openat(): Opening the second temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_test_result_pass("openat(): Opening the second temporary file: Success\n");
 	}
 
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.34.1


