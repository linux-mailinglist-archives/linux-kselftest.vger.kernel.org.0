Return-Path: <linux-kselftest+bounces-12983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C491D660
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 05:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A661F213E4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6602F8BFD;
	Mon,  1 Jul 2024 03:00:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FE6FD3;
	Mon,  1 Jul 2024 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802814; cv=none; b=Wr4cgyrFS2Jwq6MNAXbD4P6JSIDhBDJofsm1IoGfefiT/gS6cNfrkGMcQohmqPUm5xiq4ByYHrAIPS5/YanhLkK46dV+g3tj6xsPiPoOSqVktnc9eAzVaoZLYCsKf/YYfPcEObKYBxu/UfeJf70VrA/E6A4wkixl44G+nn1/eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802814; c=relaxed/simple;
	bh=+3FTdy+Kocf/XofJ6dI+397jQDQCgE5szk2OayCUtEQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eUn0ZkN1eMMYdviAt5Dh+5xEYuvB9wUHnaIHwYEdWqCDVPYaj+VnIuKq7/MToICUxI5mY0VDNy5IJKb6orb7EtCnp174bedfrlYEzI4Q0y82hWTCZzWz9dc4sjEk1fg0LRsep1lQTG21G95t5NTE1qAhwor1PjfY07PnUE2wb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366821bb7f31-a873a;
	Mon, 01 Jul 2024 11:00:07 +0800 (CST)
X-RM-TRANSID:2ee366821bb7f31-a873a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966821bb4318-59935;
	Mon, 01 Jul 2024 11:00:07 +0800 (CST)
X-RM-TRANSID:2ee966821bb4318-59935
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: angquan21@gmail.com,
	zhujun2@cmss.chinamobile.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/breakpoints:Remove unused variable
Date: Sun, 30 Jun 2024 20:00:03 -0700
Message-Id: <20240701030003.3852-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

This variable is never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
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




