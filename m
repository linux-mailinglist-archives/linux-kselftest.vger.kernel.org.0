Return-Path: <linux-kselftest+bounces-49472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 696A3D3C320
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF4D268058C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E673B8D4E;
	Tue, 20 Jan 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucLZQAR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804353B8BBB
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768898961; cv=none; b=nYK4cH3R2mUddsg5d+BswSJwvxiDbBpFuk+DlNJJEFiJ05k7xDzhFVCsIgbBrPVQ5iXenGNgoDGTNMJ/0k1xd5N0ZlmJMzLZjVHvZvm2kjq1qETimAauNr2SJWwsBngXVwQk3uOFz9eMd4095HAqr/BrcGGjhjT2Pr7onxBiLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768898961; c=relaxed/simple;
	bh=LItWGG7vJFV8Z6lwaP47B6AzEaYXFT8Zo38po2X7m2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoqLA7UdEZ8nbLWXLlwScnYd6p2XUOXCmJJWA2JmOp65QfY0+2LBnNB32CLsAxjCi3p72+R66okLsC5AzYtYNMxOcM2xojIVhpJoEYQ7qjNTNzLPY2qK6kW8YVNolwVrZ1iGf1WPpy45sgOCeGqNgyl90iBHbUKc2rgLf4VEZGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucLZQAR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444BDC19424
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768898961;
	bh=LItWGG7vJFV8Z6lwaP47B6AzEaYXFT8Zo38po2X7m2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ucLZQAR+oVbyOm4uhSJ2XNi9bOTMVpjisCRVewgPNDrRkIQsNhD4RvUC7nnSWD7ip
	 U0CYRZNMw6SqPYDd+kUZSvntYRShAHzA0BpCC2nOJvDcLTh5gaiayu13MGd2vVHdvd
	 n4/I/38oKSIAWDTWR5o2YoT6GoLlx3pDaRbIgbCTTBsglAzH4cWIb9dENDLyB/iq7M
	 tiwCHTWrovEAAGevA9lnJA05gxX266ISzCJVwQwmBjsctw0tdKaX68a2wkfg7TADtp
	 a7eHhl9kjEdD8Q50M+PCNaW+Y9JyJma76Bw7CW/5d7FWh7M3Sh1MhgfrDq5MIOqolD
	 y5UNHDN5zEJYQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59a10df8027so5808502e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jan 2026 00:49:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTcXITs6UnDrmUGR0JnyXGWpAq1mRE4sCPQcNgbYgMTZSqJJ1MhtFl3WoEienmApdISOEpPMVcRkuUr4sUzqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6a+Ir0MilN+edj7SvnLQbmAWavpLAeq0fCMSveXo3VnGAZuV
	pKKsViCNT26BT9cc/wPdrNgyvOrSSkOLd+SCjHqPFWzcHk8/3xE1tOi9thPkFaxwUi2/BevAihx
	6sC9PUYfVCOMxHJIkdbjdsIx9PBrVcwbypQYg3dgJAw==
X-Received: by 2002:a05:6512:12c3:b0:59b:8259:5fcc with SMTP id
 2adb3069b0e04-59baeef0c8amr4645725e87.52.1768898959765; Tue, 20 Jan 2026
 00:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116081036.352286-1-tzungbi@kernel.org> <20260116081036.352286-5-tzungbi@kernel.org>
 <CAMRc=Mc4UoXif=vwUQG1jYW8G3QziZwbdcfvZGquytdrd4SBpg@mail.gmail.com> <aW7yazJvgRu-WyZQ@google.com>
In-Reply-To: <aW7yazJvgRu-WyZQ@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 20 Jan 2026 09:49:06 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mc65Oo9hHNXu3pxv-9PqgBnbWLyKYaPO5C9R5s07bkB2Q@mail.gmail.com>
X-Gm-Features: AZwV_QjlXTj3OPUDAGm9xmA9ueX3pxZH12LDy0PJ8wJfK3l5w55VKf2MBS8AxUQ
Message-ID: <CAMRc=Mc65Oo9hHNXu3pxv-9PqgBnbWLyKYaPO5C9R5s07bkB2Q@mail.gmail.com>
Subject: Re: [PATCH 04/23] gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, linux-gpio@vger.kernel.org, 
	stable@vger.kernel.org, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 4:11=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Fri, Jan 16, 2026 at 01:26:01PM +0000, Bartosz Golaszewski wrote:
> > On Fri, 16 Jan 2026 09:10:17 +0100, Tzung-Bi Shih <tzungbi@kernel.org> =
said:
> > > On error handling paths, lineinfo_changed_notify() doesn't free the
> > > allocated resources which results leaks.  Fix it.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: d4cd0902c156 ("gpio: cdev: make sure the cdev fd is still acti=
ve before emitting events")
> > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > ---
> > >  drivers/gpio/gpiolib-cdev.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.=
c
> > > index ba1eae15852d..6196aab5ed74 100644
> > > --- a/drivers/gpio/gpiolib-cdev.c
> > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > @@ -2549,7 +2549,7 @@ static int lineinfo_changed_notify(struct notif=
ier_block *nb,
> > >     ctx =3D kzalloc(sizeof(*ctx), GFP_ATOMIC);
> > >     if (!ctx) {
> > >             pr_err("Failed to allocate memory for line info notificat=
ion\n");
> > > -           return NOTIFY_DONE;
> > > +           goto err_put_fp;
> > >     }
> > >
> > >     ctx->chg.event_type =3D action;
> > > @@ -2563,6 +2563,9 @@ static int lineinfo_changed_notify(struct notif=
ier_block *nb,
> > >     queue_work(ctx->gdev->line_state_wq, &ctx->work);
> > >
> > >     return NOTIFY_OK;
> > > +err_put_fp:
> > > +   fput(fp);
> > > +   return NOTIFY_DONE;
> > >  }
> > >
> > >  static int gpio_device_unregistered_notify(struct notifier_block *nb=
,
> > > --
> > > 2.52.0.457.g6b5491de43-goog
> > >
> > >
> >
> > There's only one place where you need this fput(), please do it directl=
y in
> > the error path of kzalloc() and drop the label.
>
> Sure, just wanted to give a heads up: 17/23 might introduce the label bac=
k.
>
> v2: https://lore.kernel.org/all/20260120030857.2144847-1-tzungbi@kernel.o=
rg

That's alright, we prefer a smaller patch for backporting.

Bart

