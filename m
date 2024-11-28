Return-Path: <linux-kselftest+bounces-22592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE39DB1CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 04:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632F9281E58
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Nov 2024 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC04683CC1;
	Thu, 28 Nov 2024 03:22:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA8433B1;
	Thu, 28 Nov 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764174; cv=none; b=O8z3b+l3XD/ahSfTYeCmgV54/gBFMSOFFsCvLT6B/uFjuzMA3xIP90T9EyZWlEAussAolpXekwmAHW+9SfPv7MWcqunJLw3Uxg4+9zBITDu//skLUc2ytNd3/w9dgqdBT/oQeDWgPoQ9Ot3CiAZ6a4eLmk4hr/XgGgoktLGeEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764174; c=relaxed/simple;
	bh=SAiWo6sbT/fKesrptIDEhFk12afUVL4hGRQm9HqYN5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ebi2S1XUiZ2Z7vY2O335T4bo5IZ+wjS09eqbBYY4rRJOcKDH2ERQEie+hO9MKaYkykF2/QsHdMUatk1h2HzvbddOH+ie8dWhvURQf1rOLxJY+q0m2eIACMjcTU4bHLZmCVFWKVP6ix3pMp70x3kKtZwmgfwaKlw1mGDLW82xd3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56747e20544a-95461;
	Thu, 28 Nov 2024 11:22:47 +0800 (CST)
X-RM-TRANSID:2ee56747e20544a-95461
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56747e206dc2-8a2a7;
	Thu, 28 Nov 2024 11:22:47 +0800 (CST)
X-RM-TRANSID:2ee56747e206dc2-8a2a7
From: liujing <liujing@cmss.chinamobile.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] selftests/x86: Fix the wrong format specifier
Date: Thu, 28 Nov 2024 11:22:40 +0800
Message-Id: <20241128032240.3288-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both 'iterations' and 'num_threads' are unsigned int types,
so the output format should be %u.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 1fdf35a4d7f6..b64ba55c9019 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -758,7 +758,7 @@ static void test_context_switch(void)
 
 	req_xtiledata_perm();
 
-	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
+	printf("[RUN]\tCheck tiledata context switches, %u iterations, %u threads.\n",
 	       ctxtswtest_config.iterations,
 	       ctxtswtest_config.num_threads);
 
-- 
2.27.0




