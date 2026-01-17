Return-Path: <linux-kselftest+bounces-49241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EABD390CE
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CD43011741
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2702E1EE0;
	Sat, 17 Jan 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZe4dE5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C02D47E1;
	Sat, 17 Jan 2026 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768680572; cv=none; b=iq22gJO4m/xm+i3cMVvXe2Kl/hjFDmFWaEgwXxzjQIX1p+vo3+s3xOKoFEkbnsGm1LkT6CbS+f8owRoWUTEXVF0oQLD/J7J5Vlak6O6HIHYfJYxCQmUufq5v+EHWnGCcaWQIUrd8jQWvtZ76QFPa8ltfuLkYVVNtO/+rb/s0rpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768680572; c=relaxed/simple;
	bh=yNtUP3cbtCzyqW8w/wWfztOZ+kq6tbeJYUz9d5vkFsc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=PDav/6ialtPZ4SElxXVuB2vYxx0fdBTtXHuFbkg9VNSr57uzoDVwm7rbBZeW8VPiQfEPfX7CtuGpXb2xVGkHo9yyLlANGXksR6Fs6kVX06gGuqr5KEhLgkxzONBWgGqBqyLC317HxAzvjxzNEhJjDOHC0r8d1BwKToO8vReUQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZe4dE5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0331C16AAE;
	Sat, 17 Jan 2026 20:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768680571;
	bh=yNtUP3cbtCzyqW8w/wWfztOZ+kq6tbeJYUz9d5vkFsc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=MZe4dE5CouiTgUw1SfPPNJPZ8YSnikU6bqDH2lG/zalEbetK4WVU1bS0p2CMyq+VF
	 jrKGwgWAPLTai5zHCXSwPOYfMFGmUPMZ8MbpnKP1szccMsG2JiIi4tOTaczWwQeY/T
	 oxYH3SuEh+dk+zTiMF1J2+v4UUSf/qOhRjJGiChWIaZ/I5T3QfJMVjeknsQwFlT+o6
	 3svxIZMeDq7l3H0PJ5/MXSezmS5PAk8jt0bSQxhO6IGy81FTThP+Gz3bm2vdnUu6d2
	 IgmOWUxxMVFpwwtPE7pa1xKCr+bhTtH4OZAdrAmj3QUpbCXQfomywwZ3bRESvh1efg
	 vc3GzOd0nUltQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Jan 2026 21:09:25 +0100
Message-Id: <DFR4XMX2KJR2.14GDPHKYMFWUZ@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <raemoar63@gmail.com>, "Tamir Duberstein" <tamird@gmail.com>, "Igor
 Korotin" <igor.korotin.linux@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>, "Guilherme Giacomo Simoes"
 <trintaeoitogc@gmail.com>, <linux-kselftest@vger.kernel.org>,
 <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/12] rust: macros: convert `#[kunit_tests]` macro
 to use `syn`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260112170919.1888584-1-gary@kernel.org>
 <20260112170919.1888584-9-gary@kernel.org>
In-Reply-To: <20260112170919.1888584-9-gary@kernel.org>

On Mon Jan 12, 2026 at 6:07 PM CET, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Make use of `syn` to parse the module structurally and thus improve the
> robustness of parsing.
>
> String interpolation is avoided by generating tokens directly using
> `quote!`.
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

Cheers,
Benno

> ---
>  rust/macros/kunit.rs | 274 +++++++++++++++++++------------------------
>  rust/macros/lib.rs   |   6 +-
>  2 files changed, 123 insertions(+), 157 deletions(-)

