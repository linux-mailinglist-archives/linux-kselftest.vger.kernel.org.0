Return-Path: <linux-kselftest+bounces-29888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A663A74D20
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CBC1895529
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723181BFE00;
	Fri, 28 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Gp/WXm2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E721364
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173391; cv=none; b=IaVcoWgLdRDjeMxfQU5R/uOPKYIKsw8ThsJnoKjrHxJVmgi8YJK5broJhMMUFCAzRWk2iVWYPEjmX/y/ZjtR3PlvsK3HcQS8wa9lu2KACKdcfwWAz3jlB4mMXxrekkc398qHcMX8TIMm4a+cERcTSZ+bLxyVKTewkxchptZx1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173391; c=relaxed/simple;
	bh=5QoDJasVJCSRob26SaqP8v6LyoeauikyBKKMM6QxvVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uv2sx4dJ8wfo3y5i+oUEc7qXdNULvhzHY5/2f2qm0SEGYOS2sl17tr5qcPFJ2J46xKwF1znst2dgpACA4DAm1sxbSnJt29ykq01VmAFPami3B2Xxfsz1EcCk0E3BTUNX2t6MEV0+sn5ZTS6oIdEYCG+d4GclxOZDxvso5k8P1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Gp/WXm2l; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1743173365;
	bh=gOCE2XZ+oFG0N0yRj2KFQwBgb8J3uvFu5G0ccEsgt0Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Gp/WXm2lK9/+t++oGJqMWVWME8h1lUm3YCJuXpBk08xOnRl1JhpHBe9iTplktvSsh
	 C2/ZRgk6aLWgdNzyulmy6XstLHrtrsLLbq8lk/bVxiqeIAnap9p4if6oAkb7AJqL87
	 rl89RFDeUJ4D/5eNWavQOqbYfjECJBZyJBhg7TBU=
X-QQ-mid: bizesmtp89t1743173360tv6s5qhj
X-QQ-Originating-IP: +d/7e2IZBZVA2u2pECQrPdy+/XcBsSCZd+REvJgAxkE=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Mar 2025 22:49:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9131221561744330332
EX-QQ-RecipientCnt: 4
From: lufei <lufei@uniontech.com>
To: linux-kselftest@vger.kernel.org
Cc: pvorel@suse.cz,
	viro@zeniv.linux.org.uk,
	lufei <lufei@uniontech.com>
Subject: [PATCH] unshare_test: set nr_open using soft limit
Date: Fri, 28 Mar 2025 22:47:17 +0800
Message-Id: <20250328144717.108054-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: M5znx2hx04lb0PJYa2igNXGkQQM1rSIG2HOR6s+71xnj6EP/m08T4iaq
	VOPSlqm16Xc3JQkszGr59ZWVnm2U2WubwRR9zkBTZHi5rn7IUjEIj8zzHN0qnL5fhv9XiYa
	t8UwlSaKXkB1a1T6LHxUyF42hW0QxrDC9IEJ6TBbhtYNHrlwtyuR3gevbhSfSCOUmREgZu3
	LFvch37Z7YkVeFoUn3S9j/3uWmvoOPlfxrD8PW5BFJHY12ler9eI5N7Z53NlJtpKy843rNa
	96YI7WqkUNMOqucOcyZnB1hfondp4aZkFiHyuDIQZZykgnizLWOl0SHqaqcba16nlfpE3yU
	09nSqdGqdyG7ab1uKCN2c6uqGphv5ywr8biodOzHTBHyy9cnt1Mk+jFuQrzuAi5BSMYxiBD
	RGsSxnL7m7ikIX7O6BtcBh1zu+R5zmvAjsJ/Cba9B60j6o5bP3HKn1CMj/UjQsC91XsLklp
	U9+Lg/zMs7JMr9VA/hKoQu9XTrZGOFHYkmy/ueivVvKJt2kcFEqQAutl51Mv/Y1TbaBPsng
	/tY3BtMwEm+BMtJogqgmHMyTd/fYzOJtECvKIuy1sIgaO83ZHZMFNWs7OQ6tHs+kfp7KiN9
	VSnLzDRTOk3PSZrgN22++ktsvFVrAHcYI203xfBRxC57MCtzEFuv1bCZU9nNW2bgZshqg0k
	dQo+YVKI1QoOT9eJl3WBKZbaC/qR8aRCShLLVlZyII9Xzyfw6EF+rxtk0vZCjwEojZOZimp
	XNwlJQ8uB7KUqpVfqqL7HptBEg7LOce0g8ZQ9eHvE64AaPygxtBQ4inFKJd/e7t2nVry6tj
	XT9E0KjEdG42I2+HMyhWGpDdYLmM2J44l4nrVRV/Dk6I1Om/Ld01ySDG6qFL/PXNcXYuRzr
	IzcKiOAoy3PJSFLzWA6amxCUlqD83fb5/yM11lRDrr2hCiE/WyvG0iVTdmfW8Vuy0mP1LvA
	C3CugmLIpeSgkmvcR68lFVCrrt/XQ5GMbM6ZUYO7XyJ/1gA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Set maximum file descriptor number limit by rlimit.rlim_max than
nr_open(hard limit). Hard limit may cause dup2 fail.

Signed-off-by: lufei <lufei@uniontech.com>
---
 tools/testing/selftests/core/unshare_test.c | 28 +++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index 7fec9dfb1b0e..2c4e7104b0d9 100644
--- a/tools/testing/selftests/core/unshare_test.c
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -26,10 +26,11 @@ TEST(unshare_EMFILE)
 		.exit_signal = SIGCHLD,
 	};
 	int fd;
-	ssize_t n, n2;
-	static char buf[512], buf2[512];
+	ssize_t n, n2, n3;
+	static char buf[512], buf2[512], buf3[512];
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
+		n3 = sprintf(buf3, "%d\n", rlimit_max);
 		lseek(fd, 0, SEEK_SET);
-		write(fd, buf, n);
+		write(fd, buf3, n3);
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


