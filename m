Return-Path: <linux-kselftest+bounces-28830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D5A5E22F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 18:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DE916BEF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA81E8325;
	Wed, 12 Mar 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b2jziJiR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F4282F1;
	Wed, 12 Mar 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799153; cv=none; b=STqJ7f6pSVfR/2gXooTzjalv7cvy5YKNV/rhAvC5MEgK9izNTuqUGSimSe1JyAUjqqeKTgisEdXBm1f+nR/8b5zexfwWwpueLMRdsSywlNo0A0r8GO8zS8QvgDpvguDH3EjkeuAykuvMFqrYEZrVKiS18n2te8oFWWq6qcrIkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799153; c=relaxed/simple;
	bh=AP2DarFxP1kHmbc1UQ9k/cTreCsRImTcUA6mVTmVGkY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C++DcwqaEl5Z0oUpJPDZ3ehSJO4jjCzvww1oywZ4bQnMZT3bYe4C6KeIuIC6gW9jFpO/6hsJ3UaYS6XzapTsC3xfJNErjfoV/hxkQarxV7DnSFCyt+cDxEpeiRCoo2ueqchlIGQRtbFL5QvQSnAKFU4eCQMcZBxwgQ9wzjDupds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b2jziJiR; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741799147; x=1742058347;
	bh=H5vl6p6VvHTW8KbGWXzE7B7/l993EE1hKM2A3P0sLhk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=b2jziJiRFsmsGXaAH/pfzEpF6rybEcf/p6HsH/3iuVY6V8RgfKPuIaPsdUqv/kk38
	 jDaRI6UihnNYvD9eCeTozR9RJm6VOcspVF7Jv3U9v1rrWLyyvpcfbQajG+eAw/pa3+
	 Qnkxgek2raHEZB6LkzhlfCmAp+aN5AQDN5bwptySMixAf84ZVG6nWirq03aKZDNfRO
	 +A4MLcTa9PYJd8Whi1yfBdZ6is1iQMDwpkkuKIhIDmz5YHnpT4B+5qs4BHxSccRrkr
	 TrSccll+fzpnzBOsr/6GIy/APpeqhW+YhhSRzBlglgXWLsVyStn9PTuqzMbg7s/56n
	 MshHrVkdfD/hA==
Date: Wed, 12 Mar 2025 17:05:42 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me>
In-Reply-To: <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me> <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e4ddaa38df8cc192110bac9445ef586b5ce36b87
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 12, 2025 at 4:35 PM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 11:05=E2=80=AFAM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
>> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> > index 598001157293..20159b7c9293 100644
>> > --- a/rust/kernel/devres.rs
>> > +++ b/rust/kernel/devres.rs
>> > @@ -45,7 +45,7 @@ struct DevresInner<T> {
>> >  /// # Example
>> >  ///
>> >  /// ```no_run
>> > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, i=
o::{Io, IoRaw}};
>> > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, f=
fi::c_void, io::{Io, IoRaw}};
>> >  /// # use core::ops::Deref;
>> >  ///
>> >  /// // See also [`pci::Bar`] for a real example.
>> > @@ -59,19 +59,19 @@ struct DevresInner<T> {
>> >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
>> >  ///         // SAFETY: By the safety requirements of this function [`=
paddr`, `paddr` + `SIZE`) is
>> >  ///         // valid for `ioremap`.
>> > -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZE =
as _) };
>> > +///         let addr =3D unsafe { bindings::ioremap(paddr as u64, SIZ=
E) };
>>
>> The argument of `ioremap` is defined as `resource_size_t` which
>> ultimately maps to `u64` on 64 bit systems and `u32` on 32 bit ones. I
>> don't think that we should have code like this... Is there another
>> option?
>>
>> Maybe Gary knows something here, do we have a type that represents that
>> better?
>
> Ah yeah the problem is that this type is an alias rather than a
> newtype. How do you feel about `as bindings::phys_addr_t`?

Yeah that's better.

>> >  ///         if addr.is_null() {
>> >  ///             return Err(ENOMEM);
>> >  ///         }
>> >  ///
>> > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
>> > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
>>
>> This should be `addr.addr()` (requires `strict_provenance` on Rust 1.83
>> & before).
>>
>> (I am assuming that we're never casting the usize back to a pointer,
>> since otherwise this change would introduce UB)
>
> Yeah, we don't have strict provenance APIs (and we can't introduce
> them without compiler tooling or bumping MSRV). I'm not sure if we are
> casting back to a pointer, but either way this change doesn't change
> the semantics - it is only spelling out the type.

It's fine to enable the feature, since it's stable in a newer version of
the compiler.

>> >  ///     }
>> >  /// }
>> >  ///
>> >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>> >  ///     fn drop(&mut self) {
>> >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly m=
apped by `Self::new`.
>> > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
>> > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void);=
 };
>>
>> Can't this be a `.cast::<c_void>()`?
>
> This is an integer-to-pointer cast. `addr` returns `usize`:

Oh I missed the `*mut`... In that case, we can't use the `addr`
suggestion that I made above, instead we should use `expose_provenance`
above and `with_exposed_provenance` here.

> impl<const SIZE: usize> IoRaw<SIZE> {
>     [...]
>
>     /// Returns the base address of the MMIO region.
>     #[inline]
>     pub fn addr(&self) -> usize {
>         self.addr
>     }
>
>     [...]
> }
>
>>
>> >  ///     }
>> >  /// }
>> >  ///
>>
>> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
>> > index 8654d52b0bb9..eb8fa52f08ba 100644
>> > --- a/rust/kernel/error.rs
>> > +++ b/rust/kernel/error.rs
>> > @@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk=
_status_t {
>> >      /// Returns the error encoded as a pointer.
>> >      pub fn to_ptr<T>(self) -> *mut T {
>> >          // SAFETY: `self.0` is a valid error due to its invariant.
>> > -        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
>> > +        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }
>>
>> Can't this be a `.into()`?
>
> error[E0277]: the trait bound `isize: core::convert::From<i32>` is not sa=
tisfied
>    --> ../rust/kernel/error.rs:155:49
>     |
> 155 |         unsafe { bindings::ERR_PTR(self.0.get().into()).cast() }
>     |                                                 ^^^^ the trait
> `core::convert::From<i32>` is not implemented for `isize`

That's a bummer... I wonder why that doesn't exist.

>> >      }
>> >
>> >      /// Returns a string representing the error, if one exists.
>>
>> > @@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
>> >              let addr =3D self.io_addr_assert::<$type_name>(offset);
>> >
>> >              // SAFETY: By the type invariant `addr` is a valid addres=
s for MMIO operations.
>> > -            unsafe { bindings::$name(addr as _) }
>> > +            unsafe { bindings::$name(addr as *const c_void) }
>>
>> Also here, is `.cast::<c_void>()` enough? (and below)
>
> It's an integer-to-pointer cast. In the same `impl<const SIZE: usize>
> IoRaw<SIZE>` as above:
>
>     fn io_addr_assert<U>(&self, offset: usize) -> usize {
>         build_assert!(Self::offset_valid::<U>(offset, SIZE));
>
>         self.addr() + offset
>     }

I would prefer we use the strict_provenance API.

>> >          }
>> >
>> >          /// Read IO data from a given offset.
>>
>> > diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
>> > index 04f2d8ef29cb..40d1bd13682c 100644
>> > --- a/rust/kernel/of.rs
>> > +++ b/rust/kernel/of.rs
>> > @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
>> >      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(binding=
s::of_device_id, data);
>> >
>> >      fn index(&self) -> usize {
>> > -        self.0.data as _
>> > +        self.0.data as usize
>>
>> This should also be `self.0.data.addr()`.
>
> Can't do it without strict_provenance.
>
>>
>> >      }
>> >  }
>> >
>> > @@ -34,10 +34,10 @@ pub const fn new(compatible: &'static CStr) -> Sel=
f {
>> >          // SAFETY: FFI type is valid to be zero-initialized.
>> >          let mut of: bindings::of_device_id =3D unsafe { core::mem::ze=
roed() };
>> >
>> > -        // TODO: Use `clone_from_slice` once the corresponding types =
do match.
>> > +        // TODO: Use `copy_from_slice` once stabilized for `const`.
>>
>> This feature has just been stabilized (5 days ago!):
>>
>>     https://github.com/rust-lang/rust/issues/131415
>
> Yep! I know :)
>
>> @Miguel: Do we already have a target Rust version for dropping the
>> `RUSTC_BOOTSTRAP=3D1`? If not, then I think we should use this feature
>> now, since it will be stable by the time we bump the minimum version.
>> (not in this patch [series] though)
>>
>> >          let mut i =3D 0;
>> >          while i < src.len() {
>> > -            of.compatible[i] =3D src[i] as _;
>> > +            of.compatible[i] =3D src[i];
>> >              i +=3D 1;
>> >          }
>>
>> > @@ -317,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, =
num: i32) {
>> >          // `ioptr` is valid by the safety requirements.
>> >          // `num` is valid by the safety requirements.
>> >          unsafe {
>> > -            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
>> > +            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel=
::ffi::c_void);
>>
>> Again, probably castable.
>
> How? `ioptr` is a `usize` (you can see the prototype).

Sorry, I missed all the `*mut`/`*const` prefixes here.

---
Cheers,
Benno


