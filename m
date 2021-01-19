Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16EB2FBE05
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404749AbhASOvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393144AbhASMdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:33:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1220C0613CF;
        Tue, 19 Jan 2021 04:31:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j12so3105931pjy.5;
        Tue, 19 Jan 2021 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cCv2wIHBUA2OBP0G0sZ8W1yCZLNMmx7yo4vsapAVUbs=;
        b=n8hJ6koBqoYIRBhYsduA+Neqlg+nVEHcSbH3TdGz6OC4y8oXOxr3ZWcoIWNBGKGkee
         avyx2rEp2QsRnpgegNSM6ntC9sxvYJGq9ICJg8L9HdjIR+xwBqYsBXsUIFjHiozFMAhQ
         yupTCXDekahLXRQnlUnvh8dkMSTua4OF9T3bRMTiIcGSS//I+qORxBZrXRYVDqbXNhBO
         5s/Cgs2pmue2RptBDayfAUEgyqSixKANDNQUhLP2OgVoOK5O/t5iTGTsnxZ6dovmetIA
         gd/dcBFA7aJT+U1Ot7tA5uIepuIzxoV5qqXzAYUmfMmXfDY6RFF09hAGDuwgRqs4vMOT
         0CNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cCv2wIHBUA2OBP0G0sZ8W1yCZLNMmx7yo4vsapAVUbs=;
        b=DA0MxVHi9Dq8x4+JUYjvhIdKEyvk2HjlHnu2ZCXiwBC5Sk1J2QSvCsWWTAzULccIIV
         J9LlhT9tL+5qnBSrfsrsYlVKGAam4TcnGfM01vIxX3W7Z9S3sTFyK0HWO2O+v5LaA5Z7
         3OVNZYNT+m3u1k0EkT8RmvAl484CKSYfn01AZ71u3+qJUy3z0a6m7Rog4CnqRcraogUD
         XiJhUXP3lmj6zvWAF/jb7Rwq9vneSAAARDgEcHwNUxYIT8f2D4r3iBnFZmm2/iWnzAuN
         QavWmB6hZrE6Cbu/Bc24obAwQ7Wy0dk0Q7U5nqPydx/tP3W1eYJ7z1sgx8EQzPLZfEB0
         qPBw==
X-Gm-Message-State: AOAM533DOdYC6o6CoqWZOesQ5iP+U153hREAgmvU2li4YylAliTp15Ls
        g1fST5TOt06JVANG161KKHmlnkxG4bI=
X-Google-Smtp-Source: ABdhPJyR/zicJHQLPdl13dvirO0HxefzsfhxWPZXnMV6aiasWHcG0ovss3HNoR05hyMgaoFQ+9JfRA==
X-Received: by 2002:a17:90a:f404:: with SMTP id ch4mr5166086pjb.78.1611059508770;
        Tue, 19 Jan 2021 04:31:48 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:48 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 5/7] tools: gpio: remove uAPI v1 code no longer used by selftests
Date:   Tue, 19 Jan 2021 20:30:57 +0800
Message-Id: <20210119123059.102004-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gpio-mockup-chardev helper has been obsoleted and removed, so also remove
the tools/gpio code that it, and nothing else, was using.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

