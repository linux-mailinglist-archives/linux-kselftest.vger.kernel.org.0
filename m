Return-Path: <linux-kselftest+bounces-28425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A252A5553A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 19:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8F43A0FA8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453D26BD98;
	Thu,  6 Mar 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="mg3Akb/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C534C1DE4EC
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286530; cv=none; b=k8OS2b7eJ7Yt6PUhesMXDCpG5reEXtshQ7and158RpawtCiSOfwmsdvn6If5azO5fsHg7nK3cFqZQS92VW94qIR524dxv4pULwmvql5YAUlD6M9RaAH0vqhM4bE9eRhXmv5AlGLZA2Y3X9OjBOY2UBPs/0SWHoEKrfNd0ApS1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286530; c=relaxed/simple;
	bh=76aTe/CtLg3kccV14mTmV+UumHp63EWQM6Kim/FC9s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWwuhDtXXkcasr0yoDBQDxhPh39S74eSuVecF8qa8p6qbNyksZ3raO3Jmc1WBSxKk/0HQY1mowUtT83aTfA9Va8vxji9E01chIbFIkqDjnjSLB3iruV8IF29KcYKv+/lsh7QdtPwl0f1iQYQoPhcWPuIXV2kQ8DiV9MB5qpoZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=mg3Akb/H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bbb440520so12274505e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286526; x=1741891326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vkok6y8nwZ8O9EzKx/H2lutbJF5VipBGWeb3xj61TA=;
        b=mg3Akb/HH+rCsKnWKmnhoj/+e/+1lSNCTuxfV8MOGh6Ux2V8qRs67K7paMIWp2yZpv
         wuZ7F2RtNEkmHUBgs2+Mvg0c7JLEEp5MZ6lvODkdNGLRGz/sXsfMhJA703p4ARgyTpm4
         5q6Z+pBpXsj7AXhXROGyiKxttxlBK3FMIctP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286526; x=1741891326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vkok6y8nwZ8O9EzKx/H2lutbJF5VipBGWeb3xj61TA=;
        b=dOFXPJYxO0JB4Ea+OOpdbIENyPl69k/YkbaNWKG+MZSGsvyTjFzcxf1rj2HK0BbLsM
         QamnhWNQzRkA5ZRM4DeE0vKGdx5FyFcRBh+g1aoMlJ91VDM+d3h3IEbgJhHRVPBElVJP
         2ZdL1sdd0Fkf+CqFMqGqSsLibKwW5NO7P1ELgKFjqXWcHn/yfnTeF2fq8qrK7taOlTmg
         ur9argT0jfVJSAcM9kGs77rsefu82OCn2uFbVIz+7IVMiHhM3g1hCHZ2KyiJ/lcn0dRD
         eADR4IDevY6Pj6TX0nXs0UbXbQslQReZ1a018cN57wA/Xi/ZQm4wQT7p5dZKLWYOpIeB
         KySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMVMLmgn6YWjuiz0yKYbzHWmDCZd6g0t9DSvyZ35a0AMsIfICCGRjgCMunl6BiSW9DHmcLc0blvtEazQ2hyEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpp0tveL5Qn+0lsAy/v1770dnUDw9GFQskIsLF47IukERSZfik
	c+MFh7qUb0bk4tX30URr+GKLTkl8BvyPtpe/xVsghWX/6mkCP9xQ4Vlugfrg944=
X-Gm-Gg: ASbGncu6sRymydRmEsn7DRRWcuPD3mfO476RvQLW2Uu2GxG0QLXvyyHuZspzGlykizt
	5R85fXFBaTEhWGFpN+DawHfyaLDla9JDw+kU4X5jiUDtKsO8uBFK1QlG9esO1zpKjt5VZlXpzEJ
	2rFyKGHtyjPsqxsShNTtZemdJYDeA22hGyFrD5J4fxE+fKMXVk0mB1NpZJLlLLlaK1S5hNmoWXZ
	HZvjMy9cbTRulnESYt/bPhO5qiMYo+fodqiptA+oWvXBlNapj4JmK+pSTWQZ6kbrfHbp5BYMv/X
	GjMf5rMEZs9fkmVNrICEVMVolRxhtMdDf1JIgSRXE9Yqpv23ZYqhY6VXCtIYMNPuegbFzRGi7LF
	XvkewQQ==
X-Google-Smtp-Source: AGHT+IGCiLjhro8jMad47kv7jUJhyb6BzldwixdARUwgd08H5VrTUPi46xg8eljOiltQ6S3G4C4vtQ==
X-Received: by 2002:a05:600c:1c10:b0:43b:cf9c:700c with SMTP id 5b1f17b1804b1-43c601d06a7mr7775025e9.16.1741286526041;
        Thu, 06 Mar 2025 10:42:06 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:05 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/5] tools/nolibc: add support for openat(2)
Date: Thu,  6 Mar 2025 18:41:18 +0000
Message-ID: <20250306184147.208723-1-louis@kragniz.eu>
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
 tools/testing/selftests/nolibc/nolibc-test.c | 17 +++++++++++++
 2 files changed, 42 insertions(+)

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
index 79c3e6a845f3..e8faddcecf9d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1028,6 +1028,22 @@ int test_rlimit(void)
 	return 0;
 }
 
+int test_openat(void)
+{
+	int dev, null;
+
+	dev = openat(AT_FDCWD, "/dev", O_DIRECTORY);
+	if (dev < 0)
+		return -1;
+
+	null = openat(dev, "null", O_RDONLY);
+	close(dev);
+	if (null < 0)
+		return -1;
+
+	close(null);
+	return 0;
+}
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -1116,6 +1132,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(openat_dir);        EXPECT_SYSZR(1, test_openat()); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-- 
2.45.2


