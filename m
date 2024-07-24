Return-Path: <linux-kselftest+bounces-14137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8393AC90
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 08:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE501C20DE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 06:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1C482EF;
	Wed, 24 Jul 2024 06:26:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0A4C84;
	Wed, 24 Jul 2024 06:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721802396; cv=none; b=AVOTcb9J7CnWL9WoxUUo5tNompePADEiuGZQ6cMmZLxdGsgADvNXt+y1114gM1UupsSP8AKrOrT/IVqIwKrCG5O/GyKhUu+ViGDFRD7UvagG1pMbqoX0xyfn1CA61Q3dNkKru5VZ4Kxkgm+CT4Z8nrGd+Lcn0VJSM6/sPBNx/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721802396; c=relaxed/simple;
	bh=t2SG26QMer9VdP//vUDlyv9KbuZ0dx+K3wMgvzdY+E0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=evROP9V9xeypYgkZP8eOJ7V01EryHZjMZqBmoqaXgiCcYVqJPKCPSyiYcTjt9Tllhy6qWgsvaKOZhfsRDsBtN1c0fvJZ1K7sal3y74HpLCl7+S2P6gsSJV10SASTY5sjprQqnwnMxkDASb486IEP7/36/9OhI2EWj5sq80tbIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366a09e90b18-66323;
	Wed, 24 Jul 2024 14:26:26 +0800 (CST)
X-RM-TRANSID:2ee366a09e90b18-66323
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee466a09e915a9-93ee7;
	Wed, 24 Jul 2024 14:26:25 +0800 (CST)
X-RM-TRANSID:2ee466a09e915a9-93ee7
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: zhang.lyra@gmail.com
Cc: shuah@kernel.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v3] selftests:Fix printf format string in kselftest_harness.h
Date: Tue, 23 Jul 2024 23:26:24 -0700
Message-Id: <20240724062624.5157-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

'%u' in format string requires 'unsigned int' in __wait_for_test()
but the argument type is 'signed int' that this problem was discovered
by reading code.use macro WTERMSIG like those above usage to
fix the wrong format specifier.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
Changes 
v1->v2:
	modify commit info add how to find the problem in the log
v2->v3:
	Seems this can use macro WTERMSIG like those above usage, rather than
	changing the print format.

 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index dbbbcc6c04ee..f41f4435e9a4 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1086,7 +1086,7 @@ void __wait_for_test(struct __test_metadata *t)
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test ended in some other way [%d]\n",
 			t->name,
-			status);
+			WTERMSIG(status));
 	}
 }
 
-- 
2.17.1




