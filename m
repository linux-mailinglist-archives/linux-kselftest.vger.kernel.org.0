Return-Path: <linux-kselftest+bounces-20697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352119B0F55
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9281F23E38
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A411212163;
	Fri, 25 Oct 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JfRE3Bf5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44220BB35;
	Fri, 25 Oct 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885574; cv=none; b=sqyuFMkVQRLYC7QqBfpN/I6cx9KcxKpi27MfEm+BH0ejp7hjj4M4BNBgnI15n0m/L55+Dq2fag8k2yP5uh5PjXuRQoZbuIrK8a/V6e5J8sc3M5MJjekiYKHNTo3sietVbx6Ev9Okv6dt7RDfhfTUttFI9p4AkcOsocwsL3Bl3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885574; c=relaxed/simple;
	bh=xueF8NL4biPM6Tjkyld4sBVF/E87RcWAqU59Qy6ahiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BAZPYnFYpufV7IdqB2IHcoO7GKQC3zHMoesedzFjPsLV08jlhTTGQhIsyN4S9JJ/+ASJgN0zrF1NIDHnbAhp5Vk73WEUdZ10SX4DiC7vo2KPGs74zPgkXHcyW6dzwaVZ2aK5MeF3O3bdp0EO37V8Hl3GvykEvGzRMtA9+VcPG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JfRE3Bf5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729885570;
	bh=xueF8NL4biPM6Tjkyld4sBVF/E87RcWAqU59Qy6ahiw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JfRE3Bf5Gfu+OpGxQvbs1PSFqG70Pn28Sq2qOU7LQ4hw4W+nB67hd9iDvxcsSREL8
	 p1A7xZIQW0LnL0uAlmfFuyju47fyw5wCkybqvrQ0iysKmk0CNN/IeRPvsgskBfFpfb
	 cRQGmn6gx9uvcSH/pBtOzK0eVcgHQZikWjxJHsRD4O9G6cSR18lERuuHtsvdKEB1UM
	 uM+ELKf6iGPCJBfwkMCVILAsdRpXs271f0T1OL3D5U5/vJpffLXEoCfyUxbhT1VLTt
	 Y38wrzXU4n1z55CNULfAO3TrDzcM8kEj5S+zjESHfZhrVuLDf2sx0Hg4KTI6Y9mBIK
	 CtVOFr7/XZBLA==
Received: from [192.168.1.54] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BFB6817E3706;
	Fri, 25 Oct 2024 21:46:08 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 25 Oct 2024 15:45:36 -0400
Subject: [PATCH RFC v2 1/5] pinctrl: mediatek: paris: Expose more
 configurations to GPIO set_config
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241025-kselftest-gpio-set-get-config-v2-1-040d748840bb@collabora.com>
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
pinctrl_paris driver only supports configuring a single parameter on
specific pins (the input debounce of the EINT controller, on pins that
support it), even though many other configurations are already
implemented and available through the pinctrl API for configuration of
pins by the Devicetree and other drivers.

Expose all configurations currently implemented through the GPIO API so
they can also be set from userspace, which is particularly useful to
allow testing them from userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 87e958d827bf939aa6006794287698be4936f25e..c9455de266a447ab7f5446c1511bef0ef9c9128e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -255,10 +255,9 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	return err;
 }
 
-static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			   enum pin_config_param param, u32 arg)
+static int mtk_paris_pin_config_set(struct mtk_pinctrl *hw, unsigned int pin,
+				    enum pin_config_param param, u32 arg)
 {
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
 	int err = -ENOTSUPP;
 	u32 reg;
@@ -795,9 +794,9 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	int i, ret;
 
 	for (i = 0; i < num_configs; i++) {
-		ret = mtk_pinconf_set(pctldev, grp->pin,
-				      pinconf_to_config_param(configs[i]),
-				      pinconf_to_config_argument(configs[i]));
+		ret = mtk_paris_pin_config_set(hw, grp->pin,
+					       pinconf_to_config_param(configs[i]),
+					       pinconf_to_config_argument(configs[i]));
 		if (ret < 0)
 			return ret;
 
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
+	return mtk_paris_pin_config_set(hw, offset, param, arg);
 }
 
 static int mtk_build_gpiochip(struct mtk_pinctrl *hw)

-- 
2.47.0


