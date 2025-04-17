Return-Path: <linux-kselftest+bounces-31082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8ECA92BC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F129E8E0887
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE9C20299D;
	Thu, 17 Apr 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2vbQ3cN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5FA926;
	Thu, 17 Apr 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918176; cv=none; b=FwCzgAT4TFEjajK0thtTI140pQ5lFL01DPOhCSTf9VCJm+6WYtrCWhEkdaDHpU93PnfR8wlXG9L3fv2SKnyHNzV//s1LF1nYVTt4alL39i84b8NoUSsR5h2OKYQPAr2VfxYM15gWrMf3Uu+ImvTZ2ee5+74kqdg9HSSbAdJN0Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918176; c=relaxed/simple;
	bh=pT3IFkgbeQ/Y0niNBtavyNFdstDIm78DIgwRK9lHa1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3C806DHCp4inwSAyiWTsXXpnMf/z6P77nUXszwHihTY+xbL5e33pSxPm/k4zpTtmhUhp7tm2hCHcyK+vv5rvOS59p/HdIkclZjVJKMIHEqt8nkO3oFyy/cUqocS1Hx0WJylX0QlggIb9TRtEc+oQE58wPej8BxrvrKgOQb9nTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2vbQ3cN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3106217268dso9866841fa.1;
        Thu, 17 Apr 2025 12:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744918172; x=1745522972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVUIqZiEwl1B2+vNCfJHA2gPwonxMuRc8KmAVY778TU=;
        b=F2vbQ3cN+Rl/tID6bs0VzPV+HP5IzcUHFqDwpaQfZXY3dHCZfzx5hz5Mls8VE6VzpJ
         qCHlW/YsdOOsQ3Q7IblOArs7XKXOtyu7cTtkH3RhrmfHbPy1+FC2A1cItkLsbUtC0oh0
         xmbKu7Xro8CrmRsdr21dYbEaFVVAYojqzPZhgi0uDEeyAWP7ASKzKRc342TUMyEwvc+4
         3+v2d/h1giUygCQhK0EPCGnFB7UxhIMSU2WprLspdH6yag0Jav8lXQgRkktBw8IEEIHH
         x0CepRyNX2n0MvhufdjrZDEpNQNniigG0g5uCInxB+u5+74pXzlWRnpms3Yo51IrMplW
         fYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744918172; x=1745522972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVUIqZiEwl1B2+vNCfJHA2gPwonxMuRc8KmAVY778TU=;
        b=Ipq3OzmWjNdWJUq9c/INC9rKYDOGOZ1HlZPP3eC4kuoggH2/vgwzrlAETLD9G8tsRK
         /rGEs53Bjgk6LpzxJeBKDuAj5DMiYiAPg/+Jvdmt/jgShBUTktGSLF6AeFUPiVQMuJ0D
         p9hKw9cfYZfGLf7NSiGE6x0gNkndkXoNayhMy4/TA5tFj458cDdEZmNR5qvmFk6rM/ed
         gSijl6q6NVLwK9Rm/Bu14egVRzXgVfeZQKIgMXNKgROm7XmtW3U5GpELYPayd9l0UWbX
         FJd04MBfrPqrzbXC5oOKiVNTxjlKc2SowdN0+bz98UN+LrSh3jGeqectrZsL+aDQs4pi
         LMTw==
X-Forwarded-Encrypted: i=1; AJvYcCU/p+WrciV+dsChSzhhlvqBr+IrMFg3N3L5DHsXJNWgRXR8Jc1EyvoDSJWkbwJEiD38vDdYwSm+1G1R7EqSCzWN@vger.kernel.org, AJvYcCUa0SP42dwrKs1Pm6FW4iXJA0gAE/CWSVRxwRXh1JJuIKJ37Vsk5cQl0n/yE4zX5tUHf9FWG3vOFIFH@vger.kernel.org, AJvYcCWjsJ6kY4WR0S/OBsMnnw20f/NaBT3paR8BdYdEZSplRWqhuZZWDosIwUvO0z85Tdi3yPezFf04G5G6avCt@vger.kernel.org, AJvYcCXBML32D49NIVfMTF+fyD2sInBfeetoZLFCpMJ3+U4t/FZiUmfYweCyyl4dAXYykyrAA1vZII4aZs73/nc=@vger.kernel.org, AJvYcCXhmNl5/3bv9OKXgCNlLVej/qb5i0gZ4KyADbYKiJVmuVLV6w62QU700KVjpd5JBct6Msr5G/dr@vger.kernel.org, AJvYcCXq41KLofClk6q0XgFZGB054fKYWrzRHDr+JlJITTKwnu6HkMGfCphJKBQaPwuqbIcHKY1MBB8DxFvNCzsO@vger.kernel.org, AJvYcCXs11yi9icNeTQSKVMhwlmo8H7X9iJ+EIUBkPnRbVm5vn2TxdbKplGe2i554k1zJEJ1dW+4g/4dYyYJ@vger.kernel.org, AJvYcCXxb9IEAO0MzNqVNSj8JMk/dVHjTiT9NpSSwDxtm9WyXPc8tDoj8QK1Cm2bRmk+5Pe+7vGApo2M1jFImRH83wc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQdBbqcwwwC5HzNaxFCW6y/BVGejSGpgFW5rrfvYkrvl3kSBl
	8P85ej4hSlO1lEF6PvSJ0RRTV4I3QWsHTqgRgtP2EuuFGZICO2VK6YobWS+oCPEIEKrdfoe7L2z
	GZVUq2oa+4EJRvbVK3kc39RMG8Zw=
X-Gm-Gg: ASbGncsoetOn7Tc+hmwrn6VnR6ZOsZGq+YfIkvaEND4L2qKLDIpE6WSlnW4Zps3CaA5
	DnxF2wkIZL5C6gyCSvsb/DQJ+89zB5m0OFo9+vsVcwrijdewzxl+MMuPh3a94Mk3bkLJMbylyaj
	EWQQPAoAvqwiIDygJNs2Y1o/V9j2TlaOUmeS1u6uasKjVuH0Te1SpumGAm
X-Google-Smtp-Source: AGHT+IG5mK7LWEjBBjgvaPujR4uL+pD+1vaxQJEnu5BLKGvcdiDqWZfp+hxnrvF2g8P0ICGFMFbUr3+qlHFH6S/5gSM=
X-Received: by 2002:a2e:b894:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-310903bc156mr905941fa.0.1744918172067; Thu, 17 Apr 2025
 12:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-5-18ec29b1b1f3@gmail.com> <68013a67.050a0220.8a966.0ee4@mx.google.com>
In-Reply-To: <68013a67.050a0220.8a966.0ee4@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 17 Apr 2025 15:28:56 -0400
X-Gm-Features: ATxdqUEYpB6Rcb7DkTbpdj8iW2c5U3MqBLy3k7sa8KPmXCWoLVopG5m6ePd31Ys
Message-ID: <CAJ-ks9neJ+8mwfa7UO-8ymM=AAOHrR0iH+NGA6B3c=DWT5Cu1Q@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] rust: enable `clippy::cast_lossless` lint
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 1:29=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Apr 16, 2025 at 01:36:09PM -0400, Tamir Duberstein wrote:
> > Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
> >
> > > Rust=E2=80=99s `as` keyword will perform many kinds of conversions, i=
ncluding
> > > silently lossy conversions. Conversion functions such as `i32::from`
> > > will only perform lossless conversions. Using the conversion function=
s
> > > prevents conversions from becoming silently lossy if the input types
> > > ever change, and makes it clear for people reading the code that the
> > > conversion is lossless.
> >
> > While this doesn't eliminate unchecked `as` conversions, it makes such
> > conversions easier to scrutinize.  It also has the slight benefit of
> > removing a degree of freedom on which to bikeshed. Thus apply the
> > changes and enable the lint -- no functional change intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_lo=
ssless [1]
>
> Hmm.. I agree with the solution mentioned from the lint URL, using
> `from()` is better, so..
>
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  Makefile                        | 1 +
> >  drivers/gpu/drm/drm_panic_qr.rs | 2 +-
> >  rust/bindings/lib.rs            | 1 +
> >  rust/kernel/net/phy.rs          | 4 ++--
> >  rust/uapi/lib.rs                | 1 +
> >  5 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 57080a64913f..eb5a942241a2 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -476,6 +476,7 @@ export rust_common_flags :=3D --edition=3D2021 \
> >                           -Wclippy::all \
> >                           -Wclippy::as_ptr_cast_mut \
> >                           -Wclippy::as_underscore \
> > +                         -Wclippy::cast_lossless \
> >                           -Wclippy::ignored_unit_patterns \
> >                           -Wclippy::mut_mut \
> >                           -Wclippy::needless_bitwise_bool \
> > diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_pani=
c_qr.rs
> > index f2a99681b998..d28e8f199d11 100644
> > --- a/drivers/gpu/drm/drm_panic_qr.rs
> > +++ b/drivers/gpu/drm/drm_panic_qr.rs
> > @@ -386,7 +386,7 @@ fn next(&mut self) -> Option<Self::Item> {
> >          match self.segment {
> >              Segment::Binary(data) =3D> {
> >                  if self.offset < data.len() {
> > -                    let byte =3D data[self.offset] as u16;
> > +                    let byte =3D data[self.offset].into();
>
>         let byte =3D u16::from(data[self.offset]);
>
> otherwise, the code has not local indicator saying what type the byte
> is, and given its name is "byte" but it's really a `u16`, I think it's
> better we mention the type here.
>
> >                      self.offset +=3D 1;
> >                      Some((byte, 8))
> >                  } else {
> > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > index 0486a32ed314..b105a0d899cc 100644
> > --- a/rust/bindings/lib.rs
> > +++ b/rust/bindings/lib.rs
> > @@ -25,6 +25,7 @@
> >  )]
> >
> >  #[allow(dead_code)]
> > +#[allow(clippy::cast_lossless)]
> >  #[allow(clippy::ptr_as_ptr)]
> >  #[allow(clippy::undocumented_unsafe_blocks)]
> >  mod bindings_raw {
> > diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> > index a59469c785e3..abc58b4d1bf4 100644
> > --- a/rust/kernel/net/phy.rs
> > +++ b/rust/kernel/net/phy.rs
> > @@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
> >          // SAFETY: The struct invariant ensures that we may access
> >          // this field without additional synchronization.
> >          let bit_field =3D unsafe { &(*self.0.get())._bitfield_1 };
> > -        bit_field.get(13, 1) =3D=3D bindings::AUTONEG_ENABLE as u64
> > +        bit_field.get(13, 1) =3D=3D bindings::AUTONEG_ENABLE.into()
>
>         bit_field.get(13, 1) =3D=3D u64::from(bindings::AUTONEG_ENABLE)
>
> >      }
> >
> >      /// Gets the current auto-negotiation state.
> > @@ -426,7 +426,7 @@ impl<T: Driver> Adapter<T> {
> >          // where we hold `phy_device->lock`, so the accessors on
> >          // `Device` are okay to call.
> >          let dev =3D unsafe { Device::from_raw(phydev) };
> > -        T::match_phy_device(dev) as i32
> > +        T::match_phy_device(dev).into()
>
>         i32::from(T::match_phy_device(dev))
>
> Thoughts? Better be explicit in these cases, IMO.

I changed the first two. This one I'll leave as `into()` because the
destination type is in the method signature, which is 5 lines above.

Thanks for the review!

