Return-Path: <linux-kselftest+bounces-13360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEEF92B447
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B481F246BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3415534D;
	Tue,  9 Jul 2024 09:44:59 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B4155A21;
	Tue,  9 Jul 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518299; cv=none; b=TiFed0OgLUyBp5igMUOZt21GPR9/95PtolkOMDr66uNC1QsXQg/rLCEIjdH10k7gpnhXwrMzwoiLETVzhIKkMKV86i1F9R+5gsBxVtRqAYKhHRsRgUcn3cdaMUcxUxHWM1D9RyT0nBQJY+UXuhqQKDw3Yx6sLXr/h5DYXEl/4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518299; c=relaxed/simple;
	bh=+3FTdy+Kocf/XofJ6dI+397jQDQCgE5szk2OayCUtEQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=szFDAkhG2MFhS9xih9XIYdDciaTB5Rp+i/Euk4UcImTMITxp9zWaE6OnuF1D3g14R59vkq+JGl+NOyi9U1U5VKfZhW8lwkXFYC1Qm6riQzUUSB/NCix3L8Ckv5PzhVGcCmOka4A8my5sDNpYDOGiqiiEKP9/8tOL7anTWY5Z2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7668d068a6d6-236d7;
	Tue, 09 Jul 2024 17:44:45 +0800 (CST)
X-RM-TRANSID:2ee7668d068a6d6-236d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9668d068d95d-b507e;
	Tue, 09 Jul 2024 17:44:45 +0800 (CST)
X-RM-TRANSID:2ee9668d068d95d-b507e
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: angquan21@gmail.com,
	zhujun2@cmss.chinamobile.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND] selftests/breakpoints:Remove unused variable
Date: Tue,  9 Jul 2024 02:44:43 -0700
Message-Id: <20240709094443.3648-1-zhujun2@cmss.chinamobile.com>
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




