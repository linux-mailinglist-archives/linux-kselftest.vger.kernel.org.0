Return-Path: <linux-kselftest+bounces-1037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD6A802D54
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3DB2808B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB553AA;
	Mon,  4 Dec 2023 08:37:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D688C1
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 00:37:33 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4656d8fc944d-5ed1d;
	Mon, 04 Dec 2023 16:37:31 +0800 (CST)
X-RM-TRANSID:2ee4656d8fc944d-5ed1d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5656d8fc9d27-280da;
	Mon, 04 Dec 2023 16:37:31 +0800 (CST)
X-RM-TRANSID:2ee5656d8fc9d27-280da
From: liujing <liujing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: bigeasy@linutronix.de,
	tglx@linutronix.de,
	linux-kselftest@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools/testing/selftests/x86: add dlclose function in the test_vsyscall.c
Date: Mon,  4 Dec 2023 03:37:28 -0500
Message-Id: <20231204083728.2767-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

in the init_vdso function of test_vsyscall.c, Missing a dlclose function
in the end

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/x86/test_vsyscall.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 47cab972807c..9035d2745c28 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -94,6 +94,9 @@ static void init_vdso(void)
 	vdso_getcpu = (getcpu_t)dlsym(vdso, "__vdso_getcpu");
 	if (!vdso_getcpu)
 		printf("[WARN]\tfailed to find getcpu in vDSO\n");
+
+	dlclose(vdso);
+
 }
 
 static int init_vsys(void)
-- 
2.18.2




