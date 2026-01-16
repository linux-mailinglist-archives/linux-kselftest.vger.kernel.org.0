Return-Path: <linux-kselftest+bounces-49146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7333D31D88
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 14:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFC0B301296E
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1D6283FFB;
	Fri, 16 Jan 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6baq6J3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16758283C82
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570248; cv=none; b=WNO7kJKzsg/bJGu600tP5t/YSGwo0zs/fn9AmAM4kc83rthG3sqO/skNjrNyMZczVsh5fUsGyFZfQAu3dmZkRWl3DIIo1qQdtr1ZqL+0Wpalqi9AMobyjCOo0Ej268Bly6A2rCrNCZnV/e8JsUe4Hi2aeABH/DL1brXDAMIkJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570248; c=relaxed/simple;
	bh=eGzB6OGr4m8+g8uVvAo6Ydy6NYM3NPFPawuIGPTHtRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxC0q52vD4hehYu/fyHwmeMfEVx0CWHoEWjRKgQ8Ieio16saCpfg4TRbPt27qxcfpbuPrQ/PF+GW/7ZSfgUF6BEK6BPV3ubx9uACwCDydJwaai+oXOlENfGkuUxSuQF8t/yvihRiFni5X9mI1iDmByWiE2oVInjWM+Pq6RuJQMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6baq6J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08C3C2BCB3
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768570247;
	bh=eGzB6OGr4m8+g8uVvAo6Ydy6NYM3NPFPawuIGPTHtRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T6baq6J35ev3l8kZcfx2qly83pUgbqVynqp7ELM4vdl3BB1gRw+xUsV68iZV+5s3Y
	 Ydc7XekQVNrFOysAsb/3B3vsfGgBkPuBOPaAKyy0j/N5fzb4elCOlefyOtYxP9D7jw
	 pgij0Jokga3jpRUDIB/ME8WXzAoKeQ1xqxbklRX+Y6DOtIHW48Vu5OfWjwDU0v+P6N
	 HY9aM3sNy4SYTw9pwomcErDq3cOeSFigl60nVdmYirpRTFyHGUKSnHnH4D1aahyDFN
	 HSSK0Xz/ZoHy+lSvOK3RMqEtcyNTh/LqHwS8Ob+qM8eSXMMg0RFM5C5xQgCjtDYYko
	 o5hNQsoNUJeKQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b30275e69so2834143e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 05:30:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl0JrikgaaUiM9iAuqvVGOpNtJPMg2HVyKw+i/coXbWgi7b13eKqfnLsm5vjqcZowRY9NyhaTu/qzNuHMuH3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetHMzMkKNB74nTHY0dihrzAa8e5PIQPGI++cc9UgEYQ2EdKPz
	yPU+3hmHYV3RVrZrESDc5IGLZ3TxShquSdNOgfoUwL6uhuxZf2Kao4q01q0JSBXOyJf3gPoaG2V
	ST7KOQkHCnHZX7NB18YUSKOkEZMeo4XuaR/EAD3F19A==
X-Received: by 2002:a05:6512:3e28:b0:59b:6ea9:6ece with SMTP id
 2adb3069b0e04-59baffdcd6fmr789261e87.41.1768570246372; Fri, 16 Jan 2026
 05:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-2-tzungbi@kernel.org>
 <CAMRc=MeiQho5mfxGsL1AZ60brCzfox64XQao=xWnxMsdHF2-vA@mail.gmail.com> <2026011600-thirsty-troubling-dc76@gregkh>
In-Reply-To: <2026011600-thirsty-troubling-dc76@gregkh>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 14:30:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mc=So83ukL0t-UvQ2bntbpGuiBMa3zH4Bdi-XWEgMwnqQ@mail.gmail.com>
X-Gm-Features: AZwV_Qj0zg3ZexZ9QZCtjYQVu6qiFXd_yXaDnIEZBuAnAK6JdVbjKDUdawvxezs
Message-ID: <CAMRc=Mc=So83ukL0t-UvQ2bntbpGuiBMa3zH4Bdi-XWEgMwnqQ@mail.gmail.com>
Subject: Re: [PATCH 01/23] gpiolib: Correct wrong kfree() usage for `kobj->name`
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 2:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 16, 2026 at 01:15:17PM +0000, Bartosz Golaszewski wrote:
> > On Fri, 16 Jan 2026 09:10:14 +0100, Tzung-Bi Shih <tzungbi@kernel.org> =
said:
> > > `kobj->name` should be freed by kfree_const()[1][2].  Correct it.
> > >
> > > [1] https://elixir.bootlin.com/linux/v6.18/source/lib/kasprintf.c#L41
> > > [2] https://elixir.bootlin.com/linux/v6.18/source/lib/kobject.c#L695
> > >
> >
> > Please don't add links third-party groks to git commit messages.
> >
> > > Cc: stable@vger.kernel.org
> > > Fixes: c351bb64cbe6 ("gpiolib: free device name on error path to fix =
kmemleak")
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 5eb918da7ea2..ba9323432e3a 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -1263,7 +1263,7 @@ int gpiochip_add_data_with_key(struct gpio_chip=
 *gc, void *data,
> > >  err_free_descs:
> > >     kfree(gdev->descs);
> > >  err_free_dev_name:
> > > -   kfree(dev_name(&gdev->dev));
> > > +   kfree_const(dev_name(&gdev->dev));
> > >  err_free_ida:
> > >     ida_free(&gpio_ida, gdev->id);
> > >  err_free_gdev:
> > > --
> > > 2.52.0.457.g6b5491de43-goog
> > >
> > >
> >
> > I've never paid attention to this bit but it really looks broken. I und=
erstand
> > that this string won't get freed until we initialize refcounting on the
> > underlying kobject but reaching two abstraction layers below to get the=
 string
> > for freeing out of the kobject looks incorrect to me.
> >
> > It's also one of only two instances of doing kfree(dev_name(dev)), the =
other
> > one being in drivers/scsi/hosts.c.
>
> That one is wrong, I already rejected it :)
>
> > It looks to me that the device name is not really used in
> > gpiochip_add_data_with_key(). Can we move dev_set_name() after
> > device_initialize()?
>
> This should be cleaned up automatically by the driver core, no need to
> free this on its own.
>

It will once we initiate kobject reference counting from
device_initialize(). The code here still hasn't called it though. It
doesn't look like it'll be freed to me on errors before
device_initialize(). A later patch in this series seems to try to
address it though so maybe this one's not even needed except for
backporting to stable branches.

Bartosz

