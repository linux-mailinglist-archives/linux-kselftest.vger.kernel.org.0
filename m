Return-Path: <linux-kselftest+bounces-14126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2C93AAF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 04:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F72E1F22C9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 02:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6E134AB;
	Wed, 24 Jul 2024 02:14:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556712E5B;
	Wed, 24 Jul 2024 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787271; cv=none; b=fgsPfEhV6xSAo/5grz4vZdYKiAKdCL3g4vt2iTS223e1yhvC+a/sBzzzHM9BNgzgZOvQL5U0txBfCo5I9pCKENwBitByDAitO1xiT4lfmNBxXahrhFaFAAnq1k3jdpMBMQrH5zJUBd3loei/3n3zqiWQxWhec5zAHMRAsMXH2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787271; c=relaxed/simple;
	bh=6w6Plydr9zV5A7he2c9U+8Z6fT4gBZS4Y5Ikv+WT4hU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=V1rqJb4xulo+q1xCvrFFIjvl9CG8o3DwY2tKpPL/9PpKe/0ou6PP+pKtdba209UvNpAf2tTtwYld/VpxTZRdvrRlCDr1fBWNIDSCaG40eBNDqA9dBX64cqz6fkkINVcLQ5Ao8vj39KHMskAqdjysLLEzETF3kvDwOiZgPxZOjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566a062c0f28-94f29;
	Wed, 24 Jul 2024 10:11:14 +0800 (CST)
X-RM-TRANSID:2ee566a062c0f28-94f29
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766a062c139d-8ff65;
	Wed, 24 Jul 2024 10:11:14 +0800 (CST)
X-RM-TRANSID:2ee766a062c139d-8ff65
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND PATCH v2] selftests:Fix printf format string in kselftest_harness.h
Date: Tue, 23 Jul 2024 19:11:12 -0700
Message-Id: <20240724021112.2840-1-zhujun2@cmss.chinamobile.com>
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




