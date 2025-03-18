Return-Path: <linux-kselftest+bounces-29340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D53A66F9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 10:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B87A8D43
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 09:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65A5207677;
	Tue, 18 Mar 2025 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OTAqvIZo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED620764C;
	Tue, 18 Mar 2025 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289834; cv=none; b=FW9ivN938bugCWcF6pILhPUPNegs/xFRbjdwBavOVt2LTffspgJ4nCM0KY7TNqSdkzttUy44ajpx6UfuuLEtQuV7QXeYFeUD2XlG7QFYiQ08pRkCpOQtKXjxhC9n/zOUcQK2EVX1Bn8S7jwlwWXlEfUft95MPTS1y/K3Lz825+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289834; c=relaxed/simple;
	bh=rshk75o930iXzjXZKX+5UTvSwiOC3zAysRaXInOpHOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDH3Ioo6J2gXaUAsa5qIZDobOyl3A+Cv9pG7XpNyiPsj7eeRMCj4Olmjn+djBJigYMQsGJGZAoGKw/ek70IqNe7WHX63wI5K1BJwSECccITgedQaxoWXM8ddSR1Mhh+sB7JdU8E8MRQSu684FuuIoN49YTs2xOCVdij1Sff7VwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OTAqvIZo; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742289829; x=1742549029;
	bh=mQuW6b5jEmujh9k3HmmMRVbEVNl+m8ypHt+c7938u3M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OTAqvIZotcTkpmzzHrVJO77lGvvBaJqCw6aZvIXLyzy00fylMI7CFEMx0sfQhvcro
	 tnA1uU41VKSN/iOn4EcqWRctj9wVlL3bbJeJa2OeBPQrjrAUlItcbqYoS46w0ezL3+
	 GZh9fc+DPNTUGT4Yu1vLOjTi2sB4hItn5Sj1w29NBOkFcNgRf0YMEocDHrg69LmW7Z
	 Zmt73feWtwhnITqi1dvAxpNO91oaXGJ8EP7rALZss7pGnxIlOBSBNpUhtz3YwOqcGB
	 q8ReXtgigVleXgJtv0Z+2m0Tme8247kakEQCVgkrKEr9g7QwE1IVkW/77fS3kE8PQJ
	 lDAEM2rAFsDpw==
Date: Tue, 18 Mar 2025 09:23:42 +0000
To: Boqun Feng <boqun.feng@gmail.com>, Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8JA6Z142FKY.4RRGIN0PDDYQ@proton.me>
In-Reply-To: <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
References: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com> <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com> <67d885ff.0c0a0220.111215.5644@mx.google.com> <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com> <67d88a1d.050a0220.2cdacf.4adf@mx.google.com> <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com> <67d895cc.050a0220.99d33.5adc@mx.google.com> <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 62fa245554ceb372780867add0e7aa64a9f3faec
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 18, 2025 at 1:11 AM CET, Boqun Feng wrote:
> On Mon, Mar 17, 2025 at 02:36:08PM -0700, Boqun Feng wrote:
> [...]
>> >=20
>> > What about `pointer::expose_provenance`? It's a method that was added =
in 1.79.0.
>> >=20
>>=20
>> We have a few options:
>>=20
>> 1) we can decide to use funtion-version of expose_provenance() (i.e. the
>>    stub), if we feel the symmetry with with_exposed_provenance() is
>>    a strong rationale. This also means we won't likely use
>>    pointer::expose_provenance() in the future. That is, although kernel
>>    doesn't have stable internal API, but in the foreseeable future, we
>>    decide to use funtion-version of expose_provenance().
>>=20
>> 2) we can introduce a PtrExt trait for <1.79
>>=20
>>    pub trait PtrExt<T> {
>>        fn expose_provenance(self) -> usize;
>>    }
>>=20
>>    and
>>=20
>>    impl<T> PtrExt<T> for *const T {
>>    =09...
>>    }
>>=20
>>    and `PtrExt` in kernel::prelude.
>>=20
>>    (we need to #[allow(unstable_name_collisions)] to make that work)
>>=20
>>    We can also make with_exposed_provenance() use the same *Ext trick,
>>    and remove it when we bump the minimal rustc version.
>
> This is probably a wrong suggestion, because with_exposed_provenance()
> is a function instead of a method in Rust std.
>
> Below is what I combined all together (based on your v5 patchset), and I
> did test on 1.78, 1.79, 1.84 and 1.85 and it seems working ;-)

I like this a lot, I also thought that we should just disable the
`incompatible_msrv` lint. That we get rid of the stubs is a nice bonus
:)

The only annoying thing that's left IMO is that we need to conditionally=20
import the `PtrExt` trait, but that would need the built-in prelude
feature :(

Couple notes below.

> Regards,
> Boqun
> ------------------------------------->8
> diff --git a/init/Kconfig b/init/Kconfig
> index 82e28d6f7c3f..e316b98b3612 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -135,6 +135,9 @@ config RUSTC_HAS_COERCE_POINTEE
>  config RUSTC_HAS_STABLE_STRICT_PROVENANCE
>  =09def_bool RUSTC_VERSION >=3D 108400
> =20
> +config RUSTC_HAS_EXPOSED_PROVENANCE
> +=09def_bool RUSTC_VERSION >=3D 107900
> +
>  config PAHOLE_VERSION
>  =09int
>  =09default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index e8232bb771b2..a87a437bd9ab 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -64,7 +64,7 @@ struct DevresInner<T> {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?)=
)
> +///         Ok(IoMem(IoRaw::new(addr.expose_provenance(), SIZE)?))
>  ///     }
>  /// }
>  ///
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0a018ad7478a..60c71f26d29d 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -75,7 +75,7 @@ pub fn maxsize(&self) -> usize {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(kernel::expose_provenance(addr), SIZE)?)=
)
> +///         Ok(IoMem(IoRaw::new(addr.expose_provenance(), SIZE)?))
>  ///     }
>  /// }
>  ///
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index c1b274c04a0f..79b19e601372 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -22,6 +22,9 @@
>      feature(strict_provenance_lints),
>      deny(fuzzy_provenance_casts, lossy_provenance_casts)
>  )]
> +#![cfg_attr(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE), feature(stri=
ct_provenance))]
> +#![cfg_attr(all(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE), CONFIG_R=
USTC_HAS_EXPOSED_PROVENANCE), feature(exposed_provenance))]
> +
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  // Stable in Rust 1.83
> @@ -30,78 +33,24 @@
>  #![feature(const_ptr_write)]
>  #![feature(const_refs_to_cell)]
> =20
> -#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> -#[allow(clippy::incompatible_msrv)]
> -mod strict_provenance {
> -    /// Gets the "address" portion of the pointer.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.addr.
> -    #[inline]
> -    pub fn addr<T>(ptr: *const T) -> usize {
> -        ptr.addr()
> -    }
> -
> -    /// Exposes the "provenance" part of the pointer for future use in
> -    /// [`with_exposed_provenance`] and returns the "address" portion.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.expose_provenance.
> -    #[inline]
> -    pub fn expose_provenance<T>(ptr: *const T) -> usize {
> -        ptr.expose_provenance()
> -    }
> -
> -    /// Converts an address back to a pointer, picking up some previousl=
y 'exposed'
> -    /// provenance.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_pr=
ovenance.html.
> -    #[inline]
> -    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> -        core::ptr::with_exposed_provenance(addr)
> -    }
> -
> -    /// Converts an address back to a mutable pointer, picking up some p=
reviously 'exposed'
> -    /// provenance.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_pr=
ovenance_mut.html
> -    #[inline]
> -    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> -        core::ptr::with_exposed_provenance_mut(addr)
> -    }
> -
> -    /// Creates a pointer with the given address and no [provenance][cra=
te::ptr#provenance].
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/ptr/fn.without_provena=
nce_mut.html.
> -    #[inline]
> -    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> -        core::ptr::without_provenance_mut(addr)
> -    }
> -}
> +#![allow(clippy::incompatible_msrv)]
> =20
> -#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
>  mod strict_provenance {

Since there is only a single trait and impl in here, I think we don't
need a module.

> -    /// Gets the "address" portion of the pointer.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.addr.
> -    #[inline]
> -    pub fn addr<T>(ptr: *const T) -> usize {
> -        // This is core's implementation from
> -        // https://github.com/rust-lang/rust/commit/4291332175d12e79e606=
1cdc3f5dccac2e28b969 through
> -        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/sr=
c/ptr/const_ptr.rs#L172
> -        // which is the first version that satisfies `CONFIG_RUSTC_HAS_S=
TABLE_STRICT_PROVENANCE`.
> -        #[allow(clippy::undocumented_unsafe_blocks)]
> -        unsafe {
> -            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
> -            core::mem::transmute(ptr.cast::<()>())
> -        }
> +    #[doc(hidden)]
> +    pub trait PtrExt<T> {

The `T` here and in the impl below probably should have a `?Sized`
bound, since that's also what the stdlib does.

> +        /// Exposes the "provenance" part of the pointer for future use =
in
> +        /// [`with_exposed_provenance`] and returns the "address" portio=
n.
> +        ///
> +        /// See https://doc.rust-lang.org/stable/core/primitive.pointer.=
html#method.expose_provenance.
> +        fn expose_provenance(self) -> usize;
>      }
> =20
> -    /// Exposes the "provenance" part of the pointer for future use in
> -    /// [`with_exposed_provenance`] and returns the "address" portion.
> -    ///
> -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.expose_provenance.
> -    #[inline]
> -    pub fn expose_provenance<T>(ptr: *const T) -> usize {
> -        ptr.cast::<()>() as usize
> +    impl<T> PtrExt<T> for *const T {
> +        #[inline]
> +        fn expose_provenance(self) -> usize {
> +            self.cast::<()>() as usize
> +        }
>      }
> =20
>      /// Converts an address back to a pointer, picking up some previousl=
y 'exposed'
> @@ -131,8 +80,12 @@ pub fn without_provenance_mut<T>(addr: usize) -> *mut=
 T {
>      }
>  }
> =20
> +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
>  pub use strict_provenance::*;
> =20
> +#[cfg(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE)]
> +pub use core::ptr::{with_exposed_provenance, with_exposed_provenance_mut=
, without_provenance_mut};

We shouldn't need this any longer, right?

---
Cheers,
Benno

> +
>  // Ensure conditional compilation based on the kernel configuration work=
s;
>  // otherwise we may silently break things like initcall handling.
>  #[cfg(not(CONFIG_RUST))]
> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index b70076d16008..3670676071ff 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
>      const DRIVER_DATA_OFFSET: usize =3D core::mem::offset_of!(bindings::=
of_device_id, data);
> =20
>      fn index(&self) -> usize {
> -        crate::addr(self.0.data)
> +        self.0.data.addr()
>      }
>  }
> =20
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 87c9f67b3f0f..73958abdc522 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -287,7 +287,7 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result=
<Self> {
>          // `pdev` is valid by the invariants of `Device`.
>          // `num` is checked for validity by a previous call to `Device::=
resource_len`.
>          // `name` is always valid.
> -        let ioptr =3D crate::expose_provenance(unsafe { bindings::pci_io=
map(pdev.as_raw(), num, 0) });
> +        let ioptr =3D unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0=
) }.expose_provenance();
>          if ioptr =3D=3D 0 {
>              // SAFETY:
>              // `pdev` valid by the invariants of `Device`.
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index baa774a351ce..3ea6aa9e40e5 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -41,3 +41,6 @@
>  pub use super::init::InPlaceInit;
> =20
>  pub use super::current;
> +
> +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> +pub use super::PtrExt;
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 6bc6357293e4..d8e740267f14 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -8,6 +8,9 @@
> =20
>  use crate::error::{code::*, Error};
> =20
> +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> +use crate::PtrExt;
> +
>  /// Byte string without UTF-8 validity guarantee.
>  #[repr(transparent)]
>  pub struct BStr([u8]);
> @@ -692,9 +695,9 @@ fn new() -> Self {
>      pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
>          // INVARIANT: The safety requirements guarantee the type invaria=
nts.
>          Self {
> -            beg: crate::expose_provenance(pos),
> -            pos: crate::expose_provenance(pos),
> -            end: crate::expose_provenance(end),
> +            beg: pos.expose_provenance(),
> +            pos: pos.expose_provenance(),
> +            end: end.expose_provenance(),
>          }
>      }
> =20
> @@ -705,7 +708,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mu=
t u8) -> Self {
>      /// The memory region starting at `buf` and extending for `len` byte=
s must be valid for writes
>      /// for the lifetime of the returned [`RawFormatter`].
>      pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> -        let pos =3D crate::expose_provenance(buf);
> +        let pos =3D buf.expose_provenance();
>          // INVARIANT: We ensure that `end` is never less then `buf`, and=
 the safety requirements
>          // guarantees that the memory region is valid for writes.
>          Self {
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 08b6380933f5..b070da0ea972 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -226,7 +226,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  # Compile Rust sources (.rs)
>  # ----------------------------------------------------------------------=
-----
> =20
> -rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_=
reasons
> +rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_=
reasons,exposed_provenance
> =20
>  # `--out-dir` is required to avoid temporaries being created by `rustc` =
in the
>  # current working directory, which may be not accessible in the out-of-t=
ree
> diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> index 036635fb1621..331ed32adc35 100644
> --- a/scripts/rustdoc_test_gen.rs
> +++ b/scripts/rustdoc_test_gen.rs
> @@ -224,6 +224,8 @@ macro_rules! assert_eq {{
>          BufWriter::new(File::create("rust/doctests_kernel_generated.rs")=
.unwrap()),
>          r#"//! `kernel` crate documentation tests.
> =20
> +#![allow(clippy::incompatible_msrv)]
> +
>  const __LOG_PREFIX: &[u8] =3D b"rust_doctests_kernel\0";
> =20
>  {rust_tests}



