Return-Path: <linux-kselftest+bounces-29970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B346BA77273
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 03:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7593A167E73
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E5113F434;
	Tue,  1 Apr 2025 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="R3TnT+z8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561A14658C
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472602; cv=none; b=SwRaZvDU5HVxzU6nWbi4iwRY0Tk5A5mcHvygOgSzTKkM+eHoVQtGzydGcwPqhIYF6OWsFZQT4oLL269z30ujHQ2B4ljEIqL/UQWEkUG2GHCgET8KFpliCTujfJCAJFjTL7GOttYJ9XiMP40K/JlDhSB0dpbdth3leim6TDOxuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472602; c=relaxed/simple;
	bh=FslQTb4Z9uL0AEIitAxb/euPIg+UXZgeV9beFj+VEcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uIZYGGuucjNN0Cr+NK6B/UHlht+Jmv4+/+p+rzudXbL7qFN885d4Px+Pfxy4fSMSrHphO5yCg99fRlLYfvZU3p+rwa3jDqbVr9D/Mp9y/PJH2PPKwz2UWlhT2gmtajM2fzeYEewEaFuI/foAMj0QbIzQEoT2NMKhqN1P3njl4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=R3TnT+z8; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1743472581;
	bh=4iCHnL15QgM45/51mPgGqISp7MxZZxQv8n/a2/GWuZ8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=R3TnT+z8fHlDO/VjpqH8moLNcza608/1V2W/3FAGodc7ICeuxQUJ0w0bSyfZ7a3C4
	 CjXZPzEnX7vA88MbF65WX/cccZ35SgO9w/sqX9xBAa+xFLEioqBNcMxnWzB/vyEgBI
	 YrgQqLfexYGatqIZsqB97ZTnAbf5huuAXl4qUVJk=
X-QQ-mid: bizesmtpsz8t1743472576tkaibs2
X-QQ-Originating-IP: Pva1DRHNHoz0Xryx2VONayQ5/6fUa04Cnh+3VxCVpCg=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Apr 2025 09:56:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6004092062988001327
EX-QQ-RecipientCnt: 4
From: lufei <lufei@uniontech.com>
To: linux-kselftest@vger.kernel.org
Cc: pvorel@suse.cz,
	viro@zeniv.linux.org.uk,
	lufei <lufei@uniontech.com>
Subject: [PATCH v2] unshare_test: set nr_open using soft limit
Date: Tue,  1 Apr 2025 09:55:57 +0800
Message-Id: <20250401015557.113872-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Mq+dXfLz1bhaojTLSSmzYu3Bg/gYxC7NthJyNHqC+UszWYXbgQAGirKt
	kbCGQYl/Z3v9L0thGsdIcGX2LttHVX5A3JgrO+IaBC1VifIucKxTTTic8OLGGxBl86YTLzg
	54SZea1vy5+I2Y16NQr+bgI1Ep/duw3QvICtdkS6HkRBUcCZK9j1yGAGT6RLXoBDSehZ00u
	zo5QgrOHiO0+/q5XA3JWcJ3E5CjJcdCAk6Huyy9FFOp7ur1QyMGVPyBpbp+keMEggj8IOJD
	ltbGUOu2NI0qQOBokm5rg1ZREd0NsqRazKibkwdv0DMR6TV2CouoIdK/g1wagl+ZGJfiBt4
	HYzKHBaZcA9b3czlxY1fzpXVjATyAm5Khdf8jkdXie/EyQ9/IsJFNZOM5HebF/4HPoph8/Y
	Y20okS4ZlhAUKYs1pjBxmhxPn9GQXeYAZlwhiTW+o8dX3op8nuyobyEhOhjX56m74ajA98h
	LcX7UGZ+jQWDtmSkYiRkNO5v0LbLmgw/1rTB8PyW4a2soOt7DmH2YkBJkrxbIae5Tbcr85H
	TlGYo9fzKW+uQtOOHIlWb/dHzsKWkaVbQwVTuxYoalRXTjQA7DN56vC1VK3B5lKZRQKKtkZ
	evDeQjDapld/4NCgSJRDxt9unswIUdkNfi/03acUYu1h//hsWSBxQh0PbY6fzvVg8iJANhT
	2CNxrEiqtj09giZTk2TICMsB4TAZrVuWQvcRkCTL9jKkOMk/5nVdyCLklle0xF71mbblSch
	1/4odmG8AZNt8269H0QyStQ+fxQ6dTmp0WVbI57FgJKpXP7Usw6rpbCbrY50+kpbXclnnDr
	kkxFWWM3YabDMkX2bfAWckCXfN6hpO4Ga85Ojq7wZCVY0QpIiz3fbTE5JUBa6lno0T/EKuF
	oKGvQNsGW5N3fSYxqisJ0dDWu92PKW2St76qCgOPHAMjnvKOIM09rTBuj8dZTkAZ4KRp5LS
	T80gK/QB00EVrVbK97stjC+Lv5+9BKvDNjetksOhljvkViy7eWVgYsMux
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Set maximum file descriptor number limit by rlimit.rlim_max than
nr_open(hard limit). Hard limit may cause dup2 fail.

Signed-off-by: lufei <lufei@uniontech.com>
---
 tools/testing/selftests/core/unshare_test.c | 24 ++++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index 7fec9dfb1b0e..66b651168887 100644
--- a/tools/testing/selftests/core/unshare_test.c
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -30,6 +30,7 @@ TEST(unshare_EMFILE)
 	static char buf[512], buf2[512];
 	struct rlimit rlimit;
 	int nr_open;
+	int rlimit_max;
 
 	fd = open("/proc/sys/fs/nr_open", O_RDWR);
 	ASSERT_GE(fd, 0);
@@ -42,22 +43,24 @@ TEST(unshare_EMFILE)
 
 	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
 
-	/* bump fs.nr_open */
-	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
+	rlimit_max = rlimit.rlim_max;
+
+	/* bump rlimit.rlim_max */
+	n2 = sprintf(buf2, "%d\n", rlimit_max + 1024);
 	lseek(fd, 0, SEEK_SET);
 	write(fd, buf2, n2);
 
 	/* bump ulimit -n */
-	rlimit.rlim_cur = nr_open + 1024;
-	rlimit.rlim_max = nr_open + 1024;
+	rlimit.rlim_cur = rlimit_max + 1024;
+	rlimit.rlim_max = rlimit_max + 1024;
 	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
 		lseek(fd, 0, SEEK_SET);
 		write(fd, buf, n);
 		exit(EXIT_FAILURE);
 	}
 
-	/* get a descriptor past the old fs.nr_open */
-	EXPECT_GE(dup2(2, nr_open + 64), 0) {
+	/* get a descriptor past the old rlimit.rlim_max */
+	EXPECT_GE(dup2(2, rlimit_max + 64), 0) {
 		lseek(fd, 0, SEEK_SET);
 		write(fd, buf, n);
 		exit(EXIT_FAILURE);
@@ -74,15 +77,20 @@ TEST(unshare_EMFILE)
 	if (pid == 0) {
 		int err;
 
-		/* restore fs.nr_open */
+		n2 = sprintf(buf2, "%d\n", rlimit_max);
 		lseek(fd, 0, SEEK_SET);
-		write(fd, buf, n);
+		write(fd, buf2, n2);
+
 		/* ... and now unshare(CLONE_FILES) must fail with EMFILE */
 		err = unshare(CLONE_FILES);
 		EXPECT_EQ(err, -1)
 			exit(EXIT_FAILURE);
 		EXPECT_EQ(errno, EMFILE)
 			exit(EXIT_FAILURE);
+
+		/* restore fs.nr_open */
+		lseek(fd, 0, SEEK_SET);
+		write(fd, buf, n);
 		exit(EXIT_SUCCESS);
 	}
 
-- 
2.39.3


