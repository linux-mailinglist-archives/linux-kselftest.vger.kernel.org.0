Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51CE46B739
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 10:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhLGJiA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 04:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhLGJhx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 04:37:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14523C0611F7
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 01:34:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so28164771wrw.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 01:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLE3QPwL4b8b/ee9pGQMjsQcF3NssyLlDXPOSMNwayg=;
        b=M5Oc0UUXMMRXySSoaFUIuHhMP2/Tgaf5SE/TdUXMlg0qVQW5cFB97XO06AiUCa0jJ+
         lr+3Mam8kwmpP3VSJSbG02KJsFz3VdpQUBphvepk+ooF5ZdTLTaGq+AL1fFhaEvhlpWg
         fabHsVkbKfzSDrlEoJmKkhwAA8PHV9ryW7Ba1QNDCGzw8/YVaGh9VcJmYKNXngbCDNO9
         JE70e0w+8ldovkHAPQr9LMbcVxupVCamkqay9KSyARBjSThsqrN9A8daRrwqZpL9L/DP
         5amuGBAVnl6GCuaAxfXpvUydcQx8cbQx5uEeaFRFRjKBbfM9vJ1sxG9/wyNMJKejKH4g
         rRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLE3QPwL4b8b/ee9pGQMjsQcF3NssyLlDXPOSMNwayg=;
        b=51lBGk4Xp8zd52HezbA2quxjDgVesIGdId4s1Kb05DbHGrgwvxOSDOYB/QhqBZrAwe
         JgaKZeWeJh+UbD7WVYBaLu0REddzQ7KuUrLuH1A1bsVzboVUUfl1Fb4XkGpxh8amYC97
         NS5CW+ptUXtsDBkPsnyYRlESFyg3JKE2cirKoldYvmasAqoChx6Bj+a2Mj3hazAZlShn
         jDiztbUQZvxKcsJ3GSV09B6oLNjJOidWQV/2g4c+T0fUaGMfxGHZfyHK6luUNMFW+6ZW
         jd0TWZ+P47S3/CLfjGUCiqRCmpEbpjk+oIEnqutm9y+MHod/ThBvxpXpcsAbMcpPMsgd
         J4HQ==
X-Gm-Message-State: AOAM532fCeYymcXa7cE/2Kvw8/tE31FGK/eHu6FGr0E9VqiFUsd+lfLc
        eWkHaadI5rQI14wfdxeg3dSLlA==
X-Google-Smtp-Source: ABdhPJzRAHK9S49klhkvFaR/NeMftMkoVHJYlSDuSZHSjmeM32EJ+GoURC3nmqRpuCkrWncKEFMi/Q==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr51357067wrp.29.1638869660636;
        Tue, 07 Dec 2021 01:34:20 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id k13sm13783291wri.6.2021.12.07.01.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:34:20 -0800 (PST)
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
Subject: [PATCH v13 5/7] selftests: gpio: provide a helper for reading chip info
Date:   Tue,  7 Dec 2021 10:34:10 +0100
Message-Id: <20211207093412.27833-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211207093412.27833-1-brgl@bgdev.pl>
References: <20211207093412.27833-1-brgl@bgdev.pl>
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
index 000000000000..fdc07e742fba
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

