Return-Path: <linux-kselftest+bounces-360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C37F2470
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 03:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE27282190
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 02:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A495379EE;
	Tue, 21 Nov 2023 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8553DC;
	Mon, 20 Nov 2023 18:59:24 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2655c1d09f85-7c2b4;
	Tue, 21 Nov 2023 10:59:21 +0800 (CST)
X-RM-TRANSID:2ee2655c1d09f85-7c2b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7655c1d082ed-c5454;
	Tue, 21 Nov 2023 10:59:21 +0800 (CST)
X-RM-TRANSID:2ee7655c1d082ed-c5454
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: kernel-janitors@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com,
	ivan.orlov0322@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/media_tests: fix a resource leak
Date: Mon, 20 Nov 2023 18:59:18 -0800
Message-Id: <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
References: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by code reading

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/media_tests/media_device_open.c | 3 +++
 tools/testing/selftests/media_tests/media_device_test.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
index 93183a37b133..2dfb2a11b148 100644
--- a/tools/testing/selftests/media_tests/media_device_open.c
+++ b/tools/testing/selftests/media_tests/media_device_open.c
@@ -70,6 +70,7 @@ int main(int argc, char **argv)
 	fd = open(media_device, O_RDWR);
 	if (fd == -1) {
 		printf("Media Device open errno %s\n", strerror(errno));
+		close(fd);
 		exit(-1);
 	}
 
@@ -79,4 +80,6 @@ int main(int argc, char **argv)
 	else
 		printf("Media device model %s driver %s\n",
 			mdi.model, mdi.driver);
+
+	close(fd);
 }
diff --git a/tools/testing/selftests/media_tests/media_device_test.c b/tools/testing/selftests/media_tests/media_device_test.c
index 4b9953359e40..7cabb62535a7 100644
--- a/tools/testing/selftests/media_tests/media_device_test.c
+++ b/tools/testing/selftests/media_tests/media_device_test.c
@@ -79,6 +79,7 @@ int main(int argc, char **argv)
 	fd = open(media_device, O_RDWR);
 	if (fd == -1) {
 		printf("Media Device open errno %s\n", strerror(errno));
+		close(fd);
 		exit(-1);
 	}
 
@@ -100,4 +101,6 @@ int main(int argc, char **argv)
 		sleep(10);
 		count--;
 	}
+
+	close(fd);
 }
-- 
2.17.1




