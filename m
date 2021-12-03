Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46146467859
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 14:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381070AbhLCNd6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 08:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381051AbhLCNdz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 08:33:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC514C06174A
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 05:30:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4884535wml.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdC8L7KcajeuYgRxRzq/BDd9/Try3NuMaNKMjlQg9Bs=;
        b=eOPfFHeEJBk64UrSwG47YQttEAuD8/mJPEeLRH8X546NQcfeNqddQ6U8yWjfSbXMQS
         W/hZwO8AcyahQDyMW+qXPYnV1TFxcL05m3aTiFa14G/bY7lkbT80m+btoErQg4GMMwWy
         6c6wFs8/QIX7tXuFSwf1tfQ7qFVPG7jwPI17qBfxNVCKbtR39wFE1gGRaUXjVlKxpH3s
         azd+m+wDbr3qFbIdf9UayMMjTYIy05t3kr5BBlUuGvbLXRYsVqdBLqWKidJ+vviHYcwT
         r/PtmP+TStZtpbZIgaw2RoHvBJj5t4icZjYpSvdF1GsEgrThHStujb4uAT5OAEulil3e
         KOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdC8L7KcajeuYgRxRzq/BDd9/Try3NuMaNKMjlQg9Bs=;
        b=75RigkNutgpxastkJFFinurbREIP0PWjiepnbVsErnctvvAxdi9pRMGBQgUJhFyQLa
         0MSEgvUfDNYPxvL8jGQweI60QyVNg3HU/zGFgpVkMcz6/w4dDewBQ87a6wpD9U8sr0eZ
         0PQr0ayHN92p8nZR4y8kU0hB9dyC9MNa51Tx7ywJkf1Gt7VbKEq7KTS8n8SBzH5GB4CA
         E3WaZLf+dUPwaFQna5Pw5lbHP1r0yWLetzFj4iypx/eOJ1w3ebau1jpMuaQav+oYssuL
         9qPAoRpAVhIhPrnNlzTKS/zsTAMVrSV6igtmRyZ0LZ7rPCB7LxqO8idBC1NEbX7LhzLF
         /a1g==
X-Gm-Message-State: AOAM533zA3lx0UApHyBHyo2aQV3FeJJO9LJs70w1y/tHSG6uvLmTp8gi
        5GXsj00cV2cDv5F0ZaWU5Wm7xQ==
X-Google-Smtp-Source: ABdhPJzjwGj5PkvCKIzMba+1+kZH4qwprMHh0Gdl1cJBZ+0jDoq/GmJCCZ8a9/uKwUd30SjZN0U7RA==
X-Received: by 2002:a05:600c:500a:: with SMTP id n10mr15680676wmr.136.1638538229299;
        Fri, 03 Dec 2021 05:30:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id j11sm2755910wrt.3.2021.12.03.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:30:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v12 6/7] selftests: gpio: add a helper for reading GPIO line names
Date:   Fri,  3 Dec 2021 14:30:02 +0100
Message-Id: <20211203133003.31786-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203133003.31786-1-brgl@bgdev.pl>
References: <20211203133003.31786-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a simple program that allows to read GPIO line names from the
character device. This will be used in gpio-sim selftests.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 tools/testing/selftests/gpio/.gitignore       |  1 +
 tools/testing/selftests/gpio/Makefile         |  2 +-
 tools/testing/selftests/gpio/gpio-line-name.c | 55 +++++++++++++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c

diff --git a/tools/testing/selftests/gpio/.gitignore b/tools/testing/selftests/gpio/.gitignore
index 4ea4f58dab1a..ededb077a3a6 100644
--- a/tools/testing/selftests/gpio/.gitignore
+++ b/tools/testing/selftests/gpio/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 gpio-mockup-cdev
 gpio-chip-info
+gpio-line-name
diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index a40b818c394e..293aa9749408 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -2,7 +2,7 @@
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
 CFLAGS += -O2 -g -Wall -I../../../../usr/include/
 
 include ../lib.mk
diff --git a/tools/testing/selftests/gpio/gpio-line-name.c b/tools/testing/selftests/gpio/gpio-line-name.c
new file mode 100644
index 000000000000..e635cfadbded
--- /dev/null
+++ b/tools/testing/selftests/gpio/gpio-line-name.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * GPIO character device helper for reading line names.
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
+	printf("  gpio-line-name <chip path> <line offset>\n");
+}
+
+int main(int argc, char **argv)
+{
+	struct gpio_v2_line_info info;
+	int fd, ret;
+	char *endp;
+
+	if (argc != 3) {
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
+	info.offset = strtoul(argv[2], &endp, 10);
+	if (*endp != '\0') {
+		print_usage();
+		return EXIT_FAILURE;
+	}
+
+	ret = ioctl(fd, GPIO_V2_GET_LINEINFO_IOCTL, &info);
+	if (ret) {
+		perror("line info ioctl failed");
+		return EXIT_FAILURE;
+	}
+
+	printf("%s\n", info.name);
+
+	return EXIT_SUCCESS;
+}
-- 
2.25.1

