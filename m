Return-Path: <linux-kselftest+bounces-13432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EE192C850
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 04:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4187282D33
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 02:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2888BEC;
	Wed, 10 Jul 2024 02:11:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5668F62;
	Wed, 10 Jul 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577510; cv=none; b=g8W8Nn67dIWe3DxqWEVl9k2JHh6Sg/lVXfYi5e8UNSfMCRwxRm9SBSHQm6tTbCzgKCwKIzSB+q7FwjjbPP9++MRXW5vbqu1z6JLNN9ba2rXoq3LJuKu8BXHK5y0mugUu5FJk3UfJgwWWr+oBXzetaISpWlgj26b6pa4cmz2aXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577510; c=relaxed/simple;
	bh=2NPELxRNTPYT5BsaSIX4B37kPukRgd5iTRXfASU8+xk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GIWDP0qoPozxViuAY/3COQrfGQ8Lvtzm7rax5Zhf5CQz/AULt4hyzCYexT1/Umm1itufl+gCwNhJ0zUFx04WKutHuyGSHlXCUYVnii6lSqJ6kAlR/b5QSDnMzPn8ilizUSb/MtP6uXJoSwvPMsazn1LSPMY5m0P2CkAs9Vy4YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1668deddbd08-f7602;
	Wed, 10 Jul 2024 10:11:40 +0800 (CST)
X-RM-TRANSID:2ee1668deddbd08-f7602
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7668dedd9c83-d22c6;
	Wed, 10 Jul 2024 10:11:40 +0800 (CST)
X-RM-TRANSID:2ee7668dedd9c83-d22c6
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com,
	angquan21@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/breakpoints:Remove unused variable
Date: Tue,  9 Jul 2024 19:11:36 -0700
Message-Id: <20240710021136.2753-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

This variable is never referenced in the code, just remove them 
that this problem was discovered by reading the code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
 - modify commit info

 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index b8703c499d28..dfec31fb9b30 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -130,7 +130,6 @@ int run_test(int cpu)
 void suspend(void)
 {
 	int power_state_fd;
-	struct sigevent event = {};
 	int timerfd;
 	int err;
 	struct itimerspec spec = {};
-- 
2.17.1




