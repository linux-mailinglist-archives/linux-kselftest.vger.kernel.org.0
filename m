Return-Path: <linux-kselftest+bounces-20831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D69B39CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154C5B21473
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1581DFE10;
	Mon, 28 Oct 2024 18:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk3ZGe8s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0C1E04B3;
	Mon, 28 Oct 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141885; cv=none; b=fFGOo8WAzTQ8FjfofSkxIVUZxbCLL19OSnA2Q1tVB8UVliavW60JxKPry1gx6iCofblCU1h3lcR+Gv9lrIUFcGu5hk/wkrvYJoazUeX059Dlm5cbqK1d46XHvakjf+n4TiT6RaWmJkNJsq5+DcPxgz3obVkhvPP0eMM73+36frU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141885; c=relaxed/simple;
	bh=bEPBfW/l6CjqVixkwzjqBHOV5Mx7ksSTgcc/4rwIYNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JjmRo0vK/9uDkOtIzsP/i/doavtDmg73fWefXCBLEy4goS5wAwJ7GAB+yjIFKSurbT/HCLXAF442X0t5zHbuCEvdW0GABguE4/UMPOouTqngbl3aCuSH2JnAMuCbNHa6RXT+CzvW4uptLJNL5ipwtX2qRXCvvybc9pX6MSl7feQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk3ZGe8s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb89a4e4cso30701255ad.3;
        Mon, 28 Oct 2024 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730141883; x=1730746683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVAsl/Gq/LK933AIOajuswSxYJYiHHzJGzaBk2zCBU=;
        b=Sk3ZGe8sGVEJkA4NV3tNmajKxyjD9TeqNxCEpyMh2IQNTdcDaWg2BGWoYRDq0ou1Y0
         UQRirMQnVQZcS4Ysi19bB2tjMlq4opGq7ekU2JEd0zkyfDntJ6FvtaeVXIHUuiDjn6jX
         mpXMSVWoWWgnXj2XyJ/Z8huTUPdfUDSTOz7ff9X8DciIA1lnQ2zllAdHq813pGJ3ttBb
         hgNyIaINrVuFT8/iYGwdc6+3f9scl2DPY627pddBcGqsVsubZCDCm1kHp/l/Y8f1tiOH
         UcwaijkOvqSZD9KdiXFc+kICjipRJUSqL1TuoDFAp9NIgbZXMUZWfYWRMrqTQcpOmJ77
         6z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141883; x=1730746683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDVAsl/Gq/LK933AIOajuswSxYJYiHHzJGzaBk2zCBU=;
        b=ugRbqqQG1lr/feDNu1fKSpe5iBi8frNQWuAhft00o/BFoVCwqkmoIf8ZJHvZjOeaFG
         ttqtqDQGRfphvhhhSBMO2tgTlKEuD9YUOPsvOh344uf2lR60ydwHmQgePk7EZTNwmppL
         hBfB5qe7Je5yJ5/Afvq+YFRU7i77lU6GzEloq1MZPnL/SVpsKuZhJjSBlOnFL7gpwob8
         uzlPLPik1bD7x30Fjv8OWVKhfifs7Q7znQ2KlEyM46fc6qNWoJai0lT/ZWS+sv27VCZ0
         W2byiqYSjhRRG18801eio7rYuCHVJhj/Nla0pz4aZEUo/w38apo/oIdECjiGUUM2YONN
         bI4g==
X-Forwarded-Encrypted: i=1; AJvYcCXkLYR0YXyM1Ppe1+fjSSFT71qheT5D2+phfzfyEt0YX+ZUsukpCklR45s9fPuhsTGPF3ubJahx9i555BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLUVH9xRQ/KpaYVqrV3bWUtc6W5HJgyDt0xDWCxQc+16T83BL
	uACkysLv6kKXND/OBLAvMXcVWCSzYLmuGvSDVQffdJeehnsrAewJPUyIh12iBTU=
X-Google-Smtp-Source: AGHT+IFXHdEyKBxvZd517Wlu7PUo7CDVO734Pn9ZcXZbhmMP6t+wXWAlsyIQcLQWHykKIuOL87Gb0w==
X-Received: by 2002:a17:903:1108:b0:20c:e262:2580 with SMTP id d9443c01a7336-210c6c3ffb6mr103408205ad.44.1730141882872;
        Mon, 28 Oct 2024 11:58:02 -0700 (PDT)
Received: from localhost.localdomain ([27.7.141.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc082cf2sm53223325ad.294.2024.10.28.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:58:02 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v3] selftests: tmpfs: Add kselftest support to tmpfs
Date: Tue, 29 Oct 2024 00:27:56 +0530
Message-ID: <20241028185756.111832-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kselftest support for openat, linkat, unshare, mount tests

- Replace direct error handling with
 'ksft_test_result_*' , 'ksft_print_msg' macros for better
 reporting.

- Add `ksft_print_header()` and `ksft_set_plan()`
 to structure test outputs more effectively.

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
  unshare(): Creat new mount namespace: Success.
  mount(): Root filesystem private mount: Success
  mount(): Mounting tmpfs on /tmp: Success
  openat(): Open first temporary file: Success
  linkat(): Linking the temporary file: Success
  openat(): Opening the second temporary file: Success
  ok 1 Test : Success
  Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---

Notes:
		Changes in v3:
				- Remove extra ksft_set_plan()
				- Remove function for unshare()
				- Fix the comment style

		link to v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/

		Changes in v2:
				- Make the commit message more clear.

		link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 69 +++++++++++++++----
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..9ca1245784d9 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,45 +23,90 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
+
 int main(void)
 {
 	int fd;
 
+	/* Setting up kselftest framework */
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Check if test is run as root */
+	if (geteuid()) {
+		ksft_test_result_skip("This test needs root to run!\n");
+		return 1;
+	}
+
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_fail("unshare() error: unshare, errno %d\n", errno);
+			return 1;
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
+		else{
+			fprintf(stderr, "unshare() error: unshare, errno %d\n", errno);
+			ksft_test_result_fail("unshare() error: unshare, errno %d\n", errno);
+			return 1;
+
+		}
+	} 
+	
+	else {
+		ksft_print_msg("unshare(): Creat new mount namespace: Success.\n");
+
 	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
+
+
+
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
+		ksft_test_result_fail("mount() error: Root filesystem private mount: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_print_msg("mount(): Root filesystem private mount: Success\n");
 	}
 
+
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
+		ksft_test_result_fail("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_print_msg("mount(): Mounting tmpfs on /tmp: Success\n");
 	}
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
+		ksft_test_result_fail("openat() error: Open first temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_print_msg("openat(): Open first temporary file: Success\n");
 	}
+
+
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
+		ksft_test_result_fail("linkat() error: Linking the temporary file: Fail %d\n", errno);
+		/* Ensure fd is closed on failure */
+		close(fd); 
 		return 1;
+	} else {
+		ksft_print_msg("linkat(): Linking the temporary file: Success\n");
 	}
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
+		ksft_test_result_fail("openat() error: Opening the second temporary file: Fail %d\n", errno);
 		return 1;
+	} else {
+		ksft_print_msg("openat(): Opening the second temporary file: Success\n");
 	}
 
+    ksft_test_result_pass("Test : Success\n");
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.45.2


