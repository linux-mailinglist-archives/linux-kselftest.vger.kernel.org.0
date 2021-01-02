Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23CA2E861F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhABCbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A1C06179F;
        Fri,  1 Jan 2021 18:31:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v3so11633555plz.13;
        Fri, 01 Jan 2021 18:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ZWwPxQwthfPLOud5M1vvgnEdHUhBjOY3GOowC8y3/s=;
        b=DUODYccX3oPjWTeSjUoi1GC3mgdreCnthEZTKSQFL2a7xN1gkyXGGdIQFUUSfIVWfN
         UCRHwUwbkYPjBI3uFBQhyUO/emv11dv8ZIMoqZaU0ObDv7iV37QSjUYVqgfTnciS/6oe
         GfF84RWSGZMcUPfA7Q7qE96soSg9glGqpKC75Nue/+pueLBpSV8BCpxuIrlZ4Vyfb0mK
         qpJZULGTxKwaYG5sOsj9oPsAVReGYN33dZamjeRei5G9wbtZeAkj2AQrOQ62ZisOiV3/
         AcAZF8QVEk1akD6MJbhkQMS5lXCsz600JFIZRVdRim7iiHXaz62l+pPLxoHjPSP/fn/Z
         I9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZWwPxQwthfPLOud5M1vvgnEdHUhBjOY3GOowC8y3/s=;
        b=M4bK0UrRZK7YxN2rHsNVXf3OBRCUQEug2z5AkzSXMCNCqFD2bUAzSi0SoMuD3pZsms
         X4+NIvXJc1HSzcjGx8cgY3dSE9rByEZgpxb5pj/Mmbjp9jO84AGj0d5GxgCBcM13yZFJ
         Aj7ZsZdvhmFbreZxjpJxxSktgIKE5racuLH+GLObAApu2sC/QohNgtzeyEbGuSDLKn3x
         vn4PVA9glXBT/cLEbhbh+MMFYRzWa1/VQHrXEmPnrOJOXQJNfGeDVxKTJXEZFd+svZ7e
         OJMHtUJfr05cbL9X/uNInr2OoIfen4u1IIHeSmFqwD6zsK+uHJLf2Byyw0mfrPUKzjTl
         3W6Q==
X-Gm-Message-State: AOAM531nIrt8CGQwxwaEzWxQKrEbfKe99LQevzgCS6yCEnnjgtAXK274
        Vo8u5rWVdOimGZJIGSpbA0jLxVPHE8SdgA==
X-Google-Smtp-Source: ABdhPJyDPC9wWyqyvBmpKeIo5cRBQ94EMALZniCVPET8ql/s9CJuWIn2Izus/Kwg94CHm7uT0AhU5Q==
X-Received: by 2002:a17:90a:2b88:: with SMTP id u8mr20445909pjd.161.1609554660123;
        Fri, 01 Jan 2021 18:31:00 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:30:59 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 5/7] tools: gpio: remove uAPI v1 code no longer used by selftests
Date:   Sat,  2 Jan 2021 10:29:47 +0800
Message-Id: <20210102022949.92304-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
References: <20210102022949.92304-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gpio-mockup-chardev helper has been obsoleted and removed, so also remove
the tools/gpio code that it, and nothing else, was using.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/gpio/gpio-utils.c | 89 -----------------------------------------
 tools/gpio/gpio-utils.h |  6 ---
 2 files changed, 95 deletions(-)

diff --git a/tools/gpio/gpio-utils.c b/tools/gpio/gpio-utils.c
index 37187e056c8b..1639b4d832cd 100644
--- a/tools/gpio/gpio-utils.c
+++ b/tools/gpio/gpio-utils.c
@@ -32,74 +32,6 @@
  * following api will request gpio lines, do the operation and then
  * release these lines.
  */
-/**
- * gpiotools_request_linehandle() - request gpio lines in a gpiochip
- * @device_name:	The name of gpiochip without prefix "/dev/",
- *			such as "gpiochip0"
- * @lines:		An array desired lines, specified by offset
- *			index for the associated GPIO device.
- * @num_lines:		The number of lines to request.
- * @flag:		The new flag for requsted gpio. Reference
- *			"linux/gpio.h" for the meaning of flag.
- * @data:		Default value will be set to gpio when flag is
- *			GPIOHANDLE_REQUEST_OUTPUT.
- * @consumer_label:	The name of consumer, such as "sysfs",
- *			"powerkey". This is useful for other users to
- *			know who is using.
- *
- * Request gpio lines through the ioctl provided by chardev. User
- * could call gpiotools_set_values() and gpiotools_get_values() to
- * read and write respectively through the returned fd. Call
- * gpiotools_release_linehandle() to release these lines after that.
- *
- * Return:		On success return the fd;
- *			On failure return the errno.
- */
-int gpiotools_request_linehandle(const char *device_name, unsigned int *lines,
-				 unsigned int num_lines, unsigned int flag,
-				 struct gpiohandle_data *data,
-				 const char *consumer_label)
-{
-	struct gpiohandle_request req;
-	char *chrdev_name;
-	int fd;
-	int i;
-	int ret;
-
-	ret = asprintf(&chrdev_name, "/dev/%s", device_name);
-	if (ret < 0)
-		return -ENOMEM;
-
-	fd = open(chrdev_name, 0);
-	if (fd == -1) {
-		ret = -errno;
-		fprintf(stderr, "Failed to open %s, %s\n",
-			chrdev_name, strerror(errno));
-		goto exit_free_name;
-	}
-
-	for (i = 0; i < num_lines; i++)
-		req.lineoffsets[i] = lines[i];
-
-	req.flags = flag;
-	strcpy(req.consumer_label, consumer_label);
-	req.lines = num_lines;
-	if (flag & GPIOHANDLE_REQUEST_OUTPUT)
-		memcpy(req.default_values, data, sizeof(req.default_values));
-
-	ret = ioctl(fd, GPIO_GET_LINEHANDLE_IOCTL, &req);
-	if (ret == -1) {
-		ret = -errno;
-		fprintf(stderr, "Failed to issue %s (%d), %s\n",
-			"GPIO_GET_LINEHANDLE_IOCTL", ret, strerror(errno));
-	}
-
-	if (close(fd) == -1)
-		perror("Failed to close GPIO character device file");
-exit_free_name:
-	free(chrdev_name);
-	return ret < 0 ? ret : req.fd;
-}
 
 /**
  * gpiotools_request_line() - request gpio lines in a gpiochip
@@ -215,27 +147,6 @@ int gpiotools_get_values(const int fd, struct gpio_v2_line_values *values)
 	return ret;
 }
 
-/**
- * gpiotools_release_linehandle(): Release the line(s) of gpiochip
- * @fd:			The fd returned by
- *			gpiotools_request_linehandle().
- *
- * Return:		On success return 0;
- *			On failure return the errno.
- */
-int gpiotools_release_linehandle(const int fd)
-{
-	int ret;
-
-	ret = close(fd);
-	if (ret == -1) {
-		perror("Failed to close GPIO LINEHANDLE device file");
-		ret = -errno;
-	}
-
-	return ret;
-}
-
 /**
  * gpiotools_release_line(): Release the line(s) of gpiochip
  * @fd:			The fd returned by
diff --git a/tools/gpio/gpio-utils.h b/tools/gpio/gpio-utils.h
index 6c69a9f1c253..8af7c8ee19ce 100644
--- a/tools/gpio/gpio-utils.h
+++ b/tools/gpio/gpio-utils.h
@@ -24,12 +24,6 @@ static inline int check_prefix(const char *str, const char *prefix)
 		strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
-int gpiotools_request_linehandle(const char *device_name, unsigned int *lines,
-				 unsigned int num_lines, unsigned int flag,
-				 struct gpiohandle_data *data,
-				 const char *consumer_label);
-int gpiotools_release_linehandle(const int fd);
-
 int gpiotools_request_line(const char *device_name,
 			   unsigned int *lines,
 			   unsigned int num_lines,
-- 
2.30.0

