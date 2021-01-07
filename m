Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72C22EC85F
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAGC7g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 21:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAGC7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0BEC0612EF;
        Wed,  6 Jan 2021 18:59:00 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w6so2978780pfu.1;
        Wed, 06 Jan 2021 18:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M28N0P5hDzLpDgJlVAVNR6bG1on+WpV10HCIOZozDlU=;
        b=KIQSZp96Vjw99b/hanudxfI0qagW+t/fgaoUTqOFuTe8mLMjcKmSHg79bCEeqZo/6H
         9Bv+cjNnz1CHS24SgALV8GDcFl+z+66IQJQkvn6UuG4nJI5Q1FdirEwscv/5cER6vW0+
         l5f63R1UBFKzMOqHgUaQGlIanJMOojIpe+EGHSyCFz64QHUNjz1O85X/l8SdVxx2UYOB
         p9kd3widyZ14mY5DikFRCTUjnJs2HoEWuJmiyBhWww1R+IUjgMDdGDwsSkLlp77c2mvt
         4vgxeLpHu0E72UjNpL4wBhW34orgZexWALA/ZVA1zF7jQq08QjKsr6M7aw1C6UOcpZnd
         yv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M28N0P5hDzLpDgJlVAVNR6bG1on+WpV10HCIOZozDlU=;
        b=JzghGjQ6XMUBPcx2NamNByA7+sP5EIwI/o4sqsbNmnReDvtz3RMh6RFb2VsWSzl8Xf
         EeZS+n3GJ9N1i4c/j61DbXMXkVVNbFBfZxfGb/osZRhqgdRqiYX3R3VwJiKbarmwqhH7
         y+k7aFCs2Q2jopuDYO46oYyp7M4rbnaLoRTsMNCAwO0aVgX7cwHaeKHm9tkIvrMrgzV8
         8juWxtDWbZKCzwvHTPGZq/aoB23ThVLivSDGNenLHalStuayBFY9N7haFzxj+OHLsINI
         lh1OUBUerMwEvgCbCLnG+eF1/TwcKUdAVOLsKATDX39iNNyTsoUzdzFuFxHOoXkD7GZC
         891Q==
X-Gm-Message-State: AOAM530Ze08NnCikRh/B5ql1MJUHwIzMtTGlZWi+I1xsPx6CtZs5blQ7
        hqOHbHIOmR28nK6pq3dOzHtzrdj0RRyl2w==
X-Google-Smtp-Source: ABdhPJxJBxW0vkAXLTTzojxJQw323ODrRU31B8Am0G7tXMDi/ealh5wlF9S+ZM/SmOkouYxl9AlBSQ==
X-Received: by 2002:a62:c504:0:b029:1a5:b198:18dc with SMTP id j4-20020a62c5040000b02901a5b19818dcmr6897705pfg.79.1609988339225;
        Wed, 06 Jan 2021 18:58:59 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:58:58 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 5/7] tools: gpio: remove uAPI v1 code no longer used by selftests
Date:   Thu,  7 Jan 2021 10:57:29 +0800
Message-Id: <20210107025731.226017-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gpio-mockup-chardev helper has been obsoleted and removed, so also remove
the tools/gpio code that it, and nothing else, was using.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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

