Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103AD2EC86B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbhAGC75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 21:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbhAGC74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:56 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171A4C0612F1;
        Wed,  6 Jan 2021 18:58:37 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q7so1908261pgm.5;
        Wed, 06 Jan 2021 18:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hHIZlGSfUuczSVDjUPxY1V0FnUlIA+ur4GNSNrQi9ug=;
        b=J4ME7Llyo8QsYParyZ5OEf1HdrMIDEgEZC/V9V/He8qualnr/e1ARsg3HVgYg9jfTG
         am+AvXR4xZ5tmxUr1pOI6iiqVEkNQtD9akjkoqJjp1y1CxYRrlO49Q6k2I+6cLmtuREk
         GB4pzV9V2kytTgx5WOoY8OXJcVZBwhxAi7ThC1I0HtH4MIdemytYeA/k37YpjhPOEE+t
         sfHbhz7N3RtV1myXhGqRbmult8e2XHDPoD83nbtFaPHbBKiYdl04gm0PVDt+GLLXaE35
         i2W1p0GOxGAjQb3NNmvGycCuj1AYuzB1qE5J7s+t2ddwp+5XNgVDUtI/OJb5uogFg2/C
         vQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hHIZlGSfUuczSVDjUPxY1V0FnUlIA+ur4GNSNrQi9ug=;
        b=IjbdHcY6eg4PcUw5lR3cVmrjWlqwXrpSEvdP9qjBCacWmzIul9b2kLsBtKRunNKMoO
         h72NoS7PVgrqb8grDUxxTD8j4B0BR5qP5WtHA7F/EgmNGZW4plQkqcQNLSVqtFvc8Yuc
         2BejZU+wsi+aGFw9x+YOVRkOOv8srMah1J8x4F5+58/GErS2Cz6Og62d7ABzfFzjO3F6
         LA7CBcaODguQthXuylqAs+B5M0Ap73/aaak1QUsO0inQ5o3v3eP4zxOJAREqOWfyNOgI
         L+RhOdXjkYxNLIaZdYQV44PLxatYbMB4j3HedjqhfWp8FxBwC4H1rVbOzwbMQkrg01T4
         8nrw==
X-Gm-Message-State: AOAM531i3p4t6U6m6+szSUJWYZzqhtdOlp0rWg2uwp8mzR4ADmseiHry
        sIwZAc6hde8dE/NApeHV9lvV4E2g0vONAw==
X-Google-Smtp-Source: ABdhPJzcogu0Kc8wPpJtUriIeTSdY2/prMe880UaebCWK+0Ph2MY4jnJyfDo3iSNReoqzJHU5lT+hQ==
X-Received: by 2002:aa7:978c:0:b029:1a9:1989:a07 with SMTP id o12-20020aa7978c0000b02901a919890a07mr7091585pfp.30.1609988316088;
        Wed, 06 Jan 2021 18:58:36 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:58:35 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 2/7] selftests: gpio: remove obsolete gpio-mockup-chardev.c
Date:   Thu,  7 Jan 2021 10:57:26 +0800
Message-Id: <20210107025731.226017-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO selftests have changed to new gpio-mockup-cdev helper, so remove
old gpio-mockup-chardev helper.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../selftests/gpio/gpio-mockup-chardev.c      | 323 ------------------
 1 file changed, 323 deletions(-)
 delete mode 100644 tools/testing/selftests/gpio/gpio-mockup-chardev.c

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
deleted file mode 100644
index 73ead8828d3a..000000000000
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ /dev/null
@@ -1,323 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * GPIO chardev test helper
- *
- * Copyright (C) 2016 Bamvor Jian Zhang
- */
-
-#define _GNU_SOURCE
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-#include <getopt.h>
-#include <sys/ioctl.h>
-#include <libmount.h>
-#include <err.h>
-#include <dirent.h>
-#include <linux/gpio.h>
-#include "../../../gpio/gpio-utils.h"
-
-#define CONSUMER	"gpio-selftest"
-#define	GC_NUM		10
-enum direction {
-	OUT,
-	IN
-};
-
-static int get_debugfs(char **path)
-{
-	struct libmnt_context *cxt;
-	struct libmnt_table *tb;
-	struct libmnt_iter *itr = NULL;
-	struct libmnt_fs *fs;
-	int found = 0, ret;
-
-	cxt = mnt_new_context();
-	if (!cxt)
-		err(EXIT_FAILURE, "libmount context allocation failed");
-
-	itr = mnt_new_iter(MNT_ITER_FORWARD);
-	if (!itr)
-		err(EXIT_FAILURE, "failed to initialize libmount iterator");
-
-	if (mnt_context_get_mtab(cxt, &tb))
-		err(EXIT_FAILURE, "failed to read mtab");
-
-	while (mnt_table_next_fs(tb, itr, &fs) == 0) {
-		const char *type = mnt_fs_get_fstype(fs);
-
-		if (!strcmp(type, "debugfs")) {
-			found = 1;
-			break;
-		}
-	}
-	if (found) {
-		ret = asprintf(path, "%s/gpio", mnt_fs_get_target(fs));
-		if (ret < 0)
-			err(EXIT_FAILURE, "failed to format string");
-	}
-
-	mnt_free_iter(itr);
-	mnt_free_context(cxt);
-
-	if (!found)
-		return -1;
-
-	return 0;
-}
-
-static int gpio_debugfs_get(const char *consumer, int *dir, int *value)
-{
-	char *debugfs;
-	FILE *f;
-	char *line = NULL;
-	size_t len = 0;
-	char *cur;
-	int found = 0;
-
-	if (get_debugfs(&debugfs) != 0)
-		err(EXIT_FAILURE, "debugfs is not mounted");
-
-	f = fopen(debugfs, "r");
-	if (!f)
-		err(EXIT_FAILURE, "read from gpio debugfs failed");
-
-	/*
-	 * gpio-2   (                    |gpio-selftest               ) in  lo
-	 */
-	while (getline(&line, &len, f) != -1) {
-		cur = strstr(line, consumer);
-		if (cur == NULL)
-			continue;
-
-		cur = strchr(line, ')');
-		if (!cur)
-			continue;
-
-		cur += 2;
-		if (!strncmp(cur, "out", 3)) {
-			*dir = OUT;
-			cur += 4;
-		} else if (!strncmp(cur, "in", 2)) {
-			*dir = IN;
-			cur += 4;
-		}
-
-		if (!strncmp(cur, "hi", 2))
-			*value = 1;
-		else if (!strncmp(cur, "lo", 2))
-			*value = 0;
-
-		found = 1;
-		break;
-	}
-	free(debugfs);
-	fclose(f);
-	free(line);
-
-	if (!found)
-		return -1;
-
-	return 0;
-}
-
-static struct gpiochip_info *list_gpiochip(const char *gpiochip_name, int *ret)
-{
-	struct gpiochip_info *cinfo;
-	struct gpiochip_info *current;
-	const struct dirent *ent;
-	DIR *dp;
-	char *chrdev_name;
-	int fd;
-	int i = 0;
-
-	cinfo = calloc(sizeof(struct gpiochip_info) * 4, GC_NUM + 1);
-	if (!cinfo)
-		err(EXIT_FAILURE, "gpiochip_info allocation failed");
-
-	current = cinfo;
-	dp = opendir("/dev");
-	if (!dp) {
-		*ret = -errno;
-		goto error_out;
-	} else {
-		*ret = 0;
-	}
-
-	while (ent = readdir(dp), ent) {
-		if (check_prefix(ent->d_name, "gpiochip")) {
-			*ret = asprintf(&chrdev_name, "/dev/%s", ent->d_name);
-			if (*ret < 0)
-				goto error_out;
-
-			fd = open(chrdev_name, 0);
-			if (fd == -1) {
-				*ret = -errno;
-				fprintf(stderr, "Failed to open %s\n",
-					chrdev_name);
-				goto error_close_dir;
-			}
-			*ret = ioctl(fd, GPIO_GET_CHIPINFO_IOCTL, current);
-			if (*ret == -1) {
-				perror("Failed to issue CHIPINFO IOCTL\n");
-				goto error_close_dir;
-			}
-			close(fd);
-			if (strcmp(current->label, gpiochip_name) == 0
-			    || check_prefix(current->label, gpiochip_name)) {
-				*ret = 0;
-				current++;
-				i++;
-			}
-		}
-	}
-
-	if ((!*ret && i == 0) || *ret < 0) {
-		free(cinfo);
-		cinfo = NULL;
-	}
-	if (!*ret && i > 0) {
-		cinfo = realloc(cinfo, sizeof(struct gpiochip_info) * 4 * i);
-		*ret = i;
-	}
-
-error_close_dir:
-	closedir(dp);
-error_out:
-	if (*ret < 0)
-		err(EXIT_FAILURE, "list gpiochip failed: %s", strerror(*ret));
-
-	return cinfo;
-}
-
-int gpio_pin_test(struct gpiochip_info *cinfo, int line, int flag, int value)
-{
-	struct gpiohandle_data data;
-	unsigned int lines[] = {line};
-	int fd;
-	int debugfs_dir = IN;
-	int debugfs_value = 0;
-	int ret;
-
-	data.values[0] = value;
-	ret = gpiotools_request_linehandle(cinfo->name, lines, 1, flag, &data,
-					   CONSUMER);
-	if (ret < 0)
-		goto fail_out;
-	else
-		fd = ret;
-
-	ret = gpio_debugfs_get(CONSUMER, &debugfs_dir, &debugfs_value);
-	if (ret) {
-		ret = -EINVAL;
-		goto fail_out;
-	}
-	if (flag & GPIOHANDLE_REQUEST_INPUT) {
-		if (debugfs_dir != IN) {
-			errno = -EINVAL;
-			ret = -errno;
-		}
-	} else if (flag & GPIOHANDLE_REQUEST_OUTPUT) {
-		if (flag & GPIOHANDLE_REQUEST_ACTIVE_LOW)
-			debugfs_value = !debugfs_value;
-
-		if (!(debugfs_dir == OUT && value == debugfs_value)) {
-			errno = -EINVAL;
-			ret = -errno;
-		}
-	}
-	gpiotools_release_linehandle(fd);
-
-fail_out:
-	if (ret)
-		err(EXIT_FAILURE, "gpio<%s> line<%d> test flag<0x%x> value<%d>",
-		    cinfo->name, line, flag, value);
-
-	return ret;
-}
-
-void gpio_pin_tests(struct gpiochip_info *cinfo, unsigned int line)
-{
-	printf("line<%d>", line);
-	gpio_pin_test(cinfo, line, GPIOHANDLE_REQUEST_OUTPUT, 0);
-	printf(".");
-	gpio_pin_test(cinfo, line, GPIOHANDLE_REQUEST_OUTPUT, 1);
-	printf(".");
-	gpio_pin_test(cinfo, line,
-		      GPIOHANDLE_REQUEST_OUTPUT | GPIOHANDLE_REQUEST_ACTIVE_LOW,
-		      0);
-	printf(".");
-	gpio_pin_test(cinfo, line,
-		      GPIOHANDLE_REQUEST_OUTPUT | GPIOHANDLE_REQUEST_ACTIVE_LOW,
-		      1);
-	printf(".");
-	gpio_pin_test(cinfo, line, GPIOHANDLE_REQUEST_INPUT, 0);
-	printf(".");
-}
-
-/*
- * ./gpio-mockup-chardev gpio_chip_name_prefix is_valid_gpio_chip
- * Return 0 if successful or exit with EXIT_FAILURE if test failed.
- * gpio_chip_name_prefix: The prefix of gpiochip you want to test. E.g.
- *			  gpio-mockup
- * is_valid_gpio_chip:	  Whether the gpio_chip is valid. 1 means valid,
- *			  0 means invalid which could not be found by
- *			  list_gpiochip.
- */
-int main(int argc, char *argv[])
-{
-	char *prefix;
-	int valid;
-	struct gpiochip_info *cinfo;
-	struct gpiochip_info *current;
-	int i;
-	int ret;
-
-	if (argc < 3) {
-		printf("Usage: %s prefix is_valid", argv[0]);
-		exit(EXIT_FAILURE);
-	}
-
-	prefix = argv[1];
-	valid = strcmp(argv[2], "true") == 0 ? 1 : 0;
-
-	printf("Test gpiochip %s: ", prefix);
-	cinfo = list_gpiochip(prefix, &ret);
-	if (!cinfo) {
-		if (!valid && ret == 0) {
-			printf("Invalid test successful\n");
-			ret = 0;
-			goto out;
-		} else {
-			ret = -EINVAL;
-			goto out;
-		}
-	} else if (cinfo && !valid) {
-		ret = -EINVAL;
-		goto out;
-	}
-	current = cinfo;
-	for (i = 0; i < ret; i++) {
-		gpio_pin_tests(current, 0);
-		gpio_pin_tests(current, current->lines - 1);
-		gpio_pin_tests(current, random() % current->lines);
-		current++;
-	}
-	ret = 0;
-	printf("successful\n");
-
-out:
-	if (ret)
-		fprintf(stderr, "gpio<%s> test failed\n", prefix);
-
-	if (cinfo)
-		free(cinfo);
-
-	if (ret)
-		exit(EXIT_FAILURE);
-
-	return ret;
-}
-- 
2.30.0

