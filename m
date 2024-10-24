Return-Path: <linux-kselftest+bounces-20549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB099AEA27
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6FD1C225D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3D1C8788;
	Thu, 24 Oct 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jHIPwf0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AF15853B;
	Thu, 24 Oct 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783031; cv=none; b=j4XC4H0Eq8uffbnsnsdoMlPt3PdrEw8cMwpKp0cBwgMeTk8RxX6DUrHuNsWEQ4MtqabuU+rilbXiQhS+n8F+OHL3jf0fl8/XbtO1yJs8YpFEfoB8LV8kkDEPM3+ROOQjH+2B+TRoQGOw5LS+IbAHzJc1X7ulWgLyWdfg0dezxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783031; c=relaxed/simple;
	bh=2Kve0loElZNKii6MgyGBUDusGqHjRRmkEVjHcH8MDHI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSp9Hp6Z3gTLHu6civLdjS1LCM/4ExuogBoUqHZ88DdGZOf34H6sTTTrvVmxsMQrK+xFCv2J9ZfNPyxKHeb3zoCwmlQtlIg+OIywyF8mz7wQkV/AN6KXLC6f/cFN73x1ADnU0jr5euAQm1d5jml459B0qgkSkCzXH7wDSCvCceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jHIPwf0d; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729783027;
	bh=2Kve0loElZNKii6MgyGBUDusGqHjRRmkEVjHcH8MDHI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jHIPwf0da3VkiA6MyWCQRxgWZMsLgxaXSmYoBtUKQPclhbCIjta2dEo48riMRAvS/
	 IR60w0PmCG98ZQeCVU0WSbwYlOgmdZfTPQj3Ulwg6H5UDySFiXjF7RV/D5CskfYdoH
	 5JjB74wb4Bd2kfaOTPYr4q2hUw1HX4TTho8rMLR40duK+qL98i98jnkZL1kCnMDNqx
	 k27UlrSnqGk5PeTfaM/pEAip5Oa/4gRZTPjmc0Is219kemSiP6pkNXsqqNRYupcdJn
	 u2rT9NPZjRqisz8L6AlvkoxqERXHP8TyyDLCwmgi5BHdltbvl9UpNpA0Pl1XDxsOB5
	 z2hd18mJStVjA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A23C217E1543;
	Thu, 24 Oct 2024 17:17:06 +0200 (CEST)
Message-ID: <8fdeec5c-5de7-44ae-9086-7930d02d610e@collabora.com>
Date: Thu, 24 Oct 2024 17:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] pinctrl: mediatek: paris: Expose more
 configurations to GPIO set_config
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 kernelci@lists.linux.dev
References: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
 <20240909-kselftest-gpio-set-get-config-v1-1-16a065afc3c1@collabora.com>
 <01020191e0901d10-d427a5dd-af4e-4ecf-99e1-4bb051ad1475-000000@eu-west-1.amazonses.com>
Content-Language: en-US
In-Reply-To: <01020191e0901d10-d427a5dd-af4e-4ecf-99e1-4bb051ad1475-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/09/24 12:10, AngeloGioacchino Del Regno ha scritto:
> Il 09/09/24 20:37, Nícolas F. R. A. Prado ha scritto:
>> Currently the set_config callback in the gpio_chip registered by the
>> pinctrl_paris driver only supports PIN_CONFIG_INPUT_DEBOUNCE, despite
> 
> [...] only supports operations configuring the input debounce parameter
> of the EINT controller and denies configuring params on the other AP GPIOs [...]
> 
> (reword as needed)
> 
>> many other configurations already being implemented and available
>> through the pinctrl API for configuration of pins by the Devicetree and
>> other drivers.
>>
>> Expose all configurations currently implemented through the GPIO API so
>> they can also be set from userspace, which is particularly useful to
>> allow testing them from userspace.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>> ---
>>   drivers/pinctrl/mediatek/pinctrl-paris.c | 20 ++++++++++----------
> 
> You can do the same for pinctrl-moore too, it's trivial.
> 
> Other than that, I agree about performing this change, as this may be useful
> for more than just testing.
> 

Nicolas, please don't forget to respin this patch.

Thanks,
Angelo


>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/ 
>> pinctrl-paris.c
>> index e12316c42698..668f8055a544 100644
>> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
>> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
>> @@ -255,10 +255,9 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>>       return err;
>>   }
>> -static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
>> +static int mtk_pinconf_set(struct mtk_pinctrl *hw, unsigned int pin,
>>                  enum pin_config_param param, u32 arg)
>>   {
>> -    struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
>>       const struct mtk_pin_desc *desc;
>>       int err = -ENOTSUPP;
>>       u32 reg;
>> @@ -795,7 +794,7 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, 
>> unsigned group,
>>       int i, ret;
>>       for (i = 0; i < num_configs; i++) {
>> -        ret = mtk_pinconf_set(pctldev, grp->pin,
>> +        ret = mtk_pinconf_set(hw, grp->pin,
>>                         pinconf_to_config_param(configs[i]),
>>                         pinconf_to_config_argument(configs[i]));
>>           if (ret < 0)
>> @@ -937,18 +936,19 @@ static int mtk_gpio_set_config(struct gpio_chip *chip, 
>> unsigned int offset,
>>   {
>>       struct mtk_pinctrl *hw = gpiochip_get_data(chip);
>>       const struct mtk_pin_desc *desc;
>> -    u32 debounce;
>> +    enum pin_config_param param = pinconf_to_config_param(config);
>> +    u32 arg = pinconf_to_config_argument(config);
>>       desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
>> -    if (!hw->eint ||
>> -        pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
>> -        desc->eint.eint_n == EINT_NA)
>> -        return -ENOTSUPP;
>> +    if (param == PIN_CONFIG_INPUT_DEBOUNCE) {
>> +        if (!hw->eint || desc->eint.eint_n == EINT_NA)
>> +            return -ENOTSUPP;
>> -    debounce = pinconf_to_config_argument(config);
>> +        return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, arg);
>> +    }
>> -    return mtk_eint_set_debounce(hw->eint, desc->eint.eint_n, debounce);
>> +    return mtk_pinconf_set(hw, offset, param, arg);
>>   }
>>   static int mtk_build_gpiochip(struct mtk_pinctrl *hw)
>>
> 
> 



