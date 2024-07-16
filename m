Return-Path: <linux-kselftest+bounces-13771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90393235A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C258AB23647
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0CC198A0A;
	Tue, 16 Jul 2024 09:49:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0715EA6;
	Tue, 16 Jul 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123349; cv=none; b=TDMeeOtQFKGy3K+TWY4R2XtpJkK9x9M/yVEhY269Tv17tm4jRm3XcedpRqeJnf9tN4JKLYbC16PX+etBT7Rrt8pP6z4nzsv0S9cKfeE+8F/0z90/N3CsqaVwM+UGHWJGopDofnkSvPQ2RB00zZWeAzVj9dg55SWRXjKOOLcYz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123349; c=relaxed/simple;
	bh=8UvQU7I9knuWhkpzd9TO9Fs/k8V16zg/peOwYTNUXUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgKtUNrQkAIttaPf4CLx9xeMyBzEp3hDIy+Re/5bhz3wCnaMozLSB9j5z5blrCaVutbkryl6V967eQIYMXPy0n6VwrhzNePIaKVQtZOjz/7wA31OelixlrAq9gAyJB48IFlimke2+RKqUY1Ersnq9Tnmhc9sy4hzgQyNmpWGR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e057bdc936fso5240665276.1;
        Tue, 16 Jul 2024 02:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123345; x=1721728145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRQTvYVjx0Y6w3qpoyzLPKWPbAyGp8ArajcCwsaEB18=;
        b=vvxaKZ692zESgqP/WvRtkSb4pea3vkbR134MeYOFaxvD1pHKdE5d0n1zBuK1wUFk1d
         SOEeIyvUfC1l5MdMOA7h4C6jau9yxt0Tw2zpLDMxh8TytP3FHGVvfGQsAdExIvt6dZic
         9SNHiBjzQc3LdWm8ME2tVL7FeU8/L9fE9gBpmQH0nYlOqBe0TC1/Oslk77CUvO1zHY3E
         OliidOAORXzeHiHD4HBCy8S7n9h0eefMj8c4CsXTZtQf1tCTuWaSAzLqvrUkOmhidCon
         aKr8q25hL0eCw4eWjMD+ytKIsoGQBUN/e6pt5nFXzfe+yzFtFOy3t7Ea2tFk5LTRMWqZ
         pIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXd7wVgKxW2I36bxri0IaAadBU16HAjtZcV3Exeunj4vPQwkvueCnDZ3q7UgWi7jmp2AY0bYi3m2XU22hHXeKIXd4IAAfSFZETH3kAQ6/jV+7wLNhbenaABxwe5Ha0jVW2+21jaE/v0QspZJTwbuZMRH4TcIOv/WeP+G5KUNHf8Hi++YUjUz8rgBAS43BVTdkIQTAQYXLZGtS0UW2nG173D+UB4sGhH9VqOwoW/O2zcnSNdBrbYf3orO14z2WY04Q==
X-Gm-Message-State: AOJu0Yz9bUvCziP77YdPGk0nJ6V6DqXRwO2Iihjb3r8cTbsgUm2CKiOM
	Ol7/BE4uPOYJNi/ONlku8LDGTf9KQMf/mYm1CTKqYwnRRfy+0eefXEWIYgBM
X-Google-Smtp-Source: AGHT+IHDOwQCXxlWls2E2WxUggo4e7W62NofTFzO/4waHMBDxD1Zf7wxldMc/f+Fl559sgNJpfnelg==
X-Received: by 2002:a25:84c6:0:b0:dff:4a3:2df4 with SMTP id 3f1490d57ef6-e05d56e718dmr1732478276.31.1721123344902;
        Tue, 16 Jul 2024 02:49:04 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e05a4695bc9sm1175809276.36.2024.07.16.02.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 02:49:04 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e057bdc936fso5240607276.1;
        Tue, 16 Jul 2024 02:49:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgDyR8h2fuF4Bem3aMKDcoht3tPwUfIDktipVKZT16ilBXlxTqMOBwzJ/pEV6KpHQKrfz21fzGuM9fLLUPt69g2xJpOTkw/chjkTRGOs25MgFH+EL/3R6F0SDV7oTq8IYxBAUi0dim5ICHZy+YXoyFDXMfKTGDdxXVyX5KGw2nXDLVSyQBtZNfovbmdUc4Idw7+lktHg2UcSel+VLB0s5DZTDv6XsJPlStgej5l6zLyBdESnqSGI2agW5PSX+PLw==
X-Received: by 2002:a0d:de04:0:b0:63b:f8cb:9281 with SMTP id
 00721157ae682-663817d8a34mr15909167b3.41.1721123342440; Tue, 16 Jul 2024
 02:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-2-sboyd@kernel.org>
In-Reply-To: <20240710201246.1802189-2-sboyd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jul 2024 11:48:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV56nezM9cj1bVo4+gqi0OPvKjktu7i4Ov9ZKeyNkoiOg@mail.gmail.com>
Message-ID: <CAMuHMdV56nezM9cj1bVo4+gqi0OPvKjktu7i4Ov9ZKeyNkoiOg@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] of/platform: Allow overlays to create platform
 devices from the root node
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, patches@lists.linux.dev, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxime Ripard <maxime@cerno.tech>, Peter Rosin <peda@axentia.se>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Wed, Jul 10, 2024 at 10:14=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> We'd like to apply overlays to the root node in KUnit so we can test
> platform devices created as children of the root node.
>
> On some architectures (powerpc), the root node isn't marked with
> OF_POPULATED_BUS. If an overlay tries to modify the root node on these
> platforms it will fail, while on other platforms, such as ARM, it will
> succeed. This is because the root node is marked with OF_POPULATED_BUS
> by of_platform_default_populate_init() calling
> of_platform_default_populate() with NULL as the first argument.
>
> Loosen the requirement here so that platform devices can be created for
> nodes created as children of the root node via DT overlays even if the
> platform bus wasn't populated for the root node.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks for your patch, which is now commit 98290f295fbcf18f
("of/platform: Allow overlays to create platform devices from the
root node") in clk/clk-next.

This causes i2c-demux-pinctrl to fail on the Koelsch development board:

        i2c-demux-pinctrl i2c-mux1: failed to setup demux-adapter 0 (-19)
        i2c-demux-pinctrl i2c-mux2: failed to setup demux-adapter 0 (-19)
        i2c-demux-pinctrl i2c-mux3: failed to setup demux-adapter 0 (-19)
        i2c-demux-pinctrl i2c-mux2: Failed to create device link
(0x180) with e6ef0000.video
        i2c-demux-pinctrl i2c-mux2: Failed to create device link
(0x180) with e6ef1000.video
        i2c-demux-pinctrl i2c-mux2: Failed to create device link
(0x180) with hdmi-in
        i2c-demux-pinctrl i2c-mux2: Failed to create device link
(0x180) with hdmi-out

and anything relying on I2C connected to these muxes fails, too.

Also, loading the 25LC040 DT overlay[1] on Ebisu using the out-of-tree
of-configfs now fails, too.

> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -732,11 +732,14 @@ static int of_platform_notify(struct notifier_block=
 *nb,
>         struct of_reconfig_data *rd =3D arg;
>         struct platform_device *pdev_parent, *pdev;
>         bool children_left;
> +       struct device_node *parent;
>
>         switch (of_reconfig_get_state_change(action, rd)) {
>         case OF_RECONFIG_CHANGE_ADD:
> -               /* verify that the parent is a bus */
> -               if (!of_node_check_flag(rd->dn->parent, OF_POPULATED_BUS)=
)
> +               parent =3D rd->dn->parent;
> +               /* verify that the parent is a bus (or the root node) */
> +               if (!of_node_is_root(parent) &&

Parent =3D /soc, so this returns early. Hence of_changeset_apply() [2]
didn't add the I2C mux bus, causing of_get_i2c_adapter_by_node() [3]
to fail.

> +                   of_node_check_flag(parent, OF_POPULATED_BUS))

Oh, you inverted the check for of_node_check_flag(); was that
intentional?  Re-adding the "!" fixes all issues for me.

>                         return NOTIFY_OK;       /* not for us */
>
>                 /* already populated? (driver using of_populate manually)=
 */
> @@ -749,7 +752,7 @@ static int of_platform_notify(struct notifier_block *=
nb,
>                  */
>                 rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
>                 /* pdev_parent may be NULL when no bus platform device */
> -               pdev_parent =3D of_find_device_by_node(rd->dn->parent);
> +               pdev_parent =3D of_find_device_by_node(parent);
>                 pdev =3D of_platform_device_create(rd->dn, NULL,
>                                 pdev_parent ? &pdev_parent->dev : NULL);
>                 platform_device_put(pdev_parent);

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.g=
it/tree/arch/arm64/boot/dts/renesas/r8a77990-ebisu-cn41-msiof0-25lc040.dtso=
?h=3Dtopic/renesas-overlays
[2] https://elixir.bootlin.com/linux/latest/source/drivers/i2c/muxes/i2c-de=
mux-pinctrl.c#L60
[3] https://elixir.bootlin.com/linux/latest/source/drivers/i2c/muxes/i2c-de=
mux-pinctrl.c#L64

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

