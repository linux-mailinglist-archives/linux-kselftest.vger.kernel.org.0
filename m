Return-Path: <linux-kselftest+bounces-1038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6319802DBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A63A1F210A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E010A0D;
	Mon,  4 Dec 2023 09:01:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1254A83
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Dec 2023 01:01:20 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6656d9559351-5ebda;
	Mon, 04 Dec 2023 17:01:14 +0800 (CST)
X-RM-TRANSID:2ee6656d9559351-5ebda
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1656d9559937-28cbf;
	Mon, 04 Dec 2023 17:01:13 +0800 (CST)
X-RM-TRANSID:2ee1656d9559937-28cbf
From: liujing <liujing@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools/testing/selftests/x86: add dlclose function in the vdso_restorer.c
Date: Mon,  4 Dec 2023 04:01:11 -0500
Message-Id: <20231204090111.2967-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

in the main function of vdso_restorer.c,there is a dlopen function,
but there is no dlclose function to close the file

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 tools/testing/selftests/x86/vdso_restorer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f2434155..a0b1155dee31 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -57,6 +57,8 @@ int main()
 		return 0;
 	}
 
+	dlclose(vdso);
+
 	memset(&sa, 0, sizeof(sa));
 	sa.handler = handler_with_siginfo;
 	sa.flags = SA_SIGINFO;
-- 
2.18.2




