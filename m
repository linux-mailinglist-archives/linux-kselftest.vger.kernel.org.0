Return-Path: <linux-kselftest+bounces-49168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF1D333E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA6C306A0E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0672633A707;
	Fri, 16 Jan 2026 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORBQ1GE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758133987A;
	Fri, 16 Jan 2026 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577728; cv=none; b=GDY3CFuHLfeblCgCv6H/WDnYWi2I4pikTj2QW9vfIm1cuqCw1/VFMPGBrjaZjEH0OenfbD1mUdh8prUrKgKj61BuX71T5IH5W6BwL58mYFK+9zAv4PCWzlGubxc+stnFZrqKVTpvn/aIzNpm5jn3SyVKm8PvNCkHcq+RCcfntd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577728; c=relaxed/simple;
	bh=4PoH/DebIJz2+Pz5XFGoXyTAH2jrdRT9HWeJf8Q8LJc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=I4xzYTLScO6Tmoy5FJguLyfxzkLY/rnbEXF9xQqFte7VQrvutaTHTAoeqi6F2zvCP68p/y7sMABRQFSCRwO4ospF0mhpRoGzAgjUVNjntAccb6FWqvAvNaJ0mstWjPRiODouDgYe8VAf2Vr4EGC/kD8BSm+9E8Rkqv3ju9+FxJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORBQ1GE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A9EC116C6;
	Fri, 16 Jan 2026 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577728;
	bh=4PoH/DebIJz2+Pz5XFGoXyTAH2jrdRT9HWeJf8Q8LJc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ORBQ1GE1PtqvGzR5OEr5zxCmarn/cEUxPYNtst4iZ4RsTY2Gt/FBoXJzyLeKTKuZB
	 6IG3vLNlavrlVkgTSv1bftproTJvSswT8hDvhxHXIk+tgHnd0cGkM13+iSYDHdoeaE
	 AHdQAYAjGlmH+yWXPEEuDPdMcr8WczSoBN1egcLr5TMSnJ8g/F3Toew8jw+VTclwqJ
	 /PHkV0q+KH1QBIClIKDNDCesiQHqbNu0KTcQ3ckuxP29wZjGHTPPilYoJXN7OEfWRd
	 +fX5NIY6NH3SbwcHIh+kUDa4s2qwDa9j1wP1JUkUcsTL6V8xEUJRWoZ1Jl8c4DzpFk
	 O6mweEzxAZO/w==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 16:35:23 +0100
Message-Id: <DFQ4H9T3QMLK.3TNZF7ID6EJB6@kernel.org>
Subject: Re: [PATCH v7 1/3] revocable: Revocable resource management
Cc: "Tzung-Bi Shih" <tzungbi@kernel.org>, "Benson Leung"
 <bleung@chromium.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, "Linus Walleij"
 <linusw@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <shuah@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
 <linux-kselftest@vger.kernel.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Dan Williams" <dan.j.williams@intel.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, <linux-gpio@vger.kernel.org>
To: "Bartosz Golaszewski" <brgl@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260116080235.350305-1-tzungbi@kernel.org>
 <20260116080235.350305-2-tzungbi@kernel.org>
 <DFQ45FWO4XHC.2BW7I9LGC76WT@kernel.org>
 <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>
In-Reply-To: <CAMRc=Medaqr5UPimc8o+VTy=9MgU5p8AXjArisQfBNqi7ktSGg@mail.gmail.com>

On Fri Jan 16, 2026 at 4:27 PM CET, Bartosz Golaszewski wrote:
> On Fri, Jan 16, 2026 at 4:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> On Fri Jan 16, 2026 at 9:02 AM CET, Tzung-Bi Shih wrote:
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index a671e3d4e8be..fd683c62012a 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -22517,6 +22517,13 @@ F:   include/uapi/linux/rseq.h
>> >  F:   kernel/rseq.c
>> >  F:   tools/testing/selftests/rseq/
>> >
>> > +REVOCABLE RESOURCE MANAGEMENT
>> > +M:   Tzung-Bi Shih <tzungbi@kernel.org>
>> > +L:   linux-kernel@vger.kernel.org
>> > +S:   Maintained
>> > +F:   drivers/base/revocable.c
>> > +F:   include/linux/revocable.h
>>
>> NIT: I think we should add this include to the DRIVER CORE entry as well=
.
>
> FWIW: I'm not even sure drivers/base/ is the right place for this.
> Except for a few devm_ helpers, nothing here is inherently tied into
> the driver model This could be useful outside of device drivers and I
> would suggest to put it under lib/ with devres factored out into a
> separate source file.

It is indeed correct that in the end revocable is more of a generic
synchronization primitve.

In fact, the Revocable type in Rust is not listed under driver core
infrastructure either. However, it was introduced for use with Devres (whic=
h is
still the only user).

I think the, by far, most common use-case where a resource is revoked from =
an
entity are device resources revoked by devres.

So, I'd say let's factor it out once we see interest by more users?

