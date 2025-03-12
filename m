Return-Path: <linux-kselftest+bounces-28833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BCA5E35D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DA117B2F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831324BC09;
	Wed, 12 Mar 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq4+/BYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3908635C;
	Wed, 12 Mar 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802512; cv=none; b=RJhvHfTJMzKzFngnoySpvV276y3IRBLy6iVzrh5sB6lg1wtfzJGGu6D1jgN7vmQpIdLaanCNhmIJLsQz8JOmeNz5YAo6+MxDXspZ8cBQ81QuBZM8RnrKeTrcEG8k/WXAZo1vsTyt4jIUGYl0YdIU7G1TeCJCmjel1yYgVKPX6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802512; c=relaxed/simple;
	bh=rO6bQeiLgciAhvTAT8+JnA5u7mmVwP4ISyEvx8VNooQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4Ivu4vFTNh+H1nyi1YgEep6VzTCFusaCoiaPx+w4u3ptMJesp8a0vSK90/dVnaWk2vuSs+qkYbzJUT2z8PRqydOU3gDbZdn9cdp1au7Gwae5vQJwDMp+aovtM4euj/4/yUKUp2IO/auIO5DiGxBHmVF0Koys9695lD70Nvobok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq4+/BYe; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-307c13298eeso1942101fa.0;
        Wed, 12 Mar 2025 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741802508; x=1742407308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApRv/PQW+ijuMOPlXLAcG0C+/xPXK0bfDJ3PT3/amII=;
        b=Dq4+/BYeZRuVO2UBxPHMcOVZ4BpsQcjWKjFmjzq7M105Aq/m/HcBjRfRZWa3MjsKMC
         8kmAvS/bm8h+HEhljSRbymvlmQe6Vg+Al9y+fDG5UFC/y06b0ffwPPa73fi87ihsvGjW
         6JYvKTIpToZd00qLazI90EN8cbUX27kA5DAsAGDGNdIDMmlwTlt9lbrEBcK87ouRRDsr
         yxQctD0cht42gx8+tIfFeNS2JqJ41nqlYLV240rjcXVZRPvZiFnB8su4QP3wK7iAOuii
         Q4GUOY90+dqWzCVwlzkr8U8bMtqgL8Dg51r6VkDfs3C7EClRlmvCaPseRB4LezMQkXPF
         1/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741802508; x=1742407308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApRv/PQW+ijuMOPlXLAcG0C+/xPXK0bfDJ3PT3/amII=;
        b=EJAtRWLJTuJN867/u8nnkGWqfHlmVfUodj+bT0eyBkrUdPrHvtL4SYTZwqBTv4BlFz
         n9c3qwiaQuzIRWOE2RIddYd3qb+9uEJQANblwQRacaxI1v1cr1lhJoiLZHKVsTYMn54d
         3yRiuwAYhFTED51xFYv7y6k4LyOnCK+hQV5hEqLAM1bwHVpkiuzzQN00IgLXbeiElUcH
         wcV9WpPLb40xY5ow/bFlbUei+bF33QhiYjLcJJdTvg+0XobKSmWLTg2nVHRRxQrOKYA4
         QdTwN5LfCdPhb9GRIyvcKCD7+ytb2WXDombJAr62qrSliN5Sn6pNaGTH4gUH9zZ5ymn/
         SZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCWUk8BVZYRcWkJ2fiZZNHGLSjHSSuss3c7MVn+cWlph2W6GaqQmhDapgtCm9OBS1nLUK6qFxTnoqeegegsGfYEM@vger.kernel.org, AJvYcCWizVmhTACRnnaWKu0dYgz+JOmadYuGNxwx48HDm42t5ctNTA2/wT0hSuI6+/uJkWM9iN7/ZIQyEk8I@vger.kernel.org, AJvYcCWw0gr9xmXcD9GaRWH3P5tbmKTM4VjN8URDiCnoGFo5GyfikRuwoDwT8p9L517HCkAAp62RHICD4Xhc@vger.kernel.org, AJvYcCWxIU9r49sbOQxsImPI7R16LBUvWrj0VhaoFfqlAUDh5Lp+vQDluiTphDgmLbD/tton+Gntq1GvWGM6ef1o@vger.kernel.org, AJvYcCXP19A2EZwGJXf3Ziry3DJElpmo1YzAUSFMJxawcQHfpAhKSGLsMVN66H64m7GlzG5egOKsf3JwRlkR67+E1x8=@vger.kernel.org, AJvYcCXYJA4CBhEtbM/ZnKyrJAePPLCbgtDEF5mgrU3pKvWECCE2GesItiLeYOryIY8Ic1swptn9N3bBhSJCMyKd@vger.kernel.org, AJvYcCXmua0EuCpsjovr8vUUncxz8tRrs1T+dhQxLTWrNpZh8JyVzzKBywdMD4hKDdaFm2KfFTBZuDnBUya6DEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfnmRW9KyPu3Qs2Fh83GnisuMaCoVyQeDyj9ghm39hiV03EpwY
	TM+vcNGlbqiU6eXHABSWykB1AcgvPjslwxjQQtyYWU9+hiTuZ9+eOBalqVsMSBb7y6lQ1AtRbF7
	DG6amprL2MZeUcKaEqWcLm/w8cY0=
X-Gm-Gg: ASbGnctVE/NJ9zr5Ixe6wLNNt2seDrmHrjPU4O5mJQBHldGfIeEwBSil4rYvkTEGO5S
	xIf0blkDc/IsRxVjiu6QFKbYlBf6HWG6oLuDmQph7uq/f/3bt/YzCHTOoRZCJ4sD4OesknMt94b
	wYYB6tnZPKqbRlSjPL87RRrfQpkQLNPq2TBVf50pIsYA==
X-Google-Smtp-Source: AGHT+IG6P/j5632p/8QjaseOyQ5uu5EySxTcXUQPluEGY8olXaxgcj7BTmBvUnZG7r6EGWt6/GALADJs9px3sBUs164=
X-Received: by 2002:a2e:8713:0:b0:30b:f2b4:8868 with SMTP id
 38308e7fff4ca-30c3af65abamr2545071fa.4.1741802506191; Wed, 12 Mar 2025
 11:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com> <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me>
In-Reply-To: <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 14:01:10 -0400
X-Gm-Features: AQ5f1JoQIzBOvINLDZZ_4cXGjM0X7iwR4tSMnTEGuwMm3AxvV9pDiuhDEV8ViqU
Message-ID: <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
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

On Wed, Mar 12, 2025 at 1:05=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 4:35 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 12, 2025 at 11:05=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >>
> >> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> >> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> >> > index 598001157293..20159b7c9293 100644
> >> > --- a/rust/kernel/devres.rs
> >> > +++ b/rust/kernel/devres.rs
> >> > @@ -45,7 +45,7 @@ struct DevresInner<T> {
> >> >  /// # Example
> >> >  ///
> >> >  /// ```no_run
> >> > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres,=
 io::{Io, IoRaw}};
> >> > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres,=
 ffi::c_void, io::{Io, IoRaw}};
> >> >  /// # use core::ops::Deref;
> >> >  ///
> >> >  /// // See also [`pci::Bar`] for a real example.
> >> > @@ -59,19 +59,19 @@ struct DevresInner<T> {
> >> >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> >> >  ///         // SAFETY: By the safety requirements of this function =
[`paddr`, `paddr` + `SIZE`) is
> >> >  ///         // valid for `ioremap`.
> >> > -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZ=
E as _) };
> >> > +///         let addr =3D unsafe { bindings::ioremap(paddr as u64, S=
IZE) };
> >>
> >> The argument of `ioremap` is defined as `resource_size_t` which
> >> ultimately maps to `u64` on 64 bit systems and `u32` on 32 bit ones. I
> >> don't think that we should have code like this... Is there another
> >> option?
> >>
> >> Maybe Gary knows something here, do we have a type that represents tha=
t
> >> better?
> >
> > Ah yeah the problem is that this type is an alias rather than a
> > newtype. How do you feel about `as bindings::phys_addr_t`?
>
> Yeah that's better.
>
> >> >  ///         if addr.is_null() {
> >> >  ///             return Err(ENOMEM);
> >> >  ///         }
> >> >  ///
> >> > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> >> > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> >>
> >> This should be `addr.addr()` (requires `strict_provenance` on Rust 1.8=
3
> >> & before).
> >>
> >> (I am assuming that we're never casting the usize back to a pointer,
> >> since otherwise this change would introduce UB)
> >
> > Yeah, we don't have strict provenance APIs (and we can't introduce
> > them without compiler tooling or bumping MSRV). I'm not sure if we are
> > casting back to a pointer, but either way this change doesn't change
> > the semantics - it is only spelling out the type.
>
> It's fine to enable the feature, since it's stable in a newer version of
> the compiler.
>
> >> >  ///     }
> >> >  /// }
> >> >  ///
> >> >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> >> >  ///     fn drop(&mut self) {
> >> >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly=
 mapped by `Self::new`.
> >> > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> >> > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void=
); };
> >>
> >> Can't this be a `.cast::<c_void>()`?
> >
> > This is an integer-to-pointer cast. `addr` returns `usize`:
>
> Oh I missed the `*mut`... In that case, we can't use the `addr`
> suggestion that I made above, instead we should use `expose_provenance`
> above and `with_exposed_provenance` here.
>
> > impl<const SIZE: usize> IoRaw<SIZE> {
> >     [...]
> >
> >     /// Returns the base address of the MMIO region.
> >     #[inline]
> >     pub fn addr(&self) -> usize {
> >         self.addr
> >     }
> >
> >     [...]
> > }
> >
> >>
> >> >  ///     }
> >> >  /// }
> >> >  ///
> >>
> >> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> >> > index 8654d52b0bb9..eb8fa52f08ba 100644
> >> > --- a/rust/kernel/error.rs
> >> > +++ b/rust/kernel/error.rs
> >> > @@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::b=
lk_status_t {
> >> >      /// Returns the error encoded as a pointer.
> >> >      pub fn to_ptr<T>(self) -> *mut T {
> >> >          // SAFETY: `self.0` is a valid error due to its invariant.
> >> > -        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
> >> > +        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }
> >>
> >> Can't this be a `.into()`?
> >
> > error[E0277]: the trait bound `isize: core::convert::From<i32>` is not =
satisfied
> >    --> ../rust/kernel/error.rs:155:49
> >     |
> > 155 |         unsafe { bindings::ERR_PTR(self.0.get().into()).cast() }
> >     |                                                 ^^^^ the trait
> > `core::convert::From<i32>` is not implemented for `isize`
>
> That's a bummer... I wonder why that doesn't exist.
>
> >> >      }
> >> >
> >> >      /// Returns a string representing the error, if one exists.
> >>
> >> > @@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name=
 {
> >> >              let addr =3D self.io_addr_assert::<$type_name>(offset);
> >> >
> >> >              // SAFETY: By the type invariant `addr` is a valid addr=
ess for MMIO operations.
> >> > -            unsafe { bindings::$name(addr as _) }
> >> > +            unsafe { bindings::$name(addr as *const c_void) }
> >>
> >> Also here, is `.cast::<c_void>()` enough? (and below)
> >
> > It's an integer-to-pointer cast. In the same `impl<const SIZE: usize>
> > IoRaw<SIZE>` as above:
> >
> >     fn io_addr_assert<U>(&self, offset: usize) -> usize {
> >         build_assert!(Self::offset_valid::<U>(offset, SIZE));
> >
> >         self.addr() + offset
> >     }
>
> I would prefer we use the strict_provenance API.
>
> >> >          }
> >> >
> >> >          /// Read IO data from a given offset.
> >>
> >> > diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> >> > index 04f2d8ef29cb..40d1bd13682c 100644
> >> > --- a/rust/kernel/of.rs
> >> > +++ b/rust/kernel/of.rs
> >> > @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
> >> >      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindi=
ngs::of_device_id, data);
> >> >
> >> >      fn index(&self) -> usize {
> >> > -        self.0.data as _
> >> > +        self.0.data as usize
> >>
> >> This should also be `self.0.data.addr()`.
> >
> > Can't do it without strict_provenance.
> >
> >>
> >> >      }
> >> >  }
> >> >
> >> > @@ -34,10 +34,10 @@ pub const fn new(compatible: &'static CStr) -> S=
elf {
> >> >          // SAFETY: FFI type is valid to be zero-initialized.
> >> >          let mut of: bindings::of_device_id =3D unsafe { core::mem::=
zeroed() };
> >> >
> >> > -        // TODO: Use `clone_from_slice` once the corresponding type=
s do match.
> >> > +        // TODO: Use `copy_from_slice` once stabilized for `const`.
> >>
> >> This feature has just been stabilized (5 days ago!):
> >>
> >>     https://github.com/rust-lang/rust/issues/131415
> >
> > Yep! I know :)
> >
> >> @Miguel: Do we already have a target Rust version for dropping the
> >> `RUSTC_BOOTSTRAP=3D1`? If not, then I think we should use this feature
> >> now, since it will be stable by the time we bump the minimum version.
> >> (not in this patch [series] though)
> >>
> >> >          let mut i =3D 0;
> >> >          while i < src.len() {
> >> > -            of.compatible[i] =3D src[i] as _;
> >> > +            of.compatible[i] =3D src[i];
> >> >              i +=3D 1;
> >> >          }
> >>
> >> > @@ -317,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize=
, num: i32) {
> >> >          // `ioptr` is valid by the safety requirements.
> >> >          // `num` is valid by the safety requirements.
> >> >          unsafe {
> >> > -            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
> >> > +            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kern=
el::ffi::c_void);
> >>
> >> Again, probably castable.
> >
> > How? `ioptr` is a `usize` (you can see the prototype).
>
> Sorry, I missed all the `*mut`/`*const` prefixes here.
>
> ---
> Cheers,
> Benno
>

I think all the remaining comments are about strict provenance. I buy
that this is a useful thing to do, but in the absence of automated
tools to help do it, I'm not sure it's worth it to do it for just
these things I happen to be touching rather than doing it throughout.

I couldn't find a clippy lint. Do you know of one? If not, should we
file an issue?

