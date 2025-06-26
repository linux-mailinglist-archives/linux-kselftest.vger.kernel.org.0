Return-Path: <linux-kselftest+bounces-35851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4542AE9B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61464A715A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7445B221F38;
	Thu, 26 Jun 2025 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="AqlIhmXM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE0C221FA8;
	Thu, 26 Jun 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933033; cv=none; b=AZwRxLFcAVNWlBvokR9X6Vl8ytLaQiyiF+evScmMu1NOeEZc7AIDgkNGdiHSNE7ULBL+mJv4iiG9BvPX6loi5C0hGvHtNjM631BQi9IZmpeX7iiFmXXgUdRm1doQinNEITEGAwM3SeNb19O4vWRvMbhJ+bontLQ1PsflUpeVyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933033; c=relaxed/simple;
	bh=LW0ekEF132zirr3/C0iPKEdjIqOsqdj1sSpsqbrp2ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o6wZiBnn92kA+9s0e4Kl+Ks+ldeeoCQpEWE/Rk75EqNXXrJbM+wMnZjq0pgk8hI4yrx6H3cYqov5bHhnawg24JdFTMAlRHxQsmM4/mX9+srkZ9zztJK2qOqINyl5RjtNBoTQV2h+JGw49L0/O9sQgS5viBCtq7+w4Jf3r2elD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=AqlIhmXM; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:3b23:0:640:a115:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 07922620DB;
	Thu, 26 Jun 2025 13:09:50 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id a9SiQLjLaGk0-QaEKKLEt;
	Thu, 26 Jun 2025 13:09:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1750932589;
	bh=LW0ekEF132zirr3/C0iPKEdjIqOsqdj1sSpsqbrp2ng=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=AqlIhmXMu1HgwANBpx1gwlwJSdK2mFxNBgcLe+XjtbneZPYgMay/fVYeeo+s26nPJ
	 svmn6k/mORV0xESmCEZ/Tj7807Mbiz/7+no8e+O6h0JNq/Jpb1tnoIlhaBhLIlKnNv
	 BDm8/sEIgXcritMKpV/XG8thJ+TlOLfvDkAPnOUw=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 26 Jun 2025 13:09:36 +0300
From: Onur <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, rafael@kernel.org,
 viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 davidgow@google.com, nm@ti.com
Subject: Re: [PATCH 2/2] rust: drop unnecessary lints caught by
 `#[expect(...)]`
Message-ID: <20250626130936.3c8b25dc@nimda>
In-Reply-To: <20250626100448.27921-3-work@onurozkan.dev>
References: <20250626100448.27921-1-work@onurozkan.dev>
	<20250626100448.27921-3-work@onurozkan.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Jun 2025 13:04:48 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> From: onur-ozkan <work@onurozkan.dev>
>=20
> They are no longer needed.
>=20
> Signed-off-by: onur-ozkan <work@onurozkan.dev>

Oh crap... This should be "Onur =C3=96zkan" not "onur-ozkan".
I forgot to update that in my 2nd computer, which was used
to send this patch.

