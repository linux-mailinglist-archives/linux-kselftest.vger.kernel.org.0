Return-Path: <linux-kselftest+bounces-36036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0910AEC691
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7496A69DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34B1FBE80;
	Sat, 28 Jun 2025 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="NhjXIQ2b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E14A3C;
	Sat, 28 Jun 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751106633; cv=none; b=RKl2tAc7KTHxv4VxYBVNWAifr7IytNmoX/7mhd1XyKfU4t/jnyXwhKein0kbsxeR3IBHDZsxp+75wM+HYXP8qz4281hpobnIU/I7rNd9SGM1RbTn0WjLRw7L12nE/Kf1uC9Ai8Li2EEGrlUFRUzxBPd5rJKTqSM+QdQV2KLv3rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751106633; c=relaxed/simple;
	bh=uQhRKDxK2mabMgCqoieFovOw4kdCdDL7hqMmNvBVq1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hESvwOd4OC7h5GNXqJpXC82a+G+NE9IGAI7wrACh7XKAsPNwvsIpKEIPOcWPfGEICJF84rmONNhCFJjHSBYXMVg2jkp9yD0GfMjhTgZdbsKnAS8pYoAyTD4vahR0QIsRZK+1qqhLEojF/OKnsX9/ICJwb9QrLYtVwMnMvo8il2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=NhjXIQ2b; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:82a4:0:640:9cc1:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 847CA6140A;
	Sat, 28 Jun 2025 13:30:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FUUIxAMLliE0-iaB20H8x;
	Sat, 28 Jun 2025 13:30:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1751106620;
	bh=uQhRKDxK2mabMgCqoieFovOw4kdCdDL7hqMmNvBVq1w=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=NhjXIQ2bggrzxKaYhfubQknCHqyk6QZICObr3m6HDPo2sRSdLba6UHytf1es05UqC
	 CxHrGU8uV2M9ExsJ+PPeniwqeZ9iHt0rKjI+3C58JHDfFrRDXFkRDW3zhEaLLqE2sU
	 443MrhPJZzvVknbVSGMghG2CUeD4qzdzSWgpkJQE=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 28 Jun 2025 13:30:13 +0300
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
Subject: Re: [PATCH v3 3/3] rust: remove
 `#[allow(clippy::non_send_fields_in_send_ty)]`
Message-ID: <20250628133013.703461c8@nimda.home>
In-Reply-To: <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
References: <20250628040956.2181-1-work@onurozkan.dev>
	<20250628040956.2181-4-work@onurozkan.dev>
	<CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 28 Jun 2025 09:13:50 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sat, Jun 28, 2025 at 6:10=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > Clippy no longer complains about this lint.
>=20
> Do you have more context? For instance, do you know since when it no
> longer complains, or why was the reason for the change? i.e. why we
> had the `allow` in the first place, so that we know we don't need it
> anymore?
>=20
> For instance, please how I reasoned about it in commit 5e7c9b84ad08
> ("rust: sync: remove unneeded
> `#[allow(clippy::non_send_fields_in_send_ty)]`").
>=20
> (It may happen to be the same reason, or not.)
>=20
> Thanks!
>=20
> Cheers,
> Miguel

It doesn't seem to be the same reason. I rebased over
c6af9a1191d042839e56abff69e8b0302d117988 (the exact commit where that
lint was added) but still Clippy did not complain about it on the
MSRV. So it was either a leftover, or there is a version between
1.78 and the current stable where Clippy did complain. I can dig into it
more during the week if you would like.

IMO, we should require people to add a comment explaining the reason
for adding these lint rules to the codebase. It would make both reading
and modifying the code much simpler and clearer.

Regards,
Onur

