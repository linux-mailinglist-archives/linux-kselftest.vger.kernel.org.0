Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26406D2F5C
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Apr 2023 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjDAJWQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Apr 2023 05:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDAJWP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Apr 2023 05:22:15 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175FAF26;
        Sat,  1 Apr 2023 02:22:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b20so99002441edd.1;
        Sat, 01 Apr 2023 02:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680340932; x=1682932932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2JAXjEh00e4SLFvJwSAfkOz5lCcAQOFO7gXGReDig9g=;
        b=hM9QVU/gTNXHt0T6rSic4JFPX3dZwj6smNRVN2+KTkGBsqpaZPzKm4yL+ANnu2JyP6
         hRXf2XQLgeHC0XPhpRDuSCB5AvLvlGNZCBqBUCQoBGE0xcEm2Vg1vAJfqwJGiYcl/6ph
         eThu1cHNsNkKLdVlx9fbi6j16b2lFluox1vj0UOyH8OUDFpOar3UUdt+FVTfsM3CWgoy
         ui02UUMxFPCXPP+uXKbue4PkbRt3MoKmH9t/YuNp0qgKfgnUzZM5mIeNsbFPR2Qo3VGJ
         CcSevXERu+fnqgAYb1kTXM6jsOQgcr6T0HfMiA1+LuxviP184wDZqUeubUzAzuk95/aD
         YsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680340932; x=1682932932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JAXjEh00e4SLFvJwSAfkOz5lCcAQOFO7gXGReDig9g=;
        b=qbYr5W8++jk65P0csOMq64atYfK0pI2yX+ai9hLYTFv1h+sWM5pC2p566DxNtef/C6
         w3nTueTizpsP9IRxC+yhqS4ZOMR2Dhl4lHwaPJmYAEcpwJ6tMCaVsam27cwFeVXM953S
         tXEr5X1jQxf2WU0H35/jIQ+IMiTdPthpUw+bJYPfI9gWXyp+Omwd5N2NoAlPlCErAMW+
         FXvGeysR8uMqBZU0pNYEIUpV0swaj8uUXLypZsB6IJukaxtep0jqdWDUFSat0gSYn1Th
         dmYXEvIS2iE4USZ+/o3PmSQqHYN7jL+O4+DFMMDZ0wIn0gxf3e1cxJjRsgqTm8Mm/+cy
         5frA==
X-Gm-Message-State: AAQBX9cxQXHIg7wIT7vVuv/iyb699m9wRb1l/mLhX3DTNcY0TnqSSrDa
        SLFm/z7o7u2CRZPXPdZ2+fg=
X-Google-Smtp-Source: AKy350ZC7Jp6bb0KKIDt6HVyCcf/E6RKfx79MtDfHO/qgKIZXf2ZLQRw9+yzj75P/WOHpopxMG1T5Q==
X-Received: by 2002:a05:6402:524e:b0:502:465:28e0 with SMTP id t14-20020a056402524e00b00502046528e0mr8967686edd.0.1680340931961;
        Sat, 01 Apr 2023 02:22:11 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.81.51])
        by smtp.gmail.com with ESMTPSA id t28-20020a50ab5c000000b005024faae65esm1885147edc.10.2023.04.01.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 02:22:11 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        himadrispandya@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] selftests: media_tests: Add new subtest to video_device_test
Date:   Sat,  1 Apr 2023 13:22:07 +0400
Message-Id: <20230401092207.16667-1-ivan.orlov0322@gmail.com>
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
 .../selftests/media_tests/video_device_test.c | 131 +++++++++++++-----
 1 file changed, 93 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/media_tests/video_device_test.c b/tools/testing/selftests/media_tests/video_device_test.c
index 0f6aef2e2593..5e6f65ad2ca3 100644
--- a/tools/testing/selftests/media_tests/video_device_test.c
+++ b/tools/testing/selftests/media_tests/video_device_test.c
@@ -13,18 +13,9 @@
  * in the Kselftest run. This test should be run when hardware and driver
  * that makes use of V4L2 API is present.
  *
- * This test opens user specified Video Device and calls video ioctls in a
- * loop once every 10 seconds.
- *
  * Usage:
  *	sudo ./video_device_test -d /dev/videoX
- *
- *	While test is running, remove the device or unbind the driver and
- *	ensure there are no use after free errors and other Oops in the
- *	dmesg.
- *	When possible, enable KaSan kernel config option for use-after-free
- *	error detection.
-*/
+ */
 
 #include <stdio.h>
 #include <unistd.h>
@@ -37,45 +28,67 @@
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
+	/*
+	 * This test opens user specified Video Device and calls video ioctls in a
+	 * loop once every 10 seconds.
+	 * While test is running, remove the device or unbind the driver and
+	 * ensure there are no use after free errors and other Oops in the
+	 * dmesg.
+	 * When possible, enable KaSan kernel config option for use-after-free
+	 * error detection.
+	 */
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

