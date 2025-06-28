Return-Path: <linux-kselftest+bounces-36048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A858AEC757
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67793189C088
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2D20FA9C;
	Sat, 28 Jun 2025 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="G7+w4WaU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C31D5147;
	Sat, 28 Jun 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751116300; cv=none; b=cEvs4JQMd7QcWLTH/1MjuPPaX2r9+p6fzenJjJS+u3MWjGmArwZt7RlaXXbi1aI+Dk5Qhi8Lf1ESAXcOQ5UbBa4K/uvMbRX/rzH7dj/IEE1aDoEpALAgfERneBrpYG9lw1yHGtu8AdXxVREayKhilUcR0VmkDjBW5FUDs6js8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751116300; c=relaxed/simple;
	bh=6kZvgVMupLbitw2H5D7pjE1sklGrjkR/+x5bw4n7WvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpB1f6eaGrOo5WHZL1iEFK59nsjfs4UvdqdASykD4/WRPqbBuGKwQhMGhy5BlWGosw4LZ1Bbhv9CiVaeWxRMBBbrGkbjjqbcSY4SgEABH+iuFVSwWqHPmsxePKLqHx3ieI50TvGSkPP/PRPTMgNNlGvoKCqsiB19rP3aCgCzmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=G7+w4WaU; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:2ea3:0:640:da3e:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id D29C8617DB;
	Sat, 28 Jun 2025 16:11:26 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JBXavsRLuqM0-Q8zSRzbz;
	Sat, 28 Jun 2025 16:11:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751116285;
	bh=HzkPC5GsYJpkwV6UXiIKTgXXNu7YWQ9eeCJ+zRRh5uw=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=G7+w4WaULXDt7zxL4Yp7M+GSS3CyHJdK7zOVFr9HlZIbYluzXadVctSQxCzI99BFa
	 Vnletnp5uAoEMmg+YpWE+tj4RyTKbMyoajwsMGurOTbVr1KHAxtvnxwmy7ko0/avvK
	 nxeNM3oYDLGTdKykNrGOHrLoRK9BleaBPa8/HZWE=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 16:11:17 +0300
From: Onur <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rafael@kernel.org,
 gregkh@linuxfoundation.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, davidgow@google.com, nm@ti.com
Subject: Re: [PATCH v3 3/3] rust: remove
 `#[allow(clippy::non_send_fields_in_send_ty)]`
Message-ID: <20250628161117.7786b3a4@nimda.home>
In-Reply-To: <CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
References: <20250628040956.2181-1-work@onurozkan.dev>
	<20250628040956.2181-4-work@onurozkan.dev>
	<CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
	<20250628133013.703461c8@nimda.home>
	<CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
	<20250628154237.0f367cee@nimda.home>
	<CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jun 2025 14:51:15 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Jun 28, 2025 at 2:42=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
> >
> > Yes, I am sure. Just to clarify, I am not testing 5e7c9b84ad08. I am
> > testing c6af9a1191d042839e56abff69e8b0302d117988 where
> > `#[allow(clippy::non_send_fields_in_send_ty)]` was added on
> > `unsafe impl<T: Driver> Send for Registration<T> {}`.
> >
> > Switching from `allow` to `expect` produced the following result on
> > my end:
>=20
> Yes, of course it does -- what I am telling you (and what 5e7c9b84ad08
> says) is that the lint is disabled.
>=20
> And since it is disabled, if you change the line to `expect`, then it
> will obviously complain.
>=20
> If you actually enabled the lint with e.g.
>=20
>     #![warn(clippy::non_send_fields_in_send_ty)]
>=20
> at the top of the file, and then used `expect`, it will build fine.


Aha, I see. I missed that. I guess `allow` was added when the author
had this lint enabled on their checkout, but their work was merged when
lint removal was merged before that.

Do you want me to update the patch description by including
5e7c9b84ad08 ref and send v4?

Sorry for misunderstanding by the way!

Many thanks,
Onur

