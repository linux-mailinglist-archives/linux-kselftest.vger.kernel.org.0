Return-Path: <linux-kselftest+bounces-31128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2667BA93974
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B71B6721B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13DB20A5D2;
	Fri, 18 Apr 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPbI5yyv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0C1E884;
	Fri, 18 Apr 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989389; cv=none; b=oLjDiDK1aiITf0AMw79+5LipeCkhPJEwFSdHi0eugxn7JHQB2sP/3WQCs8TVj+tFB5qcHpD3CfcaRmvNl1iKSsV8qQLvDRvB4Z5i7PVG9//1aRqohaVoRZ7ZWORRp2SQTYrv57b4A5XGnpEFQpoiaaqiDTNxleQAmEVx/nmpGa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989389; c=relaxed/simple;
	bh=DwBg4ckNvm7kD9BhT0nnFyoW3EMVX22gEsYcF0JIasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j5UjIR7vXtohCggg0liTxVS76IIe/mxDyTP5o0fPMLUOF7Ugg476Up/7eEAl50BNSF4y14ixgJtStsuEgdDZK1DqWUVjEbdngB4yPquOQe9u/xxgnngcUD/yrW67zWBGZdjh9SMxlSAMFsddfh4zKPWscmD2GlhKaJyoTRMKmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPbI5yyv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so14637951fa.2;
        Fri, 18 Apr 2025 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744989386; x=1745594186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg/XryCXtmzIR8VElx3wkFZ2q0fuZ+2pn069yJHEtd8=;
        b=UPbI5yyvf+Hra284abGk0gjgawgsVens55bhm8cBEoXe01jhtb/izNR/Bjr2eMaHBD
         9S8sdS04BDh6ouQkA1a04VuSTYR0wF97yBu+PQRTJOx/xQwdFxpo8m5Cf+Pe5KAWtyXm
         WaWcXYIsIi28KfY94z3AYq8ijgbkwR6q7m9JYZ/LeiCOP8lJYdqDNgJCkm4rtUWVUQ0s
         V33NZSk4xDY8eVmbyrc86kPUjZ25UvrEZzCCULmOBZTXPJ6uZYuF7lXGZt+QG3yP0lsy
         uxYsvgDYLzeKRF2r6H4zIb5bQkybSaFNsfpIY5tj61Le5WMkNgjqaXEvm4G6hwH/RIul
         nKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744989386; x=1745594186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg/XryCXtmzIR8VElx3wkFZ2q0fuZ+2pn069yJHEtd8=;
        b=qzQSlPFhh1ibmEzGH94fxSoulBQNCeaZvIdNNkp3SOuTwY0s2L8QaNrpzWC8VuZDQy
         l911n14JyEs/n65Pebr8fxmKqYjoXEYLDlqD66znMJcPW2l4btVkt0y2yO5NFnLtMmmc
         c2Clkb1jVJbHqm1Mc+FAMECQh/SJV8FNJrI0vs60EVD3bHMR6eEFL+aSDVXaoVH60jGW
         6jZ85ibAoBB/mUhyaOUY6L8RqGWDlP2KdQRLEWbjCVn+5+l4jqAf46jkm+hMLHDPXsN+
         bvUljuIa96Iej/q6uZPOECbG4d2mJ18wQoqK+yupohPKs6jhC1LeYURbKuL8KsZXx28S
         84EA==
X-Forwarded-Encrypted: i=1; AJvYcCUFpKq7X6Qpk0WVptL+WeeSRIZOTJt+n4oIvyaE1MOW6ncY7PE3+vt2sT2GpEX1LIwknIEaa6r9QGOlwStK1bQh@vger.kernel.org, AJvYcCUPWYbHBzi0Tw5E9Er0BXUtt+HbyocSXtRQbDyPMvtEO5Yo5/hInX+/CI/oFw3/70NdOOj+W+iU8wVr@vger.kernel.org, AJvYcCVDbybdS/7rZljks4b6WfMjELf5G0IjdfsAVpaZSsRvo7ST5zOYqwCWfFdKP0xeZebEAXDvoauI4iQR6SzW@vger.kernel.org, AJvYcCVDbyzScC2Iuie64okKfPYmex0g9zPh98ejrdXp2wAzdXiHjY4zcSv6USgIsZlkZddEPIB4G0A4b5od+G6RrzI=@vger.kernel.org, AJvYcCVwRlFHkUrUz7LEmg6uIl0dmgMlCrW6dYI+IY6yA7EHPQLUGQHHsm056ScOq9EkJrOarJjWoTpS@vger.kernel.org, AJvYcCWAMxHfon6w1B0g+Rn+CFDof68mhHrTzBvGJSBIACVNksU1iUUjHt65ns6XdIio2hxijBd3BpAcPdrD@vger.kernel.org, AJvYcCWC7gHtrlfhqi8UkOQcUr35MYO+hQ8+0Wg4/0dlxx52MogRvHAbIrw+tRJlKBp3XrVvH2CSCxZHvC0KWspk@vger.kernel.org, AJvYcCXoAUkyGkilGGQamlrPVvxz2fmO2n6JbcHsqLeEnXBxfTAwXOJRV9ZXh4an/ELIbT4KhtrJXaYtKEjKJVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqPnAcCF4yyB/Ng7f2P1fJIBb6MCBj6snUscCFk7zJCbjytEr
	uj1b8TvxbvcMUMlkuRMKerYjUHtP4Xg+yClumOsx8YrfoA4QDuSu0qNd09ZMb50JbR2xxF6jZMH
	Jhang2uKca1a9vyy+eW4ohoGuOGY=
X-Gm-Gg: ASbGnctxHXOga119luca9yGi/aWq7MrYHie+GzRjGi029Pm8yDD7lUAq2EjJJVLGr1c
	mJvYnW6EnzkYLi4xEdAzvp7sjHaVRQU6ZMUoQwf84TaBdrlbtIXTm3cTFmSYbRbTRanzKHZDHmv
	MyWcGkT9Fksnj7ldj1IGLHMtm3BE1djTwDoKN60q9JrU4V9BQz6NwPIfcZ
X-Google-Smtp-Source: AGHT+IF7s4G6MY5J8Z9f/kRrKwwOP8kRUFivscO5d8i28kyI9/OrydmeokG0mUI1GGr9ZtKyzTHEiIGDsj2mMK1VKSM=
X-Received: by 2002:a2e:a590:0:b0:308:f3b4:ea66 with SMTP id
 38308e7fff4ca-31090556784mr13001471fa.28.1744989385268; Fri, 18 Apr 2025
 08:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com> <68014084.0c0a0220.394e75.122c@mx.google.com>
 <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com>
 <680160b8.050a0220.223d09.180f@mx.google.com> <CAJ-ks9=TXjk8W18ZMG4mx0JpYvXr4nwnUJqjCnqvW9zu2Y1xjA@mail.gmail.com>
 <aAJrOV88S-4Qb5o0@Mac.home>
In-Reply-To: <aAJrOV88S-4Qb5o0@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 18 Apr 2025 11:15:49 -0400
X-Gm-Features: ATxdqUGa0yL3BJTd10vx67e5vgbZ6t-kHCwTvjIRZDePw3OECStFIEAsMMp1hyE
Message-ID: <CAJ-ks9=FauL4LGMhrdDbd-NSaxHQ=w_ZtcntSuz2ZgSJWx2wvw@mail.gmail.com>
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

On Fri, Apr 18, 2025 at 11:09=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Fri, Apr 18, 2025 at 08:08:02AM -0400, Tamir Duberstein wrote:
> > On Thu, Apr 17, 2025 at 4:12=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Thu, Apr 17, 2025 at 03:26:14PM -0400, Tamir Duberstein wrote:
> > > [...]
> > > > >
> > > > > >          Ok(())
> > > > > >      }
> > > > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.r=
s
> > > > > > index e5859217a579..4063f09d76d9 100644
> > > > > > --- a/rust/kernel/device_id.rs
> > > > > > +++ b/rust/kernel/device_id.rs
> > > > > > @@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArr=
ay<T, U, N> {
> > > > > >              unsafe {
> > > > > >                  raw_ids[i]
> > > > > >                      .as_mut_ptr()
> > > > > > -                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
> > > > > > +                    .byte_add(T::DRIVER_DATA_OFFSET)
> > > > > >                      .cast::<usize>()
> > > > > >                      .write(i);
> > > > > >              }
> > > > > > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > > > > > index f7e8f5f53622..70d12014e476 100644
> > > > > > --- a/rust/kernel/devres.rs
> > > > > > +++ b/rust/kernel/devres.rs
> > > > > > @@ -45,7 +45,7 @@ struct DevresInner<T> {
> > > > > >  /// # Example
> > > > > >  ///
> > > > > >  /// ```no_run
> > > > > > -/// # use kernel::{bindings, c_str, device::Device, devres::De=
vres, io::{Io, IoRaw}};
> > > > > > +/// # use kernel::{bindings, c_str, device::Device, devres::De=
vres, ffi::c_void, io::{Io, IoRaw}};
> > > > > >  /// # use core::ops::Deref;
> > > > > >  ///
> > > > > >  /// // See also [`pci::Bar`] for a real example.
> > > > > > @@ -59,19 +59,19 @@ struct DevresInner<T> {
> > > > > >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> > > > > >  ///         // SAFETY: By the safety requirements of this func=
tion [`paddr`, `paddr` + `SIZE`) is
> > > > > >  ///         // valid for `ioremap`.
> > > > > > -///         let addr =3D unsafe { bindings::ioremap(paddr as _=
, SIZE as _) };
> > > > > > +///         let addr =3D unsafe { bindings::ioremap(paddr as b=
indings::phys_addr_t, SIZE) };
> > > > >
> > > > >
> > > > > ///         let addr =3D unsafe { bindings::ioremap(bindings::phy=
s_addr_t::from(paddr), SIZE) };
> > > > >
> > > > > better? Or even with .into()
> > > > >
> > > > > ///         let addr =3D unsafe { bindings::ioremap(paddr.into(),=
 SIZE) };
> > > >
> > > > This doesn't compile because `paddr` is usize, and
> > > > `bindings::phys_addr_t` is u64 (on my machine, which is aarch64).
> > > >
> > >
> > > Ok, looks like Rust yet doesn't provide From/Into between usize and u=
64
> > > even if the pointer size is fixed. Latest discussion can be found at:
> > >
> > >         https://github.com/rust-lang/rust/issues/41619#issuecomment-2=
056902943
> > >
> > > Lemme see if we can get an issue tracking this. Thanks for taking a
> > > look.
> > >
> > > > > >  ///         if addr.is_null() {
> > > > > >  ///             return Err(ENOMEM);
> > > > > >  ///         }
> > > > > >  ///
> > > > > > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > > > > > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> > > > > >  ///     }
> > > > > >  /// }
> > > > > >  ///
> > > > > >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> > > > > >  ///     fn drop(&mut self) {
> > > > > >  ///         // SAFETY: `self.0.addr()` is guaranteed to be pro=
perly mapped by `Self::new`.
> > > > > > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > > > > > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c=
_void); };
> > > > > >  ///     }
> > > > > >  /// }
> > > > > >  ///
> > > > > [...]
> > > > > > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> > > > > > index 43ecf3c2e860..851a6339aa90 100644
> > > > > > --- a/rust/kernel/dma.rs
> > > > > > +++ b/rust/kernel/dma.rs
> > > > > > @@ -38,7 +38,7 @@
> > > > > >  impl Attrs {
> > > > > >      /// Get the raw representation of this attribute.
> > > > > >      pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> > > > > > -        self.0 as _
> > > > > > +        self.0 as crate::ffi::c_ulong
> > > > >
> > > > >         crate::ffi::c_ulong::from(self.0)
> > > > >
> > > > > maybe, a C unsigned long should always be able to hold the whole =
`Attr`
> > > > > and a lossly casting is what this function does.
> > > >
> > > > This also doesn't compile: "the trait `core::convert::From<u32>` is
> > > > not implemented for `usize`". Upstream has ambitions of running on
> > > > 16-bit, I guess :)
> > > >
> > >
> > > They do but they also have the target_pointer_width cfg, so they can
> > > totally provide these functions. It's just they want to find a better
> > > way (like the link I post above).
> >
> > Did you want me to hold off on the respin on this point, or shall I go =
ahead?
>
> No need to wait. This doesn't affect your current patch. But we do need
> to start making some decisions about how we handle the conversions *32
> =3D> *size, *size =3D> *64 and c*long <=3D> *size, they should all be los=
sless
> in the context of kernel. We have 3 options:
>
> 1.      Using `as`.
> 2.      Having our own to_*size(*32), to_*64(*size), to_*size(*64),
>         to_c*long(*size) and to_*size(c*long) helper functions.
> 3.      Waiting and using what Rust upstream comes up.
>
> I'm leaning towards to 2 and then 3, because using `as` can sometimes
> surprise you when you change the type. Thoughts?

Yes, I think that's the right thing to do. That, along with the
provenance functions, might even allow us to turn on
https://rust-lang.github.io/rust-clippy/master/index.html#as_conversions.

