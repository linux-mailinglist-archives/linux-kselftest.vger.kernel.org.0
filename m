Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2697463A59
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 16:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhK3Ppj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 10:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbhK3Poz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 10:44:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29352C061756
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 07:41:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id u1so45322571wru.13
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Nov 2021 07:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2GWUpkiuXSzN66GVjCDh6suML+iAta4LGHtIvVqjGEk=;
        b=PJzVzAJyxffNnedFEdvo481yX7NGXk4byfDTk9Z+gAKucSrVtPDOmma+Zq16xS4zPL
         /oLFiqmI1ZQ3+lfq9LpkGTH1V1WqqwvFN1V5Y320M+foXAXjllcA8CRcZlfGsnH4Llox
         8BaOyYiRVwdMGUN58XJ6nWjhieOO0LmXhG0xcyXvoGP1Xhz65XUfClslBQ8mHGZmdxku
         jKAH5npL9jWZDUW0Jpl7Y5geb9YHprVMnDMV13mYlpW0/F87QzP23ZDDbnmOjS7AeDsE
         IrKFJYoXlRjd6AIFWYie7vFBZfOTsm3KpIFBFtL16epNToVpCGKz/w3m3eVw+79SxWqY
         F3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GWUpkiuXSzN66GVjCDh6suML+iAta4LGHtIvVqjGEk=;
        b=ENOmUeOw15z+fqQEg7v1RRe2MYE96ySGo71hwQ3zc78w4rwYdcEsHMKrQR4nAd1Sva
         OV0vHQbO8GJALEHhojqoAZaSc/6fRqvv6GPRImLF29lwqPvt9RdAe4RTFfV7DHSfrm1Q
         r8errW7YI2vi+sLHaIry3Y1/cVlYx/ZObROx8OOupkwkiP7LAXeFor1VDHKlvaLZQUIr
         WfB5irYQ+L9GaJBDxCicx7agTIKVTF/LHCm1T34N9C4mK+8yt9rwsyoj7JLEXLGI/pkg
         uyg26eA29GB5ADwBWCUOMFuHxfWlNuNl+juKNPE0nzhcnmNzGEG7y3iCbUcRRheZUVgq
         t5hw==
X-Gm-Message-State: AOAM530u1U5dX1tVIB7jL7TmTwjqGhS12ivBFP3VVgZhyplCmeRgrQju
        EDp/ixzTj3Kf8oZRIkCn2fQfXtXHPj1UTkbk
X-Google-Smtp-Source: ABdhPJz0VsHHfilKNFFewqQ0dSxoK0Rdda6+4+w0X/nSuuXalMZ/KZ7xP+oj2cH5v0NA84jqI1U4Jg==
X-Received: by 2002:adf:ce0e:: with SMTP id p14mr40866287wrn.423.1638286894783;
        Tue, 30 Nov 2021 07:41:34 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id l2sm2962792wmq.42.2021.11.30.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 07:41:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v11 4/6] selftests: gpio: provide a helper for reading chip info
Date:   Tue, 30 Nov 2021 16:41:25 +0100
Message-Id: <20211130154127.12272-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211130154127.12272-1-brgl@bgdev.pl>
References: <20211130154127.12272-1-brgl@bgdev.pl>
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
index d7b312b44a62..a40b818c394e 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -2,7 +2,7 @@
 
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
-TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
+TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev gpio-chip-info
 CFLAGS += -O2 -g -Wall -I../../../../usr/include/
 
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

