Return-Path: <linux-kselftest+bounces-14193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AFA93BAE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 04:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13C71F23CFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 02:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47311711;
	Thu, 25 Jul 2024 02:34:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6211103;
	Thu, 25 Jul 2024 02:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874867; cv=none; b=VzN/egYMfu2BeEEDuKSwikpn9kqFvWADXW9y7vrwjJ0LAPaVhHDj+9SSaJPDRAIcoukhsTJCQBwx53yeoSubuo5iD5sQw2lIs627uifOCbDqNo+UrmEjAG6OSEuc2pRifvisWGYuWD+F8ZIn9UD9/VgqcUirdG3jrfRPv4/LbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874867; c=relaxed/simple;
	bh=b0p9hIs73UVjOkDg+cEbXbIHemjxZEx4CTcG+jIMPMk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Imj0f2sAuNjn1Jdu/iJhBVV/hotRkVephijX30MDFqGPNjWo+knVi1jVQbbNcHsUv9PSLrhivyw2W42OF7NHtLFwB1InNIti1UE67EInyywIkQdNxT/g9fdBrcOHXX4RFT17JjJAcGt1o02BsMx5G8vFP9Uqpe0N18/eKudbvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966a1b99af42-a3f42;
	Thu, 25 Jul 2024 10:34:02 +0800 (CST)
X-RM-TRANSID:2ee966a1b99af42-a3f42
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266a1b999d04-c6c8c;
	Thu, 25 Jul 2024 10:34:02 +0800 (CST)
X-RM-TRANSID:2ee266a1b999d04-c6c8c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: zhang.lyra@gmail.com
Cc: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v4] tools/testing:Fix the wrong format specifier
Date: Wed, 24 Jul 2024 19:34:01 -0700
Message-Id: <20240725023401.13365-1-zhujun2@cmss.chinamobile.com>
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




