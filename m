Return-Path: <linux-kselftest+bounces-39831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8451EB34438
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5D02A30CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AE92F0694;
	Mon, 25 Aug 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxVDzLGz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA5393DCB;
	Mon, 25 Aug 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132306; cv=none; b=cAwQeCvv4gRi1GEKc/jaZocclc+6Sdsc5LGKJ8z3eN5Ya5cnRo48Gs4OXq7MrHU5zIVGavyGY8k6vL5K880GHE/753Xlt3CSOwa6/5bntu8+cNRzo1GGa7bHPI0mFqgiF3MnvhlPzB+mgRNVpC/rXdOO2NUk1fPwSy+kEwFyPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132306; c=relaxed/simple;
	bh=9NI4GU1BAOwqa1sVUTZsj4DQO6EVHr2Y6HgJsrFNfSo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=H3HAwkAl5n53bxT/SEm+7PMqrLkzH5uVu02NWcKdCqSa+FwTYrdeGKHBbExnk4XJ4r/EPtFmqq/2O2N+mhKcooY0tJI9ZBBkTy9cPQvP994TpVncN9KnseVsKuuCaJKEXrUbJUCH+vTB3GKyiJ/dG+sWrW0QSFJnAsBsdJv/Ge4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxVDzLGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DFC4CEED;
	Mon, 25 Aug 2025 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756132306;
	bh=9NI4GU1BAOwqa1sVUTZsj4DQO6EVHr2Y6HgJsrFNfSo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=LxVDzLGzWvSKzQ7TbZlFBaxzBIkD0TTtWkG57wrT0mxO94XElAT3ktHg7SZPKqg5v
	 owdTC9haicF42q6DOEYzUSQElWnExS2eSw0gA/rhdV7M0d5dQt6O3q601QiI4hAg5z
	 6QJrpmF5Uao5F4bmno6L/m4Pg3vTeCXrm7n9GPK3dMniW6U5fFXijVv11W7+KEtuK/
	 TH8qrsAPagmTNZVlziEDNi5dbnKKKi8LP16+LM3n91/QNnzoYw0hPClR9+qlD0efQN
	 to6YYb/dPHXzDI0Gm43kKXAxNtfvHCs8aapQY3w8S1tCbnVmlQ85dxKqYfHfcv1cG7
	 OVzTo6Fbk7LpQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Aug 2025 16:31:41 +0200
Message-Id: <DCBKY1SJY43S.UM6L2B8AQHOX@kernel.org>
Subject: Re: [PATCH] rust: kernel: remove support for unused host `#[test]`s
Cc: "Alex Gaynor" <alex.gaynor@gmail.com>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Masahiro
 Yamada" <masahiroy@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>, "Rae
 Moar" <rmoar@google.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, <linux-kbuild@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
To: "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250726180750.2735836-1-ojeda@kernel.org>
In-Reply-To: <20250726180750.2735836-1-ojeda@kernel.org>

On Sat Jul 26, 2025 at 8:07 PM CEST, Miguel Ojeda wrote:
> Since commit 028df914e546 ("rust: str: convert `rusttest` tests into
> KUnit"), we do not have anymore host `#[test]`s that run in the host.
>
> Moreover, we do not plan to add any new ones -- tests should generally
> run within KUnit, since there they are built the same way the kernel
> does. While we may want to have some way to define tests that can also
> be run outside the kernel, we still want to test within the kernel too
> [1], and thus would likely use a custom syntax anyway to define them.
>
> Thus simplify the `rusttest` target by removing support for host
> `#[test]`s for the `kernel` crate.
>
> This still maintains the support for the `macros` crate, even though we
> do not have any such tests there.
>
> Link: https://lore.kernel.org/rust-for-linux/CABVgOS=3DAKHSfifp0S68K3jgNZ=
AkALBr=3D7iFb=3DniryG5WDxjSrg@mail.gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to alloc-next, thanks!

