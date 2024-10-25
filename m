Return-Path: <linux-kselftest+bounces-20700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C249B0F5F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A6F1C221E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8057A215C6C;
	Fri, 25 Oct 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f2p8AAee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740120F3F0;
	Fri, 25 Oct 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885580; cv=none; b=fFxmFLUEbEVu7HAoswYYD1wkxX/0h8pND7ttjvXAUn8Ua4cqqQwR8z9Gka4mps8SpZOAu5sq1nrNX+crSOyMGAS4dr4KhF2c8doZdx20dlvpss0/2Lvih8y1tHRcrNQRGu0TiO3s8pdf8eFMgfbXeu8u1dBf4qKOUToVJDVigUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885580; c=relaxed/simple;
	bh=f8c7443BrlIy7kGWqHO1w3bVU9UBo745msa/mryqajY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S1YMvC2o/ELEGtvmzm0zpNnawVfkBWPK9SIcAJGZSHeZHyKqXoZ/GiOkF07dw/ZQXeX7+RLWO5IJAtCMexMU8s1CpHf5OISKBArOiM/ALEL3q6iu3FROSMO81WbZxvAYr7qxZMAxoaxBdDBlB5SQI1bIzyATgZiFTrxHxe24Ujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f2p8AAee; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729885576;
	bh=f8c7443BrlIy7kGWqHO1w3bVU9UBo745msa/mryqajY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f2p8AAeeEWHrq78LD1YvK3uDCGFvRD3XFQmXKcObGF+E9KS4NKAU55wZFkuX7KD6v
	 08WsSx1fR4bA7bYVkjHF9iAgpMqBaZRhNG+c4J0cZKGUkuUrIjEV/HzCihMoDQLkzO
	 8JkoXhdUtKZv36mPwTf8icc6mTFuvNSyjmzlpAZoFfraSdUh5HJ4IfrXWhtTfebpdV
	 XBbBVOZZwueWF6BfQ0G6m1k+u/onX9n+dvPFIjEeKrpSdN5kLg3BuxK3P5VEy5CUV8
	 5ZBq1nc7OBkHovb7uD48LPxmmYHp+22q9MfKrySgpCRZIT8OrqQKgfNuWfxlZ/s5ew
	 PdNdMwd1V1Ogw==
Received: from [192.168.1.54] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3AD217E3756;
	Fri, 25 Oct 2024 21:46:14 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 25 Oct 2024 15:45:39 -0400
Subject: [PATCH RFC v2 4/5] selftest: gpio: Add wait flag to
 gpio-mockup-cdev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241025-kselftest-gpio-set-get-config-v2-4-040d748840bb@collabora.com>
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
In-Reply-To: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
To: Sean Wang <sean.wang@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mediatek@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add a -w flag to the gpio-mockup-cdev utility that causes the program to
wait until a signal is received before exiting, even when its behavior
is to retrieve the GPIO value of the line. This allows using this
utility to keep a GPIO line configured even when in input mode, which
will be relied on in other tests.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/gpio/gpio-mockup-cdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-cdev.c b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
index d1640f44f8ac2a6fda7a5f75605f83fcaa165dc0..f674dcafa60a02cb1739f3cfae8963dc09efba74 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-cdev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-cdev.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <linux/gpio.h>
+#include <stdbool.h>
 
 #define CONSUMER	"gpio-mockup-cdev"
 
@@ -95,6 +96,7 @@ static void usage(char *prog)
 	printf("               (default is to leave bias unchanged):\n");
 	printf("        -l: set line active low (default is active high)\n");
 	printf("        -s: set line value (default is to get line value)\n");
+	printf("        -w: wait even in get mode\n");
 	printf("        -u: uAPI version to use (default is 2)\n");
 	exit(-1);
 }
@@ -120,13 +122,14 @@ int main(int argc, char *argv[])
 	unsigned int offset, val = 0, abiv;
 	uint32_t flags_v1;
 	uint64_t flags_v2;
+	bool wait = false;
 
 	abiv = 2;
 	ret = 0;
 	flags_v1 = GPIOHANDLE_REQUEST_INPUT;
 	flags_v2 = GPIO_V2_LINE_FLAG_INPUT;
 
-	while ((opt = getopt(argc, argv, "lb:s:u:")) != -1) {
+	while ((opt = getopt(argc, argv, "lb:s:u:w")) != -1) {
 		switch (opt) {
 		case 'l':
 			flags_v1 |= GPIOHANDLE_REQUEST_ACTIVE_LOW;
@@ -150,10 +153,14 @@ int main(int argc, char *argv[])
 			flags_v1 |= GPIOHANDLE_REQUEST_OUTPUT;
 			flags_v2 &= ~GPIO_V2_LINE_FLAG_INPUT;
 			flags_v2 |= GPIO_V2_LINE_FLAG_OUTPUT;
+			wait = true;
 			break;
 		case 'u':
 			abiv = atoi(optarg);
 			break;
+		case 'w':
+			wait = true;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -183,9 +190,10 @@ int main(int argc, char *argv[])
 		return lfd;
 	}
 
-	if (flags_v2 & GPIO_V2_LINE_FLAG_OUTPUT) {
+	if (wait)
 		wait_signal();
-	} else {
+
+	if (flags_v2 & GPIO_V2_LINE_FLAG_INPUT) {
 		if (abiv == 1)
 			ret = get_value_v1(lfd);
 		else

-- 
2.47.0


