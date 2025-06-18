Return-Path: <linux-kselftest+bounces-35290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7DADEE72
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED70C1BC2004
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4762EA735;
	Wed, 18 Jun 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOj6UQ91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630C2E7186;
	Wed, 18 Jun 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254733; cv=none; b=orPDDx9MFmeoEq89VPkolWimfNAsdEhtvDReX26ZUGe2MvGAEk7m7TWvizXgMnaniUmV0uba6uLT1U2fVT8Vx0bjL1SkSrvrXGwesWD/CcARVD01yZkQzJKw2rNhPyf0or/X8jEWkestBpkhhYUYLYzgG5OKiGREE9oQm4TfP2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254733; c=relaxed/simple;
	bh=oLK9T/B2UDs68r1ZjzISgVE/xE7SFVRU1xoqHtQq9+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKPy6H7MrUha7CLCfCHjl03oaYSHzgxzXAI15cWGte4JObJfeKw6DK006NcfdCi0UyovY+4tXZWpDzf3Ct5+t9VNp6JQaHa6aQtv7kH39xjH15IRI+ThtwzygZmMl9ET6V54pIOHW+fxfnhmndovCtibcmnzRZaPyDP9+OnyjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOj6UQ91; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32add56e9ddso56599201fa.2;
        Wed, 18 Jun 2025 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750254730; x=1750859530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHetTVGjM9N9vKhqDfTQfQXf30L+g0MXCJcXiaNoNyE=;
        b=ZOj6UQ91qZ3yjk490+encIDTrZDlyNHQEktxTo3PLv+CwoTuqGBuoBSzAcG6vQ+l7C
         gdWH8jjJMfxuLajft6M6w+bQzWnFtp5g+TNmyaTZO4UXSqDgxw2fa+o1e03Mw0Mop3Wh
         Q44TgTfSfMobTUMUFLjsN2uC+aTnTxJocqhV+UuH9P5ihXDBZ2boO/US2/UgFx9XBubs
         vm1Z5YI+ue8DqY0aT7Z5YkDsHLI1bdBXQS/HoVef5YJ+R/CBWaRF9Jv2ntyagAQk9Dbz
         XhizJali5b3OUXORaF8rgbukVvMrn6SPb5iLczl+hApe+vM8MT/iTe2LgGobkge/JDpv
         1QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254730; x=1750859530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHetTVGjM9N9vKhqDfTQfQXf30L+g0MXCJcXiaNoNyE=;
        b=mvevnmzdPrgIDmEB8ALL0WjXIHk0UlpWA2l2jYfVOFEdwT7C0JGWKv+C8dfWUAW66C
         3xMC0NrE1HwKlaM5+h8V0e5wiJEkMi+V711aUTN8ownX2omTBsrHnQpIy8vrj1dZDDcl
         6trSyuRy5MwBf+kh1wB6CP+cmQbAOlBZlUiq1l6eDsB/E7E9OlPWNAVnQscevnAAJJSi
         wCr4jpDJ1xlUFxTeIzC8ko04GSb+yoiiPuq9cs0917fymbyd6PnUuIzZXISQKHovvzuC
         bFwMWow/U1pktTpp4g1vtRKKwzadsvRaj2Ln48HR+hi6tDwCCvAO0O7DMBsCZ3UCMGzU
         DG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+Isn8IanFi6iecGqrHpZXdhH7zSSiJAu88uNtk8oMEt8POzh5GRt9JqCMQzzK0VCJAS22jv+G@vger.kernel.org, AJvYcCVGYQtQB55IbKdNNgcJfAShO/5h3TByrs0KBwjfJurFBDn6/pYrEk/MORGu2uLuY4Oto6f+9y+N7Un8@vger.kernel.org, AJvYcCVNykFbz51KAa9fgSuznPVux9ydYFAhHMwUSH8cfP4bM0fYcqO+0zYIIhPjsjBYGJiaAzFSiby42/3TnqI=@vger.kernel.org, AJvYcCWJBmZaUStWEhWPwfWSuSBt9u9ofkiPKB091N6I+S2wO8yRMF0P5ZsCtxCQqu4m3mKTOQrYeRDsVcs=@vger.kernel.org, AJvYcCWQ2/+LaprrULdHKdi+FGszh051nyienJJINbC1SX9ZRWWq2OshnvSCiCe7ZD8LZuhH75aFSpaW1R5hdwI2@vger.kernel.org, AJvYcCWyuPV7mLCn0ysjlWhtmroN6re6PQ5Ljnp9LcZn5Wfy0aB+9FW7lqq4xvhZi87u512XLzlXR80iDPKRmcgk/FYL@vger.kernel.org, AJvYcCX6+PHlIWRiGXZlcef5/U0HkN4w70iHPyEWt136gPUg6SymOJUB7KrQxbUfYZ2d8HoejpTCRzPOwxX+@vger.kernel.org, AJvYcCXvnRHW4JrfRK1Cwv5S1oSQD23W+S1nuM+F1Yb53AJj7o2R8ASLGEiIVKQMixP6CR3vZYZYAavKYoseudpjoHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0v2wOnKg4FXkbHUTpmXHz/JYGE87vyzd5p0w8GtBw5SGiKhRR
	LcaX9Ae8z4miMrBTobhwmhDyu6gR+EZAfDJ3axOtw3m8SyAALznZJEz3Up3sQNQILke0XtmoXKS
	565U1sUET9lynb93u7L+DZnUQOcZ7b18=
X-Gm-Gg: ASbGncvdpaZciKrGxm/LSwpYhvLia87AlH9xxSzccdfst3pj87UMdoJ94RWWGdN/+bT
	lgz7DTajUF3UGQEfN9/ahDDjQtHmVnVEWQbnJ9SzCN0VvqFkEbVpOUlLoZl0TvMtuAjNI/dOV6H
	LSJUiYwPfKP6DexRbwSZW6irEP74Fnrk5b24JpnxfP81Sok0wN8jYA29IVhjU=
X-Google-Smtp-Source: AGHT+IHjpP0oUsGl8bs9dihRSaXuYuFr91sSYke6woCI9t3nFqjg18OJME02qGfpZHIEHpORU6xHL6DoZtudcacLwZI=
X-Received: by 2002:a05:651c:2203:b0:30b:edfc:5d8a with SMTP id
 38308e7fff4ca-32b4a0131c3mr43917741fa.0.1750254729384; Wed, 18 Jun 2025
 06:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com> <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
In-Reply-To: <20250615-ptr-as-ptr-v12-5-f43b024581e8@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 18 Jun 2025 09:51:33 -0400
X-Gm-Features: AX0GCFugcq7xsGtJtMG4-YlwkWLR_JC0Fxzt1KWhWAbz9DyagkQH0rU9bmUM3y8
Message-ID: <CAJ-ks9=P=N=5L8yre_C7xKoEt=t0f=Sf3ZY5POHuhb_3+5GO3w@mail.gmail.com>
Subject: Re: [PATCH v12 5/6] rust: enable `clippy::cast_lossless` lint
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 15, 2025 at 4:55=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
>
> > Rust=E2=80=99s `as` keyword will perform many kinds of conversions, inc=
luding
> > silently lossy conversions. Conversion functions such as `i32::from`
> > will only perform lossless conversions. Using the conversion functions
> > prevents conversions from becoming silently lossy if the input types
> > ever change, and makes it clear for people reading the code that the
> > conversion is lossless.
>
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_loss=
less [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

@Danilo Krummrich could you please have a look for drm and nova?

> ---
>  Makefile                             | 1 +
>  drivers/gpu/drm/drm_panic_qr.rs      | 4 ++--
>  drivers/gpu/nova-core/regs.rs        | 2 +-
>  drivers/gpu/nova-core/regs/macros.rs | 2 +-
>  rust/bindings/lib.rs                 | 1 +
>  rust/kernel/net/phy.rs               | 4 ++--
>  rust/uapi/lib.rs                     | 1 +
>  7 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 0ba22c361de8..29cf39be14de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -481,6 +481,7 @@ export rust_common_flags :=3D --edition=3D2021 \
>                             -Wclippy::all \
>                             -Wclippy::as_ptr_cast_mut \
>                             -Wclippy::as_underscore \
> +                           -Wclippy::cast_lossless \
>                             -Wclippy::ignored_unit_patterns \
>                             -Wclippy::mut_mut \
>                             -Wclippy::needless_bitwise_bool \
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_=
qr.rs
> index dd55b1cb764d..6b59d19ab631 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -404,7 +404,7 @@ fn pop3(&mut self) -> Option<(u16, usize)> {
>              let mut out =3D 0;
>              let mut exp =3D 1;
>              for i in 0..poplen {
> -                out +=3D self.decimals[self.len + i] as u16 * exp;
> +                out +=3D u16::from(self.decimals[self.len + i]) * exp;
>                  exp *=3D 10;
>              }
>              Some((out, NUM_CHARS_BITS[poplen]))
> @@ -425,7 +425,7 @@ fn next(&mut self) -> Option<Self::Item> {
>          match self.segment {
>              Segment::Binary(data) =3D> {
>                  if self.offset < data.len() {
> -                    let byte =3D data[self.offset] as u16;
> +                    let byte =3D u16::from(data[self.offset]);
>                      self.offset +=3D 1;
>                      Some((byte, 8))
>                  } else {
> diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.r=
s
> index 5a1273230306..c1cb6d4c49ee 100644
> --- a/drivers/gpu/nova-core/regs.rs
> +++ b/drivers/gpu/nova-core/regs.rs
> @@ -32,7 +32,7 @@ pub(crate) fn architecture(self) -> Result<Architecture=
> {
>      pub(crate) fn chipset(self) -> Result<Chipset> {
>          self.architecture()
>              .map(|arch| {
> -                ((arch as u32) << Self::IMPLEMENTATION.len()) | self.imp=
lementation() as u32
> +                ((arch as u32) << Self::IMPLEMENTATION.len()) | u32::fro=
m(self.implementation())
>              })
>              .and_then(Chipset::try_from)
>      }
> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core=
/regs/macros.rs
> index 7ecc70efb3cd..6851af8b5885 100644
> --- a/drivers/gpu/nova-core/regs/macros.rs
> +++ b/drivers/gpu/nova-core/regs/macros.rs
> @@ -264,7 +264,7 @@ pub(crate) fn $field(self) -> $res_type {
>          pub(crate) fn [<set_ $field>](mut self, value: $to_type) -> Self=
 {
>              const MASK: u32 =3D $name::[<$field:upper _MASK>];
>              const SHIFT: u32 =3D $name::[<$field:upper _SHIFT>];
> -            let value =3D ((value as u32) << SHIFT) & MASK;
> +            let value =3D (u32::from(value) << SHIFT) & MASK;
>              self.0 =3D (self.0 & !MASK) | value;
>
>              self
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 81b6c7aa4916..7631c9f6708d 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -25,6 +25,7 @@
>  )]
>
>  #[allow(dead_code)]
> +#[allow(clippy::cast_lossless)]
>  #[allow(clippy::ptr_as_ptr)]
>  #[allow(clippy::undocumented_unsafe_blocks)]
>  #[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_tr=
ansmutes))]
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 32ea43ece646..65ac4d59ad77 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
>          let bit_field =3D unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) =3D=3D bindings::AUTONEG_ENABLE as u64
> +        bit_field.get(13, 1) =3D=3D u64::from(bindings::AUTONEG_ENABLE)
>      }
>
>      /// Gets the current auto-negotiation state.
> @@ -427,7 +427,7 @@ impl<T: Driver> Adapter<T> {
>          // where we hold `phy_device->lock`, so the accessors on
>          // `Device` are okay to call.
>          let dev =3D unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        T::match_phy_device(dev).into()
>      }
>
>      /// # Safety
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index e79a1f49f055..08e68ebef606 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -14,6 +14,7 @@
>  #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
>  #![allow(
>      clippy::all,
> +    clippy::cast_lossless,
>      clippy::ptr_as_ptr,
>      clippy::undocumented_unsafe_blocks,
>      dead_code,
>
> --
> 2.49.0
>

