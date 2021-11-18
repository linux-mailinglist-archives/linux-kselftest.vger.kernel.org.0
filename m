Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1456D455EA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 15:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhKROzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhKROzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 09:55:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDBC061759
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:52:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s13so12104927wrb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAi1HQ0wQ9iMNplJyh+Qrg9skVX8antWQsqVsKhASSo=;
        b=7f60m7cRFZnvMc4VCnx3P1lIVKj1H+gZREnFojXCFrO3Q2tkBDBpC6doehkaCfBDar
         tK/Am7dRTBs2Z0eiT6s8wk3lNnKpkgNyhMqtO/hL2RGBli/5gD+VrollxRfxQae4f8kc
         tlqCd+5Q7bNz+6TBjWIM/6HnYTS8K7FD+Kmwua/gUhGaVMnDVa53D3tBhgTcTW0ucUx/
         gp2lvVIrezyaXS5TAUBzIS7ejScoB8ku9QdtELP6+7icFyg+j0khDTVvoT+q4n5Qq+jG
         zCrxANPi3CzDXNYD6769B7UAGVjM8dfntpy1hbnyuA3ENV1ogLYzkTFpnowSu83yUrgq
         acUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAi1HQ0wQ9iMNplJyh+Qrg9skVX8antWQsqVsKhASSo=;
        b=jm6ezMM3GzZEoj0ofdosPQ7WQ+b71LSUP9VZw+WqNknrAw88O23Ou83uicXN3exG+W
         mvzmaOw1hr+ZPj1EjkED6NLvRJDdVEZN/+ohgue23WW6myEAHdjpLr9RhIy5fLYRqyEH
         raqrMFtDCQqDoACxnZGh4i/3nKw1vkBo/OwtVbpeXIPfB/OZKxYxUp4ISKTlet8xo2yL
         +BcS2+/fBuxCqEnx6vX6vAXtReBb5mXnDTydf6YRRwihZaJQHR2d5Qqr3O98JjjkDji7
         BzSr1pgjtEd8UqGclQUUoc/tD/Qj1+Kv9twb3bk7rwy7/RkGQKxkK5H77hcRlyFhwcN2
         Cglg==
X-Gm-Message-State: AOAM533fhbqV7/6J08PKbus6rIUvsJPMeSGoWRJa0bjoVeQS4v9f7bj6
        JUy47+obZ0+k/nCJI/DJLba6XA==
X-Google-Smtp-Source: ABdhPJzZRlfzwMfpKtqhB+W4XORLpR01WOnY4EqpPI8XsKQqmkvFHz8MTA+r5FoioKFzkgZ0CBLf5g==
X-Received: by 2002:adf:eece:: with SMTP id a14mr32407532wrp.333.1637247119332;
        Thu, 18 Nov 2021 06:51:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id f7sm63154wri.74.2021.11.18.06.51.58
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
Subject: [PATCH v9 3/4] selftests: gpio: add a helper for reading GPIO line names
Date:   Thu, 18 Nov 2021 15:51:41 +0100
Message-Id: <20211118145142.14519-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
References: <20211118145142.14519-1-brgl@bgdev.pl>
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
index 84b48547f94c..d7d8f1985d99 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -2,6 +2,6 @@
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info gpio-line-name
 
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

