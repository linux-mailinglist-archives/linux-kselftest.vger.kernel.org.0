Return-Path: <linux-kselftest+bounces-36051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5091AEC774
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267DF1BC0A37
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EC1A5B9E;
	Sat, 28 Jun 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ZXWIbWvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB255E69;
	Sat, 28 Jun 2025 13:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751118173; cv=none; b=Insxp2Z+siqFCr7iODyEmwCd0dJG7knjMjKmb8imsSwVHaZ41tXNWE3nn2wMaEkUmtXGQm5BbEucLPwWdVTlhibHRgX49Hy0m+PTahvrqxDh8hWxSiROgSN6Dg0vSWYDO+gcFecr2dEWZc1GDuFM5UYV6trgmjEfyDyutjQWcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751118173; c=relaxed/simple;
	bh=VAee6+av5JH/i3C6FNByMYKYP7UNkqbQVjdUMroatfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfvCMULerd+9OW/amKOJD0ItFsUdQ2b6vKnjVev9+s18oV9u+Kq87z/P+MxJc7azVf4yodrPmUiknR5rhZCLdoleStBia0RIsUBWons6ni9JtztHl8ycOtiEETFZaLr2kOKPyeSa0XIa5qas4MyXK5O8GrXS1zVsB4xWIcCB0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ZXWIbWvL; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2ea0:0:640:5268:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 6CE0461414;
	Sat, 28 Jun 2025 16:42:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ZgXqp0LLu0U0-6beYeotD;
	Sat, 28 Jun 2025 16:42:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751118161;
	bh=VAee6+av5JH/i3C6FNByMYKYP7UNkqbQVjdUMroatfU=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=ZXWIbWvLFBkekQbsXfRUhZj3n8Cyds4+TE0bo9VWS7xaQr4qys+rL3XXS12oHbrjD
	 EL9Fqk9MBTV1RGMStTCZOwvgT1reA7xz6iGtRX3868GtXWgNsFSYHa6TCzL3SkOwxf
	 aS8phWfzvWrm8WzO2c4WWedFmCW1iX6bV80yqYZA=
Authentication-Results: mail-nwsmtp-smtp-production-main-92.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 16:42:35 +0300
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
Message-ID: <20250628164235.1376ab5f@nimda.home>
In-Reply-To: <CANiq72kgB6gQ3+etQOYLLDqWt4EQhiDfN3dcwHBOpZh9USt3iA@mail.gmail.com>
References: <20250628040956.2181-1-work@onurozkan.dev>
	<20250628040956.2181-4-work@onurozkan.dev>
	<CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
	<20250628133013.703461c8@nimda.home>
	<CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
	<20250628154237.0f367cee@nimda.home>
	<CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
	<20250628161117.7786b3a4@nimda.home>
	<CANiq72kgB6gQ3+etQOYLLDqWt4EQhiDfN3dcwHBOpZh9USt3iA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jun 2025 15:28:29 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Jun 28, 2025 at 3:11=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
> >
> > Aha, I see. I missed that. I guess `allow` was added when the author
> > had this lint enabled on their checkout, but their work was merged
> > when lint removal was merged before that.
>=20
> Yeah, some of the code going around was written years ago, so
> sometimes this sort of thing happens. :)
>=20
> > Do you want me to update the patch description by including
> > 5e7c9b84ad08 ref and send v4?
>=20
> Sure -- maybe wait a few days, to see if anyone says anything else.
> Then we will need to wait for Acked-bys from other maintainers.
>=20
> Or, actually, if you are sending a new version and you are willing to
> do it, then it would be easier to land if you split the first patch
> also by subsystem -- that way each maintainer can take their patches
> on their own time instead. Since each patch is independent, you can
> send them in independent patch series, that makes it even easier for
> maintainers to track.

I don't have enough time to do it right now, but I would be happy
to do it in ~3 days during the week (assuming it's still not being
reviewed by the maintainers by then).

Regards,
Onur

