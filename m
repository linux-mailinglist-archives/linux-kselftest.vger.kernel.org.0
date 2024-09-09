Return-Path: <linux-kselftest+bounces-17540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179199721EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73641F24324
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7985189906;
	Mon,  9 Sep 2024 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A+pCizIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01DE189518;
	Mon,  9 Sep 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907099; cv=none; b=q3/ZjUIM1XO4PAh3caxob9/TCM0sf7mAYRR7iUuwwARhiMTe9STiWKGyz8h5xNVivGgJv/JkuMRa8h3pMvSRbwdaUW0hvB24iWdraSaPz0p51X8ngy5nxHJl2lwf1Z8QdmGxlPngG06B44Yq3u4v0cMSd9gCUKYc0JIaXZzLxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907099; c=relaxed/simple;
	bh=V9HT+WFFbtvEODO7OkoAPU0v0W0Jmx2Vc+VBObPr39M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGtHQaB22+fDjd+yM+tWKpJWSrBdxTqI787fJEGS1onP2ED9YMvneMS9Buldyd5xS1s7374fRcDsx0MZNOo+J24lm3bF9GBb2KodNtUcqpE/vQVuGwq3a70PFw2uknpoe5KYOhaQUdxB5hhNF3WWioeXr4E6JU7lolI1Lo/yEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A+pCizIE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725907095;
	bh=V9HT+WFFbtvEODO7OkoAPU0v0W0Jmx2Vc+VBObPr39M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A+pCizIEC6YstPQ3l+iqEHe024H211npMNG0BUJmMNDTe4frB3G1Bigc/1YiYXY8w
	 FyuznWXFONgb823F7NQzNTWLbulMhp14dWpwrZSHrWeYap6B2pZmKsPOR9I0KFkjI8
	 xoZmbHVW3itf5hqCx4TWVR4SA3k1cc6rDkQhym1Lpl2UMvdKTzi2/bktktZZ9hb09F
	 AL10duXmNzRKHTNUz0AhfoA7AbDpVeU31luw5LhzeBfszoIG5WWpPEX0BT/8qVCzlF
	 pODNtPSNigKoWIMdhLyihKTbpIP+f+M8i8jq8G354FlNCiOv/ej7HdET4e6ifYEL2j
	 1sOgI0iE6th5w==
Received: from [192.168.1.95] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB12017E35FD;
	Mon,  9 Sep 2024 20:38:13 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 09 Sep 2024 14:37:32 -0400
Subject: [PATCH RFC 1/3] pinctrl: mediatek: paris: Expose more
 configurations to GPIO set_config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-kselftest-gpio-set-get-config-v1-1-16a065afc3c1@collabora.com>
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

Currently the set_config callback in the gpio_chip registered by the
pinctrl_paris driver only supports PIN_CONFIG_INPUT_DEBOUNCE, despite
many other configurations already being implemented and available
through the pinctrl API for configuration of pins by the Devicetree and
other drivers.

Expose all configurations currently implemented through the GPIO API so
they can also be set from userspace, which is particularly useful to
allow testing them from userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index e12316c42698..668f8055a544 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -255,10 +255,9 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	return err;
 }
 
-static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+static int mtk_pinconf_set(struct mtk_pinctrl *hw, unsigned int pin,
 			   enum pin_config_param param, u32 arg)
 {
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
 	int err = -ENOTSUPP;
 	u32 reg;
@@ -795,7 +794,7 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
-		ret = mtk_pinconf_set(pctldev, grp->pin,
+		ret = mtk_pinconf_set(hw, grp->pin,
 				      pinconf_to_config_param(configs[i]),
 				      pinconf_to_config_argument(configs[i]));
 		if (ret < 0)
@@ -937,18 +936,19 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
 	const struct mtk_pin_desc *desc;
-	u32 debounce;
+	enum pin_config_param param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
 
 	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
 
-	if (!hw->eint ||
-	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
-	    desc->eint.eint_n == EINT_NA)
-		return -ENOTSUPP;
+	if (param == PIN_CONFIG_INPUT_DEBOUNCE) {
+		if (!hw->eint || desc->eint.eint_n == EINT_NA)
+			return -ENOTSUPP;
 
-	debounce = pinconf_to_config_argument(config);
+		return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, arg);
+	}
 
-	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
+	return mtk_pinconf_set(hw, offset, param, arg);
 }
 
 static int mtk_build_gpiochip(struct mtk_pinctrl *hw)

-- 
2.46.0


