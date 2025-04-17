Return-Path: <linux-kselftest+bounces-31081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5FA92BB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 21:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16B28A71AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A11200112;
	Thu, 17 Apr 2025 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvq2Pbux"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F741FF60E;
	Thu, 17 Apr 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744918015; cv=none; b=F0Im8pOpr9c2kEYDM9Xr6pQQswJZ15m6pLeDWK7WqgGId9MjjmbmKBXu4im/iCD5oKck68PeVZDkQ9Tn4BaeSdX2TQv15b3vP9Dy19JARs4sVPWEc0/drneaV6xIpRBvOklaxzhFf9UKtljIsCKaxMeqnbiZ7KsIPZ11eBBFDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744918015; c=relaxed/simple;
	bh=1rgyqBa6PGvHKaXLaFi+0MQeP0/t/MyWKoysFzzdw9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2Wi7c2FNT3QjBRCuupTEu6Irg/jc1cCmGNegdWfXCQNyDfbYHzyyNtGjRSo3Wy7WBd4Ibetw2inCR4Oy8x5Jq1eqlV1KH5MrRnRql12r48p42g8LtNuT3yQYj8jR1ojxJhC02TRg/kYEBm7G+yOFgTIATLBIqYjT9vGnTiAfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvq2Pbux; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bf1d48843so9935601fa.2;
        Thu, 17 Apr 2025 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744918011; x=1745522811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZphEE6mRsXJVjDuLp4TlhI1glcfhD7HPw8PnXuxw7+Y=;
        b=Zvq2PbuxGjn42pJ7+QEFya50p/sWJ7C+FIE+q8/meWSE6xwbaliB9HiLNfFqbCKdFD
         kIjztQ5SO4GomB3larcaSUCVluH/IzKA7kmlYhGvWpegB6jFJKKSh1OWCyjVzqY1GMFV
         hSpQQhGgu9RhzFec/cXciobcODwCoGniNWgNcymAk/xIaQZlkYNu4UcGjSmAXHANCR0S
         llfWMFLhTT97bauBx1EO0ewgU440EsWclM+F3srD0BjxlW8Ou3buf1jIRILbpO/oPbsF
         2SIbEpXC35LIMZf39dRvQNJ7GTG6Wg35rukEc3iAWP+MJB5qbX1MzXxicWrG33j6WXd6
         UbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744918011; x=1745522811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZphEE6mRsXJVjDuLp4TlhI1glcfhD7HPw8PnXuxw7+Y=;
        b=Nu2zYGvuwfpyOx76lao8COAGDbYs+RSXUG2VDwnaVVlCGnLrTHH/fEFMOhix3IrcyZ
         V1Ko80qiRZPLkXEHaVDvYHB25/jMy1C8G5UUxCce0U9ZQBqnRLzp3RQzYos2/Jn9faiB
         Gfo4PYtZhanEDcFHuVCii0nroAbW8ADxRYDOTMvwrR/NzpQ1n41Mh3Z7X34w/35dcdEr
         q7VIxdVDfa+P6lYLFwXPnH7OUedhA7lH52xycE2YxP9lsgxLQ0xVw/NcW2OH0vBQ1INr
         fKcHjAOkhtDCvbJSPbOTMswjz4RoOmq65sssCEWY1f7SUH1xLViOwY/Wy4R7K0jgKvFk
         1XnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+xM36UeQzJHwsMOQ7dhDBDYn8x1KZMCr6qJloWTnjrHukQ3LDfHy1rUTWt7n2ziDu0VCq1cm7uQoVnos+@vger.kernel.org, AJvYcCUQd/7XWwUskvAxSzmvcry8Ffd5E/UkT6GH9gOuEQoCe7yJzTwL4tGubv/b3ECJKWvcCSK+1Ec6G1pI@vger.kernel.org, AJvYcCUlidGGEzCU2EPnuh4Hy/RA9ej6FO6fF6s81TL5if/aMyBRY2f0/adlB7Sz5YVGCN8TCYa9d6BX+rnF@vger.kernel.org, AJvYcCVQb6CWYYrIDBmTLK1krxhNaiob8O9LoaLBYdmWD8FbZU2sVIS9DDAYlfGW8hUrctNOLwbWfpCp@vger.kernel.org, AJvYcCWGGZPJxcANUNndrY3o1sMh+tiLf1lfNvvREu2n10ErzWqlph6AUYh+GewK4/eb9KcCggD/5sjZ6jY3bmM=@vger.kernel.org, AJvYcCWVXc3WUwdxKUBOE1ec/YgucaBZLG/gdCUUjztorVwvJmyIcdXjlwdbM8Wj1PkWUHjMb8y0DexMYzPOBPlk@vger.kernel.org, AJvYcCXFdGNSuJjEGiei6b63051dMkKGeqM4AMvytCsLI+mdhvaCO1keMfZ+BvL8mgu6Xbt7+ZQGQGa49rNWaYZfh7mM@vger.kernel.org, AJvYcCXPMMSOU1xh+YGCGLhl4eeQ1pKRxhWJ3nN1RjoefWPZ+7GNLH0dD3iodrfj2VU7iYm/ZHf9gzcdc5Sde7DSqLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO2gKhysi/Uwut6+UZxEJf/QAVsMA8xli5qHjB040QH0crr5cb
	Al/sAFooc5kFYXaIcECtRd3csuvNHF8OZTr8KvTNU56nyYjOipfJh6+yyjMgDnMdJaYSrZWboTl
	kaXnbizAKYCW4dr5YKqk3fb6k3P0=
X-Gm-Gg: ASbGncs6d8d5ORflCUoFM13tG99BB8bGUZthopdwMuUa1sPxfrPBJcDfGBsW36p9vMD
	VIduBLQEOXMYjKYvUnnpuYeu5WzR36kPrPtnybMZzjp8WrJaKZOvOkRg8DDpCAPZ9nNmteAMZW2
	6zgmQBC+9GPwoP0Y7vQtFFLk3edMBVuSLEWrozDJfvcMcQWmLuFo2kL1x2
X-Google-Smtp-Source: AGHT+IF2XTv7HEMjuAx71ffsVmOHEEMf+2KfvDr/EyFROldtRi3Nj0Q6tLUChxn/8pPu3HfKc/G6xbDuaC2Pjkx+paw=
X-Received: by 2002:a2e:a58c:0:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-310904d424bmr815101fa.9.1744918010897; Thu, 17 Apr 2025
 12:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com> <68014084.0c0a0220.394e75.122c@mx.google.com>
In-Reply-To: <68014084.0c0a0220.394e75.122c@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 17 Apr 2025 15:26:14 -0400
X-Gm-Features: ATxdqUHAtAIGsosX3Js7zsmhna_CZhgy2ypzTbcfLvguLbUlfr3PFS5qMUsCdB8
Message-ID: <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/6] rust: enable `clippy::as_underscore` lint
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

On Thu, Apr 17, 2025 at 1:55=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Apr 16, 2025 at 01:36:08PM -0400, Tamir Duberstein wrote:
> > In Rust 1.63.0, Clippy introduced the `as_underscore` lint [1]:
> >
> > > The conversion might include lossy conversion or a dangerous cast tha=
t
> > > might go undetected due to the type being inferred.
> > >
> > > The lint is allowed by default as using `_` is less wordy than always
> > > specifying the type.
> >
> > Always specifying the type is especially helpful in function call
> > contexts where the inferred type may change at a distance. Specifying
> > the type also allows Clippy to spot more cases of `useless_conversion`.
> >
> > The primary downside is the need to specify the type in trivial getters=
.
> > There are 4 such functions: 3 have become slightly less ergonomic, 1 wa=
s
> > revealed to be a `useless_conversion`.
> >
> > While this doesn't eliminate unchecked `as` conversions, it makes such
> > conversions easier to scrutinize.  It also has the slight benefit of
> > removing a degree of freedom on which to bikeshed. Thus apply the
> > changes and enable the lint -- no functional change intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_unde=
rscore [1]
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  Makefile                           |  1 +
> >  rust/kernel/block/mq/operations.rs |  2 +-
> >  rust/kernel/block/mq/request.rs    |  2 +-
> >  rust/kernel/device_id.rs           |  2 +-
> >  rust/kernel/devres.rs              | 15 ++++++++-------
> >  rust/kernel/dma.rs                 |  2 +-
> >  rust/kernel/error.rs               |  2 +-
> >  rust/kernel/io.rs                  | 18 +++++++++---------
> >  rust/kernel/miscdevice.rs          |  2 +-
> >  rust/kernel/of.rs                  |  6 +++---
> >  rust/kernel/pci.rs                 |  9 ++++++---
> >  rust/kernel/str.rs                 |  8 ++++----
> >  rust/kernel/workqueue.rs           |  2 +-
> >  13 files changed, 38 insertions(+), 33 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 04a5246171f9..57080a64913f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -475,6 +475,7 @@ export rust_common_flags :=3D --edition=3D2021 \
> >                           -Wunreachable_pub \
> >                           -Wclippy::all \
> >                           -Wclippy::as_ptr_cast_mut \
> > +                         -Wclippy::as_underscore \
> >                           -Wclippy::ignored_unit_patterns \
> >                           -Wclippy::mut_mut \
> >                           -Wclippy::needless_bitwise_bool \
> > diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/=
operations.rs
> > index 864ff379dc91..d18ef55490da 100644
> > --- a/rust/kernel/block/mq/operations.rs
> > +++ b/rust/kernel/block/mq/operations.rs
> > @@ -101,7 +101,7 @@ impl<T: Operations> OperationsVTable<T> {
> >          if let Err(e) =3D ret {
> >              e.to_blk_status()
> >          } else {
> > -            bindings::BLK_STS_OK as _
> > +            bindings::BLK_STS_OK as u8
> >          }
> >      }
> >
> > diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/req=
uest.rs
> > index af5c9ac94f36..22697104bf8c 100644
> > --- a/rust/kernel/block/mq/request.rs
> > +++ b/rust/kernel/block/mq/request.rs
> > @@ -125,7 +125,7 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<=
Self>> {
> >          // success of the call to `try_set_end` guarantees that there =
are no
> >          // `ARef`s pointing to this request. Therefore it is safe to h=
and it
> >          // back to the block layer.
> > -        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::B=
LK_STS_OK as _) };
> > +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::B=
LK_STS_OK as u8) };
> >
>
> We could consider defining a const block::mq::BLK_STATUS_OK as:
>
>         const BLK_STATUS_OK: u8 =3D bindings::BLK_STS_OK as u8;
>
> , because repeating the as pattern is a bit err-prone. But maybe in a
> later patch.

Sure. I think there's only this instance at the moment.

>
> >          Ok(())
> >      }
> > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > index e5859217a579..4063f09d76d9 100644
> > --- a/rust/kernel/device_id.rs
> > +++ b/rust/kernel/device_id.rs
> > @@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U,=
 N> {
> >              unsafe {
> >                  raw_ids[i]
> >                      .as_mut_ptr()
> > -                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
> > +                    .byte_add(T::DRIVER_DATA_OFFSET)
> >                      .cast::<usize>()
> >                      .write(i);
> >              }
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index f7e8f5f53622..70d12014e476 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -45,7 +45,7 @@ struct DevresInner<T> {
> >  /// # Example
> >  ///
> >  /// ```no_run
> > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io=
::{Io, IoRaw}};
> > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ff=
i::c_void, io::{Io, IoRaw}};
> >  /// # use core::ops::Deref;
> >  ///
> >  /// // See also [`pci::Bar`] for a real example.
> > @@ -59,19 +59,19 @@ struct DevresInner<T> {
> >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> >  ///         // SAFETY: By the safety requirements of this function [`p=
addr`, `paddr` + `SIZE`) is
> >  ///         // valid for `ioremap`.
> > -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZE a=
s _) };
> > +///         let addr =3D unsafe { bindings::ioremap(paddr as bindings:=
:phys_addr_t, SIZE) };
>
>
> ///         let addr =3D unsafe { bindings::ioremap(bindings::phys_addr_t=
::from(paddr), SIZE) };
>
> better? Or even with .into()
>
> ///         let addr =3D unsafe { bindings::ioremap(paddr.into(), SIZE) }=
;

This doesn't compile because `paddr` is usize, and
`bindings::phys_addr_t` is u64 (on my machine, which is aarch64).

> >  ///         if addr.is_null() {
> >  ///             return Err(ENOMEM);
> >  ///         }
> >  ///
> > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> >  ///     }
> >  /// }
> >  ///
> >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> >  ///     fn drop(&mut self) {
> >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly ma=
pped by `Self::new`.
> > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); =
};
> >  ///     }
> >  /// }
> >  ///
> [...]
> > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> > index 43ecf3c2e860..851a6339aa90 100644
> > --- a/rust/kernel/dma.rs
> > +++ b/rust/kernel/dma.rs
> > @@ -38,7 +38,7 @@
> >  impl Attrs {
> >      /// Get the raw representation of this attribute.
> >      pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> > -        self.0 as _
> > +        self.0 as crate::ffi::c_ulong
>
>         crate::ffi::c_ulong::from(self.0)
>
> maybe, a C unsigned long should always be able to hold the whole `Attr`
> and a lossly casting is what this function does.

This also doesn't compile: "the trait `core::convert::From<u32>` is
not implemented for `usize`". Upstream has ambitions of running on
16-bit, I guess :)

>
> >      }
> >
> >      /// Check whether `flags` is contained in `self`.
> [...]
> > @@ -70,19 +70,19 @@ pub fn maxsize(&self) -> usize {
> >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> >  ///         // SAFETY: By the safety requirements of this function [`p=
addr`, `paddr` + `SIZE`) is
> >  ///         // valid for `ioremap`.
> > -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZE a=
s _) };
> > +///         let addr =3D unsafe { bindings::ioremap(paddr as bindings:=
:phys_addr_t, SIZE) };
>
> Similarly:
>
> ///         let addr =3D unsafe { bindings::ioremap(paddr.into(), SIZE) }=
;
>
> or `from()`.

As above, doesn't compile.

> >  ///         if addr.is_null() {
> >  ///             return Err(ENOMEM);
> >  ///         }
> >  ///
> > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> >  ///     }
> >  /// }
> >  ///
> >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> >  ///     fn drop(&mut self) {
> >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly ma=
pped by `Self::new`.
> > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); =
};
> >  ///     }
> >  /// }
> >  ///
> [...]
>
> The rest looks good to me. Thanks!
>
> Regards,
> Boqun

Thanks!

