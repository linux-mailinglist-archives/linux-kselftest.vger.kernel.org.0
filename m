Return-Path: <linux-kselftest+bounces-368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E17F2905
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4BD3B2111C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF103BB49;
	Tue, 21 Nov 2023 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11168F5;
	Tue, 21 Nov 2023 01:32:42 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2655c7937287-805b6;
	Tue, 21 Nov 2023 17:32:40 +0800 (CST)
X-RM-TRANSID:2ee2655c7937287-805b6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8655c7937a7b-cb139;
	Tue, 21 Nov 2023 17:32:40 +0800 (CST)
X-RM-TRANSID:2ee8655c7937a7b-cb139
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: dan.carpenter@linaro.org
Cc: ivan.orlov0322@gmail.com,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v1] selftests/media_tests: fix a resource leak
Date: Tue, 21 Nov 2023 01:32:38 -0800
Message-Id: <20231121093238.5376-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
References: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

From: zhujun2 <zhujun2@cmss.chinamobile.com>

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by code reading

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---

Hi Dan Carpenter 
	
	I believe that the Linux kernel code is sacred and should strictly adhere to C code conventions

thanks,
[Zhu Jun]

 tools/testing/selftests/media_tests/media_device_open.c | 2 ++
 tools/testing/selftests/media_tests/media_device_test.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index 93183a37b133..ae263eb78a2c 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -79,4 +79,6 @@ int main(int argc, char **argv)
 	else
 		printf("Media device model %s driver %s\n",
 			mdi.model, mdi.driver);
+
+	close(fd);
 }
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 4b9953359e40..65888ce5c89f 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -100,4 +100,6 @@ int main(int argc, char **argv)
 		sleep(10);
 		count--;
 	}
+
+	close(fd);
 }
-- 
2.17.1




