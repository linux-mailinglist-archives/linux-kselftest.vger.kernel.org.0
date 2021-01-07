Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F452EC870
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAGDAC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 22:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhAGDAB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 22:00:01 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4BCC0612F6;
        Wed,  6 Jan 2021 18:59:06 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c132so3823470pga.3;
        Wed, 06 Jan 2021 18:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/z5ghLEwu+8Vo34yP7ftBnMskKAhqlwuhxiVBT/nsA=;
        b=ihx/S5Ct+q+8hcbLOAUMfzYUkIugBpTMWOsnOK8SXYJeoqU5iJjgImrTPdkBEwL4Hn
         cHSaMBz/iw2jpjSAOGJwlQXgQxr60Rm2A2RgufQpuxb1FYhIEuMz5nRJ1qspvZU6BLSp
         aS1dQwn4dkQqjGr2NCHY443CngsgGmX/186gGyoyhdzM1uAGf95x/XCRNJ9v7ulandtU
         U8T7z3fI3S4nSkOG1Ei/Yirpq0GuFtE+AHIuFJkl31mr5QKcdCulXEo0JjhJjoQ3mH1s
         B1125kR+cNFjDI0Go4bobSOm5eQGO9NRC9M7d1xvZ6EQgdCvwc0lj/56Qw0v9UJQegFr
         ZHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/z5ghLEwu+8Vo34yP7ftBnMskKAhqlwuhxiVBT/nsA=;
        b=RmrNPK3ZxTlMEEHV7qRrc/tmKZnWISlcpiUHr5e2D3VXYtSbBSbjpWUCx8R06r+BxN
         x38FgHu43J7vZudT1LR8dW/oDtEcbGL8wU4SnL1YkEmQuEKasJwwSTM/Odyz7qMh7jIa
         QlUlmZRny1QysREqPiNFYs9Rr+tCte9NMnbGcwFR1zOthFr6ibq9xCvZDCN4TGkR3RXq
         QdTb8+d5Xa/RM1SXoNaYR/m10BYCBI41d7vIEJIz2Zv4idVYg9x2W1b2zxNnBnXiyPzJ
         WdVESg62uCxSsIiE8N94/HSD9opdFQR3M553dK0v+kLt1BsxK5bl0jQwFD4nrWtDRVpF
         v/GA==
X-Gm-Message-State: AOAM532yHEibFXLbh2z2u1103880FfBHlTAI49oN0wSN5u2MomSm9uw9
        2pZnNkTBKcKq4VKUMuTA7cj0WjKMGTr4yQ==
X-Google-Smtp-Source: ABdhPJzX0Z5Puqg+cfLuwmET4PdVL9ykDumJgEJBwPtSFpk2lf8UAUdrxeJd2XC/MeA0Fi20IwJ21A==
X-Received: by 2002:a65:4906:: with SMTP id p6mr7484236pgs.173.1609988345711;
        Wed, 06 Jan 2021 18:59:05 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:59:05 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 6/7] selftests: gpio: port to GPIO uAPI v2
Date:   Thu,  7 Jan 2021 10:57:30 +0800
Message-Id: <20210107025731.226017-7-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a port to the GPIO uAPI v2 interface and make it the default.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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

