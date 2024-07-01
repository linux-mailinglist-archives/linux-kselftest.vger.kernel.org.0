Return-Path: <linux-kselftest+bounces-12984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EB91D7E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB040B23B80
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 06:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6464AEE5;
	Mon,  1 Jul 2024 06:06:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969AD824BD;
	Mon,  1 Jul 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814008; cv=none; b=BWRwVKVzLMu9/IBXYV+8giO5U4nnw4CBsDfshpqf0HcS9KFjGems5UP8T4o5/v+3y7MOVlzKBmagXlgfNierfHn63HIFtsEX2iw/Wh6xgTtnDl8gnJ/Vi1R9Ma1vhI7WpnQBoK+l57TIGSnIGTQvZZKJNbrvTrUnp5t4mRAi+fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814008; c=relaxed/simple;
	bh=jEKPVaracr2k2kKC0SBGMNuQjU00d9h7Qv5rtUpckVU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Gn2SjQczSivELc4JskyV+Y9o4ys9nRCoINLTZLVbD5uecLpjxrO4fvXqIJKt5Mq5YQA+I5xs6Ypo6Wj/yNHnshBTuluF7XIqiUKTqikGBB7jxF2pwBdmC10nojMruzxrbJEgLy+kTEYb0GPfnNTVuH4k0O4+/MjrrSSgthqMMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466824768bbc-ab4aa;
	Mon, 01 Jul 2024 14:06:36 +0800 (CST)
X-RM-TRANSID:2ee466824768bbc-ab4aa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56682476bbfb-5f098;
	Mon, 01 Jul 2024 14:06:36 +0800 (CST)
X-RM-TRANSID:2ee56682476bbfb-5f098
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com,
	angquan21@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/breakpoints:Add return value in main function
Date: Sun, 30 Jun 2024 23:06:34 -0700
Message-Id: <20240701060634.4827-1-zhujun2@cmss.chinamobile.com>
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
 .../testing/selftests/breakpoints/step_after_suspend_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
index dfec31fb9b30..37a83e3bbe7a 100644
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
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
 	}
 
 	err = sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
-	if (err < 0)
+	if (err < 0) 
 		ksft_exit_fail_msg("sched_getaffinity() failed\n");
 
 	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
@@ -222,4 +222,6 @@ int main(int argc, char **argv)
 		ksft_exit_pass();
 	else
 		ksft_exit_fail();
+
+	return err;
 }
-- 
2.17.1




