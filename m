Return-Path: <linux-kselftest+bounces-17739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C90974F63
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 12:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC251C22406
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11D181B82;
	Wed, 11 Sep 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ThHWqJwG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ArS1iDDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from a7-43.smtp-out.eu-west-1.amazonses.com (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F27E0E8;
	Wed, 11 Sep 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049430; cv=none; b=gCSmdHVqyh6M2mZuOQxQ2IEnih/1iUyKTxv2nDItN3Yn/dvzq92PHpoc2jwZFUBrLC6RkUyT0YPylnvWIbLGXufumEQjzX3z1MQRPyvkEoHCskp1NTfLkD57Z7xs34bQTurwYDzPyICUv7EXpwmQekF5ArwAIyEBH/X1Y3MgCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049430; c=relaxed/simple;
	bh=XXNXRYbmz3Zes9xyUsSvTiVqxoySTWzbF2/5l+DV+OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH7C0LZyepaH1cQ1ODlvfVmN0+8UcPKJ9PiFuhQ3X+dYw716/BGBFYHEqa4MjOltQK96PO3DfxhvFZSiWlU1GujcBXtc2mM6xn2GE8J4mUrgygc7FuQjNN5t3Z4jyUmIOOJm+BoBPkW9L8F9wIA+2hFjrASGEatz3JBeUQ++UH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ThHWqJwG; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ArS1iDDN; arc=none smtp.client-ip=54.240.7.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726049426;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=XXNXRYbmz3Zes9xyUsSvTiVqxoySTWzbF2/5l+DV+OQ=;
	b=ThHWqJwGW2d6SgyvZM1kISkV9MQ6nVMsxL2KWE26xxtlCQW80zdB8yiAjabscpRC
	bOD5jsyr6s6bIs+TsbuckZZy9MCboXfkHh3+EfKMyqpFvexSvcX4tH9TmvyXZ4XgAY1
	DCQvrz0JopgyhvSCWaxUZoQssBn6lRGB4pIYbUulCGEdYF4dOayl4E4yrZOy+n5xq9l
	E8lJSWDxwOcxts64gHTg+u+M2OKdjZtODLeqriAgAca0QHngJXQ83ctzJ5wZuhJpjbh
	iz9B3czYJqmuW3Bbcavw9lOClse881/vi7YSVtKwrYP8jXHPZWCSL84RTFcJEn89Z6i
	/lVBbmpB0Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726049426;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=XXNXRYbmz3Zes9xyUsSvTiVqxoySTWzbF2/5l+DV+OQ=;
	b=ArS1iDDNHqlmkcm+u7EYSSuksf2KcUGgBpJVPaEqYStCHYkvoCscsGkyFNEnPMe6
	FWFNuCqLUXDnoF+UcRe5Aet6oNeeq32j1AnnALjkKdEz18fFM8JLGeFieNcuqhGlp4A
	cpM9tBN8dtWu0P/MpggzN6H1KH81iPpOisHflY/Y=
Message-ID: <01020191e0901d10-d427a5dd-af4e-4ecf-99e1-4bb051ad1475-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 10:10:26 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] pinctrl: mediatek: paris: Expose more
 configurations to GPIO set_config
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Sean Wang <sean.wang@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
References: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
 <20240909-kselftest-gpio-set-get-config-v1-1-16a065afc3c1@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240909-kselftest-gpio-set-get-config-v1-1-16a065afc3c1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.43

Il 09/09/24 20:37, Nícolas F. R. A. Prado ha scritto:
> Currently the set_config callback in the gpio_chip registered by the
> pinctrl_paris driver only supports PIN_CONFIG_INPUT_DEBOUNCE, despite

[...] only supports operations configuring the input debounce parameter
of the EINT controller and denies configuring params on the other AP GPIOs [...]

(reword as needed)

> many other configurations already being implemented and available
> through the pinctrl API for configuration of pins by the Devicetree and
> other drivers.
> 
> Expose all configurations currently implemented through the GPIO API so
> they can also be set from userspace, which is particularly useful to
> allow testing them from userspace.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 20 ++++++++++----------

You can do the same for pinctrl-moore too, it's trivial.

Other than that, I agree about performing this change, as this may be useful
for more than just testing.

Cheers,
Angelo

>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index e12316c42698..668f8055a544 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -255,10 +255,9 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>   	return err;
>   }
>   
> -static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> +static int mtk_pinconf_set(struct mtk_pinctrl *hw, unsigned int pin,
>   			   enum pin_config_param param, u32 arg)
>   {
> -	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
>   	const struct mtk_pin_desc *desc;
>   	int err = -ENOTSUPP;
>   	u32 reg;
> @@ -795,7 +794,7 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
>   	int i, ret;
>   
>   	for (i = 0; i < num_configs; i++) {
> -		ret = mtk_pinconf_set(pctldev, grp->pin,
> +		ret = mtk_pinconf_set(hw, grp->pin,
>   				      pinconf_to_config_param(configs[i]),
>   				      pinconf_to_config_argument(configs[i]));
>   		if (ret < 0)
> @@ -937,18 +936,19 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
>   {
>   	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
>   	const struct mtk_pin_desc *desc;
> -	u32 debounce;
> +	enum pin_config_param param = pinconf_to_config_param(config);
> +	u32 arg = pinconf_to_config_argument(config);
>   
>   	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
>   
> -	if (!hw->eint ||
> -	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
> -	    desc->eint.eint_n == EINT_NA)
> -		return -ENOTSUPP;
> +	if (param == PIN_CONFIG_INPUT_DEBOUNCE) {
> +		if (!hw->eint || desc->eint.eint_n == EINT_NA)
> +			return -ENOTSUPP;
>   
> -	debounce = pinconf_to_config_argument(config);
> +		return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, arg);
> +	}
>   
> -	return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
> +	return mtk_pinconf_set(hw, offset, param, arg);
>   }
>   
>   static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
> 




