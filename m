Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C087455E9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 15:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhKROzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhKROzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 09:55:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B00C061757
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:59 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so12069657wrb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6IP4ig0UItZ1EQ0Lll4U4AiUmzEqZVRIV6/6jfEsves=;
        b=gjqVccp6HsMEpBbCBu2LojNpRwsouWWSS7maK/ZC3b7SaUd04VYbmMKvccHWHQvA5s
         xg7+foGOX0wcgaOxW2EP/vJleF1kf5zKIBx/EpDkd5gOFPGbNFVTIbCFwzJw1URPoJyO
         7WwvIlMvMsz69HzSukuz7a9b45oOSH7RESj1P1macYJMOtlEsD4lEmUbeLbRuH+aPtpZ
         shRttsNVuZi9ZB8hF8PYyz3JFzlUCFJIm2taYJM+rcFnVkUfiI5Vlm5LSuQ+aWU14EfV
         Pwb8msf3JbFKWl0xoh3bRpPiSGtkFdqBwl3uOKGVn+7rX/jBNqwv1fzgYt9Tb12iwpXR
         mWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6IP4ig0UItZ1EQ0Lll4U4AiUmzEqZVRIV6/6jfEsves=;
        b=x2qUfAG9wYftjpwu61Nc6ZMFul44AADi+H01cgUS/mp9OOpsvd7lyoEAU4wi1tqp9S
         jSbG1rl29ivpAZRl2jcpiIlReRDt0Bd2M9LYEFCGVYojnupcVDfUsJxAFd5t9LqvK3YC
         9SDEdkGWQKROGq0njbmylGkIaATDM67v5wCPYFOlButnsIstZmsPY6f+BlbstOG0t9pe
         upOLaEJiBUMm4C+cixiiZFSOZCsaxgEQUBAoZoGP6//SiP2wW8OLsiIW3RTCjROGPEwe
         Q4DoExhNU52OCaVsK5OjLx8fZUKnray0fXybcxjiRP0F6k0QwHK2Fw/8rlT5YcXi3rAR
         ffzQ==
X-Gm-Message-State: AOAM533lU+r4/9gc719RX6gg5ZpPSEzkT3RLQmdOGBcY0PPaCP7KEWgr
        exjoNphV3t+GmutTkNQ+F8LLBQ==
X-Google-Smtp-Source: ABdhPJwGPAiStngLs+qIHJtCyqJq8QT/q4Q71dAjm18hFV3Z++tvqsYsLdmVUxXNUm7wns7hYqoAaQ==
X-Received: by 2002:adf:fd4c:: with SMTP id h12mr31279026wrs.429.1637247118245;
        Thu, 18 Nov 2021 06:51:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id f7sm63154wri.74.2021.11.18.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:51:58 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 2/4] selftests: gpio: provide a helper for reading chip info
Date:   Thu, 18 Nov 2021 15:51:40 +0100
Message-Id: <20211118145142.14519-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
References: <20211118145142.14519-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple program that allows to retrieve chip properties from the
GPIO character device. This will be used in gpio-sim selftests.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 tools/testing/selftests/gpio/.gitignore       |  1 +
 tools/testing/selftests/gpio/Makefile         |  2 +-
 tools/testing/selftests/gpio/gpio-chip-info.c | 57 +++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c

diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index a4969f7ee020..4ea4f58dab1a 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gpio-mockup-cdev
+gpio-chip-info
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 39f2bbe8dd3d..84b48547f94c 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -2,6 +2,6 @@
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info
 
 include ../lib.mk
diff --git a/tools/testing/selftests/gpio/gpio-chip-info.c b/tools/testing/selftests/gpio/gpio-chip-info.c
new file mode 100644
index 000000000000..8f2d2e23e9f6
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-chip-info.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO character device helper for reading chip information.
+ *
+ * Copyright (C) 2021 Bartosz Golaszewski <brgl@bgdev.pl>
+ */
+
+#include <fcntl.h>
+#include <linux/gpio.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+
+static void print_usage(void)
+{
+	printf("usage:\n");
+	printf("  gpio-chip-info <chip path> [name|label|num-lines]\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct gpiochip_info info;
+	int fd, ret;
+
+	if (argc !=3) {
+		print_usage();
+		return EXIT_FAILURE;
+	}
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror("unable to open the GPIO chip");
+		return EXIT_FAILURE;
+	}
+
+	memset(&info, 0, sizeof(info));
+	ret = ioctl(fd, GPIO_GET_CHIPINFO_IOCTL, &info);
+	if (ret) {
+		perror("chip info ioctl failed");
+		return EXIT_FAILURE;
+	}
+
+	if (strcmp(argv[2], "name") == 0) {
+		printf("%s\n", info.name);
+	} else if (strcmp(argv[2], "label") == 0) {
+		printf("%s\n", info.label);
+	} else if (strcmp(argv[2], "num-lines") == 0) {
+		printf("%u\n", info.lines);
+	} else {
+		fprintf(stderr, "unknown command: %s\n", argv[2]);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
-- 
2.25.1

