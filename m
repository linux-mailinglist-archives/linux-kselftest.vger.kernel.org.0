Return-Path: <linux-kselftest+bounces-29069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C77F5A61C4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F3A7ACC71
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B0204F7C;
	Fri, 14 Mar 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ALm3FkKa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669D1FCFF4;
	Fri, 14 Mar 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983504; cv=none; b=N1euH0ZfwpOHZW85eARX0HIHWDl8ZWmbJKfShWqVX32a0Qq46gYejPZyuLiaSDVmG2yJqMf0c8S0rLR8bqbLyWr/NQgzHc0oMpTkahr77tcXP7yvJFC9wzNJy/VhF7F6S/HolrZUElDycD6vkMF+kPGE+6Db1rCEn5WMO4BJpIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983504; c=relaxed/simple;
	bh=sCQx/aKSmnYRY2xesZgryjToMGZNomPc2gToQAvQ5g0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvR9RFK28CDKryPeyp2743nhjzCdHae8YGonflE5KFVlGAd5J1BSalCJOy4txhHkJba9fOwRLMIFGMSdgAsIkCofOI1i/TgDWd3dfrPcNuKOCDXeulL2xWnsv75x+t9JgwslzKFXZ8EPerCogDmdcFiY5M86NDVAZyjVELCN4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ALm3FkKa; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=smpbnqcmhrgubdh756icejpx2y.protonmail; t=1741983498; x=1742242698;
	bh=zl7FDKS0rmnsnQTzD15GK9QqXG+mzmd9a6ITJ3m8pzU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ALm3FkKa7/2fNNFfNBJGhkUE/8GbFQUBjld9dJVAcX1Z3+cYEjyeWsx3eyPxWSeKC
	 tMPKRJBYrYkYuEgYv7gaflHllI+cgQXNrptvzlyQAsAKeNeFhlrKrzGgSnlLUzwEhk
	 2ybVTnk0YQZP8hgTAwMbgfWkTJeBBn4EsZz1a9AVKcv+vTRpQ71DooLT1i+QJvm4VY
	 dsDbxggv9MIHSsMz8d9/KltElM60W4Ga8Q9LilKAudrQF6se3MVid2iwJPkrXYptUx
	 QvA7AYH3vt1ZQ2nwPrmpBG3hkLyGuWrO10kNSad9mENEGUZrK/Zb/E7CtFpKyGLyxu
	 oLcxjBgnI1xPQ==
Date: Fri, 14 Mar 2025 20:18:15 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <D8G9LZCS7ETL.9UPPQ73CAUQM@proton.me>
In-Reply-To: <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com> <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 23a586bab6aba90d7bdbcb6233ed47e6607f72df
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 1:28 PM CET, Tamir Duberstein wrote:
> Rust 1.84.0 stabilized the strict provenance APIs[1].
>
> This patch enables the (unstable) lints `fuzzy_provenance_casts` and
> `lossy_provenance_casts` (available since Rust 1.61.0[2]) and uses
> strict provenance APIs where these lints triggered. The `kernel` crate
> is kept backwards-compatible by introducing forwarding functions at the
> root which are marked `#[allow(clippy::incompatible_msrv)]` to avoid
> warnings on rustc < 1.84.0.
>
> The discussion in the tracking Issue for strict_provenance_lints[3]
> seems to be nearing resolution with the only open question being:
>
>> do we really want two separate lints for the two directions?
>
> which seems minor enough that this is unlikely to cause significant
> churn when stabilized.
>
> This is limited to the `kernel` crate because adding these lints in the
> root `Makefile` causes `core` itself to be compiled with them, which in
> turn causes warnings on the implementations of the strict provenance
> APIs themselves.

This isn't the case anymore? (ie it isn't limited to the `kernel`
crate?)

> Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-prove=
nance-apis [1]
> Link: https://github.com/rust-lang/rust/blob/e71f9a9a98b0faf423844bf0ba74=
38f29dc27d58/compiler/rustc_feature/src/unstable.rs#L605 [2]
> Link: https://github.com/rust-lang/rust/issues/130351 [3]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/

Missing SoB.

> ---
>  Makefile               |  9 ++++++++-
>  init/Kconfig           |  3 +++
>  rust/Makefile          | 26 ++++++++++++++++++++------
>  rust/kernel/alloc.rs   |  2 +-
>  rust/kernel/devres.rs  |  4 ++--
>  rust/kernel/io.rs      | 14 +++++++-------
>  rust/kernel/lib.rs     | 20 ++++++++++++++++++++
>  rust/kernel/of.rs      |  2 +-
>  rust/kernel/pci.rs     |  4 ++--
>  rust/kernel/str.rs     | 16 ++++++----------
>  rust/kernel/uaccess.rs | 12 ++++++++----
>  scripts/Makefile.build |  2 +-
>  scripts/Makefile.host  |  4 ++++
>  13 files changed, 83 insertions(+), 35 deletions(-)

Thanks for making the effort and getting this to work, unfortunately, I
have checked if this compiles with 1.78 and sadly it doesn't. That's
because that version doesn't have the `with_exposed_provenance`
function! I am very sorry about that, I thought I had checked that
before suggesting it to you. It does exist in >=3D1.79 && <1.84 under a
different feature: `exposed_provenance`. (I haven't checked if
everything works when also adding that)

I don't know when we'll be bumping the minimum version. IIRC 1.85.0 is
going to be in debian trixie, so eventually we could bump it to that,
but I'm not sure what the time frame will be for that.

Maybe we can salvage this effort by gating both the lint and the
unstable features on the versions where it works? @Miguel, what's your
opinion?

We could even make it simple, requiring 1.84 and not bothering with the
older versions.

> diff --git a/Makefile b/Makefile
> index 2af40bfed9ce..bc12650783f1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -473,6 +473,8 @@ export rust_common_flags :=3D --edition=3D2021 \
>  =09=09=09    -Astable_features \
>  =09=09=09    -Dnon_ascii_idents \
>  =09=09=09    -Dunsafe_op_in_unsafe_fn \
> +=09=09=09    -Wfuzzy_provenance_casts \
> +=09=09=09    -Wlossy_provenance_casts \
>  =09=09=09    -Wmissing_docs \
>  =09=09=09    -Wrust_2018_idioms \
>  =09=09=09    -Wunreachable_pub \
> @@ -498,7 +500,7 @@ KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(H=
OST_LFS_CFLAGS) \
>  KBUILD_HOSTCXXFLAGS :=3D -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS) \
>  =09=09       -I $(srctree)/scripts/include
>  KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
> -=09=09=09-Zallow-features=3D $(HOSTRUSTFLAGS)
> +=09=09=09$(HOSTRUSTFLAGS)

This should be mentioned explicitly in the commit message.

>  KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
>  KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>  KBUILD_PROCMACROLDFLAGS :=3D $(or $(PROCMACROLDFLAGS),$(KBUILD_HOSTLDFLA=
GS))
> @@ -870,6 +872,11 @@ KBUILD_CFLAGS +=3D -Os
>  KBUILD_RUSTFLAGS +=3D -Copt-level=3Ds
>  endif
> =20
> +# Lints were moved to `strict_provenance_lints` when `strict_provenance`=
 was stabilized.
> +#
> +# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f888e3=
3dd52a13d3ecb64.
> +export rustc_strict_provenance_feature :=3D $(if $(CONFIG_RUSTC_HAS_STAB=
LE_STRICT_PROVENANCE),strict_provenance_lints,strict_provenance)
> +
>  # Always set `debug-assertions` and `overflow-checks` because their defa=
ult
>  # depends on `opt-level` and `debug-assertions`, respectively.
>  KBUILD_RUSTFLAGS +=3D -Cdebug-assertions=3D$(if $(CONFIG_RUST_DEBUG_ASSE=
RTIONS),y,n)
> diff --git a/init/Kconfig b/init/Kconfig
> index 324c2886b2ea..04df2893348c 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -132,6 +132,9 @@ config CC_HAS_COUNTED_BY
>  config RUSTC_HAS_COERCE_POINTEE
>  =09def_bool RUSTC_VERSION >=3D 108400
> =20
> +config RUSTC_HAS_STABLE_STRICT_PROVENANCE
> +=09def_bool RUSTC_VERSION >=3D 108400
> +
>  config PAHOLE_VERSION
>  =09int
>  =09default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
> diff --git a/rust/Makefile b/rust/Makefile
> index ea3849eb78f6..dad47bea19f3 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -57,10 +57,12 @@ endif
>  core-cfgs =3D \
>      --cfg no_fp_fmt_parse
> =20
> +rustc_strict_provenance_flags =3D -Zcrate-attr=3D'feature($(rustc_strict=
_provenance_feature))'
> +
>  quiet_cmd_rustdoc =3D RUSTDOC $(if $(rustdoc_host),H, ) $<
>        cmd_rustdoc =3D \
>  =09OBJTREE=3D$(abspath $(objtree)) \
> -=09$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_com=
mon_flags),$(rust_flags))) \
> +=09$(RUSTDOC) $(filter-out $(skip_flags),$(if $(rustdoc_host),$(rust_com=
mon_flags),$(rust_flags)) $(rustc_strict_provenance_flags)) \
>  =09=09$(rustc_target_flags) -L$(objtree)/$(obj) \
>  =09=09-Zunstable-options --generate-link-to-definition \
>  =09=09--output $(rustdoc_output) \
> @@ -99,7 +101,7 @@ rustdoc-macros: $(src)/macros/lib.rs FORCE
> =20
>  # Starting with Rust 1.82.0, skipping `-Wrustdoc::unescaped_backticks` s=
hould
>  # not be needed -- see https://github.com/rust-lang/rust/pull/128307.
> -rustdoc-core: private skip_flags =3D -Wrustdoc::unescaped_backticks
> +rustdoc-core: private skip_flags =3D -Wrustdoc::unescaped_backticks $(ru=
stc_strict_provenance_flags)

Why aren't the lints excluded?

>  rustdoc-core: private rustc_target_flags =3D $(core-cfgs)
>  rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
>  =09+$(call if_changed,rustdoc)

> @@ -436,7 +450,7 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(=
recordmcount_source) FORCE
>  $(obj)/exports.o: private skip_gendwarfksyms =3D 1
> =20
>  $(obj)/core.o: private skip_clippy =3D 1
> -$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
> +$(obj)/core.o: private skip_flags =3D -Wunreachable_pub -Wlossy_provenan=
ce_casts $(rustc_strict_provenance_flags)

Why not also the `-Wfuzzy_provenance_casts`? They could be introduced at
any moment in core, so I don't think that we should enable the lint
there.

>  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intrin=
sics),--redefine-sym $(sym)=3D__rust$(sym))
>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 9cd6b6864739..ebf7db3ad9ee 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -25,6 +25,26 @@
>  #![feature(const_ptr_write)]
>  #![feature(const_refs_to_cell)]
> =20
> +#[allow(clippy::incompatible_msrv)]
> +mod strict_provenance {
> +    #[doc(hidden)]
> +    pub fn expose_provenance<T>(addr: *const T) -> usize {
> +        addr.expose_provenance()
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance<T>(addr: usize) -> *const T {
> +        core::ptr::with_exposed_provenance(addr)
> +    }
> +
> +    #[doc(hidden)]
> +    pub fn with_exposed_provenance_mut<T>(addr: usize) -> *mut T {
> +        core::ptr::with_exposed_provenance_mut(addr)
> +    }
> +}

Still, I don't think we should re-export them. It'll only confuse folks
and the `incompatible_msrv` lint isn't useful at the moment.

> +
> +pub use strict_provenance::*;
> +
>  // Ensure conditional compilation based on the kernel configuration work=
s;
>  // otherwise we may silently break things like initcall handling.
>  #[cfg(not(CONFIG_RUST))]

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 0b80a119d5f0..6bc6357293e4 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -692,9 +692,9 @@ fn new() -> Self {
>      pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
>          // INVARIANT: The safety requirements guarantee the type invaria=
nts.
>          Self {
> -            beg: pos as usize,
> -            pos: pos as usize,
> -            end: end as usize,
> +            beg: crate::expose_provenance(pos),
> +            pos: crate::expose_provenance(pos),
> +            end: crate::expose_provenance(end),

Just import it, you're also using it below in the file.

---
Cheers,
Benno

>          }
>      }
> =20


