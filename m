Return-Path: <linux-kselftest+bounces-47598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F105FCC1DBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 10:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950063021FA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 09:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6813346AA;
	Tue, 16 Dec 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APpKDzVH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5018F219A8E;
	Tue, 16 Dec 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765878478; cv=none; b=KY4meiOnAf6v5a5XbqVVaMBi0OzI97ALXmWIEX5AeUbPSyaSai00n3iRQNWVkN3FTE+JyAlp44gEeYdWZa7ida9i4bUxaLoBxRA+7EXLMHtStA5D8FU5Bde++vBevvD/ZAADKuVU6WlrpjmCTiNK/0HERgFJv3PGlWstIpYbwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765878478; c=relaxed/simple;
	bh=doVzXgniW8zc2KcAcGi0KSPD8+Sd3f6BFM/+QMKljBE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tARXSAyuCpskFFd2+30iwBzn1+SR/o72uaGynDhA9kyOTh9f/uYeDGxO2LsuSvhNWxYxh6FA1fNlCjltQhWs1/qhQwmtKZxl0xRHGLhyZW+xn5VegPMZ0yjBzuadFg2V19LTT+8a9UAU+W66/Om7p36U3l0Poo9rJFW3wKnMnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APpKDzVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F08C4CEF1;
	Tue, 16 Dec 2025 09:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765878477;
	bh=doVzXgniW8zc2KcAcGi0KSPD8+Sd3f6BFM/+QMKljBE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=APpKDzVHxF/oYIoFPMkfk+a1SoB3FNTuLkyP6XERl+KKfTO5GOFKysg1H8AIOqzWc
	 ZlS+yVq0veVxFKfs9TCo0QTbCcxV2scZyRoNyp/xCnDOUum7FsHPzxonSEM0CEFukn
	 jVDqz/V2gtE+sJmxS9ZCpn5pdr2yzF1boLD2DeuihxV1YzdQdUAyAxiimNDrNScKUB
	 MgNB2gdxtm9wo5wz07l0UFD9ZHMoi2yW5Oh0anuLVHVEEkiA5WVa0XIFAreg8ZDqmI
	 nawvgaahTyQzsLLArZGYlrkiFmIGQe2qtIBnvpbcELbYBlWy9M27vn1VRxagc5pgP5
	 0SJpkHX19PxSQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Dec 2025 10:47:51 +0100
Message-Id: <DEZJOAT8ERZ5.34R3FCWWNF065@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>
Subject: Re: [PATCH 02/11] rust: macros: use `quote!` from vendored crate
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <raemoar63@gmail.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Tamir Duberstein" <tamird@gmail.com>, "Fiona Behrens" <me@kloenk.dev>,
 "Igor Korotin" <igor.korotin.linux@gmail.com>,
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>, "Guilherme
 Giacomo Simoes" <trintaeoitogc@gmail.com>
X-Mailer: aerc 0.21.0
References: <20251211185805.2835633-1-gary@kernel.org>
 <20251211185805.2835633-3-gary@kernel.org>
In-Reply-To: <20251211185805.2835633-3-gary@kernel.org>

On Thu Dec 11, 2025 at 7:56 PM CET, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With `quote` crate now vendored in the kernel, we can remove our custom
> `quote!` macro implementation and just rely on that crate instead.
>
> The `quote` crate uses types from the `proc-macro2` library so we also
> update to use that, and perform conversion in the top-level lib.rs.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/macros/concat_idents.rs |   2 +-
>  rust/macros/export.rs        |   4 +-
>  rust/macros/fmt.rs           |   4 +-
>  rust/macros/helpers.rs       |   2 +-
>  rust/macros/kunit.rs         |   3 +-
>  rust/macros/lib.rs           |  21 ++--
>  rust/macros/module.rs        |   6 +-
>  rust/macros/paste.rs         |   2 +-
>  rust/macros/quote.rs         | 182 -----------------------------------
>  rust/macros/vtable.rs        |   3 +-
>  10 files changed, 28 insertions(+), 201 deletions(-)
>  delete mode 100644 rust/macros/quote.rs

> @@ -275,7 +273,7 @@ pub fn fmt(input: TokenStream) -> TokenStream {
>  /// ```
>  #[proc_macro]
>  pub fn concat_idents(ts: TokenStream) -> TokenStream {
> -    concat_idents::concat_idents(ts)
> +    concat_idents::concat_idents(ts.into()).into()
>  }
> =20
>  /// Paste identifiers together.
> @@ -413,9 +411,12 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream=
 {
>  /// [`paste`]: https://docs.rs/paste/
>  #[proc_macro]
>  pub fn paste(input: TokenStream) -> TokenStream {
> -    let mut tokens =3D input.into_iter().collect();
> +    let mut tokens =3D proc_macro2::TokenStream::from(input).into_iter()=
.collect();
>      paste::expand(&mut tokens);
> -    tokens.into_iter().collect()
> +    tokens
> +        .into_iter()
> +        .collect::<proc_macro2::TokenStream>()
> +        .into()

There is no `FromIterator` impl on `proc_macro::TokenStream`? Sad :(

Cheers,
Benno

>  }
> =20
>  /// Registers a KUnit test suite and its test cases using a user-space l=
ike syntax.

