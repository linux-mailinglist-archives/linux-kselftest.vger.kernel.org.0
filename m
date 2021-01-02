Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A192E8623
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhABCbr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCbr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329F6C061573;
        Fri,  1 Jan 2021 18:31:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x126so13101547pfc.7;
        Fri, 01 Jan 2021 18:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4k/oKFi0UoGvgNKJiNffJyyWwVXy9f67MkS0lyxKXfk=;
        b=nzEhXGBFxuAXTL/S0I3Aj2pNqnBbcUGhVGdLW+UMPx5erkxbb2iavWarWNP6wlo+zy
         JwZMhIIkrBwOnqynEQlJpv0hagzzYnM9wU24wHYF/AGsCvTcex+7GrIpzIspiGpbdLWT
         JjTEMV17rjXH3tVr3ZYlLix8gbtf0Eu3SkgtsXL1ZBQTgxnjTS+4p9sIJg5bkCR0rOyP
         p4OXEoPDJR04DYhEWGaznekfG4R1yWKCmZXEEz+83TM0lGHrwMsd7unrLOlL9bfXzoLY
         Lz/EyAquqzwsJzjsu0NPr2VM95IQgmjI6XjcGt7Om6NfpLaoBMn3zrEV2K1yMzkYvw4g
         PVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4k/oKFi0UoGvgNKJiNffJyyWwVXy9f67MkS0lyxKXfk=;
        b=WR5Bfj0SF6gfdZnHsG9L0BfwInZmTF7yr/srmNkYbZWUplgjNtfpITdVnoE9DZUGgZ
         p55MiM7n0rmDNN+YvvTy6KydisDOuZvTlz7CIILAj4dYgKntruraugaGv5wETbvqzMQM
         Im93TIP49Z9Lvn8uzLGgpiWt+0LNhADN5DeANkCdbTQbC8tUGI/ZIx8UM2BbozDWZBcn
         Ts30fOa/IH21Cgbrb3RZdcVZnUVVUFhx8pSDwXWLaCCXfvrx68qhKtb1B9GExwCxM0mM
         UsBhyk8naqhdBy0rjP0MHjI5oaAprvnIBB0SdF2fk33XEscYajX4iKmi9FhCLOFI7O2h
         PPPw==
X-Gm-Message-State: AOAM530kbQKiWui6QN1gnFimEr4gKlF5g1zn7eT4iDTtQTKVHQpbNrHy
        N3Tk5xZxOtPQj3lY3Sl4uAdXLYfssfTbGw==
X-Google-Smtp-Source: ABdhPJz85vlur6XQ5quCbOm1vcLRiFIfWYNopVTzE8czR0TroIKNARmji73V/bSmWZ4SIdBEDKuX9Q==
X-Received: by 2002:a63:1f4b:: with SMTP id q11mr50969764pgm.310.1609554666357;
        Fri, 01 Jan 2021 18:31:06 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:31:05 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 6/7] selftests: gpio: port to GPIO uAPI v2
Date:   Sat,  2 Jan 2021 10:29:48 +0800
Message-Id: <20210102022949.92304-7-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
References: <20210102022949.92304-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a port to the GPIO uAPI v2 interface and make it the default.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 .../testing/selftests/gpio/gpio-mockup-cdev.c | 75 +++++++++++++++++--
 tools/testing/selftests/gpio/gpio-mockup.sh   | 11 ++-
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
index 3bfd876a8b6a..e8e3d2ec662c 100644
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
index 66eed9b60963..843f829b3dd8 100755
--- a/tools/testing/selftests/gpio/gpio-mockup.sh
+++ b/tools/testing/selftests/gpio/gpio-mockup.sh
@@ -13,6 +13,7 @@ dev_type="cdev"
 module="gpio-mockup"
 verbose=
 random=
+uapi_opt=
 active_opt=
 bias_opt=
 line_set_pid=
@@ -29,6 +30,7 @@ usage()
 	echo "-r:  test random lines as well as fence posts"
 	echo "-t:  interface type:"
 	echo "      cdev (character device ABI) - default"
+	echo "      cdev_v1 (deprecated character device ABI)"
 	echo "      sysfs (deprecated SYSFS ABI)"
 	echo "-v:  verbose progress reporting"
 	exit $ksft_fail
@@ -102,7 +104,8 @@ get_line()
 {
 	release_line
 
-	$BASE/gpio-mockup-cdev $active_opt /dev/$chip $offset > /dev/null 2>&1
+	local cdev_opts=${uapi_opt}${active_opt}
+	$BASE/gpio-mockup-cdev $cdev_opts /dev/$chip $offset > /dev/null 2>&1
 	echo $?
 }
 
@@ -144,7 +147,7 @@ set_line()
 		esac
 	done
 
-	local cdev_opts=${active_opt}
+	local cdev_opts=${uapi_opt}${active_opt}
 	if [ "$val" ]; then
 		$BASE/gpio-mockup-cdev $cdev_opts -s$val /dev/$chip $offset 2>&1 >/dev/null &
 		# failure to set is detected by reading mock and toggling values
@@ -314,6 +317,10 @@ sysfs)
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

