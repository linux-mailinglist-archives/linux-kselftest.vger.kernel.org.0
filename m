Return-Path: <linux-kselftest+bounces-20573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4FE9AF347
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 22:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9222824EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 20:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C8189F3E;
	Thu, 24 Oct 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtvJlLmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1A22B67E;
	Thu, 24 Oct 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800163; cv=none; b=fqRUoorWwXTLbj28W03QBx60ykHXt4hbpgyFVeiZIqAh+R2CTKrAkplzlr2F/HBPj8a0f1gHInRcpg+b4YSDDGzNpaapiq9CwcSizA21fLGQ0ATunfgB5tfwkpUDryfgiNYqL5MPL7OTzwncD+iG2lmEacMNTOdVooFJ5iUbmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800163; c=relaxed/simple;
	bh=T0zvTMLKc1EKkc6/hTXrYzFtHL3m7tGwMEmDi8YyM8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jquzuqXbJkiNMf9yRpOxU9QDyksSoHySrDWGOZMvuvx5SYuPBwtGQCv1FLBeRpmn9DoEfCf+VW3Z2jKfd0DLTOLyN5Xig1BSJD6rau0SmbonCqKmiIMt1B1qO7vsGeqjdcsj7HKNgJ3cOPpwD9GwFDP6p6IgRzy487f4KvwLols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtvJlLmw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e67d12d04so989826b3a.1;
        Thu, 24 Oct 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729800159; x=1730404959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHwbfY63UDzTO8b8icriFJsFY8pcas/NTsbRH/s+R88=;
        b=YtvJlLmwEU86FB8aYNVJL5umbw8Dwckk1qXuKOV3HgTehI4WnK6NyHRp0Klzo+U6zn
         qKtYyYLPkq5GIn1cOzs5rbHfIVcvXzUT3lOl6jOYTZnInJPI3im+tHfRyPqAwxpcE2La
         kkwFXt1TQfJ3ZN0orarnkjpKzh7nPDXP2tKQARtrKVh8atO7XrYb24PK5zlN4qPvo9fX
         t4KgKpvQpgslctALwabGW+sDPIfx8kPLI2lOtPlz8l/R2aMiXP+/AKZBv+Qosrg3QJWC
         oGPiVdREOST7pkmRrfnc7GCB/FvX93Dcz/Oez9FLtVjTTqf3GLV9dn86CWpnLZQGbXJh
         QG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800159; x=1730404959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHwbfY63UDzTO8b8icriFJsFY8pcas/NTsbRH/s+R88=;
        b=ubdc38CiJgseD0sIccYE1LJXHxPUCNmiot2gKSO6UspE6l2YD0m8g3jNAs0eqpTw+F
         /yRs1MqfJuQ6RAcTuZoKkC4fj92HfuixS6p19WENGvKFuD9hA7bVS9dY435t+F5PdvY6
         DIX1uyEQOHu70BqjrMCezjP7l1cBg9epqvWVYIOcVrIVqlgXzqVv+k12jihOJINAeOZI
         iCzRqtSyrqBPN0SmSPvhPsWiwKmL6MADcgtEk2Y+yFUQHgHCpU8luznSZcg0bYE8Uy5v
         2qCd0a+bNPvXwnjOpjhpwhDwIZVxSV0+iHTIlc26jsdhG5AbYbcCQ7pNPqmqMe/VdOXl
         /ILA==
X-Forwarded-Encrypted: i=1; AJvYcCXhb9hkTzJk9RNkBJ74VMmiJFqDaWAOFd6aMdj38B1fY5Ge3luCsUHQAJXMn5WNI9qznRtVXCWA3gMFQ78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fbloOQyUr6K/pFqzvQ5c+NEYw4wNtMx19Ct16xDca4sSCjsO
	sBErlAuSkNrEXK+aW4regkkeG+pVZI77WU/c1SZJQE3wb+dwJE2+
X-Google-Smtp-Source: AGHT+IFi9mf5mlXQvgESgnEmpyDpyeRtCjGFBbfd2MjU7oyAlOqka7FHVYWSyJ9tTS7rHRYCflstMg==
X-Received: by 2002:a05:6a21:4a4c:b0:1d9:175a:c2ba with SMTP id adf61e73a8af0-1d978b0245fmr9675442637.20.1729800159150;
        Thu, 24 Oct 2024 13:02:39 -0700 (PDT)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13334f7sm8328426b3a.77.2024.10.24.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:02:38 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Fri, 25 Oct 2024 01:32:28 +0530
Message-Id: <20241024200228.1075840-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <15feeb54-5136-41e2-9d8a-10524efc92f2@linuxfoundation.org>
References: <15feeb54-5136-41e2-9d8a-10524efc92f2@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kselftest support for open, linkat, unshare, mount tests

- Replace direct error handling with
 `ksft_test_result_*` macros for better reporting
  of test outcomes.

- Add `ksft_print_header()` and `ksft_set_plan()`
 to structure test outputs more effectively.

- Introduce the helper function `is_unshare()` to
  handle unshare() related checks.

- Improve the test flow by adding more detailed pass/fail
  reporting for unshare, mounting, file opening, and linking
  operations.

- Skip the test if it's not run as root, providing an
  appropriate Warning.

Test logs:

Before change:

- Without root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
 TAP version 13
 1..1
 ok 1 # SKIP This test needs root to run

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
Changes in v2:
  - Make the commit message more clear.

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


