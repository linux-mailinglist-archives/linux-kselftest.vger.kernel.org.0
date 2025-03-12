Return-Path: <linux-kselftest+bounces-28821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B0A5E080
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD03189C702
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B752C253F03;
	Wed, 12 Mar 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBYWlO3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E685C5E;
	Wed, 12 Mar 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793779; cv=none; b=GPLHp0K0apiDFAmiNl0UUgIsAaRPWyXsxN9TOI3OCx/eDGNTmFFj+FeM9DorkofquJbDWYVx/yOi/1XBWBEBDSbgmBREl1GDz4MMwLF9GaClWq9WetuM5K5/glM9MhfswOxROr8A2+7IxR7pgllTP13rxW9WVL5EUNwQhKhSDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793779; c=relaxed/simple;
	bh=GgP4Q2Rw1VYckDi3OWRgZqr4KMKYjxv/IJPaeJKHppE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDcfIQ6D0K/biV3ZdhXkNa7eI6zUq6gItq1KOc8n6quJA8mTUQ5mEx0FxVW4e5982PwQRoSlhJQ8T/zysd+tOAyKr9kOHATI+CdFHJb41rueJJvOYJxF+NOFL8EKVfmctDor7k+iZ4ddJ3BT0pDu61kpZc6d7jqj3+DU3zJ6BNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBYWlO3A; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so10307988a12.0;
        Wed, 12 Mar 2025 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793776; x=1742398576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQMZOHAomyAzg4jiqshJe3nsZjhhUaDPG3i/RS5JDzk=;
        b=iBYWlO3A+YxbfAPhM4rAPpC6lejvwvBHGJvHnyIjSHBW1Sd3iBQNus68Ob+2xo7ECd
         zqQkVkII9P++eC2yvayhI/fQnVsM0EVFVhAn7ipbAC38GU8Hqn8nF8A1jZCOV3/m+vrx
         MU13MDAjD6aexVKaq9mo1/GfMTxequ07FrxMZcq1xJxza/EaFvMvXhqSK5lUkaQ1T6ih
         LWsKnH4Omt3clN2SG8gTlpMOrfY07N0ao8le1UFnLw+3avGxN/xJH6rxEdJtLwIgAuCt
         6R+eZDpflgxWgVsGbEgAqEAG+NbjYAnGNmwkjoiuxhIJnRqR+2wOD998DreV22h9TnLh
         r4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793776; x=1742398576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQMZOHAomyAzg4jiqshJe3nsZjhhUaDPG3i/RS5JDzk=;
        b=ipN0otML/dCKiohI+VNzANxLQoY3N+Q5dAD4fjmd2HNW1D4g1+CFLRe/Cd9x0B7Nvg
         QnQpoTaGj7VHHh2kmYbvHU19d7FuPGCe98TjH85LjwRAZwjUFcBWCFhIsjoshECxnpVl
         jsyooWxkl+unQBgtP69LXk4l57IAmF+L2ZTTmY+F5zOGIvQz876yz+dwRZXCHAsthygi
         isRE8FFVmJNB396M4x4bVjuhSAygrgPSaaHajwj72yjhTweKbz1XkRX4CLIOi30ATi2r
         vD4xPZVfU9KgooUG+rDE+jCTFgliG4W5gENk98ZqTldMTPZ+6J35vcdv3lG/oFUsYmUV
         LnWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+B2/ZtEqff82b7bODxT2DS2fhKIYka5ksOK08AWeIBZzKD2KmbQm4afqMS2igtHcJ9saKVLMLAXMEzjPT40v8@vger.kernel.org, AJvYcCVHL54B+djNcv4T5odgJihkJJQr1TFArjX7EPIHlUxQfFMCrtqVwDx9nT4s4GCEVJfKGWyUWTuBXoZOvcqi@vger.kernel.org, AJvYcCVS2GOZdagWxt9sAeJoAqP4jt1l0cjezA3ta3MujOEEeTqyCiGJ6FCbX6RNz5gEtTdOQ0HJYHOvgauA9rw=@vger.kernel.org, AJvYcCWoxhXsRB1I+FiHKUXoms7+2weoyK3YZGyOtIf5SNtIskNAvP0dMnm3qTo8wQ1hvMpvx1BXVydzy6a8gdzjX6c=@vger.kernel.org, AJvYcCXG06MNDofpfC8naxaA0DQudkiRB7nioeKTWdnxeno7CJsuNh8cyuotg1GOVf8/UnawXYHmB9VwkE5a@vger.kernel.org, AJvYcCXIhezsYX0PQGF1sn6DkvfoBcRXCjpXqcSojeMZgsG8DN1rIoZZMV/pr/gXb8WLuIqMhk3s7IW2/k7T+Hna@vger.kernel.org, AJvYcCXQARJ3SD3cbYhvpj4fSBvV9laTlod0mYbIixz4YTe53gqz+Jv1SAlw19F3oS3I8L+yaDB/IvQaWx0+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWWc1lX8F5NSg6DL5rQlF4X9IpJg5MO7hKHQ9XoBk6Ktqqqruy
	D+DJz/lbx1cYEQEEWj82Z+xVo7Thiwo5MjDT+evKkIJjmRwpvQNHK/ZZGA/etLH9lrGynPFORR/
	HNI2Vzv3lYWQKNQUe6d4ZP/g6bUk=
X-Gm-Gg: ASbGncsJTatEceXOm88A4NGKqaqPv0FnKRs9D2qcGl/2QtJqH5sA0gP7woXaCbnXONb
	IObrL313yo3yYmXikQaKgDJFYkfTWjh0GGVzPvhd/M5oHmfAtg6gFwdROcAIi+bTXJZBFXJwKKK
	TBG4+Xj2ska4ebh27/gAprn8DW8cVNsI6fPwItWXesqA==
X-Google-Smtp-Source: AGHT+IGNV8i6S+ubXKrjupQg31WxsAznMi2mVw6pqkziEFUnd13z/4zdnvWBup5ZJat6a3pGvU3yN7ENoZVbR0PzlcY=
X-Received: by 2002:a17:906:882:b0:ac2:7be7:95c5 with SMTP id
 a640c23a62f3a-ac27be79e32mr1741806466b.33.1741793775528; Wed, 12 Mar 2025
 08:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
In-Reply-To: <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 11:35:29 -0400
X-Gm-Features: AQ5f1JovFkieADK2j5qsaOP-ipWuDczGfkWnRMeg_0yLN1jvGEFw6PHwYpccKHM
Message-ID: <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 11:05=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index 598001157293..20159b7c9293 100644
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
> > +///         let addr =3D unsafe { bindings::ioremap(paddr as u64, SIZE=
) };
>
> The argument of `ioremap` is defined as `resource_size_t` which
> ultimately maps to `u64` on 64 bit systems and `u32` on 32 bit ones. I
> don't think that we should have code like this... Is there another
> option?
>
> Maybe Gary knows something here, do we have a type that represents that
> better?

Ah yeah the problem is that this type is an alias rather than a
newtype. How do you feel about `as bindings::phys_addr_t`?

> >  ///         if addr.is_null() {
> >  ///             return Err(ENOMEM);
> >  ///         }
> >  ///
> > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
>
> This should be `addr.addr()` (requires `strict_provenance` on Rust 1.83
> & before).
>
> (I am assuming that we're never casting the usize back to a pointer,
> since otherwise this change would introduce UB)

Yeah, we don't have strict provenance APIs (and we can't introduce
them without compiler tooling or bumping MSRV). I'm not sure if we are
casting back to a pointer, but either way this change doesn't change
the semantics - it is only spelling out the type.

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
>
> Can't this be a `.cast::<c_void>()`?

This is an integer-to-pointer cast. `addr` returns `usize`:

impl<const SIZE: usize> IoRaw<SIZE> {
    [...]

    /// Returns the base address of the MMIO region.
    #[inline]
    pub fn addr(&self) -> usize {
        self.addr
    }

    [...]
}

>
> >  ///     }
> >  /// }
> >  ///
>
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index 8654d52b0bb9..eb8fa52f08ba 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_=
status_t {
> >      /// Returns the error encoded as a pointer.
> >      pub fn to_ptr<T>(self) -> *mut T {
> >          // SAFETY: `self.0` is a valid error due to its invariant.
> > -        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
> > +        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }
>
> Can't this be a `.into()`?

error[E0277]: the trait bound `isize: core::convert::From<i32>` is not sati=
sfied
   --> ../rust/kernel/error.rs:155:49
    |
155 |         unsafe { bindings::ERR_PTR(self.0.get().into()).cast() }
    |                                                 ^^^^ the trait
`core::convert::From<i32>` is not implemented for `isize`

>
> >      }
> >
> >      /// Returns a string representing the error, if one exists.
>
> > @@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
> >              let addr =3D self.io_addr_assert::<$type_name>(offset);
> >
> >              // SAFETY: By the type invariant `addr` is a valid address=
 for MMIO operations.
> > -            unsafe { bindings::$name(addr as _) }
> > +            unsafe { bindings::$name(addr as *const c_void) }
>
> Also here, is `.cast::<c_void>()` enough? (and below)

It's an integer-to-pointer cast. In the same `impl<const SIZE: usize>
IoRaw<SIZE>` as above:

    fn io_addr_assert<U>(&self, offset: usize) -> usize {
        build_assert!(Self::offset_valid::<U>(offset, SIZE));

        self.addr() + offset
    }

>
> >          }
> >
> >          /// Read IO data from a given offset.
>
> > diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> > index 04f2d8ef29cb..40d1bd13682c 100644
> > --- a/rust/kernel/of.rs
> > +++ b/rust/kernel/of.rs
> > @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
> >      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings=
::of_device_id, data);
> >
> >      fn index(&self) -> usize {
> > -        self.0.data as _
> > +        self.0.data as usize
>
> This should also be `self.0.data.addr()`.

Can't do it without strict_provenance.

>
> >      }
> >  }
> >
> > @@ -34,10 +34,10 @@ pub const fn new(compatible: &'static CStr) -> Self=
 {
> >          // SAFETY: FFI type is valid to be zero-initialized.
> >          let mut of: bindings::of_device_id =3D unsafe { core::mem::zer=
oed() };
> >
> > -        // TODO: Use `clone_from_slice` once the corresponding types d=
o match.
> > +        // TODO: Use `copy_from_slice` once stabilized for `const`.
>
> This feature has just been stabilized (5 days ago!):
>
>     https://github.com/rust-lang/rust/issues/131415

Yep! I know :)

> @Miguel: Do we already have a target Rust version for dropping the
> `RUSTC_BOOTSTRAP=3D1`? If not, then I think we should use this feature
> now, since it will be stable by the time we bump the minimum version.
> (not in this patch [series] though)
>
> >          let mut i =3D 0;
> >          while i < src.len() {
> > -            of.compatible[i] =3D src[i] as _;
> > +            of.compatible[i] =3D src[i];
> >              i +=3D 1;
> >          }
>
> > @@ -317,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, n=
um: i32) {
> >          // `ioptr` is valid by the safety requirements.
> >          // `num` is valid by the safety requirements.
> >          unsafe {
> > -            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
> > +            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel:=
:ffi::c_void);
>
> Again, probably castable.

How? `ioptr` is a `usize` (you can see the prototype).

>
> >              bindings::pci_release_region(pdev.as_raw(), num);
> >          }
> >      }
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 6a1a982b946d..0b80a119d5f0 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -692,9 +692,9 @@ fn new() -> Self {
> >      pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self=
 {
> >          // INVARIANT: The safety requirements guarantee the type invar=
iants.
> >          Self {
> > -            beg: pos as _,
> > -            pos: pos as _,
> > -            end: end as _,
> > +            beg: pos as usize,
> > +            pos: pos as usize,
> > +            end: end as usize,
>
> I would prefer if we use `pos.expose_provenance()` (also for `end`)
> here.

Me too! But we can't until we actually start using strict provenance.

>
> >          }
> >      }
> >
> > @@ -719,7 +719,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len:=
 usize) -> Self {
> >      ///
> >      /// N.B. It may point to invalid memory.
> >      pub(crate) fn pos(&self) -> *mut u8 {
> > -        self.pos as _
> > +        self.pos as *mut u8
>
> This should then also be `with_exposed_provenance(self.pos)`

Same as other instances of strict provenance.

