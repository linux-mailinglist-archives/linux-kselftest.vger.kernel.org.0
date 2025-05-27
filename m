Return-Path: <linux-kselftest+bounces-33851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E7AC4E33
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EC5188A496
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF19D267B9B;
	Tue, 27 May 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF45kAWw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0F2641CA;
	Tue, 27 May 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347613; cv=none; b=KX/P6FxjPxKAeAx8sRyrhF8PSFxRXHrzjmQP8SoZhjnl7tt75d8IalptZXQr7m/gXtO44/54wbPNVW2NbJHNZrBhwcVrDNPLRwNnWvVPVKPp4xRo/tcJEXe1rYH0KVHFaVW9ceovhYI2K3qCzyeYDF5IWKiFt10J5qBjbjNKyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347613; c=relaxed/simple;
	bh=RXDbnBymAlSsSIpER/QV+lZ97Yk/cvFyNkxvhvW7rhw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YpW/P4UDR1+HeW3VgVPPxFt7slNPHWRobvEifrH458/iM0gaJetIqAW9d9rf5fMsmdPZly1YySquuB5IFLp7jFAhCcei/u6RdKgunMr6y39xWAeK8i9t0ti8NODLYBzYNERHbB1jgldKeqpV8kaatCNe3/cMbpG7FCrCHxJbs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF45kAWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F67C4CEE9;
	Tue, 27 May 2025 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748347613;
	bh=RXDbnBymAlSsSIpER/QV+lZ97Yk/cvFyNkxvhvW7rhw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=LF45kAWwqzc+RzdywBYfELSXxD3ncUbPKHKWc8cE5JEEYkptAnlAZomEl+WRn1ZRt
	 yhU0t9RVEZOYEtF+3Nl4VI7XLziO7byu1h/mZyQisVblBxBU+3Vvn41PvztXeFNRF8
	 e3/MJ7TpkIFjdK1N8E+P93ESX9cf2hGQP+OCiIGR/e0bpSJmEsrayrkfwLKxHfXjdu
	 fxaCkr3XEBzk+ZvcPHl7QaQA4739SamxajuurWPGSnuiSGvVJYj5t/kJpIMczXUR8m
	 NDhRfVkknaNRCx4dkxSvYYo4E3RsSomCxQhRMt+wCh94RDxF3DzCMpeq3bLcSsCl/d
	 iML0sm2dp1PWA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 May 2025 14:06:48 +0200
Message-Id: <DA6XI37GNRHE.1FN5893KE2OIG@kernel.org>
To: "Jesung Yang" <y.j3ms.n@gmail.com>, "Brendan Higgins"
 <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Rae Moar"
 <rmoar@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: kunit: use crate-level mapping for `c_void`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250526162429.1114862-1-y.j3ms.n@gmail.com>
In-Reply-To: <20250526162429.1114862-1-y.j3ms.n@gmail.com>

On Mon May 26, 2025 at 6:24 PM CEST, Jesung Yang wrote:
> Use `kernel::ffi::c_void` instead of `core::ffi::c_void` for consistency
> and to centralize abstraction.
>
> Since `kernel::ffi::c_void` is a transparent wrapper around
> `core::ffi::c_void`, both are functionally equivalent. However, using
> `kernel::ffi::c_void` improves consistency across the kernel's Rust code
> and provides a unified reference point in case the definition ever needs
> to change, even if such a change is unlikely.
>
> Signed-off-by: Jesung Yang <y.j3ms.n@gmail.com>
> ---
>  rust/kernel/kunit.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 81833a687b75..bd6fc712dd79 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -6,7 +6,8 @@
>  //!
>  //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
> =20
> -use core::{ffi::c_void, fmt};
> +use core::fmt;
> +use kernel::ffi::c_void;

We don't need to explicitly import it, as `c_void` is present in the
prelude since 3d5bef5d47c3 ("rust: add C FFI types to the prelude").

With the import removed:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

