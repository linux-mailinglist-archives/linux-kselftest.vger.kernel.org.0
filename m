Return-Path: <linux-kselftest+bounces-78-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A187EAD2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 10:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17AC1C2083A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C0168B1;
	Tue, 14 Nov 2023 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E316403
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Nov 2023 09:38:24 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 288C418E;
	Tue, 14 Nov 2023 01:38:20 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee565534009c5c-d14fe;
	Tue, 14 Nov 2023 17:38:17 +0800 (CST)
X-RM-TRANSID:2ee565534009c5c-d14fe
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee565534008686-5bf03;
	Tue, 14 Nov 2023 17:38:17 +0800 (CST)
X-RM-TRANSID:2ee565534008686-5bf03
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	zhujun2@cmss.chinamobile.com,
	ivan.orlov0322@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/media_tests: fix a resource leak
Date: Tue, 14 Nov 2023 01:38:12 -0800
Message-Id: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
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




