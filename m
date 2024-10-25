Return-Path: <linux-kselftest+bounces-20699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4B9B0F5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC8828437E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BF215C4F;
	Fri, 25 Oct 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UvWdNBT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588F21441D;
	Fri, 25 Oct 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885578; cv=none; b=DnMptDIv8LXspmMwvn+YChG61E3kQOk3i2QWzgntON0dZVeR1gQJ2FxJjhrdJdDqXfOIXMX4Ln86f0Xzx1C0Y8E0ELusXtlDpL6fb7NrAt5qdDrIgjpXxLaTVsQonUFCs09a3YQO7Ky2AacOqpo55gE4QMFnY5Z07UfebOYCc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885578; c=relaxed/simple;
	bh=IHDKkPuL6bGyn5e67txu92IjSUnnKlLm5rnqXrHDXfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBPuiemoh4N+oEBc1NS4WLQWAiV1POktc8NGi8bqoE3zKmWfZBT89bWr9BtcaUIvWSh6vDblmKNXUtsqJRWK8fWRYPi3pl7xjlL9mNYJPyD9CvJtq+0yg818LvW4nHh3T9ckpZqKb2guMQsrawLeCysf+Wwf25JdH7xqzslpJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UvWdNBT8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729885574;
	bh=IHDKkPuL6bGyn5e67txu92IjSUnnKlLm5rnqXrHDXfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UvWdNBT8E+GAvnMABd12C2gfjEy/go+AclK2eXCzTWQodocmtcvFeSHDBB7BtvLYn
	 beJF7K7beKxA/8UIldFBb2Fyd3xtK2p2jDm97aF4rmFpj1yjV/cECCVNpDcUipjwCR
	 bZtRbOPxPyS8ajt+WL4xSH/Jy1vmDYQtxB3Q3NwW3Wdvj5j15DqZ8SlnlrJsyjyBJH
	 g7c2gZIsmkj1Gd+alM3oY5/ApuW/3xFSCqPxXmVqeNqGegcwteqgI6hfbSMvxaS/GX
	 AwneRLNuHMKz3lSYYGdHSgNGaD+gn4TQewucuYm6jsNCBv3ExSHJRzi9KOfCGc8qXv
	 gKmVw+uA/mt4A==
Received: from [192.168.1.54] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A5C9D17E3750;
	Fri, 25 Oct 2024 21:46:12 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 25 Oct 2024 15:45:38 -0400
Subject: [PATCH RFC v2 3/5] pinctrl: mediatek: common: Expose more
 configurations to GPIO set_config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-kselftest-gpio-set-get-config-v2-3-040d748840bb@collabora.com>
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

Currently the set_config callback in the gpio_chip registered by the
pinctrl-mtk-common driver only supports configuring a single parameter
on specific pins (the input debounce of the EINT controller, on pins
that support it), even though many other configurations are already
implemented and available through the pinctrl API for configuration of
pins by the Devicetree and other drivers.

Expose all configurations currently implemented through the GPIO API so
they can also be set from userspace, which is particularly useful to
allow testing them from userspace.
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 48 ++++++++++++++++-----------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 91edb539925a49b4302866b9ac36f580cc189fb5..7f9764b474c4e7d0d4c3d6e542bdb7df0264daec 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -62,13 +62,12 @@ static unsigned int mtk_get_port(struct mtk_pinctrl *pctl, unsigned long pin)
 			<< pctl->devdata->port_shf;
 }
 
-static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
-			struct pinctrl_gpio_range *range, unsigned offset,
-			bool input)
+static int mtk_common_pin_set_direction(struct mtk_pinctrl *pctl,
+					unsigned int offset,
+					bool input)
 {
 	unsigned int reg_addr;
 	unsigned int bit;
-	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
 	reg_addr = mtk_get_port(pctl, offset) + pctl->devdata->dir_offset;
 	bit = BIT(offset & pctl->devdata->mode_mask);
@@ -86,6 +85,15 @@ static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range, unsigned int offset,
+			bool input)
+{
+	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return mtk_common_pin_set_direction(pctl, offset, input);
+}
+
 static void mtk_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	unsigned int reg_addr;
@@ -363,12 +371,11 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 	return 0;
 }
 
-static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
+static int mtk_pconf_parse_conf(struct mtk_pinctrl *pctl,
 		unsigned int pin, enum pin_config_param param,
-		enum pin_config_param arg)
+		u32 arg)
 {
 	int ret = 0;
-	struct mtk_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -381,15 +388,15 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		ret = mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
-		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
+		mtk_common_pin_set_direction(pctl, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_OUTPUT:
 		mtk_gpio_set(pctl->chip, pin, arg);
-		ret = mtk_pmx_gpio_set_direction(pctldev, NULL, pin, false);
+		ret = mtk_common_pin_set_direction(pctl, pin, false);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
+		mtk_common_pin_set_direction(pctl, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
@@ -421,7 +428,7 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
-		ret = mtk_pconf_parse_conf(pctldev, g->pin,
+		ret = mtk_pconf_parse_conf(pctl, g->pin,
 			pinconf_to_config_param(configs[i]),
 			pinconf_to_config_argument(configs[i]));
 		if (ret < 0)
@@ -870,19 +877,20 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	struct mtk_pinctrl *pctl = gpiochip_get_data(chip);
 	const struct mtk_desc_pin *pin;
 	unsigned long eint_n;
-	u32 debounce;
+	enum pin_config_param param = pinconf_to_config_param(config);
+	u32 arg = pinconf_to_config_argument(config);
 
-	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
+	if (param == PIN_CONFIG_INPUT_DEBOUNCE) {
+		pin = pctl->devdata->pins + offset;
+		if (pin->eint.eintnum == NO_EINT_SUPPORT)
+			return -EINVAL;
 
-	pin = pctl->devdata->pins + offset;
-	if (pin->eint.eintnum == NO_EINT_SUPPORT)
-		return -EINVAL;
+		eint_n = pin->eint.eintnum;
 
-	debounce = pinconf_to_config_argument(config);
-	eint_n = pin->eint.eintnum;
+		return mtk_eint_set_debounce(pctl->eint, eint_n, arg);
+	}
 
-	return mtk_eint_set_debounce(pctl->eint, eint_n, debounce);
+	return mtk_pconf_parse_conf(pctl, offset, param, arg);
 }
 
 static const struct gpio_chip mtk_gpio_chip = {

-- 
2.47.0


