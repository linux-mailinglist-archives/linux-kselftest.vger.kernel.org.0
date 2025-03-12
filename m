Return-Path: <linux-kselftest+bounces-28814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510BFA5DFAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23153A93F3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6524F5B5;
	Wed, 12 Mar 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="d6m1Ie+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437F24E009;
	Wed, 12 Mar 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741791920; cv=none; b=mXeuxvBKYaRaTWM6EfGYyATGZDaLxiNF9s39lhn+XTrAUZqJq/e3HOZJzEEZq2foggm2SfT5+jQTS5L4AgV7yGO7Ar9xXa5N6TaW1WraVzZb95aP1j2mtxjIh6fOSHVBPBgO1KfdCphhjd+a5Yb7pvbUe+t9TGJCi8wRIl0JVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741791920; c=relaxed/simple;
	bh=lkaVr3h8k8MDqUDGA2wr8vqhHwKNjp8uXvlrZ+yWHOQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRZuEAMf9zm3GnDn8jTFPaDwuU7wImIwZw2xX4Ej3nu9fSx6VcvTJ7I7rKMuQK+uLHG92mazNaeRhmugwG/Av66B7jmjgeLBewcZvaF7QhDbSM3455r4cs73KU4CU7xZqTvxE8xaVaJ1PJiyc3sKbobH7TMn+hcsGfFtMdbYStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=d6m1Ie+M; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=n6ivansrebgizanuseiv5ngepu.protonmail; t=1741791915; x=1742051115;
	bh=ifQavh2xwoM5ni8IIYcnU08nnIdJQmSsQAjnMmb0m/I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=d6m1Ie+MPpjT0ndzXqUA0IIISaH0Bqp0jTG0OjYYts//vm56yT9PTBHvV8JAO4JEr
	 LI8CfGQO1sabsWxnb/HG0j4jQlo1gmZGRj7X0YAbniLjOf8Xqv1WZ++FuDiQmdLko/
	 GyUH8tbAObNORyCKpiZi/54IIRu5zsDdCMyOijjcHd8sYNLYBKKksyyYSSiW+gcDSh
	 /GTn5jqo9KXZTAGlfkcRCBViDGQUk8lkeBdB9EK6mKvomSz1PCo1xNoRbMblv3OBOr
	 kagQC/u6SnPszh/Iuo0eTQTZu4ozpkY49RISmntAk7wgRpqMqdnHVMr4HvcBr1GjfB
	 zx4W4cSq17/fg==
Date: Wed, 12 Mar 2025 15:05:08 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
In-Reply-To: <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 60984a7c33cfac13fdc78c1a649a642031fb12da
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 598001157293..20159b7c9293 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -45,7 +45,7 @@ struct DevresInner<T> {
>  /// # Example
>  ///
>  /// ```no_run
> -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::=
{Io, IoRaw}};
> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ffi:=
:c_void, io::{Io, IoRaw}};
>  /// # use core::ops::Deref;
>  ///
>  /// // See also [`pci::Bar`] for a real example.
> @@ -59,19 +59,19 @@ struct DevresInner<T> {
>  ///     unsafe fn new(paddr: usize) -> Result<Self>{
>  ///         // SAFETY: By the safety requirements of this function [`pad=
dr`, `paddr` + `SIZE`) is
>  ///         // valid for `ioremap`.
> -///         let addr =3D unsafe { bindings::ioremap(paddr as _, SIZE as =
_) };
> +///         let addr =3D unsafe { bindings::ioremap(paddr as u64, SIZE) =
};

The argument of `ioremap` is defined as `resource_size_t` which
ultimately maps to `u64` on 64 bit systems and `u32` on 32 bit ones. I
don't think that we should have code like this... Is there another
option?

Maybe Gary knows something here, do we have a type that represents that
better?

>  ///         if addr.is_null() {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))

This should be `addr.addr()` (requires `strict_provenance` on Rust 1.83
& before).

(I am assuming that we're never casting the usize back to a pointer,
since otherwise this change would introduce UB)

>  ///     }
>  /// }
>  ///
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapp=
ed by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };

Can't this be a `.cast::<c_void>()`?

>  ///     }
>  /// }
>  ///

> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 8654d52b0bb9..eb8fa52f08ba 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -152,7 +152,7 @@ pub(crate) fn to_blk_status(self) -> bindings::blk_st=
atus_t {
>      /// Returns the error encoded as a pointer.
>      pub fn to_ptr<T>(self) -> *mut T {
>          // SAFETY: `self.0` is a valid error due to its invariant.
> -        unsafe { bindings::ERR_PTR(self.0.get() as _).cast() }
> +        unsafe { bindings::ERR_PTR(self.0.get() as isize).cast() }

Can't this be a `.into()`?

>      }
> =20
>      /// Returns a string representing the error, if one exists.

> @@ -119,7 +119,7 @@ pub fn $name(&self, offset: usize) -> $type_name {
>              let addr =3D self.io_addr_assert::<$type_name>(offset);
> =20
>              // SAFETY: By the type invariant `addr` is a valid address f=
or MMIO operations.
> -            unsafe { bindings::$name(addr as _) }
> +            unsafe { bindings::$name(addr as *const c_void) }

Also here, is `.cast::<c_void>()` enough? (and below)

>          }
> =20
>          /// Read IO data from a given offset.

> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index 04f2d8ef29cb..40d1bd13682c 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
>      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings::=
of_device_id, data);
> =20
>      fn index(&self) -> usize {
> -        self.0.data as _
> +        self.0.data as usize

This should also be `self.0.data.addr()`.

>      }
>  }
> =20
> @@ -34,10 +34,10 @@ pub const fn new(compatible: &'static CStr) -> Self {
>          // SAFETY: FFI type is valid to be zero-initialized.
>          let mut of: bindings::of_device_id =3D unsafe { core::mem::zeroe=
d() };
> =20
> -        // TODO: Use `clone_from_slice` once the corresponding types do =
match.
> +        // TODO: Use `copy_from_slice` once stabilized for `const`.

This feature has just been stabilized (5 days ago!):

    https://github.com/rust-lang/rust/issues/131415

@Miguel: Do we already have a target Rust version for dropping the
`RUSTC_BOOTSTRAP=3D1`? If not, then I think we should use this feature
now, since it will be stable by the time we bump the minimum version.
(not in this patch [series] though)

>          let mut i =3D 0;
>          while i < src.len() {
> -            of.compatible[i] =3D src[i] as _;
> +            of.compatible[i] =3D src[i];
>              i +=3D 1;
>          }

> @@ -317,7 +320,7 @@ unsafe fn do_release(pdev: &Device, ioptr: usize, num=
: i32) {
>          // `ioptr` is valid by the safety requirements.
>          // `num` is valid by the safety requirements.
>          unsafe {
> -            bindings::pci_iounmap(pdev.as_raw(), ioptr as _);
> +            bindings::pci_iounmap(pdev.as_raw(), ioptr as *mut kernel::f=
fi::c_void);

Again, probably castable.

>              bindings::pci_release_region(pdev.as_raw(), num);
>          }
>      }
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 6a1a982b946d..0b80a119d5f0 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -692,9 +692,9 @@ fn new() -> Self {
>      pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
>          // INVARIANT: The safety requirements guarantee the type invaria=
nts.
>          Self {
> -            beg: pos as _,
> -            pos: pos as _,
> -            end: end as _,
> +            beg: pos as usize,
> +            pos: pos as usize,
> +            end: end as usize,

I would prefer if we use `pos.expose_provenance()` (also for `end`)
here.

>          }
>      }
> =20
> @@ -719,7 +719,7 @@ pub(crate) unsafe fn from_buffer(buf: *mut u8, len: u=
size) -> Self {
>      ///
>      /// N.B. It may point to invalid memory.
>      pub(crate) fn pos(&self) -> *mut u8 {
> -        self.pos as _
> +        self.pos as *mut u8

This should then also be `with_exposed_provenance(self.pos)`

---
Cheers,
Benno

>      }
> =20
>      /// Returns the number of bytes written to the formatter.
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 8ff54105be3f..d03f3440cb5a 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -198,7 +198,7 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::E=
nqueueOutput
>          unsafe {
>              w.__enqueue(move |work_ptr| {
>                  bindings::queue_work_on(
> -                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
> +                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as i32,
>                      queue_ptr,
>                      work_ptr,
>                  )



