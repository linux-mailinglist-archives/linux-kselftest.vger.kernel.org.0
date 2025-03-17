Return-Path: <linux-kselftest+bounces-29264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B77A65B7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C02179114
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573471AF0C1;
	Mon, 17 Mar 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="P9J9ecPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866AA1A83E5;
	Mon, 17 Mar 2025 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233853; cv=none; b=GVeXOBgOku4+8ef3qNiUWOiA90ZAiMwBG8vHABfqCLwNWtVo7avQZvvoN89vHqo+aOgoEsCW3EfZPEyvNReCLxTeBw2tGckKpT3/HMrYb4nYAsmgVDkowgno5hKaRtwja+kY2ERiPdZn8iTXXhEBoa+irpU24jvMjGFmDwJ/Osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233853; c=relaxed/simple;
	bh=m1J+GlCnSs1V3eKSpEzP0HLIPlFQKU5vK8yQL04FOY0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbBvi/eukUvINq1xT8f/zPuMSgpkNhoAocsgbhvHf7FNyKnvhNHOJ2VEfiqs1PSIz4OTE3kIn7c9hYI8lq68GDwS+IAUp+uNUuE+ZSWa3KCfCLjNtvuLtnN1VwgbCEjYG8BCvkmltm6zOJ1W7hM9M/IGa854u5BNLUDVFrFiA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=P9J9ecPq; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742233847; x=1742493047;
	bh=jhrRLqEl3iEr57VAvfSUeb0SK6yGoWOiTfnMPFKUv4M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=P9J9ecPq5xxFQsW1R4INE7psjA2bcyMbqj/Vz1X1e+SxrtZrogqpde0pZMyioL05c
	 5uV3Dx/3VajelTPuX0Yih3bFDflG+ok/jwCmrbJu+lYqOyw7PcemdvbEfWRjn+A4Ft
	 rpcrqhQCMTF6MOZ7RT1EDlIM2Sqcflnkx/wboYcWytff2kWy/DDshWhhmCEVBFjDmC
	 YQvAAduNkOl7fkOaksQ+b0DnTdhmBCXvbvCHTYrGTPUb+zEimn2Ewn94+w/w/XDpjj
	 iZa64zb2mIEiXbxMupFt7SvvgTrruUhWhSKU2h31Y8vEBqlZHTyKVFCm58f9wOBGsI
	 K2/9apW/Z/vJw==
Date: Mon, 17 Mar 2025 17:50:38 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
Message-ID: <D8IQCJHJWPNJ.1J2UO4OK0D0B3@proton.me>
In-Reply-To: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com> <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bfb891ae1b62b7c3c15f976a4883734178cbd860
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Mar 17, 2025 at 3:23 PM CET, Tamir Duberstein wrote:
> Throughout the tree, use the strict provenance APIs stabilized in Rust
> 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> functions at the `kernel` crate root along with polyfills for rustc <
> 1.84.0.
>
> Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> 1.84.0 as our MSRV is 1.78.0.
>
> In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> compiler flags that are dependent on the rustc version in use.
>
> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-prove=
nance-apis [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

One comment below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  init/Kconfig           |   3 ++
>  rust/kernel/alloc.rs   |   2 +-
>  rust/kernel/devres.rs  |   4 +-
>  rust/kernel/io.rs      |  14 +++----
>  rust/kernel/lib.rs     | 108 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/of.rs      |   2 +-
>  rust/kernel/pci.rs     |   4 +-
>  rust/kernel/str.rs     |  16 +++-----
>  rust/kernel/uaccess.rs |  12 ++++--
>  9 files changed, 138 insertions(+), 27 deletions(-)


> +#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> +mod strict_provenance {
> +    /// Gets the "address" portion of the pointer.
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.addr.
> +    #[inline]
> +    pub fn addr<T>(ptr: *const T) -> usize {
> +        // This is core's implementation from
> +        // https://github.com/rust-lang/rust/commit/4291332175d12e79e606=
1cdc3f5dccac2e28b969 through
> +        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/sr=
c/ptr/const_ptr.rs#L172
> +        // which is the first version that satisfies `CONFIG_RUSTC_HAS_S=
TABLE_STRICT_PROVENANCE`.
> +        #[allow(clippy::undocumented_unsafe_blocks)]
> +        unsafe {
> +            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
> +            core::mem::transmute(ptr.cast::<()>())
> +        }

I think we should just use `ptr as usize` here instead. It's going away
at some point and it will only affect optimizations (I don't even know
if they exist at the moment) of old versions.

---
Cheers,
Benno

> +    }
> +
> +    /// Exposes the "provenance" part of the pointer for future use in
> +    /// [`with_exposed_provenance`] and returns the "address" portion.
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html=
#method.expose_provenance.
> +    #[inline]
> +    pub fn expose_provenance<T>(ptr: *const T) -> usize {
> +        ptr.cast::<()>() as usize
> +    }
> +
> +    /// Converts an address back to a pointer, picking up some previousl=
y 'exposed'
> +    /// provenance.
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_pr=
ovenance.html.
> +    #[inline]
> +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> +        addr as *const T
> +    }
> +
> +    /// Converts an address back to a mutable pointer, picking up some p=
reviously 'exposed'
> +    /// provenance.
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/ptr/fn.with_exposed_pr=
ovenance_mut.html
> +    #[inline]
> +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> +        addr as *mut T
> +    }
> +
> +    /// Creates a pointer with the given address and no [provenance][cra=
te::ptr#provenance].
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/ptr/fn.without_provena=
nce_mut.html.
> +    #[inline]
> +    pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> +        addr as *mut T
> +    }
> +}
> +
> +pub use strict_provenance::*;
> +
>  // Ensure conditional compilation based on the kernel configuration work=
s;
>  // otherwise we may silently break things like initcall handling.
>  #[cfg(not(CONFIG_RUST))]


