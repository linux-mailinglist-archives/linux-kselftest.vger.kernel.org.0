Return-Path: <linux-kselftest+bounces-14254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C035A93CCBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 04:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18311C21C70
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9218D442F;
	Fri, 26 Jul 2024 02:32:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7122611;
	Fri, 26 Jul 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961170; cv=none; b=Gx/kAH4wtIV1mhKzEhIvw/Uteh8MBrb5jsL91SeCrM5zb1eqHluAYkhijQnDbtxgZ8HCd3yWQCpj6ZTwiGaBfj0WSi3O55jv+G5g1R1a3gQtAa1lhT8Mg8c6PMxNxxyyX4TxkbF1AsaP/9L0FDcyY04dk95yf36ennbtheC6MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961170; c=relaxed/simple;
	bh=I8doIXN/d/mZNom/wwVNkr3ImBDCsHdVBvoYOkhd5/Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uqGbwdeHvmtGB0nuxvKWEsA0tSxTes7bOesVdxSkpT5qJjZ761ee/ePQHW3CE6s2ho74GvNvaR/wqcfpckX/gqce3m9Jo0Li+OIZ7MUM8LrU6KoF2RQzQ0idQAamDBqSNv7c6N/wIUI+h6nKSHuyLF+mWeFgPAS3f70N4Q9fYnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966a30ac8224-ad224;
	Fri, 26 Jul 2024 10:32:42 +0800 (CST)
X-RM-TRANSID:2ee966a30ac8224-ad224
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866a30ac97a1-fc05c;
	Fri, 26 Jul 2024 10:32:42 +0800 (CST)
X-RM-TRANSID:2ee866a30ac97a1-fc05c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: zhang.lyra@gmail.com
Cc: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v5] tools/testing:Fix the wrong format specifier
Date: Thu, 25 Jul 2024 19:32:41 -0700
Message-Id: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The format specifier in fprintf is "%u", that "%u" should use
unsigned int type instead.the problem is discovered by reading code.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 v1->v2:
 	modify commit info add how to find the problem in the log
 v2->v3:
 	Seems this can use macro WTERMSIG like those above usage, rather than
 	changing the print format.
 v3->v4:
 	Now the commit summary doesn't match the change you are making.
	 Also WTERMSIG() is incorrect for this conditional code path.
	 See comments below in the code path.

	 I would leave the v2 code intact. How are you testing this change?
	 Please include the details in the change log.
v4->v5:
	Compile the kernel for testing using make


 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index e05ac8261046..675b8f43e148 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -910,7 +910,7 @@ void __wait_for_test(struct __test_metadata *t)
 		.sa_flags = SA_SIGINFO,
 	};
 	struct sigaction saved_action;
-	int status;
+	unsigned int status;
 
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->passed = 0;
-- 
2.17.1




