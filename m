Return-Path: <linux-kselftest+bounces-36205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BEAF01BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 19:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5451708D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418027EFFD;
	Tue,  1 Jul 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="fCwSNJXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1642741DA;
	Tue,  1 Jul 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390893; cv=none; b=kKrSvXwu0V0OYp+DYL7FWyTQFlLmn0wFTYRNlcQdqWDSIxifJbqbewzmblBnCeknUM3GCX3vkK54xdsnzVGtTURWj422MzybKBVJtydg63CPeg0foogZoWyefwzmigWer557YZYgcL3iOo3ZmVWlcDbNyp7FEL8Qedq9bWIzvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390893; c=relaxed/simple;
	bh=SefuK/BsWTSGg9td9xfzy2e6ut71LLgcl4K//G29a1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9BcmKiGOy0qSy+6ip/9xvBX/iazYHcXA9MaCUg1uWlf8yqxrk7lBJnYxbeo+dOmvevqVQhq3BwIFC7qQbW5pY1Mc5Oriu2rv5UPsp3UgFgx6RXsqRbqBy2CDs8ioomP1Gq7fKJ/XhbQKlom1NdfldNJxKb7isLhv4tQKuuvTNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=fCwSNJXJ; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:1115:0:640:abf2:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 1FB9362065;
	Tue,  1 Jul 2025 20:28:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sRe9KV0LlGk0-EE6VII3p;
	Tue, 01 Jul 2025 20:28:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751390881;
	bh=YBv0jD8rKBC/4rAgNS+GucZmX4U/NADqKv+OE5fzFkw=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=fCwSNJXJ2VZbfLU6Vl34xnSSXiA3NFtwh1iHp4MnpCJTFlVSJUk0+/8xI91d7AjqV
	 LCgE5HzVu7+GYdgwamuwSV0GKRnhLa+WiV0+NHzI5RJOUsj0SWHERHfxmqrNlit+hd
	 ONfVoSDghp0ZaLGp0MyNWKkGZevWIk4moORlJUjQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 1 Jul 2025 20:27:52 +0300
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
Subject: Re: [PATCH v4 0/6] replace `allow(...)` lints with `expect(...)`
Message-ID: <20250701202752.4f3eacc9@nimda.home>
In-Reply-To: <CANiq72keo+NKF75F7qB_Epcbf7fhQqUo27EEVkdet1J2syQfvQ@mail.gmail.com>
References: <20250701053557.20859-1-work@onurozkan.dev>
	<CANiq72keo+NKF75F7qB_Epcbf7fhQqUo27EEVkdet1J2syQfvQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025 10:43:10 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Tue, Jul 1, 2025 at 7:36=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > Onur =C3=96zkan (6):
> >   rust: switch to `#[expect(...)]` in core modules
> >   rust: switch to `#[expect(...)]` in init and kunit
> >   drivers: gpu: switch to `#[expect(...)]` in nova-core/regs.rs
> >   rust: switch to `#[expect(...)]` in devres, driver and ioctl
> >   rust: remove `#[allow(clippy::unnecessary_cast)]`
> >   rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
>=20
> Thanks for splitting this, it is very much appreciated.
>=20
> I think you decided on a split based on similarity (?). In the kernel,
> different maintainers/trees take care of different areas/files (the
> `MAINTAINERS` file describes this mapping). For instance, in one of
> them, KUnit and init is mixed, which are maintained by different
> people.

I didn't know I could use `MAINTAINERS` file to organize my changes.

> That is why the split I suggested was one that allows maintainers to
> pick them independently. With this one, maintainers still have to
> coordinate, which isn't a big deal, since the changes are small and
> straightforward, but the purpose of the split was to avoid that.


I see, I will make sure to use `MAINTAINERS` file as a ref next
time, thank you. :)

Regards,
Onur

