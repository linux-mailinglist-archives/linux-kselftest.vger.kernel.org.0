Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E926D87A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjDEUE5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjDEUE4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 16:04:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8963F268B;
        Wed,  5 Apr 2023 13:04:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-930bc91df7bso121225666b.1;
        Wed, 05 Apr 2023 13:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680725094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4ybHK0lZfDPR4eVPVTes6mvN8filGMsCKj+vPBAOkc=;
        b=SfZj5verxakoXZSU3gC/cXy7s7AfRZIwhg0IWLmtOH5SyE3h/YNrp60UByYgAnt7v4
         gxcJWWvgmjT2qe76JuFzWh7g56XFG3SKTCF+bqM5Viml0xwTF274jjduEp3XaSNF7cZz
         wxMoTkCYWP3dUOFF+h30hIJ9y/D82UIWIOktbYP/qGhv5KdsKt4NbDCOK3ZVvR9Xvdel
         tHpACLggCxUQ/0DdwMkln/3PyRLP2hvh9+A48TvPJPr8MqrC80LpghKheb+YgYTJvhPC
         l9wD73ReEPbaDFSZje17JH4ALInN11J049YDD8NDnmSai4cRj1Wt7dIlriK8sB2N3aNL
         AkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l4ybHK0lZfDPR4eVPVTes6mvN8filGMsCKj+vPBAOkc=;
        b=rIbvBvc+VUl0tQnTw8kMISdus9LXMMo6rd/lToSQspSXFewlV1J+wJ3RzO8uQEKAsI
         vT5Nr3ofoAMoQMuens5l+65M1I7a/vcExyEe4o6zNzyisdjmKXW5473akMZKCZ17wGfL
         jBsCDhLepqb8x2Q4EuIewDKb9girxF+6yWHO04QboJwjrGKNuCtst/IT6rdRbM+0AN2t
         vVG63zYz+DW+upIUlos9xPsXVl2txl3HThctJaRTNmRfUFiAkBADU3zewGO08/I1imY+
         lQPzfv2cKwEtiU3ykHpIcvhaybyNQbHleMrZgn+H0CzH0MYX+oDrc5ecHWJEeP3AwhRp
         hPeg==
X-Gm-Message-State: AAQBX9dkyl9nlzh3Xqc46huYnF6DIEAGDUuv9ELLHJ5OTWI6zO7h9Mun
        tlJ7dK3/3mShhizuPkJ7fdg=
X-Google-Smtp-Source: AKy350aif9Lwcm9XVSUrafHAfP1cry8Ie2vf0NydHq4XGIP8Qwgof/0CgfCcQaqIkul9njwPwDUnDA==
X-Received: by 2002:a05:6402:51d4:b0:502:1cf6:f52c with SMTP id r20-20020a05640251d400b005021cf6f52cmr4212056edd.4.1680725093943;
        Wed, 05 Apr 2023 13:04:53 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.92.225])
        by smtp.gmail.com with ESMTPSA id o1-20020a50c281000000b00502b0b0d75csm3655030edf.46.2023.04.05.13.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:04:53 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     shuah@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] selftests: media_tests: Add new subtest to video_device_test
Date:   Thu,  6 Apr 2023 00:04:50 +0400
Message-Id: <20230405200450.6254-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new subtest to video_device_test to cover the VIDIOC_G_PRIORITY
and VIDIOC_S_PRIORITY ioctl calls. This test tries to set the priority
associated with the file descriptior via ioctl VIDIOC_S_PRIORITY
command from V4L2 API. After that, the test tries to get the new
priority via VIDIOC_G_PRIORITY ioctl command and compares the result
with the v4l2_priority it set before. At the end, the test restores the
old priority.

This test will increase the code coverage for video_device_test, so
I think it might be useful. Additionally, this patch will refactor the
video_device_test a little bit, according to the new functionality.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2: Revert the test description change

 .../selftests/media_tests/video_device_test.c | 111 +++++++++++++-----
 1 file changed, 83 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/media_tests/video_device_test.c b/tools/testing/selftests/media_tests/video_device_test.c
index 0f6aef2e2593..2c44e115f2f0 100644
--- a/tools/testing/selftests/media_tests/video_device_test.c
+++ b/tools/testing/selftests/media_tests/video_device_test.c
@@ -37,45 +37,58 @@
 #include <time.h>
 #include <linux/videodev2.h>
 
-int main(int argc, char **argv)
+#define PRIORITY_MAX 4
+
+int priority_test(int fd)
 {
-	int opt;
-	char video_dev[256];
-	int count;
-	struct v4l2_tuner vtuner;
-	struct v4l2_capability vcap;
+	/* This test will try to update the priority associated with a file descriptor */
+
+	enum v4l2_priority old_priority, new_priority, priority_to_compare;
 	int ret;
-	int fd;
+	int result = 0;
 
-	if (argc < 2) {
-		printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
-		exit(-1);
+	ret = ioctl(fd, VIDIOC_G_PRIORITY, &old_priority);
+	if (ret < 0) {
+		printf("Failed to get priority: %s\n", strerror(errno));
+		return -1;
+	}
+	new_priority = (old_priority + 1) % PRIORITY_MAX;
+	ret = ioctl(fd, VIDIOC_S_PRIORITY, &new_priority);
+	if (ret < 0) {
+		printf("Failed to set priority: %s\n", strerror(errno));
+		return -1;
+	}
+	ret = ioctl(fd, VIDIOC_G_PRIORITY, &priority_to_compare);
+	if (ret < 0) {
+		printf("Failed to get new priority: %s\n", strerror(errno));
+		result = -1;
+		goto cleanup;
+	}
+	if (priority_to_compare != new_priority) {
+		printf("Priority wasn't set - test failed\n");
+		result = -1;
 	}
 
-	/* Process arguments */
-	while ((opt = getopt(argc, argv, "d:")) != -1) {
-		switch (opt) {
-		case 'd':
-			strncpy(video_dev, optarg, sizeof(video_dev) - 1);
-			video_dev[sizeof(video_dev)-1] = '\0';
-			break;
-		default:
-			printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
-			exit(-1);
-		}
+cleanup:
+	ret = ioctl(fd, VIDIOC_S_PRIORITY, &old_priority);
+	if (ret < 0) {
+		printf("Failed to restore priority: %s\n", strerror(errno));
+		return -1;
 	}
+	return result;
+}
+
+int loop_test(int fd)
+{
+	int count;
+	struct v4l2_tuner vtuner;
+	struct v4l2_capability vcap;
+	int ret;
 
 	/* Generate random number of interations */
 	srand((unsigned int) time(NULL));
 	count = rand();
 
-	/* Open Video device and keep it open */
-	fd = open(video_dev, O_RDWR);
-	if (fd == -1) {
-		printf("Video Device open errno %s\n", strerror(errno));
-		exit(-1);
-	}
-
 	printf("\nNote:\n"
 	       "While test is running, remove the device or unbind\n"
 	       "driver and ensure there are no use after free errors\n"
@@ -98,4 +111,46 @@ int main(int argc, char **argv)
 		sleep(10);
 		count--;
 	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+	char video_dev[256];
+	int fd;
+	int test_result;
+
+	if (argc < 2) {
+		printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
+		exit(-1);
+	}
+
+	/* Process arguments */
+	while ((opt = getopt(argc, argv, "d:")) != -1) {
+		switch (opt) {
+		case 'd':
+			strncpy(video_dev, optarg, sizeof(video_dev) - 1);
+			video_dev[sizeof(video_dev)-1] = '\0';
+			break;
+		default:
+			printf("Usage: %s [-d </dev/videoX>]\n", argv[0]);
+			exit(-1);
+		}
+	}
+
+	/* Open Video device and keep it open */
+	fd = open(video_dev, O_RDWR);
+	if (fd == -1) {
+		printf("Video Device open errno %s\n", strerror(errno));
+		exit(-1);
+	}
+
+	test_result = priority_test(fd);
+	if (!test_result)
+		printf("Priority test - PASSED\n");
+	else
+		printf("Priority test - FAILED\n");
+
+	loop_test(fd);
 }
-- 
2.34.1

