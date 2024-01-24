Return-Path: <linux-kselftest+bounces-3456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4786483AB79
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 15:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5461C253C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 14:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577A7A70F;
	Wed, 24 Jan 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dCtjoMkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244B97C08F
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105728; cv=none; b=TnsYnFG7JQlRIz0Z8MoaRMH+EOQHbQeSgQ1j2lTF46y036CXOkEEsRhPwJG190YRSvxgjs8GTDMkPLe9CLEdbgE0vY/rRvx0JGZrDNtRq0Uk1QhM7qliCEDT/BLkLCB4fl5xsFEX1FhTXI0kiyrSmFbTo3c0z2zvEtwpY7CDPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105728; c=relaxed/simple;
	bh=SXgjaHAj6mc5bUoF/0ublXUVySE2uQcKr8Ju/E+GUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUlnU0Fl+/nXHtlT6xVGCw6KDQGM5Aki0Qw86fwDjkS4T+n7eKfjqdi7KVddEh+nlu5GhJ/exIHKJwXLZQgUS2/SCNX9UJqq4hMDdVopnWmcH1ctEnd1qLYvSXY/aGY/Ms8cX+LdaW5z7n7q6jsegQRJu6Yk6TJ+2c0+R+ONDH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dCtjoMkB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5101055a16fso871443e87.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706105725; x=1706710525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Emu9TGmELjy3ceHR0soeUQYq/a/KfpUveoio5V7U5Xk=;
        b=dCtjoMkBZiBnh1uqZqVSrH5uPUKKQEMZfoCYRJxAVUm9K6DVIuFeFoR/2eyzy6QEpq
         VW40pmawSkIQZbq4pyM20SSLWo2sEYrUrPUcv51OTcZzbGrQ6mixVLZv/wiZlfxs57A5
         7wla1NLiBOoMg8nqJRkhWJ0kdaxzuqmFCUmAdTkJveYj0rFCWyiiRCkXIi7iTelCeWpm
         5XMX2NEBCljrCdN7/uySTJg9dkcvOKiHfvUF8RcIEiyEBW6Q+6VapzYjnsEBcY75Yp9u
         z4jK7dt+st47mf3Zb0nXmifzAuctHiovfXDc+wFn+7Nipi6AcJLdavecTPPkYAvwD9wZ
         Bshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105725; x=1706710525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Emu9TGmELjy3ceHR0soeUQYq/a/KfpUveoio5V7U5Xk=;
        b=Ixd+EW4o6Qg5Z315GRI44bk9UWo7NCtX8dcvZluspsR117Yk+o5BpQsGmBW7ovEBTO
         79y/K6v0InYo7vKU48obBA651rujRketXmxJg/a179WtNoe3agKu7TFbMFc97x9U1/No
         bDKv2X+Npoq/sAq2mWXUYS/9zaAGLhJAHHZx0a0k1aNMa18PbaXgKU2NUdteVaR1F+A2
         fEEmWOw4QZw+cZcOsAj41pkQkXi0Lwzpw7sa7yl/9yZq4Q6IwvS954+5I4MZ75gwLB3E
         o/quSJpCIfA/o3Y+XxkSZh+iNzIs3rY+IKm58s8pKmLa6jJLRQtdkdS9Rg6qYFicW3et
         NZXQ==
X-Gm-Message-State: AOJu0Yx/By7VZ+Au9RxwZ4SWrXaoZo+L0iX5TLsIxmRx80lFk2j3YeWd
	VCQvAEB98eb30XUvcOfGNJga22H4f3L/MnBAsLzY1Vd0Me7bQmK1Eg9/lu1bnD4=
X-Google-Smtp-Source: AGHT+IHc46rAxq1R2suh/qkOcv105YlkAEWHIOmow9ewHTYWO5FRW47hScfpHJ8HFVuGgx0owI33Fw==
X-Received: by 2002:a05:6512:2808:b0:50e:ccfa:56c3 with SMTP id cf8-20020a056512280800b0050eccfa56c3mr4497154lfb.34.1706105725323;
        Wed, 24 Jan 2024 06:15:25 -0800 (PST)
Received: from ttritton.c.googlers.com.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id vu3-20020a170907a64300b00a2d7f63dd71sm12399097ejc.29.2024.01.24.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:15:25 -0800 (PST)
From: Terry Tritton <terry.tritton@linaro.org>
To: keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	bettyzhou@google.com,
	Terry Tritton <terry.tritton@linaro.org>
Subject: [PATCH 3/3] selftests/seccomp: user_notification_addfd check nextfd is available
Date: Wed, 24 Jan 2024 14:13:57 +0000
Message-ID: <20240124141357.1243457-4-terry.tritton@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240124141357.1243457-1-terry.tritton@linaro.org>
References: <20240124141357.1243457-1-terry.tritton@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the user_notification_addfd test checks what the next expected
file descriptor will be by incrementing a variable nextfd. This does not
account for file descriptors that may already be open before the test is
started and will cause the test to fail if any exist.

Replace nextfd++ with a function get_next_fd which will check and return
the next available file descriptor.

Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 24 +++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index da11b95b8872..cacf6507f690 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4044,6 +4044,16 @@ TEST(user_notification_filter_empty_threaded)
 	EXPECT_GT((pollfd.revents & POLLHUP) ?: 0, 0);
 }
 
+
+int get_next_fd(int prev_fd)
+{
+	for (int i = prev_fd + 1; i < FD_SETSIZE; ++i) {
+		if (fcntl(i, F_GETFD) == -1)
+			return i;
+	}
+	_exit(EXIT_FAILURE);
+}
+
 TEST(user_notification_addfd)
 {
 	pid_t pid;
@@ -4060,7 +4070,7 @@ TEST(user_notification_addfd)
 	/* There may be arbitrary already-open fds at test start. */
 	memfd = memfd_create("test", 0);
 	ASSERT_GE(memfd, 0);
-	nextfd = memfd + 1;
+	nextfd = get_next_fd(memfd);
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret) {
@@ -4071,7 +4081,8 @@ TEST(user_notification_addfd)
 	/* Check that the basic notification machinery works */
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	ASSERT_EQ(listener, nextfd++);
+	ASSERT_EQ(listener, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -4126,14 +4137,16 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
@@ -4171,7 +4184,8 @@ TEST(user_notification_addfd)
 	 * Child has earlier "low" fds and now 42, so we expect the next
 	 * lowest available fd to be assigned here.
 	 */
-	EXPECT_EQ(fd, nextfd++);
+	EXPECT_EQ(fd, nextfd);
+	nextfd = get_next_fd(nextfd);
 	ASSERT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/*
-- 
2.43.0.429.g432eaa2c6b-goog


