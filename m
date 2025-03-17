Return-Path: <linux-kselftest+bounces-29205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A1A64B0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C10016F741
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC462235371;
	Mon, 17 Mar 2025 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQJtQuoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AF233141;
	Mon, 17 Mar 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208840; cv=none; b=XbBXkUuxUTDSYcULXowK1ilLaZ5MFtCnk2NXm1nVyCxQBngEbRQhbMgCCa9Xqd9qE/IMpp38UhnOr0OP4y+isW8dQagHz3q6AP82EuIUAW3KzrKZw6fDzx6TeAA/K2DT8SyLMGStDP0RhoMmwjvrHuoLMaCAsmqq06pDfVhdaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208840; c=relaxed/simple;
	bh=xQCIvtZ7gkiHiOAfI0sMD7QZtE9jk12bnsX/6xPz/l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjC6Xh0WS1Mju5WdOccTMDLbMCpL3mt41lC9QMQqmatV4+7ecfS5iIVxufHQdLYT0IXXek0AbsufHDd1zoV79zqD+DtTutoRF+ve7L04oKBrbxo6+YtJJuskAVo8qCmkSPOfR5Sw6UIaY16L+uZBiY1pfrs29DNKEenJsIAf2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQJtQuoY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfb6ab47cso42296281fa.3;
        Mon, 17 Mar 2025 03:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208836; x=1742813636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2GJ9qJ8OjX1yfsEXuO0p0ppxNDngQ6k8zpz585ECzc=;
        b=MQJtQuoYOIp0Cog5Vgqd1mpwZt0F1578JzBjV2B5ba7wrchb4cO17BwCSoPWY7fwWa
         TLZyy6ISpvB1P2jTRN/twILS0SYAh5SeQX7ZGN1o7RthRMP8NxuZOrS8OAxWkIXyGqhH
         r9VhDPvq2TYiHuGBzto7qmtrefwy2EeyJn4Z2msWoHDsMukinH4rBUkivFrIVJYVm2Ru
         Z/D9xy1fiD4vz3mOkGhKe14uWI0qJwGBSf77huAUQ9Vdznqbzv4t4i/fytd3RS3J+j53
         38J/Gs4VqByHm4QEn60Yqp/JRilMfugeMpTLM/kGPIfucBkoKZtquWf3XKaJmm0MUI93
         o0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208836; x=1742813636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2GJ9qJ8OjX1yfsEXuO0p0ppxNDngQ6k8zpz585ECzc=;
        b=WkS4W2MGFxYPUIVey6GJDTFUIDb2+GYJ3BHN/BcUyOiEiE7OAk46m5Rtatz1ylN1qF
         yjVTkUlYvby/3z3u7dIOX9JR9k7tJqSdAHpRBfgmRtvoBXWyuixERw7OLnnfusJbq1Px
         hXxqNKQsivjrwgdLzPDj8jqy/lC4/lA8ZgemEr2z8mse8l9qQR4B7gr4kUOk1zNgQ3uB
         3jWMySW8TDaesrWhXXuXfDAKq9cXe3fiw02XeKQ7mF9w4/pFhBzTg39oh8SN9MgAkDrA
         +zXLodt92ITzUrvKFCATmRxDNL04UBDWDFlpbSQPiiBCcNgLmrj09+hChrGCsAUkfuLE
         vBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUq8f14I1k1UIlQVV1+yeJUQsDpXx6ALD8AGeQ9drlJWE181BLc1SIce+fxwlKkMwd21msQfmNAOjqga9dNBZPb@vger.kernel.org, AJvYcCV0UjchdIGv8VA5Z9thu+TOIzG5Ti+H0mjuvn7QkgqQBpFqClciSYPTerFxw09/CxALxF+9b7X6UNNEE9Pj@vger.kernel.org, AJvYcCVRoHnxpPF8eLNqNZoSDXRu8VcYG/V0RbAQv+mzmQHlSlbjziqMg/k6kWclINlpSUXoWLeDL31TfZtwvig=@vger.kernel.org, AJvYcCVq8cOqd+kvTHwNGSksNPnNJ1cosQTdUaPsyfKqmxppEvbaNh/4/WD9G9A17/oarN1D7ALleV6k7pVH@vger.kernel.org, AJvYcCW10kAxPm8Ns5U3ziW3gxImNT8U+Q+qCO5VIv4PxHr5wegDQVNDl5YErzsFN0E5ui6euSMDoTKFJaMR@vger.kernel.org, AJvYcCWxLRnnLgPFuwmqdci4ebZtxrCD0FpQXo/PH743ZImOJx3sr3OtXgS5Xff9+k7siFls2pyriGv7KdtuUbjY@vger.kernel.org, AJvYcCXXpPdM3/fEcnTTjmMrbM9W/xotclTo+SkYS6N6RjaJJWIbJZO030muX2zT5GyICWSFQT/LUY0MMD6M1vVeXmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbzo4uHWyQnxmok/icIu1jl/35H3XtFYnkXfzQ/k66IQ3oIVs
	TEOCzP0EfzwvuuLyeZV4H/hq+26TSIpifEKvS48m2G2G9PYA+YGHwGpmqFRtE65ge8V7W/+sY37
	YrL1geAENWgN4bjcvJ6GHOTZ7bYU=
X-Gm-Gg: ASbGncsrzBvPKznCiQXic9uSMd/dEsDHTpiUhFeKzAZauN5ycxuAoXa27zycZqzlRKb
	t1b7YiSuhHhsghtUtR6XqlEMgcMGHrUioK449oqXgiIhJoSEzFoa1Av1fgbTqhkO+RJjZs3MENC
	WitJPZXlsWkWNNjG2zzP2C7OOA3pg2nQlB60rPLbppO1blaCfX3LbKpWAcHsrO
X-Google-Smtp-Source: AGHT+IEeubawRlSkpRnGzmVWw22++0Ktqk/MMMgtA5rXFVJr9UoRX1gyCSDhiL2Xi0GL2rblLWjf9DmjfBaJCJzQ7wE=
X-Received: by 2002:a05:651c:221b:b0:30b:d63c:ad20 with SMTP id
 38308e7fff4ca-30c4a8ce9dbmr64521931fa.24.1742208835540; Mon, 17 Mar 2025
 03:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315-ptr-as-ptr-v4-0-b2d72c14dc26@gmail.com>
 <20250315-ptr-as-ptr-v4-6-b2d72c14dc26@gmail.com> <D8IFS7175NNQ.3VAP8WA2QC8WF@proton.me>
In-Reply-To: <D8IFS7175NNQ.3VAP8WA2QC8WF@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 06:53:19 -0400
X-Gm-Features: AQ5f1JqqKWQmJQtQxcuGwEC9JarpMRPLE1rROZqjJX4KytwdbIBYSIApzB74Pbo
Message-ID: <CAJ-ks9mXzM6D++vq0QCugaFOS9ES0j7GpeWZqckY0dA3JwpnJw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: use strict provenance APIs
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 5:34=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Sat Mar 15, 2025 at 1:17 PM CET, Tamir Duberstein wrote:
> > Throughout the tree, use the strict provenance APIs stabilized in Rust
> > 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> > functions at the `kernel` crate root along with polyfills for rustc <
> > 1.84.0.
> >
> > Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> > 1.84.0 as our MSRV is 1.78.0.
>
> This isn't necessary, right?

It is necessary. MSRV is encoded in .clippy.toml, it doesn't matter
what the *current* rustc version is.

> > In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> > 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> > compiler flags that are dependent on the rustc version in use.
>
> So it won't be enabled in the doctests, right?

Yes, that is correct.

> > Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-pro=
venance-apis [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  init/Kconfig           |  3 +++
> >  rust/kernel/alloc.rs   |  2 +-
> >  rust/kernel/devres.rs  |  4 ++--
> >  rust/kernel/io.rs      | 14 +++++++-------
> >  rust/kernel/lib.rs     | 52 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  rust/kernel/of.rs      |  2 +-
> >  rust/kernel/pci.rs     |  4 ++--
> >  rust/kernel/str.rs     | 16 ++++++----------
> >  rust/kernel/uaccess.rs | 12 ++++++++----
> >  9 files changed, 82 insertions(+), 27 deletions(-)
>
>
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 486715528587..84eb2602e79e 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -17,6 +17,9 @@
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsiz=
ed))]
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_fro=
m_dyn))]
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> > +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, feature(strict_=
provenance_lints))]
> > +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(fuzzy_prov=
enance_casts))]
> > +#![cfg_attr(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE, deny(lossy_prov=
enance_casts))]
> >  #![feature(inline_const)]
> >  #![feature(lint_reasons)]
> >  // Stable in Rust 1.83
> > @@ -25,6 +28,55 @@
> >  #![feature(const_ptr_write)]
> >  #![feature(const_refs_to_cell)]
> >
> > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > +#[allow(clippy::incompatible_msrv)]
>
> Do we still need this allow?

Yes, explained above.

> > +mod strict_provenance {
> > +    #[doc(hidden)]
>
> Why make them hidden in docs?

I've added documentation that defers to the standard library.

>
> > +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> > +        addr.expose_provenance()
>
> Instead of having these stubs here, you can probably just do
>
>     pub use core::ptr::expose_provenance;

This doesn't work for the methods on primitives, but it works for the
free functions. Done.


> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> > +        core::ptr::without_provenance_mut(addr)
> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> > +        core::ptr::with_exposed_provenance(addr)
> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> > +        core::ptr::with_exposed_provenance_mut(addr)
> > +    }
> > +}
> > +
> > +#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> > +mod strict_provenance {
> > +    #[doc(hidden)]
>
> I think we should document these.

Done.

>
> ---
> Cheers,
> Benno
>
> > +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> > +        addr.cast::<()>() as usize
> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> > +        addr as *mut T
> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> > +        addr as *const T
> > +    }
> > +
> > +    #[doc(hidden)]
> > +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> > +        addr as *mut T
> > +    }
> > +}
> > +
> > +pub use strict_provenance::*;
>

