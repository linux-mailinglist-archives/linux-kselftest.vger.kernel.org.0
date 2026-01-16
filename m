Return-Path: <linux-kselftest+bounces-49197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD1D38456
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 19:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CBD730066C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 18:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBC8349B16;
	Fri, 16 Jan 2026 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4SGA+/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDE31B100
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588326; cv=none; b=VcOomRGKTRK6cr6nDn12YAFIjivoTEoAuJBz75u8bBp/eK5SERTyiiQ6aLzjqNkMYhh32XQDa3/8R56fqPXdMugirlgMdOE2r64UZDG6OFXcyFA+jKBsRvFNNeOVSsyLyyOVxWTYs24OEHnzZP1wR+ewTvZBCzxfZoR/fUBO260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588326; c=relaxed/simple;
	bh=Ss7qiRqTeuY+VD+9H9/ZWNCvERV6Dkawhl4DEc9LoVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tX1CuzGDPUI1VsAvY/XmJbJQjJgVV2W1gpKx/PDVKKWX9vep3Wnv2+lH0FP7M5HqAgfafuIMOL/z6E9hzGWAPhgxITvMRzHsBjEWFCaQ7IYDjGzHtGVgiF5QQcFNBXs3fdl2iliwjNc8EirzXUsb6zf85zAy8K0E0nH2U9HO/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4SGA+/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8869AC4AF0B
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588325;
	bh=Ss7qiRqTeuY+VD+9H9/ZWNCvERV6Dkawhl4DEc9LoVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b4SGA+/1MZXjRUOv6t/Nl8NtJ/OLE9LVuNugo9h6zdSvVvdEmabRufWLmKz2c+Vhy
	 +bbjsOm4lhhi70Bb2IF6Am1apRaUIVDgVHhHFCf3miqVmjr8J0/X5JrpofEmx0fJ56
	 u+r9m1oXG4y8YOHIhn/PcguhnDW1O4/mIF346Py2RNG8seasZ29/mxrCec6JtqAkUQ
	 Fwvrlhpn9jJ6KJydXlQBRPSGu+wcOrk0fIWswrZ41m8XSG1KmGhjtxpqI4QMNfg3hD
	 QPavFKm/WZDhd1vxAfUkpwj4YQYHogJJfPe5/6H4glBBPFVqo4FzMqC2XDS0QGbAKh
	 BGxHq+jgsO3Jg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b6a987346so2207655e87.3
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jan 2026 10:32:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZ2h4TR9BHDTgQB+9J/RV5JOV/2dtfYS4/ipa2Kfwku+KNp1CWwbiVCPU0/4EcFYhbzt8CdzTYeQEYJbZ4iPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiilPjSjta5U4oDD5/PLFR+E9YMxQKjW8Dew3Ul2cj2aKyLam
	0Equw4SHZ8Vv6hVWPiPpA+VGPL8Kt1zJht8F7398bpRPs70P/opE6NjafdvjYXo9rLbtKvvVcxg
	Jdodpef0N7FkXYtxPH/XPTas7yr0vFdidl4L0D/TDMQ==
X-Received: by 2002:a05:6512:b81:b0:59b:9f92:301f with SMTP id
 2adb3069b0e04-59bafdb63a8mr1058854e87.7.1768588324162; Fri, 16 Jan 2026
 10:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116080235.350305-1-tzungbi@kernel.org> <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org> <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
 <20260116160424.GA14499@pendragon.ideasonboard.com> <DFQ5W41X6Z7S.3V6FRPXYMDJ1F@kernel.org>
 <CAMRc=MfAZxzd2hjqgDsXBR+UxgkaEQX0vR5nNZ=a+5WccUb4GQ@mail.gmail.com> <20260116182431.GA1134360@nvidia.com>
In-Reply-To: <20260116182431.GA1134360@nvidia.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 19:31:51 +0100
X-Gmail-Original-Message-ID: <CAMRc=McsrthHS4kcV7UkmdVFS4nr9vXe8Z_kQODvMUYxVkE8KQ@mail.gmail.com>
X-Gm-Features: AZwV_QhX6LG8DkljEPjMvfuFGbrj6wIYYufM6rhcWWImQbypzvqc5Ui2tF-rlh8
Message-ID: <CAMRc=McsrthHS4kcV7UkmdVFS4nr9vXe8Z_kQODvMUYxVkE8KQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dan Williams <dan.j.williams@intel.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 7:24=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Jan 16, 2026 at 07:19:50PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 16, 2026 at 5:41=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Fri Jan 16, 2026 at 5:04 PM CET, Laurent Pinchart wrote:
> > > > Based on the discussions we had at LPC, the revocable resource mana=
gement API
> > > > is not the right solution to handle races between device removal an=
d userspace
> > > > access.
> > >
> > > Please see: https://lore.kernel.org/all/DFQ5D44A0348.PZJIGPL972N@kern=
el.org/
> > >
> > > > It is however a possibly useful tool for races between producers an=
d consumers
> > > > *inside the kernel*.
> > >
> > > Do you have an example for such a case?
> >
> > Isn't the GPIO use-case - which the series on top of it addresses - one=
?
> >
> > With fw_devlink=3Doff it's quite easy to trigger all kinds of crashes
> > with in-kernel users.
>
> Does this series solve that? It looked to me like it just replaces the
> existing SRCU with a wrapper?
>

SRCU already *did* solve it. Revocable *is* a wrapper around SRCU that
generalizes the initial solution.

Replacing SRCU with a generalized wrapper is fine but there are
subsystems out there, where the problem is much less trivial. Take I2C
for example: the struct device management is so broken that there
isn't even anything *to revoke* yet. It'll take years of little
reworks before we can even use revocable at all.

I'm not against it as a library of functions. But TBH I looked at the
series and - besides making the code run slower - it also kind of
makes it harder to read. With *naked* SRCU it's very clear what's
going on, when you start hiding the logic, it becomes needlessly
obfuscated.

I want to first see revocable match current GPIO performance and then
we can talk about accepting it.

Bartosz

