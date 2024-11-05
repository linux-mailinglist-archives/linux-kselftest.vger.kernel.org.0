Return-Path: <linux-kselftest+bounces-21497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9539BD702
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC561C22855
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E70215F62;
	Tue,  5 Nov 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF/PdT5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DBD215F53;
	Tue,  5 Nov 2024 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838414; cv=none; b=mOXgFC2O7NrblP1jsb+5friOBKbHmXJMhzP0NdzA9sf5rRhHLNULeodS2Rk+vy6pEo7vGnuPA/AlxpBBTaI9TgnFnl2SrxmJkWO5nlWKkQIO1BD0QirDu3A3TGcps9vsroBu7h/GQx+BZOaNVa4c73WutHtIjXsxeqsOBXbjDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838414; c=relaxed/simple;
	bh=ACzj8pdw96HChBwKsNw2pXfqhxjH1tOWpf8yeLsUYTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3xwR9hpQx3G5+91nrXsLcJB9yQ1slU6K02tAxqdods0Brt3mn2b/myKTQB6iiHM8Bc82c2C+Ul3qB/9JbCKVPwxuz2aHtF+rCjSYRcaIAsMFRxfR0gO/0n2wXE57o1WK+FKmbhaVBVVLt3ArfCj+1ooTFEhH1r1EgtWBdxZXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF/PdT5m; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdbe608b3so59148915ad.1;
        Tue, 05 Nov 2024 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730838412; x=1731443212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBHrik1+PfGY8aie53DmTfdP4VfBjoDYBEfpHdyGKow=;
        b=aF/PdT5m22+jnHr/h1cfLqdawxJmQ5zcDJj7EJSCuSWa1PtGgWr1yBkh4jqIoBJ/xc
         pB/4PRXDE6EWmqJeoCn6R/rOsVOvgMMf1fFcOluu14m7odoInRujY1fagcH3V9RjKYy8
         jRV5nbzsJhohbsSaQoc6HHiF6UAQSHCoj9JcU4ZRGJKUUkHJI+P7EheyW+rF23MSrz9q
         zlv3snOuEKYA0ud6hMNOGWH+5ZzD9IIUtZaqlVJZlmwcBL937C5MI7OXQKo5vfWWeNt9
         u8l2awoNfTxeyIO3KkFwwk0N/MxfPrPt1bdmE8XpAfqdWVtPnTVG/oS/WRvGoUH/FQFz
         0z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838412; x=1731443212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBHrik1+PfGY8aie53DmTfdP4VfBjoDYBEfpHdyGKow=;
        b=j+rTAi+m+u4Mgq9CDRkAFBGolQvFmeayAz83V/Z3kvVqco1n27914RnzCWJJ/H2yGL
         qTfS+6aBpQ3FRqK60kditOl3Pg5RSIv4b/FbLChdmbdlqkHI02u8d/GFH+Q5lT6r2mgn
         kI3rF8cp5ONCoW3gLwJEZFGBkUUs1Jv1rvWCfeUVy0Hueo+tRhdDixB/Bk3nSGuuZGsy
         syKDdfMj9tF9L0l8G0oGPDP85+cKpSVpvv8+h1P9fIiSDHScsLtTl1x4pHY2uNdn/MbT
         AU96gSVsbrblEnO6TnT2npeil7uIt/q0Y7/WsqPqlJj9E63wXgJGNDSRyemkgxDD9m0p
         gN1w==
X-Forwarded-Encrypted: i=1; AJvYcCVWUe3W0DJ6PZ00tb/18Smtz55mM+UsCxdWrN138+XIm+34f2C8jDJeAc07PBHtR9jIIMvU9qaLPysMkkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJrYFTALtgJVPyKPGTQ57zN6jBy+O7qdazBW1v077uX7AmrzJI
	9iqe3HJ9BCeSR+jOklp4IWag0szMSE1QSIvnDzti/HEgnpiBn4nl
X-Google-Smtp-Source: AGHT+IGgG50y/0914XGUzjBnyX8itH1E9DWnEvzd+QSjNQAJxFQWvHUuU/80Z/ECufnnjL+pO/kGaQ==
X-Received: by 2002:a17:902:db0f:b0:20b:65d6:d268 with SMTP id d9443c01a7336-210f76f53eemr353224415ad.53.1730838411972;
        Tue, 05 Nov 2024 12:26:51 -0800 (PST)
Received: from localhost.localdomain ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc65sm82640665ad.10.2024.11.05.12.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:26:51 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v4 2/2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Wed,  6 Nov 2024 01:56:39 +0530
Message-ID: <20241105202639.1977356-3-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105202639.1977356-1-cvam0000@gmail.com>
References: <20241105202639.1977356-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct error handling with 'ksft_test_result_*',
'ksft_print_msg' and KSFT_SKIP  macros for better reporting.

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

 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 66 ++++++++++++++-----
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index cdab1e8c0392..f2e6a5b20698 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -42,39 +42,71 @@ int main(void)
 
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_print_msg("unshare() error: unshare, errno %d\n", errno);
+			exit(KSFT_SKIP);
+
+		}
+		else{
+			fprintf(stderr, "unshare() error: unshare, errno %d\n", errno);
+			return 1;
+
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
+	} 
+	
+	else {
+		ksft_print_msg("unshare(): Creat new mount namespace: Success.\n");
+
 	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
+
+
+
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
+		ksft_print_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
+		exit(KSFT_SKIP);
+	} else {
+		ksft_print_msg("mount(): Root filesystem private mount: Success\n");
 	}
 
+
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
-		return 1;
+		ksft_print_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
+		exit(KSFT_SKIP);
+	} else {
+		ksft_print_msg("mount(): Mounting tmpfs on /tmp: Success\n");
 	}
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
-		return 1;
+		ksft_print_msg("openat() error: Open first temporary file: Fail %d\n", errno);
+		exit(KSFT_SKIP);
+	} else {
+		ksft_print_msg("openat(): Open first temporary file: Success\n");
 	}
+
+
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
-		return 1;
+		ksft_print_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
+		/* Ensure fd is closed on failure */
+		close(fd); 
+		exit(KSFT_SKIP);
+	} else {
+		ksft_print_msg("linkat(): Linking the temporary file: Success\n");
 	}
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
-		return 1;
+		ksft_print_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
+		exit(KSFT_SKIP);
+	} else {
+		ksft_print_msg("openat(): Opening the second temporary file: Success\n");
 	}
 
+    ksft_test_result_pass("Test : Success\n");
+	ksft_exit_pass();
 	return 0;
 }
+
-- 
2.45.2


