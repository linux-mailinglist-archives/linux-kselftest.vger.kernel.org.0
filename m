Return-Path: <linux-kselftest+bounces-13442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D2A92CBF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 09:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234671C21462
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 07:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9821382D9A;
	Wed, 10 Jul 2024 07:34:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3F482CD;
	Wed, 10 Jul 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720596844; cv=none; b=AT7Voy9BjqrsR8X6Vp6td5/xol/iq8t3Ofec7aspWA1FpQJebFBAMVNlr6v4V3+340fFO5CklM2ABVszUdL1jjRRDV/fLvGfC4CLTfHh7UpyCK4M1FWSbTA9tMYQ6YUNnvSV0YQgyEU5GmzZnYVYrpVcBw3YLG/8ugMV3R144MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720596844; c=relaxed/simple;
	bh=yPnoWvlljWgpuoo96HJlqVf3Nwk71XJ7q2vsS6fs+j8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uM3wn6xw9E8vfvwD+mKzYEEh7rqriIwpzyWOoOQ/fGl8ykzQIiV2sExYRJcn9yFBuDHd3U4h4U/E/PucKFoFF4Yg1SaVVAQpAJWm66QhqUJgNatoSX5d+4mUDQEokSQxM9E85KhJKPHbJNMfaGuR47C0mx6CAdgdH86/3cxvAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5668e3960ff2-2aff3;
	Wed, 10 Jul 2024 15:33:53 +0800 (CST)
X-RM-TRANSID:2ee5668e3960ff2-2aff3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9668e39603a5-dfd4b;
	Wed, 10 Jul 2024 15:33:53 +0800 (CST)
X-RM-TRANSID:2ee9668e39603a5-dfd4b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org,
	akpm@linux-foundation.org
Cc: cyphar@cyphar.com,
	jeffxu@google.com,
	sauravshah.31@gmail.com,
	zhujun2@cmss.chinamobile.com,
	gthelen@google.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/memfd:Fix a resource leak
Date: Wed, 10 Jul 2024 00:33:51 -0700
Message-Id: <20240710073351.6479-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

From a good programming practice perspective, especially in more
complex programs, explicitly freeing allocated memory is a good habit.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..f842a4aeb47d 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -661,9 +661,11 @@ static void mfd_assert_grow_write(int fd)
 	l = pwrite(fd, buf, mfd_def_size * 8, 0);
 	if (l != (mfd_def_size * 8)) {
 		printf("pwrite() failed: %m\n");
+		free(buf);
 		abort();
 	}
 
+	free(buf);
 	mfd_assert_size(fd, mfd_def_size * 8);
 }
 
@@ -685,8 +687,11 @@ static void mfd_fail_grow_write(int fd)
 	l = pwrite(fd, buf, mfd_def_size * 8, 0);
 	if (l == (mfd_def_size * 8)) {
 		printf("pwrite() didn't fail as expected\n");
+		free(buf);
 		abort();
 	}
+
+	free(buf);
 }
 
 static void mfd_assert_mode(int fd, int mode)
@@ -771,9 +776,11 @@ static pid_t spawn_thread(unsigned int flags, int (*fn)(void *), void *arg)
 	pid = clone(fn, stack + STACK_SIZE, SIGCHLD | flags, arg);
 	if (pid < 0) {
 		printf("clone() failed: %m\n");
+		free(stack);
 		abort();
 	}
 
+	free(stack);
 	return pid;
 }
 
-- 
2.17.1




