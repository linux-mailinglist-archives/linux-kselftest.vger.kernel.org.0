Return-Path: <linux-kselftest+bounces-28952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6558EA5F757
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 15:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB833167219
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1A267B7E;
	Thu, 13 Mar 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DoZM/Utw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F0267B04;
	Thu, 13 Mar 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875079; cv=none; b=o4f2hJUDCGqwKb4SanUzDFxwbZOdyjADA4MX0id8sTM8gGbpP/EtuQVFaaHMMjIZzAODD9Z5jiiLtsEF7yHELb2XShyQewRWQo/auJla/0Ia+qpbRQYgKJ9PZsITMua+x6IgUkFz5Jq+ZaKrUteYGMXkUy8K+a9XLgUHArDaNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875079; c=relaxed/simple;
	bh=IGqisGwCAtyYbOb7OLJfY7Fx7hmscguuf7cCiQCAFiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUZOnKojdYYX8HXrumEX2mNJxXlyE51JK4P90Y+QMRs1aD+qwzYNlMkKS5gS6ediYcblqevCxPiOdneOQY+3n6rooI043tQwhdmX56egLzq4Hy88pb17MVPgxOTJ9Ibiu+r1VPX9UwOKMNWQZZMU1mDAnMTMB+cZblzrFNvYyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DoZM/Utw; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741875073; x=1742134273;
	bh=Wwjd3F8ZVcLlKooopouWDqOPW0C84gclDWUIL90/JTg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DoZM/UtwzAz3l+BUaRdDMTlZjnm54wefuEZ9fvJS15jUhGlM4gjWCHQaSCnr+22vu
	 GAQ3M1/icunF7pBqlZ5NJr+nZu+Ui1lLY9jPcsAXadhrgcVDrgzkPwIGUzmBAIj9fk
	 xL81b9dlal8eotSV+Vh3HpqG9ZdhQ2ngsUQKK3/UFevwh8mnzfez//1z0xkq3TfHGR
	 hd20iI8Cb/DMA5BvLx9p5QTXFB/AqVNwTp57TfcELUROxM34vLHNt+78so2hAVyX4z
	 yjwY4+7OZavEatCLcw8qEu50XDdqo1auGRnKnV0ya/pJhwrQ9zTKkSYXH7JpW8tskF
	 zfhw3+LTi9GOg==
Date: Thu, 13 Mar 2025 14:11:06 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
Message-ID: <D8F76A4JSEXO.2OKKJLAU5OZN@proton.me>
In-Reply-To: <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com>
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com> <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com> <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com> <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com> <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com> <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me> <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0d8c6066aa79effc9e6ffd556187124ab8df8180
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 11:47 AM CET, Tamir Duberstein wrote:
> On Wed, Mar 12, 2025 at 6:38=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Wed Mar 12, 2025 at 11:24 PM CET, Tamir Duberstein wrote:
>> > On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >>
>> >> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
>> >> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gm=
ail.com> wrote:
>> >> >>
>> >> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin=
@proton.me> wrote:
>> >> >> > Always enable the features, we have `allow(stable_features)` for=
 this
>> >> >> > reason (then you don't have to do this dance with checking if it=
's
>> >> >> > already stable or not :)
>> >> >>
>> >> >> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
>> >> >> provenance APIs are behind `feature(strict_provenance)`. In rustc =
>=3D
>> >> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So=
 you
>> >> >> need to read the config to learn that you need to enable
>> >> >> `feature(strict_provenance_lints)`.
>> >>
>> >> I see... And `strict_provenance_lints` doesn't exist in <1.84? That's=
 a
>> >> bit of a bummer...
>> >>
>> >> But I guess we could have this config option (in `init/Kconfig`):
>> >>
>> >>     config RUSTC_HAS_STRICT_PROVENANCE
>> >>             def_bool RUSTC_VERSION >=3D 108400
>> >>
>> >> and then do this in `lib.rs`:
>> >>
>> >>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_pr=
ovenance_lints))]
>> >
>> > Yep! That's exactly what I did, but as I mentioned up-thread, the
>> > result is that we only cover the `kernel` crate.
>>
>> Ah I see, can't we just have the above line in the other crate roots?
>
> The most difficult case is doctests. You'd have to add this to every
> example AFAICT.
>
>> >> > Actually this isn't even the only problem. It seems that
>> >> > `-Astable_features` doesn't affect features enabled on the command
>> >> > line at all:
>> >> >
>> >> > error[E0725]: the feature `strict_provenance` is not in the list of
>> >> > allowed features
>> >> >  --> <crate attribute>:1:9
>> >> >   |
>> >> > 1 | feature(strict_provenance)
>> >> >   |         ^^^^^^^^^^^^^^^^^
>> >>
>> >> That's because you need to append the feature to `rust_allowed_featur=
es`
>> >> in `scripts/Makefile.build` (AFAIK).
>> >
>> > Thanks, that's a helpful pointer, and it solves some problems but not
>> > all. The root Makefile contains this bit:
>> >
>> >> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo=
 \
>> >> -Zallow-features=3D $(HOSTRUSTFLAGS)
>> >
>> > which means we can't use the provenance lints against these host
>> > targets (including e.g. `rustdoc_test_gen`). We can't remove this
>> > -Zallow-features=3D either because then core fails to compile.
>> >
>> > I'm at the point where I think I need more involved help. Want to take
>> > a look at my attempt? It's here:
>> > https://github.com/tamird/linux/tree/b4/ptr-as-ptr.

With doing `allow(clippy::incompatible_msrv)`, I meant doing that
globally, not having a module to re-export the functions :)

>> I'll take a look tomorrow, you're testing my knowledge of the build
>> system a lot here :)
>
> We're guaranteed to learn something :)

Yep! I managed to get it working, but it is rather janky and
experimental. I don't think you should use this in your patch series
unless Miguel has commented on it.

Notable things in the diff below:
* the hostrustflags don't get the *provenance_casts lints (which is
  correct, I think, but probably not the way I did it with filter-out)
* the crates compiler_builtins, bindings, uapi, build_error, libmacros,
  ffi, etc do get them, but probably shouldn't?

---
Cheers,
Benno

diff --git a/Makefile b/Makefile
index 70bdbf2218fc..38a79337cd7b 100644
--- a/Makefile
+++ b/Makefile
@@ -473,6 +473,8 @@ export rust_common_flags :=3D --edition=3D2021 \
 =09=09=09    -Astable_features \
 =09=09=09    -Dnon_ascii_idents \
 =09=09=09    -Dunsafe_op_in_unsafe_fn \
+=09=09=09    -Wfuzzy_provenance_casts \
+=09=09=09    -Wlossy_provenance_casts \
 =09=09=09    -Wmissing_docs \
 =09=09=09    -Wrust_2018_idioms \
 =09=09=09    -Wunreachable_pub \
@@ -493,7 +495,7 @@ KBUILD_HOSTCFLAGS   :=3D $(KBUILD_USERHOSTCFLAGS) $(HOS=
T_LFS_CFLAGS) \
 =09=09       $(HOSTCFLAGS) -I $(srctree)/scripts/include
 KBUILD_HOSTCXXFLAGS :=3D -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS) \
 =09=09       -I $(srctree)/scripts/include
-KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo \
+KBUILD_HOSTRUSTFLAGS :=3D $(filter-out -Wfuzzy_provenance_casts -Wlossy_pr=
ovenance_casts,$(rust_common_flags)) -O -Cstrip=3Ddebuginfo \
 =09=09=09-Zallow-features=3D $(HOSTRUSTFLAGS)
 KBUILD_HOSTLDFLAGS  :=3D $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   :=3D $(HOST_LFS_LIBS) $(HOSTLDLIBS)
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..82e28d6f7c3f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -132,6 +132,9 @@ config CC_HAS_COUNTED_BY
 config RUSTC_HAS_COERCE_POINTEE
 =09def_bool RUSTC_VERSION >=3D 108400
=20
+config RUSTC_HAS_STABLE_STRICT_PROVENANCE
+=09def_bool RUSTC_VERSION >=3D 108400
+
 config PAHOLE_VERSION
 =09int
 =09default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/Makefile b/rust/Makefile
index ea3849eb78f6..998b57c6e5f7 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -436,7 +436,8 @@ $(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(re=
cordmcount_source) FORCE
 $(obj)/exports.o: private skip_gendwarfksyms =3D 1
=20
 $(obj)/core.o: private skip_clippy =3D 1
-$(obj)/core.o: private skip_flags =3D -Wunreachable_pub
+$(obj)/core.o: private skip_flags =3D -Wunreachable_pub \
+    -Wfuzzy_provenance_casts -Wlossy_provenance_casts
 $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intrinsi=
cs),--redefine-sym $(sym)=3D__rust$(sym))
 $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
 $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs \
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 014af0d1fc70..185bf29e44d9 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -9,6 +9,14 @@
 //! using this crate.
=20
 #![no_std]
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
 // See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
 #![cfg_attr(test, allow(deref_nullptr))]
 #![cfg_attr(test, allow(unaligned_references))]
diff --git a/rust/build_error.rs b/rust/build_error.rs
index fa24eeef9929..84e24598857f 100644
--- a/rust/build_error.rs
+++ b/rust/build_error.rs
@@ -18,6 +18,14 @@
 //! [const-context]: https://doc.rust-lang.org/reference/const_eval.html#c=
onst-context
=20
 #![no_std]
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
=20
 /// Panics if executed in [const context][const-context], or triggers a bu=
ild error if not.
 ///
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index f14b8d7caf89..0dcb25a644f6 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -21,6 +21,14 @@
=20
 #![allow(internal_features)]
 #![feature(compiler_builtins)]
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
 #![compiler_builtins]
 #![no_builtins]
 #![no_std]
diff --git a/rust/ffi.rs b/rust/ffi.rs
index 584f75b49862..28a5e9a09b70 100644
--- a/rust/ffi.rs
+++ b/rust/ffi.rs
@@ -8,6 +8,14 @@
 //! C ABI. The kernel does not use [`core::ffi`], so it can customise the =
mapping that deviates from
 //! the platform default.
=20
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
 #![no_std]
=20
 macro_rules! alias {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 398242f92a96..6fd4fb2176aa 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -13,6 +13,14 @@
=20
 #![no_std]
 #![feature(arbitrary_self_types)]
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
 #![cfg_attr(CONFIG_RUSTC_HAS_COERCE_POINTEE, feature(derive_coerce_pointee=
))]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))=
]
 #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dy=
n))]
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 8c7b786377ee..91450de998d3 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -2,6 +2,15 @@
=20
 //! Crate for all kernel procedural macros.
=20
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
+
 // When fixdep scans this, it will find this string `CONFIG_RUSTC_VERSION_=
TEXT`
 // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, which=
 is
 // touched by Kconfig when the version string from the compiler changes.
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 13495910271f..84ef3828e0d4 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -8,6 +8,14 @@
 //! userspace APIs.
=20
 #![no_std]
+#![cfg_attr(
+    not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),
+    feature(strict_provenance)
+)]
+#![cfg_attr(
+    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
+    feature(strict_provenance_lints)
+)]
 // See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
 #![cfg_attr(test, allow(deref_nullptr))]
 #![cfg_attr(test, allow(unaligned_references))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d11874..021ee36ae8f2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -226,7 +226,10 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 # Compile Rust sources (.rs)
 # ------------------------------------------------------------------------=
---
=20
-rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_re=
asons
+# Lints were moved to `strict_provenance_lints` when `strict_provenance` w=
as stabilized.
+#
+# See https://github.com/rust-lang/rust/commit/56ee492a6e7a917b2b3f888e33d=
d52a13d3ecb64.
+rust_allowed_features :=3D asm_const,asm_goto,arbitrary_self_types,lint_re=
asons,$(if $(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE),strict_provenance_l=
ints,strict_provenance)
=20
 # `--out-dir` is required to avoid temporaries being created by `rustc` in=
 the
 # current working directory, which may be not accessible in the out-of-tre=
e



