Return-Path: <linux-kselftest+bounces-28182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D44A4D584
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96527A51E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C61F8BB5;
	Tue,  4 Mar 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="YJ64afzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367D1BF37
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075158; cv=none; b=oDClIDYCGNwJBKrVKHwelBFhW/5IsfI/A6/w+Y2hXFyF4qlso345dILpZUpAYtZba4ZboyI3Mr3JSNBHGh5aIq7U9bJC+fIUMk63gytyC7BfSITWpOIBZ6GY8hv08Bnr5c3Cx73VBejMTDIOB/l/xpiLv0AbNBMag37IZcXP2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075158; c=relaxed/simple;
	bh=CTRIoMGUhL6gYhD9n7OZD5t3HqwCo+j4dvhypyF3ink=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gv8kIQTd4PxlMeUBK6S8pk9BnFDlNhtG8cpv6EjpFleDnnQnwXvYu9rUD02+pHyKcLqUwAkZ6e/A4KIViuK5qo4/wJfLuhE3Ay39i/osWUcswYXCUArRUXDo/Q7/Ut3NFLqusRiLIVeHgu09fAm1RGSWciA4KcWUUqvkw761Dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=YJ64afzg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390effd3e85so3953700f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075153; x=1741679953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEKpyMCCo3m2x0BF+c71o+pahMCFOq7W/z6rphmoY+E=;
        b=YJ64afzgObdjLDumJZrVw6SFZGUwluuMeeaAuYyozLU49vB/cfIBGhyY6cyo07ynpN
         k1nwdLjgYuwUCmhAJJ89N8aWQuqB6x49iRk/tohx9TpPwNqrNE1S30GFAAxrcc1XKMZD
         cLhcnQMNnCE3EintLTjwsmqkRxpAvE9VELrDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075153; x=1741679953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEKpyMCCo3m2x0BF+c71o+pahMCFOq7W/z6rphmoY+E=;
        b=kXHSr0VFIe6xDqiLmpT0HGWRwPwUPhxKvFNHqMy6oW19K/59vnTqskKlsDUgRosu5Y
         dZrzfg0mxpMaQVJg0PpYgcwDDY2u0K6sWK4oKqA0+pt6+1u4GqcKgXzcVRjNBuY55pcK
         AG17GWG7ZPXClqZOGZyAVHtq/hrxKUTd84fsCFDZ4K8uUNvYQRXsUltatId+sXt+exBr
         4AurgmndpBRuNVOr4t3ovc3BrFlF4Jq1eubtdKaaMqXcN7QCATFKuGc0xcYGvNDeYMQL
         HvW4y/2Q7UxQe11NzG0M3+gHqGks0pyMQ/AxdtAvb+IbZ7cGkL9KEHlZ8QWymu3Nb+Xy
         AkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjbYWaU+JpY634Uzu5A3wmMc5MVy84Q47++TdqA0w2awhjT6oHL1hjgc0LJcuRJfOxR+Loj4FQLQvFjkOZkFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMUJzSdT5EoiwwGr8mFTaSvTRkyXdPqkV7WR935Ou5mylUGpQ
	fZfRBz4qzY/vT3qAXZpYSRF2tKjUFkTEGCOV+z9wx4IEQ6sseccodV7708rpBUQ=
X-Gm-Gg: ASbGncuHUeVWip/J3pEwqzovbogBB/GeZQ0pmZ1XjTuf0hGvFU4qf+IMghONRGlchjP
	V4oXFXCAm9bGKILD3erZ9mCpU0m+YyjbluL5+IZr8bZVEFb2by33jQ6uU/qsvcYVD0reKKpMED9
	1r81XO4jayhX5H089El+NU0CzFGWz0/XMYfcZf5neEspSZgQ15h1An3viFOEGg7BVFcoCbVUdiP
	zPXfzUabPzD+CFfknUzWmduVU2WGDtaK5jtrjgdrbA4LkmhPG/rBOIpvBVnFVWmoDo9MP3spgrI
	d4g0vJjxVf6dZAttvse0R5OJoij3VIrxWB/XwQehHtIRUfbspxIGvKKciDq4Bk17XbV0GCYidR4
	b2FcoQw==
X-Google-Smtp-Source: AGHT+IFnNvCJilidd2smenyhU8L+bYAQ4nimUKT3meVLiJdDM1dM9JKxUKglyvi4KEyJi72ujcATwA==
X-Received: by 2002:a05:6000:20c4:b0:38d:c627:f634 with SMTP id ffacd0b85a97d-390eca63fbbmr9557704f8f.50.1741075153406;
        Mon, 03 Mar 2025 23:59:13 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:13 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Date: Tue,  4 Mar 2025 07:58:15 +0000
Message-ID: <20250304075846.66563-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openat is useful to avoid needing to construct relative paths, so expose
a wrapper for using it directly.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/sys.h                   | 25 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 21 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8f44c33b1213..3cd938f9abda 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -765,6 +765,31 @@ int mount(const char *src, const char *tgt,
 	return __sysret(sys_mount(src, tgt, fst, flags, data));
 }
 
+/*
+ * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
+ */
+
+static __attribute__((unused))
+int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
+{
+	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
+}
+
+static __attribute__((unused))
+int openat(int dirfd, const char *path, int flags, ...)
+{
+	mode_t mode = 0;
+
+	if (flags & O_CREAT) {
+		va_list args;
+
+		va_start(args, flags);
+		mode = va_arg(args, mode_t);
+		va_end(args);
+	}
+
+	return __sysret(sys_openat(dirfd, path, flags, mode));
+}
 
 /*
  * int open(const char *path, int flags[, mode_t mode]);
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 79c3e6a845f3..2a1629938dd6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1028,6 +1028,26 @@ int test_rlimit(void)
 	return 0;
 }
 
+static int test_openat(void)
+{
+	int dev;
+	int null;
+
+	dev = openat(AT_FDCWD, "/dev", O_DIRECTORY);
+	if (dev < 0)
+		return -1;
+
+	null = openat(dev, "null", 0);
+	if (null < 0) {
+		close(dev);
+		return -1;
+	}
+
+	close(dev);
+	close(null);
+
+	return 0;
+}
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -1116,6 +1136,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-- 
2.45.2


