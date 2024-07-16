Return-Path: <linux-kselftest+bounces-13775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFD932584
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D7C1C2255C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC518198E60;
	Tue, 16 Jul 2024 11:24:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADA22309;
	Tue, 16 Jul 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129052; cv=none; b=s28jxhNX3z6Unr4BQ63bf8RzHt7G0tJ2vmgD+StF7kSGnH8Ijc0RUeKezhiAXdvFESjXQaMlleoqpuil1WwO/09BmLu6AdFl7itRDL5bMxs3zaCSDIKKrhg2boLN5DwQNSbuLTLYGqvZsSqC9XqiP+KzjOIpuCyQzjJ/1KytMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129052; c=relaxed/simple;
	bh=UlbGu3EkA+Lvmf3I3klsx8B2VOESek2LOyeDAUqvLIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5aDVBEZsLLyAIoRlXkatJN2KFLKCHcdyU7J9ycNmnDkPlgTTpHVfLJtTEQXwde7KX6nWwBFu1echIUgP/EIodBIH1E0XF1Pl/nnbwoTj4lGc1aFsetSHbS0JgYtdXoXoAvQN4ANXNEXk10DUW6XSePw/4SctR9lkXJU6+PKGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65cd720cee2so48566747b3.1;
        Tue, 16 Jul 2024 04:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129049; x=1721733849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tEqgeyPZzEuby1pRGoux5oH5BnRs53yKaWTX95zMy4=;
        b=F7mM4c+Ma28YUeEYCQEnka8AIXgEnhpZYiRQztx3sGVIZ7LS76FS0NcrdmWLnQwbYn
         hh+lw5HODOfij8yDYWBKsXknB8KyX5tbWRmgL22vi9fuHoT+N1bGs+hgwDhlwz7AdBAa
         yTucGgy8qEj1rtGGvYZmhSZaBaE9ZgRs6JQMjCunAgAH3Nb5QOXyLyVz0mIIJCrRXwYR
         1cd33dltB7MYGGTUzeJp8XVVivyEhnnYDXe1i1nkqLIKCBFC7wVdbTqBhDiQXFLkrtpD
         XZLfHpc8Eh9ufmgyqEKMNNU1Bu0CJqbE2edCvNZfv/tiLtUD6sn4EvHQsGAgzdo8rH24
         mGsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuj4Ob/hIAg0pobOY1Q1wodgO39Br/uezNSuXdIOBz82Wt9F/gwl9wc9TdqKY1amkFoJE1nDK+aOhEoM7a4+Nw4rFDNxkE6WKX3UU7pxf0Eh4XEbmFrHmvloxUHrKJ/bq/mEVlJYdBvAsxz51PRzXYSZfKnkLFrABowd5uAuwsBfR/S5cwypn0QVLDT4N+z6hCuwBX1Yx7/g0OBE8lQKK6GVron1XLx1C0Bp8eTND0KP8cuBHBCQFjzXP4oRMhNA==
X-Gm-Message-State: AOJu0YyynRSVOQ6pJZzxYIU171XDRDA063kd/S02paCcVOZfAfWybv6f
	B8jCR1tw+5yKzB3OPTpgZsJDOjujgwtaJlB4QdCHnGbdftXSD5yjF3xFpk4B
X-Google-Smtp-Source: AGHT+IHRqnHBIIsFYs75OEXLP+i+KlrxluxUBGG9UsNTTmTPDl6qYEa2wtiGCOvFVe6HF7EbkEv8/g==
X-Received: by 2002:a81:a209:0:b0:660:56fb:7f00 with SMTP id 00721157ae682-66381ac112emr21533597b3.46.1721129048894;
        Tue, 16 Jul 2024 04:24:08 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc2af4232sm11106767b3.70.2024.07.16.04.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:24:08 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65cd720cee2so48566427b3.1;
        Tue, 16 Jul 2024 04:24:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxbWyXJ7cnklMJnBek3yformXt9KWDwYgrU1HFTRr74iVFw0+XWLYbyv3E2zXs7f+ENU6GjzHHH9m5kPu+atrODhg0E6nP0Y4EgBLD+hjZ52dERcm1GKg3pZh2WcbYxPAXF0us47Aob61uk9p/bijGTbIdSK6SBTTR7M2WUI1qW71VnVM89rDz2aAZk6H35oQNGBWbc6RyK4nc79axFaBhwpqa6GaazPpk9J6cQehKCIFUtQeCZUYLxfRGoG7scg==
X-Received: by 2002:a05:690c:ece:b0:64a:3e36:7fd1 with SMTP id
 00721157ae682-6637f2bc7c4mr23335497b3.10.1721129048431; Tue, 16 Jul 2024
 04:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-2-sboyd@kernel.org>
 <CAMuHMdV56nezM9cj1bVo4+gqi0OPvKjktu7i4Ov9ZKeyNkoiOg@mail.gmail.com>
In-Reply-To: <CAMuHMdV56nezM9cj1bVo4+gqi0OPvKjktu7i4Ov9ZKeyNkoiOg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jul 2024 13:23:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV9EwBgmNYP9jZBZKNNn0ZX2XErcyeXu1xatFdBVzdXmw@mail.gmail.com>
Message-ID: <CAMuHMdV9EwBgmNYP9jZBZKNNn0ZX2XErcyeXu1xatFdBVzdXmw@mail.gmail.com>
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

On Tue, Jul 16, 2024 at 11:48=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Jul 10, 2024 at 10:14=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > We'd like to apply overlays to the root node in KUnit so we can test
> > platform devices created as children of the root node.
> >
> > On some architectures (powerpc), the root node isn't marked with
> > OF_POPULATED_BUS. If an overlay tries to modify the root node on these
> > platforms it will fail, while on other platforms, such as ARM, it will
> > succeed. This is because the root node is marked with OF_POPULATED_BUS
> > by of_platform_default_populate_init() calling
> > of_platform_default_populate() with NULL as the first argument.
> >
> > Loosen the requirement here so that platform devices can be created for
> > nodes created as children of the root node via DT overlays even if the
> > platform bus wasn't populated for the root node.
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>

> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -732,11 +732,14 @@ static int of_platform_notify(struct notifier_blo=
ck *nb,
> >         struct of_reconfig_data *rd =3D arg;
> >         struct platform_device *pdev_parent, *pdev;
> >         bool children_left;
> > +       struct device_node *parent;
> >
> >         switch (of_reconfig_get_state_change(action, rd)) {
> >         case OF_RECONFIG_CHANGE_ADD:
> > -               /* verify that the parent is a bus */
> > -               if (!of_node_check_flag(rd->dn->parent, OF_POPULATED_BU=
S))
> > +               parent =3D rd->dn->parent;
> > +               /* verify that the parent is a bus (or the root node) *=
/
> > +               if (!of_node_is_root(parent) &&
> > +                   of_node_check_flag(parent, OF_POPULATED_BUS))
>
> Oh, you inverted the check for of_node_check_flag(); was that
> intentional?  Re-adding the "!" fixes all issues for me.

I have sent a fix.
https://lore.kernel.org/a9ada686e1f1c6f496e423deaf108f1bcfd94d7d.1721123679=
.git.geert+renesas@glider.be/

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

