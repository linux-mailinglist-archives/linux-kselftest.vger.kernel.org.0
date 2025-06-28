Return-Path: <linux-kselftest+bounces-36022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63473AEC4BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 06:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34F41C4237C
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 04:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567DD1DACA1;
	Sat, 28 Jun 2025 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="fGUJH4so"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290C198A09;
	Sat, 28 Jun 2025 04:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751083743; cv=none; b=mZLIPsWcedEoSgFQ639L02hE+lGAfTh7smBKK7pOKuMgpU2spOZ/4H++x5WyboOSjfFGJ8cO1Of/vTw1VoDCmzlHn1OsERr37flSgYnr/rVkZeqgimSG/fNfQImkSzQ4n7hbFWkkEecq3z+vT+KgzCXjfL7LPA9/YOI/5v+/g/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751083743; c=relaxed/simple;
	bh=lMQKY/ZkZtxduR3viyCkwBW+r03pBblru1OA3JOf4O4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyIYkVrh+aX3xcPuAux1XjEtNns1BKw77LrLuRniXFzCVWmJrIJyUjTZPRtSbHcLTkZyZ18gapVp5fG1QdPQDDtHXk3QyrOtSd1QheS6135U4RZAbcs/j1oR5Z8aT/OfxwkElzhCj7pBQm2tK/7hcHDO4M0nh+vwR/4aFH8L/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=fGUJH4so; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:71ad:0:640:c587:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 59BAC615B6;
	Sat, 28 Jun 2025 07:03:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id m3ODbJNLlSw0-xbFbnZHy;
	Sat, 28 Jun 2025 07:03:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751083434;
	bh=lMQKY/ZkZtxduR3viyCkwBW+r03pBblru1OA3JOf4O4=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=fGUJH4soG8DEFhAQYGm/jUQ7VyxuWbZ7N4vM2Kox9HD3orPM9K+8csVltTiBnDpha
	 jfi5Eu0Wzo4ONJEVd0bwYGbqScARbgZ8FXrIAmrlMvSDC3Oki0IpdeyGWQhiuK32oZ
	 midCYPr+pQfVn5i0zQadjq9kIg0m5UpiRIiydds0=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 07:03:45 +0300
From: Onur <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 rafael@kernel.org, viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 davidgow@google.com, nm@ti.com
Subject: Re: [PATCH v2 0/3] replace `allow(...)` lints with `expect(...)`
Message-ID: <20250628070345.5499a7bf@nimda.home>
In-Reply-To: <CANiq72mMEEdP1ZG2brhLWgjaQpnwG+Mcxm43B0hAvZuaq-=jBA@mail.gmail.com>
References: <20250627065320.9315-1-work@onurozkan.dev>
	<CANiq72mMEEdP1ZG2brhLWgjaQpnwG+Mcxm43B0hAvZuaq-=jBA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025 17:55:41 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Fri, Jun 27, 2025 at 8:54=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > The `#[allow(clippy::non_send_fields_in_send_ty)]` removal was
> > tested on 1.81 and clippy was still happy with it. I couldn't test
> > it on 1.78 because when I go below 1.81 `menuconfig` no longer
> > shows the Rust option. And any manual changes I make to `.config`
> > are immediately reverted on `make` invocations.
>=20
> For that, I recommend using the `/` command inside `menuconfig` -- it
> allows you to see the dependencies of a given symbol, and whether they
> are met or not. That way, it allows one to understand what else may be
> missing to enable a symbol.
>=20
> I hope that helps.
>=20
> Cheers,
> Miguel

I already tried that but it didn't helped. I was able to make it work
with manually hacking the `init/Kconfig` file.

Removal of `#[allow(clippy::non_send_fields_in_send_ty)]` still works
as expected, but using `#![expect(internal_features)]` (which was done
in the first diff) doesn't work on 1.78. I will revert that and send v3
patch in a short.


Regards,
Onur

