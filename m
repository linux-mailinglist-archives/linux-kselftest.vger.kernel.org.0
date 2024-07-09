Return-Path: <linux-kselftest+bounces-13361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559F92B463
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C961FB20B4A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83196155382;
	Tue,  9 Jul 2024 09:51:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D56152E03;
	Tue,  9 Jul 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518684; cv=none; b=llco2YAUZMyShIUprJqrVwm+ynbV3hwh4lByKkERwB4bB7WbNIgwjc20dccip68FGf0mphFWnCvoWR8g4kSsEt0ha6xCwJQ5oEibhss0cE8yjzS7ou5Moru9xo4LVYUZz17VmdA6ELXgF7XzDxhymjTr1UufZsDr72xne2rALIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518684; c=relaxed/simple;
	bh=Hye5J18cFPxbULhNfrDen6a3cJSNxq4a7d9K9n+vwVs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k89IN4dXAizQNFt6+EgdUWVZ2nZ2OCqfRLglJDABvo2E7Ke85g4dCqYKVFw15WKBCGC8NbAIvU/+wvrefT3m9wXDNKAti4WvOWC835xz0SA0gy2unONENxi5rgD3wDoMiZwUUm+E5HZrVLKTaajTbmmfJtiz+vfUOYPqxxKo0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4668d080f609-f3ef8;
	Tue, 09 Jul 2024 17:51:11 +0800 (CST)
X-RM-TRANSID:2ee4668d080f609-f3ef8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee3668d080e739-b5009;
	Tue, 09 Jul 2024 17:51:11 +0800 (CST)
X-RM-TRANSID:2ee3668d080e739-b5009
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: angquan21@gmail.com,
	zhujun2@cmss.chinamobile.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND] selftests/breakpoints:Add return value in main function
Date: Tue,  9 Jul 2024 02:51:09 -0700
Message-Id: <20240709095109.3813-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Main function return value is int type, so add return
value in the end

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/breakpoints/step_after_suspend_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index dfec31fb9b30..b473131fce3e 100644
--- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
+++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
@@ -166,7 +166,7 @@ int main(int argc, char **argv)
 	bool succeeded = true;
 	unsigned int tests = 0;
 	cpu_set_t available_cpus;
-	int err;
+	int err = 0;
 	int cpu;
 
 	ksft_print_header();
@@ -222,4 +222,6 @@ int main(int argc, char **argv)
 		ksft_exit_pass();
 	else
 		ksft_exit_fail();
+
+	return err;
 }
-- 
2.17.1




