Return-Path: <linux-kselftest+bounces-13636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8669192F388
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 03:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D777B20D01
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93061442C;
	Fri, 12 Jul 2024 01:39:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C72A567D;
	Fri, 12 Jul 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748369; cv=none; b=VFxLPez1WPfYnSURMU1QKl6FpIKdWONeKB+FccupTtjXWJGaTEhx80Hk4MkV4akOiED+Kgph6YSiPY12uLUwo6V92LmmS9U57vVgYMyr32uG8/49a8v71ud0YM5LGf6bvbOqDn7F/MCCPsEsIU/VBQ/HcrfkOMS/V9OU2qdd8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748369; c=relaxed/simple;
	bh=6w6Plydr9zV5A7he2c9U+8Z6fT4gBZS4Y5Ikv+WT4hU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BihLTuCFVWJ9xdFkS2zoRP8Oxx3igetvIAc1Oo7vOS+Nm6SSmFs2RXNiecdcS7W8koBg91vOLNc2KVdocl8D47tO+RpETbIW0zMCIDhRrSjAhZXSa7bCj7z4NTtWvYDMAW8/SNft4UDLLRYBf+C2tosdHb2qJ7q5TLVYkBdoIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26690893ee73-6ee76;
	Fri, 12 Jul 2024 09:39:12 +0800 (CST)
X-RM-TRANSID:2ee26690893ee73-6ee76
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76690893fb0e-3357f;
	Fri, 12 Jul 2024 09:39:12 +0800 (CST)
X-RM-TRANSID:2ee76690893fb0e-3357f
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] selftests:Fix printf format string in kselftest_harness.h
Date: Thu, 11 Jul 2024 18:39:10 -0700
Message-Id: <20240712013910.2700-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

'%u' in format string requires 'unsigned int' in __wait_for_test()
but the argument type is 'signed int' that this problem was discovered 
by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes in v2:
 - modify commit info add how to find the problem in the log

 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b634969cbb6f..dbbbcc6c04ee 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1084,7 +1084,7 @@ void __wait_for_test(struct __test_metadata *t)
 		}
 	} else {
 		fprintf(TH_LOG_STREAM,
-			"# %s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%d]\n",
 			t->name,
 			status);
 	}
-- 
2.17.1




