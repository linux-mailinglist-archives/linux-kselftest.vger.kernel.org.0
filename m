Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C992FBA4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 15:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404768AbhASOvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393146AbhASMdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 07:33:13 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE515C0613D3;
        Tue, 19 Jan 2021 04:31:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so12852411pgl.10;
        Tue, 19 Jan 2021 04:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO4FgoQlfT5qC78SA/iF3xAy8MoN9OhEKSPd1TRY9cI=;
        b=IaOZMO1t2gJVw6vcWJASbjqEavOIm4Zghpnif9K619FUqWYbl6mUr2tU9TML/cwdWS
         bwl8iqxUZgpGVrzdJsaIuN/OklqTg+pJYYXIkwSPqP0pFzv6NBf128K1pjoojVfXSJ2l
         d8NVhiOGH1h+J1NLQEMEE12FtK66O2FwOfyrsgGff4QkM5HBn8x5wwAc03L3vJdFwoHS
         2HsAKznZyseE+VB1n/hb0TDySy4h7yWUN2aCcoWd8TRFJGxdqiv2bYvLnHdNXs/xpp7s
         hnrpcJHsu2DIhF9BTtCmJmI6c8fAOXPlCtTun73AW35SRyDmmPRXlIBlV+7hrzf6owjl
         ggEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO4FgoQlfT5qC78SA/iF3xAy8MoN9OhEKSPd1TRY9cI=;
        b=VMugaEnb//8uJzVribFSq+HOlUKFCH9ieCARzY9tr/gDFxxjF9ZvEdbjm/3wPNjkLj
         UWSDh7xF7b79eXhI5vwWdMH5FWgKZZWfyYXFD7jp/FbduX3C2mVKcpm58Z5C9+oZZIgL
         /7Lp2uUAz2iHyk3mCvH+FVfkGKE+AhXvbKRt5r0BehX2/QbAKRSYeGyBA3PGOK8qzHi0
         fGDdK2jle46q8T/7fBj732eFz+hLgAp7WjCOTX6NZ+EvMdIsSIamx4s4gktHF81mODx6
         Sl1l8rqPYpTrNEOBJS6T5YzdffDKp+qLzRKy0k/Tglfypbn2alvnRDPGEhgtwvEVob0i
         b1Rg==
X-Gm-Message-State: AOAM530wfcKYFzfz0tLSJusGOMnRCEeYQwuSXNtK6epVYNcYTMsYYzMR
        3admLf69ZHXj4AKzOhTatCGnW+C0JFU=
X-Google-Smtp-Source: ABdhPJwslojPn+O2Hb4zttn2fRuPOWF/Lef6EFBDPvuXeCLXae42ioiQs2MkYGIHqKsws0HeIf1qFw==
X-Received: by 2002:a62:7fc1:0:b029:19f:1dab:5029 with SMTP id a184-20020a627fc10000b029019f1dab5029mr3981033pfd.13.1611059513648;
        Tue, 19 Jan 2021 04:31:53 -0800 (PST)
Received: from sol.lan (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id q4sm19283052pgr.39.2021.01.19.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:31:53 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 6/7] selftests: gpio: port to GPIO uAPI v2
Date:   Tue, 19 Jan 2021 20:30:58 +0800
Message-Id: <20210119123059.102004-7-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119123059.102004-1-warthog618@gmail.com>
References: <20210119123059.102004-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a port to the GPIO uAPI v2 interface and make it the default.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 75 +++++++++++++++++--
 tools/testing/selftests/gpio/gpio-mockup.sh   | 11 ++-
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
index 3a7fc3ac1349..e83eac71621a 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-cdev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
@@ -18,6 +18,44 @@
 
 #define CONSUMER	"gpio-mockup-cdev"
 
+static int request_line_v2(int cfd, unsigned int offset,
+			   uint64_t flags, unsigned int val)
+{
+	struct gpio_v2_line_request req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.num_lines = 1;
+	req.offsets[0] = offset;
+	req.config.flags = flags;
+	strcpy(req.consumer, CONSUMER);
+	if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
+		req.config.num_attrs = 1;
+		req.config.attrs[0].mask = 1;
+		req.config.attrs[0].attr.id = GPIO_V2_LINE_ATTR_ID_OUTPUT_VALUES;
+		if (val)
+			req.config.attrs[0].attr.values = 1;
+	}
+	ret = ioctl(cfd, GPIO_V2_GET_LINE_IOCTL, &req);
+	if (ret == -1)
+		return -errno;
+	return req.fd;
+}
+
+
+static int get_value_v2(int lfd)
+{
+	struct gpio_v2_line_values vals;
+	int ret;
+
+	memset(&vals, 0, sizeof(vals));
+	vals.mask = 1;
+	ret = ioctl(lfd, GPIO_V2_LINE_GET_VALUES_IOCTL, &vals);
+	if (ret == -1)
+		return -errno;
+	return vals.bits & 0x1;
+}
+
 static int request_line_v1(int cfd, unsigned int offset,
 			   uint32_t flags, unsigned int val)
 {
@@ -57,6 +95,7 @@ static void usage(char *prog)
 	printf("               (default is to leave bias unchanged):\n");
 	printf("        -l: set line active low (default is active high)\n");
 	printf("        -s: set line value (default is to get line value)\n");
+	printf("        -u: uAPI version to use (default is 2)\n");
 	exit(-1);
 }
 
@@ -78,29 +117,42 @@ int main(int argc, char *argv[])
 {
 	char *chip;
 	int opt, ret, cfd, lfd;
-	unsigned int offset, val;
+	unsigned int offset, val, abiv;
 	uint32_t flags_v1;
+	uint64_t flags_v2;
 
+	abiv = 2;
 	ret = 0;
 	flags_v1 = GPIOHANDLE_REQUEST_INPUT;
+	flags_v2 = GPIO_V2_LINE_FLAG_INPUT;
 
 	while ((opt = getopt(argc, argv, "lb:s:u:")) != -1) {
 		switch (opt) {
 		case 'l':
 			flags_v1 |= GPIOHANDLE_REQUEST_ACTIVE_LOW;
+			flags_v2 |= GPIO_V2_LINE_FLAG_ACTIVE_LOW;
 			break;
 		case 'b':
-			if (strcmp("pull-up", optarg) == 0)
+			if (strcmp("pull-up", optarg) == 0) {
 				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_UP;
-			else if (strcmp("pull-down", optarg) == 0)
+				flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
+			} else if (strcmp("pull-down", optarg) == 0) {
 				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_PULL_DOWN;
-			else if (strcmp("disabled", optarg) == 0)
+				flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
+			} else if (strcmp("disabled", optarg) == 0) {
 				flags_v1 |= GPIOHANDLE_REQUEST_BIAS_DISABLE;
+				flags_v2 |= GPIO_V2_LINE_FLAG_BIAS_DISABLED;
+			}
 			break;
 		case 's':
 			val = atoi(optarg);
 			flags_v1 &= ~GPIOHANDLE_REQUEST_INPUT;
 			flags_v1 |= GPIOHANDLE_REQUEST_OUTPUT;
+			flags_v2 &= ~GPIO_V2_LINE_FLAG_INPUT;
+			flags_v2 |= GPIO_V2_LINE_FLAG_OUTPUT;
+			break;
+		case 'u':
+			abiv = atoi(optarg);
 			break;
 		default:
 			usage(argv[0]);
@@ -119,7 +171,10 @@ int main(int argc, char *argv[])
 		return -errno;
 	}
 
-	lfd = request_line_v1(cfd, offset, flags_v1, val);
+	if (abiv == 1)
+		lfd = request_line_v1(cfd, offset, flags_v1, val);
+	else
+		lfd = request_line_v2(cfd, offset, flags_v2, val);
 
 	close(cfd);
 
@@ -128,10 +183,14 @@ int main(int argc, char *argv[])
 		return lfd;
 	}
 
-	if (flags_v1 & GPIOHANDLE_REQUEST_OUTPUT)
+	if (flags_v2 & GPIO_V2_LINE_FLAG_OUTPUT) {
 		wait_signal();
-	else
-		ret = get_value_v1(lfd);
+	} else {
+		if (abiv == 1)
+			ret = get_value_v1(lfd);
+		else
+			ret = get_value_v2(lfd);
+	}
 
 	close(lfd);
 
diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/selftests/gpio/gpio-mockup.sh
index 0aa8e4294de1..0d6c5f7f95d2 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -14,6 +14,7 @@ module="gpio-mockup"
 verbose=
 full_test=
 random=
+uapi_opt=
 active_opt=
 bias_opt=
 line_set_pid=
@@ -30,6 +31,7 @@ usage()
 	echo "-r:  test random lines as well as fence posts"
 	echo "-t:  interface type:"
 	echo "      cdev (character device ABI) - default"
+	echo "      cdev_v1 (deprecated character device ABI)"
 	echo "      sysfs (deprecated SYSFS ABI)"
 	echo "-v:  verbose progress reporting"
 	exit $ksft_fail
@@ -100,7 +102,8 @@ get_line()
 {
 	release_line
 
-	$BASE/gpio-mockup-cdev $active_opt /dev/$chip $offset
+	local cdev_opts=${uapi_opt}${active_opt}
+	$BASE/gpio-mockup-cdev $cdev_opts /dev/$chip $offset
 	echo $?
 }
 
@@ -142,7 +145,7 @@ set_line()
 		esac
 	done
 
-	local cdev_opts=${active_opt}
+	local cdev_opts=${uapi_opt}${active_opt}
 	if [ "$val" ]; then
 		$BASE/gpio-mockup-cdev $cdev_opts -s$val /dev/$chip $offset &
 		# failure to set is detected by reading mockup and toggling values
@@ -340,6 +343,10 @@ sysfs)
 	source $BASE/gpio-mockup-sysfs.sh
 	echo "WARNING: gpio sysfs ABI is deprecated."
 	;;
+cdev_v1)
+	echo "WARNING: gpio cdev ABI v1 is deprecated."
+	uapi_opt="-u1 "
+	;;
 cdev)
 	;;
 *)
-- 
2.30.0

