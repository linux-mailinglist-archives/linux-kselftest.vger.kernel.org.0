Return-Path: <linux-kselftest+bounces-19420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A34C997CBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 07:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D121F238B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA6C19D072;
	Thu, 10 Oct 2024 05:57:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12B718C03D;
	Thu, 10 Oct 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539868; cv=none; b=jX32PAbGPlca8iXnW97UozG+FGgrFoPDAmhT+V70e4UJewyFRqw9qw7RV9pYGIf7wKxHIBfOCT2h8h3Q9g7kUPC1QUeNAA+nGkeP/RoOGUDVTS7X7HFnWjr7nCmBQUMbVvkqIlqmBNCPBtC/9AhQXO1M7+VlPOMbFTKte/njEeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539868; c=relaxed/simple;
	bh=X9v9yBXSafI2LhG4V2RsAbWdn5xXD+4jgAZ0zNJjFPc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pOZAsyjSsweANj0Vz0kX01xYM1lCTIn1ldjbfOgmgSoDlPGyg6luAl7IdOAxxQBD4b5IHdih+y7IrsJI+ST8iSk5KujWN+qRo7FVpG6yJfSYsU2XlLNB2ZayPvgdrGg9XghQ90sGC4FxdbMDO9K+034OYsVzt0rDl53D1buUZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee467076cccdec-c56ea;
	Thu, 10 Oct 2024 13:57:39 +0800 (CST)
X-RM-TRANSID:2ee467076cccdec-c56ea
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee967076cd247e-380c6;
	Thu, 10 Oct 2024 13:57:39 +0800 (CST)
X-RM-TRANSID:2ee967076cd247e-380c6
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: andrii@kernel.org
Cc: eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH] selftests/bpf: Removed redundant fd after close in bpf_prog_load_log_buf
Date: Wed,  9 Oct 2024 22:57:37 -0700
Message-Id: <20241010055737.4292-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Removed unnecessary `fd = -1` assignments after closing file descriptors.
because it will be assigned by the function bpf_prog_load().This improves
code readability and removes redundant operations.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/prog_tests/log_buf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/testing/selftests/bpf/prog_tests/log_buf.c
index 27676a04d0b6..169ce689b97c 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -169,7 +169,6 @@ static void bpf_prog_load_log_buf(void)
 	ASSERT_GE(fd, 0, "good_fd1");
 	if (fd >= 0)
 		close(fd);
-	fd = -1;
 
 	/* log_level == 2 should always fill log_buf, even for good prog */
 	log_buf[0] = '\0';
@@ -180,7 +179,6 @@ static void bpf_prog_load_log_buf(void)
 	ASSERT_GE(fd, 0, "good_fd2");
 	if (fd >= 0)
 		close(fd);
-	fd = -1;
 
 	/* log_level == 0 should fill log_buf for bad prog */
 	log_buf[0] = '\0';
@@ -191,7 +189,6 @@ static void bpf_prog_load_log_buf(void)
 	ASSERT_LT(fd, 0, "bad_fd");
 	if (fd >= 0)
 		close(fd);
-	fd = -1;
 
 	free(log_buf);
 }
-- 
2.17.1




