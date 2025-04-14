Return-Path: <linux-kselftest+bounces-30655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B240CA875D4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 04:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A0718909A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC9EDDD2;
	Mon, 14 Apr 2025 02:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cTrErClw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218B539A
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 02:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744597072; cv=none; b=LFzMudV7nl2nBbf9NDugWAaB599gthXaLy1RLY30Re2IAZ1A3erEWErWg+0YgysJmtWIRtWxn8NvNteXccPknN6m8N6DAPlVJLaM0cYY4u8fV0Nms7bzakIa6ZgBxfBkr5xx7fElut0BSyWvZRzIlbTdNgvEJ4UZZzFztQX5DAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744597072; c=relaxed/simple;
	bh=CF5WbureREWikw03wK1uGAdpkg68UQ07TzOYbh5ducA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFbj/cWInu06eBWHsf/4tKMLrgxJ6qe+HGjr1JyFTXZ7l8/qCp8hVjzToHIhEvb4RcwYkHPv5VGhMjgX8lqC+CxFz/jOtOJgYJ6DP1lXqjbssvHG5GT313WDV3ORI9mlOhKKEjAIc+Medz0+GENs9OJylwW3EFON4el7uG5hNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cTrErClw; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744597042;
	bh=e56E8s2dGpUA0zlloJJk57Rk8ujI1zepN2FDDzp8IN8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cTrErClwSbpdm9+C/n9EZPkiFeU6eLkfHES3n7BQXNQS9HwL33wuZ6CEz9RAB/oU0
	 pYBGcW8I1nRozzCj5qWum20KxmM7V9nYhZU3loTp1a07rB9svB6zaWcKmA1i8LArK/
	 gARUGyO5M0lR1GEYyup9aP9f5D+muGScW8Ze47oo=
X-QQ-mid: izesmtpsz16t1744597028t213b9c
X-QQ-Originating-IP: vURyhwMXQSRYkoH8BpvrvBtPqdWDJ5WFco6/loFNH/A=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Apr 2025 10:17:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16241286687761400682
EX-QQ-RecipientCnt: 5
From: lufei <lufei@uniontech.com>
To: linux-kselftest@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	pvorel@suse.cz,
	viro@zeniv.linux.org.uk,
	lufei <lufei@uniontech.com>
Subject: [PATCH v3] selftests:core: unshare_test: using bits_per_long instead of nr_open+64.
Date: Mon, 14 Apr 2025 10:17:01 +0800
Message-Id: <20250414021701.136291-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250401015557.113872-1-lufei@uniontech.com>
References: <20250401015557.113872-1-lufei@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Nr9+mHXfAFYqTlHQPET6hPnDEeh8g8A93qIFARq0ySxSh7HHXyOX54Hl
	C/f9wFPNKdBdUmWs3zcJYSJPtFNB1lwbuw38nESWif1LZHqhBmuvJLhSV/d0EY9lSVSTiFw
	9e8lRJS0GDHYPbwdiAlXiMOCKGRVtFwOOnSjfrHF49aMlQiIFjaGO9Ye13oXyXDzHrBzxCv
	KPtmtVW0KIiMFcjvau30zJeVssC7mSWudP5e6mQ+5Vnh1eaitx25DV3rg5j3CxB4hZCG5ly
	bE3goqmNvBx+jmiQU2SjfORZs9rlwNjcvwPuFnT+fw5xXPRxKlk4txilGUO5Fk2/CUnuO4M
	HxkT4lOCpi89EuQBgbo5qQdoXjm7pKLOfXnAK2H3NY+iULigKZQZjTAfeeS11vSGO9wyUkq
	wM696yJVnnBHcjSOm3ngecZGAAjVku3u1qWHuswESOAcs/28gkWHnls6aRRS4zbTq0gotF/
	QHdMBHhFjk4X8j4f9cmtde2HyuDml73ZhhcRzmX1WVoudf32w8xYtu96KW1DFQOUA3luEfH
	G96CxqkpLieM9Ohmw0Xss5+1isvwfsvdWcdi8YHAiEmH0YoNUQuQPgyv4q66rK9vZFl9npJ
	NsDHFr2zHaa3KdVDPw1Fbww4+Nf7ALwGk201s3hhFLitd7YcBTSW7lwoBwM1hJ1l9EcEZfj
	Ari/YDFUwJQ2TVJq/Y0ZvNwIHAFHrHDR3AJdpsDaSO0g2XzPtic4vbmSYfzO26iUWdwM6/j
	oO5RlPrfLBGBAupS49JrFufei0cKzM7AeZIgJM7fhbjqgRxJkLJEHxfsYYTSSI7nUHC2g8P
	sCMr32LBOHWhOoOs8T+7+1G3sul35LTBCrjmWH3bzqOAFv6nljRvhVd5zX5KE12f48aJenx
	HXUf2qGFwp+U2dYPz5qAvfFsLvzgpeUVJr6TCYRIolSID0CFlW+c8wtU2ZLlG0mmcxEuvwB
	UoVQu0Zqi5qf6q7Rk8bc6E900
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

dup2(2, nr_open+64) may cause ENOMEM error, change to dup2(2,
bits_per_long +1) and set nr_open to bits_per_long to avoid ENOMEM.

Signed-off-by: lufei <lufei@uniontech.com>
---
 tools/testing/selftests/core/unshare_test.c | 32 +++++++--------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/core/unshare_test.c b/tools/testing/selftests/core/unshare_test.c
index 7fec9dfb1b0e..ea4caa7ec28d 100644
--- a/tools/testing/selftests/core/unshare_test.c
+++ b/tools/testing/selftests/core/unshare_test.c
@@ -28,8 +28,8 @@ TEST(unshare_EMFILE)
 	int fd;
 	ssize_t n, n2;
 	static char buf[512], buf2[512];
-	struct rlimit rlimit;
 	int nr_open;
+	int bits_per_long = sizeof(long) * 8;
 
 	fd = open("/proc/sys/fs/nr_open", O_RDWR);
 	ASSERT_GE(fd, 0);
@@ -40,24 +40,8 @@ TEST(unshare_EMFILE)
 
 	ASSERT_EQ(sscanf(buf, "%d", &nr_open), 1);
 
-	ASSERT_EQ(0, getrlimit(RLIMIT_NOFILE, &rlimit));
-
-	/* bump fs.nr_open */
-	n2 = sprintf(buf2, "%d\n", nr_open + 1024);
-	lseek(fd, 0, SEEK_SET);
-	write(fd, buf2, n2);
-
-	/* bump ulimit -n */
-	rlimit.rlim_cur = nr_open + 1024;
-	rlimit.rlim_max = nr_open + 1024;
-	EXPECT_EQ(0, setrlimit(RLIMIT_NOFILE, &rlimit)) {
-		lseek(fd, 0, SEEK_SET);
-		write(fd, buf, n);
-		exit(EXIT_FAILURE);
-	}
-
-	/* get a descriptor past the old fs.nr_open */
-	EXPECT_GE(dup2(2, nr_open + 64), 0) {
+	/* get a descriptor >= bits_per_long */
+	EXPECT_GE(dup2(2, bits_per_long+1), 0) {
 		lseek(fd, 0, SEEK_SET);
 		write(fd, buf, n);
 		exit(EXIT_FAILURE);
@@ -74,15 +58,21 @@ TEST(unshare_EMFILE)
 	if (pid == 0) {
 		int err;
 
-		/* restore fs.nr_open */
+		/* set nr_open == bits_per_long */
+		n2 = sprintf(buf2, "%d\n", bits_per_long);
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


