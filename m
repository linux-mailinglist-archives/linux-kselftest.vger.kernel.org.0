Return-Path: <linux-kselftest+bounces-21285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0809B8C6F
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 08:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C086283267
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C450155A30;
	Fri,  1 Nov 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KBxIpsrP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989014A0BC
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447714; cv=none; b=g4vz5avQA+EHJ36J17sUztlViEpfLLcyvCw4ldzsYd8/SoYTye4+U21Z33RmdySFip3D90fBYOGS98TyD9Fev1Y5nb6IJ4IhvgMmgqO6LiW8bgXeX/nBy12iGfRsTUaJOcMp+cp8gboWR55kJGearEEN37BHGCp3J3NnnWd7UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447714; c=relaxed/simple;
	bh=jIjKL4b6SYbqFeKrgXq9YMrJs6AykQJ52x4/MwJmLTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lELxPWEsxg1u8DeEx673fu4BVT9dou7hUsixDDMwHUkrLf2PNy9LmDCVmnKsmHa66KI/gYLtw5X3qaNT+L/8RFPoFalwyeGeLjBpO4LSgdcEXLbXqqU2cwl8tE1uV/kc3s6P7XuC8cR5B47bolYJYqJcLb+HNdA/0I/mSzIOM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KBxIpsrP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e7e73740so1562467e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Nov 2024 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730447710; x=1731052510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3scpQG8rDPy7dccdvb0ggPZwR6YQSFTzxlSNspAAiI=;
        b=KBxIpsrPfU7ZhmO7TIJd7RWpjEMSxe9shbhHvnIHi9kTpmrSN8UxB2NUFqH/yNTFSY
         WCgqWHSNBPj46dH5D6UVJz/kVSDFBhPwpBpzGzy0RomLfMmFItTYq6JueV6ky7uA2JUy
         P/9QoZDpM+5cH7YoCyVgHmzkpIQtxxtUVeL6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730447710; x=1731052510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3scpQG8rDPy7dccdvb0ggPZwR6YQSFTzxlSNspAAiI=;
        b=NYZLCm/67pPEIzMCmFtAFXSpRqKp1nOsEtaWZ/ETGBieLf9jPcFC3XZHl9xJsvT09x
         8neW9AJrX5F7tlQI8saPIoPg2vBCCltlDwa4Yb56p9X4ZET/cQa5Mu1wAouZAEkl74ZA
         xktYkt6q1r7pFLTbMQ1G0/J0IMLVb7FlZSTDrpsHntxoOZdqAu0UjaEqu0G8/kC2v4N+
         HxBGrC662XYXAiXfJ1mrxkCZ7zmdNUJPhRr22J+0qLqePlhKHBR3sN4sxSrsK0x3B4lE
         zGlcuYvzaldAHOI+7nNJZP4pAebyCPZoJCSMRelk4Az5ZHGOoVATkQMa815t5gGvoHby
         9w3g==
X-Forwarded-Encrypted: i=1; AJvYcCVaU0gDRCAOhuZOnQPaahQDbZG3XgnsARztcwL1I21Ix1gypKETclCMI7T192xo+gEZo7Bbcn7VTGaCHjOQD2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgk7GB9Xzpqb/FI35VjzFkRxESqrer80O1BtNt1qAFDtnD+SfX
	9mAn//yr5VfGP0U+hc32oiz77k+zlr3i+0Ij620FbuGf2ACk8ugMm+F9okjaN3g33szAoj7WNfp
	6itaxGbtlex5sT5c1eT8qOMi8ZeddKKyv4bFk
X-Google-Smtp-Source: AGHT+IFHp5ntUs0OfBYXAIVSOME07Jq9csDSpjBoDIGPyzJBlFKUtiIHFZznKS39Z4EjVqTm/HlKSNuPkafVheMa5iY=
X-Received: by 2002:a05:6512:3e1a:b0:539:ff5a:7ea5 with SMTP id
 2adb3069b0e04-53b7ecdea88mr6015521e87.15.1730447710300; Fri, 01 Nov 2024
 00:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
 <20241025-kselftest-gpio-set-get-config-v2-3-040d748840bb@collabora.com>
In-Reply-To: <20241025-kselftest-gpio-set-get-config-v2-3-040d748840bb@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 1 Nov 2024 15:54:58 +0800
Message-ID: <CAGXv+5H9OTCn033yoi6oxxRKG1G=vbrBK+aw+ZWwGPWbn=uWuA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/5] pinctrl: mediatek: common: Expose more
 configurations to GPIO set_config
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Sean Wang <sean.wang@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 5:16=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Currently the set_config callback in the gpio_chip registered by the
> pinctrl-mtk-common driver only supports configuring a single parameter
> on specific pins (the input debounce of the EINT controller, on pins
> that support it), even though many other configurations are already
> implemented and available through the pinctrl API for configuration of
> pins by the Devicetree and other drivers.
>
> Expose all configurations currently implemented through the GPIO API so
> they can also be set from userspace, which is particularly useful to
> allow testing them from userspace.

Missing signed-off-by?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 48 ++++++++++++++++-----=
------
>  1 file changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.c
> index 91edb539925a49b4302866b9ac36f580cc189fb5..7f9764b474c4e7d0d4c3d6e54=
2bdb7df0264daec 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -62,13 +62,12 @@ static unsigned int mtk_get_port(struct mtk_pinctrl *=
pctl, unsigned long pin)
>                         << pctl->devdata->port_shf;
>  }
>
> -static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> -                       struct pinctrl_gpio_range *range, unsigned offset=
,
> -                       bool input)
> +static int mtk_common_pin_set_direction(struct mtk_pinctrl *pctl,
> +                                       unsigned int offset,
> +                                       bool input)
>  {
>         unsigned int reg_addr;
>         unsigned int bit;
> -       struct mtk_pinctrl *pctl =3D pinctrl_dev_get_drvdata(pctldev);
>
>         reg_addr =3D mtk_get_port(pctl, offset) + pctl->devdata->dir_offs=
et;
>         bit =3D BIT(offset & pctl->devdata->mode_mask);
> @@ -86,6 +85,15 @@ static int mtk_pmx_gpio_set_direction(struct pinctrl_d=
ev *pctldev,
>         return 0;
>  }
>
> +static int mtk_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
> +                       struct pinctrl_gpio_range *range, unsigned int of=
fset,
> +                       bool input)
> +{
> +       struct mtk_pinctrl *pctl =3D pinctrl_dev_get_drvdata(pctldev);
> +
> +       return mtk_common_pin_set_direction(pctl, offset, input);
> +}
> +
>  static void mtk_gpio_set(struct gpio_chip *chip, unsigned offset, int va=
lue)
>  {
>         unsigned int reg_addr;
> @@ -363,12 +371,11 @@ static int mtk_pconf_set_pull_select(struct mtk_pin=
ctrl *pctl,
>         return 0;
>  }
>
> -static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
> +static int mtk_pconf_parse_conf(struct mtk_pinctrl *pctl,
>                 unsigned int pin, enum pin_config_param param,
> -               enum pin_config_param arg)
> +               u32 arg)
>  {
>         int ret =3D 0;
> -       struct mtk_pinctrl *pctl =3D pinctrl_dev_get_drvdata(pctldev);
>
>         switch (param) {
>         case PIN_CONFIG_BIAS_DISABLE:
> @@ -381,15 +388,15 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev =
*pctldev,
>                 ret =3D mtk_pconf_set_pull_select(pctl, pin, true, false,=
 arg);
>                 break;
>         case PIN_CONFIG_INPUT_ENABLE:
> -               mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
> +               mtk_common_pin_set_direction(pctl, pin, true);
>                 ret =3D mtk_pconf_set_ies_smt(pctl, pin, arg, param);
>                 break;
>         case PIN_CONFIG_OUTPUT:
>                 mtk_gpio_set(pctl->chip, pin, arg);
> -               ret =3D mtk_pmx_gpio_set_direction(pctldev, NULL, pin, fa=
lse);
> +               ret =3D mtk_common_pin_set_direction(pctl, pin, false);
>                 break;
>         case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> -               mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
> +               mtk_common_pin_set_direction(pctl, pin, true);
>                 ret =3D mtk_pconf_set_ies_smt(pctl, pin, arg, param);
>                 break;
>         case PIN_CONFIG_DRIVE_STRENGTH:
> @@ -421,7 +428,7 @@ static int mtk_pconf_group_set(struct pinctrl_dev *pc=
tldev, unsigned group,
>         int i, ret;
>
>         for (i =3D 0; i < num_configs; i++) {
> -               ret =3D mtk_pconf_parse_conf(pctldev, g->pin,
> +               ret =3D mtk_pconf_parse_conf(pctl, g->pin,
>                         pinconf_to_config_param(configs[i]),
>                         pinconf_to_config_argument(configs[i]));
>                 if (ret < 0)
> @@ -870,19 +877,20 @@ static int mtk_gpio_set_config(struct gpio_chip *ch=
ip, unsigned offset,
>         struct mtk_pinctrl *pctl =3D gpiochip_get_data(chip);
>         const struct mtk_desc_pin *pin;
>         unsigned long eint_n;
> -       u32 debounce;
> +       enum pin_config_param param =3D pinconf_to_config_param(config);
> +       u32 arg =3D pinconf_to_config_argument(config);
>
> -       if (pinconf_to_config_param(config) !=3D PIN_CONFIG_INPUT_DEBOUNC=
E)
> -               return -ENOTSUPP;
> +       if (param =3D=3D PIN_CONFIG_INPUT_DEBOUNCE) {
> +               pin =3D pctl->devdata->pins + offset;
> +               if (pin->eint.eintnum =3D=3D NO_EINT_SUPPORT)
> +                       return -EINVAL;
>
> -       pin =3D pctl->devdata->pins + offset;
> -       if (pin->eint.eintnum =3D=3D NO_EINT_SUPPORT)
> -               return -EINVAL;
> +               eint_n =3D pin->eint.eintnum;
>
> -       debounce =3D pinconf_to_config_argument(config);
> -       eint_n =3D pin->eint.eintnum;
> +               return mtk_eint_set_debounce(pctl->eint, eint_n, arg);
> +       }
>
> -       return mtk_eint_set_debounce(pctl->eint, eint_n, debounce);
> +       return mtk_pconf_parse_conf(pctl, offset, param, arg);
>  }
>
>  static const struct gpio_chip mtk_gpio_chip =3D {
>
> --
> 2.47.0
>
>

