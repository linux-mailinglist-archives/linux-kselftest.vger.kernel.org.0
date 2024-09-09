Return-Path: <linux-kselftest+bounces-17541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1149721F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9B5D1F23DC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213B189BA6;
	Mon,  9 Sep 2024 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MOyVqPcq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F31898F7;
	Mon,  9 Sep 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907101; cv=none; b=t4HL7Srx1hc+xJjE0642TWVqTH6jXNYw4WOCq7aFNaZtfFLbX2oByKk8P1BJE714OfTSmjecDnf9VuLN5bKOhCnJSmkHmR4m+EAEyCp4ayrnSdS9Pe1OgpPwLbHaCrrmJMCENJVJkJsrwZf7AuYzzBvXrgQsudGvNbSu77oILRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907101; c=relaxed/simple;
	bh=NADRXRk73DSEcKHQQvni0lrWb3AK/hH7vJ+xsFaEuFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NPQop0By5Q6SrgcVgl09l8XymZx+iEVY7x2rJLscVCQw4sTdFsQ89i3g7isByhmcfpXf4SSKhykBaUKv4qMScPMvXA2Vzum9FMRmFJjEokneRPFq9yKuppDM3N+fT1nK22klEZ/eFZOUK/Ym2UzralLaDukRkMWZYkNCfGePbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MOyVqPcq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725907097;
	bh=NADRXRk73DSEcKHQQvni0lrWb3AK/hH7vJ+xsFaEuFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOyVqPcqOprLfzy/XadLU8XC5fbGGQO9ILN+44UJ7vdDvadezUBuxbfg6endteo2I
	 4ngJRt9Pe/psTrCGqbHs5Jj2yuzFUo6Z5VLW+i944LZy/tEylnfVCDx51TqCxoMHoX
	 pZeE0h8ej9VzktzoGE66zSZKXLEOyrw9oyQNp7kDbRiq83xI3vHjXYpMqDZUnv7EUB
	 MthblXGFoaEM8MTt7WanuicQ/DPHKMqNl3C1e7j+WFBtxMz6iuFyIUY/quSwqc9MEk
	 /eDtiM8FfrvIAboZc8bdR5NjWZzSyrCTuUptoWQY6/8JtmwnBDhUHGdQzD5R9l6u57
	 Q2ALrQ9fqVriw==
Received: from [192.168.1.95] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 82F8917E35FF;
	Mon,  9 Sep 2024 20:38:15 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Sep 2024 14:37:33 -0400
Subject: [PATCH RFC 2/3] selftest: gpio: Add wait flag to gpio-mockup-cdev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-kselftest-gpio-set-get-config-v1-2-16a065afc3c1@collabora.com>
References: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
In-Reply-To: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
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
X-Mailer: b4 0.14.1

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
index d1640f44f8ac..f674dcafa60a 100644
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
2.46.0


