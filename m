Return-Path: <linux-kselftest+bounces-32286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026B9AA88B6
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 19:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5053AE6A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D721FF4D;
	Sun,  4 May 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLZ2hLaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C971F4187;
	Sun,  4 May 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380530; cv=none; b=YTm/y3DalCh/Ua2N2/tlbDctSww/1GAw1gl0EbRngPtRoNm9Q/b6Q5iNbjKQosvcPmhWgMTDPbUFnp8YlgAIJcqE6tGlQ8oXfOWMqXbeP8jpiBeuRuXHjnfx+96F6rgi+2aiFERkCRQRBEF8U3NDbOdWtdk4DTcziDmyWD0FGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380530; c=relaxed/simple;
	bh=4pOunVr8/3fLXQgqGT1pXD4fEAguAC9IvJ+qcjqsR+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdP4zMIhe4xCEWRx7kaiY0vaw/iRRnBB9X0VpJwUlRuZiqjCTW6+1kKD4Y6Pf1/HTXemBrEfI+zVS5+NonoODASwtAZ3SPwjucBYkYtvLX615jRWDXIpcQHYmoIusSpr0NQmtAbsfFsFT/aq5HaxTL6zUmQpaD4AkQKQnBIk/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLZ2hLaN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfed67e08so35805221fa.2;
        Sun, 04 May 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746380527; x=1746985327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbxWuEGnrX3oYqiG6styFnyanMknLABwZdYxFlWP+28=;
        b=nLZ2hLaNc0tlCoYSgJV9j9iLNBAqBXCAsR8nrQNursQJYgTYFa8qBgPEbtOt6uwZvZ
         aWGDnbezsw5DFxQ8zoLLTUMm5368MCT2H3dgXl4QNWHoJGurf4g+LJwfzdkp9o8t+Mac
         crqPBCZnH6udVP1Yazvfd5H8+ebnGBn/Sx69Wv/VkVx49X6x4qFUyDpd5tma8Y5hMsgu
         RQt4dgOQlBwx+hKE2pk5Heb10xwwFfVCNkqxdkQnTh8VN9wXqDNPqGLAuWNOin814tGK
         46bDygmosAwe5Q31e5vV75B4Ex8i4z7VOvb5F0rqUKzCW/9Dt36pJ0zjqB7fopzvscOt
         Cy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746380527; x=1746985327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbxWuEGnrX3oYqiG6styFnyanMknLABwZdYxFlWP+28=;
        b=my9Zosd8kErQygUzAzAE2PZ4tIryza7n7jEq+7VdHpoKNT3mokx57uuB1AVdtqWbYq
         1Kl9ma74KP1iw1muDiLDn5P9S1c/3lrwaH1VJXAC788IcRb9lvyAIODwEuwvwDmzQbJD
         ZOMOA0u+IVQj9Nz6ioEfAsz6szSqoawohcxzOMAsfliMfESI3p6yT1oaXEkc/gNBW8Iv
         ISJ7+y7KMWX6kJAucJXZF5qIn9EmwB1yE/vtOMXkID5SvLXTE8kyEAzT414dGSdXSYnP
         +8g6PrZZJn5eAqcKQ3Whz6pINTeE9/SVoY3JpMZHl70a6RYhpEafItbZeOBBfIMGU4WY
         57fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrqQ5f+4ZhVbHkaPIU+Suc9j0I2pY+QDANpZX5IHt+k/sizUN1SPUNN02qui30uKkpE5YM2Nyx1Hc22NtkgHc=@vger.kernel.org, AJvYcCX30ivOTI3vjk4ZE2CTHTiaLOeQSMTD7B4Ko3eJJ+YGq17yeLv8y4qdBc8330OhnbaAsjSMARXPfM8Kw+hH0CIG@vger.kernel.org, AJvYcCXo5mBS3+P5FqvWxXHcaQxTk1dWPfMCMssjV3qn0V5BkEItPKsJPDPbvOuO4mvwZiABS0oF3tNx8Xd+Yv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5Z8ok2gyhUp6c/PYkgBcWVgG/vA7ZvgSAa8ITBonFBydYxKF
	gY9o3H4/9aVCMAdK3qu0r7orbJ9N/JVUKccNRgdZ3u5+ODGVVIxPgRSXF58WXozve+TXG06VReo
	jUfMAVdc6vxOK4cWSf/xjzYthGBo=
X-Gm-Gg: ASbGnctwPn1A7x3kPpqtJmOG5LWVNlEZzptVLjZmHiPfAoxMtsmOflHz5UzoUknGHth
	GHv+0GNgbhi2Dp5ETkRIylXd28pUJO/28RAP+wp0FUqcehgs8tMK7njfj0CAzbXOIk+xSnDnC4D
	W3zXksaFiAOVgUEqw0dToPEVsAK5hpWWFOrZOOCKNldYXD27bgSFR7zrM=
X-Google-Smtp-Source: AGHT+IEX2MgLBv1W9wDyAPXhemuUaSDB46sI5pVSf7YiajkbFnm1iRcA2zYgYDx0nutSeqLiuGNKVMOgwbgmHJhywZI=
X-Received: by 2002:a05:651c:1470:b0:30c:5c6:91e0 with SMTP id
 38308e7fff4ca-32348656ab7mr14289281fa.2.1746380526576; Sun, 04 May 2025
 10:42:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-2-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-2-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 13:41:30 -0400
X-Gm-Features: ATxdqUFBpKKDyITWcWdzh3LClwcDwVExiKBe2tO-Z1m160TXpjfIFUJFdYXPoTQ
Message-ID: <CAJ-ks9kARZT5TMrfXvAqmGdsMD+EgdaY061tyhm_n4oerFLOfA@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: kunit: support KUnit-mapped `assert!` macros in `#[test]`s
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:53=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> The KUnit `#[test]` support that landed recently is very basic and does
> not map the `assert*!` macros into KUnit like the doctests do, so they
> panic at the moment.
>
> Thus implement the custom mapping in a similar way to doctests, reusing
> the infrastructure there.
>
> In Rust 1.88.0, the `file()` method in `Span` may be stable [1]. However,
> it was changed recently (from `SourceFile`), so we need to do something
> different in previous versions. Thus create a helper for it and use it
> to get the path.
>
> With this, a failing test suite like:
>
>     #[kunit_tests(my_test_suite)]
>     mod tests {
>         use super::*;
>
>         #[test]
>         fn my_first_test() {
>             assert_eq!(42, 43);
>         }
>
>         #[test]
>         fn my_second_test() {
>             assert!(42 >=3D 43);
>         }
>     }
>
> will properly map back to KUnit, printing something like:
>
>     [    1.924325]     KTAP version 1
>     [    1.924421]     # Subtest: my_test_suite
>     [    1.924506]     # speed: normal
>     [    1.924525]     1..2
>     [    1.926385]     # my_first_test: ASSERTION FAILED at rust/kernel/l=
ib.rs:251
>     [    1.926385]     Expected 42 =3D=3D 43 to be true, but is false
>     [    1.928026]     # my_first_test.speed: normal
>     [    1.928075]     not ok 1 my_first_test
>     [    1.928723]     # my_second_test: ASSERTION FAILED at rust/kernel/=
lib.rs:256
>     [    1.928723]     Expected 42 >=3D 43 to be true, but is false
>     [    1.929834]     # my_second_test.speed: normal
>     [    1.929868]     not ok 2 my_second_test
>     [    1.930032] # my_test_suite: pass:0 fail:2 skip:0 total:2
>     [    1.930153] # Totals: pass:0 fail:2 skip:0 total
>
> Link: https://github.com/rust-lang/rust/pull/140514 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  init/Kconfig           |  3 +++
>  rust/Makefile          |  3 ++-
>  rust/kernel/kunit.rs   |  1 -
>  rust/macros/helpers.rs | 16 ++++++++++++++++
>  rust/macros/kunit.rs   | 28 +++++++++++++++++++++++++++-
>  rust/macros/lib.rs     |  4 ++++
>  6 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 63f5974b9fa6..5f442c64c47b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -140,6 +140,9 @@ config LD_CAN_USE_KEEP_IN_OVERLAY
>  config RUSTC_HAS_COERCE_POINTEE
>         def_bool RUSTC_VERSION >=3D 108400
>
> +config RUSTC_HAS_SPAN_FILE
> +       def_bool RUSTC_VERSION >=3D 108800
> +
>  config PAHOLE_VERSION
>         int
>         default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
> diff --git a/rust/Makefile b/rust/Makefile
> index 3aca903a7d08..075b38a24997 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -402,7 +402,8 @@ quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET=
) P $@
>                 -Clink-args=3D'$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' =
\
>                 --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --exter=
n proc_macro \
>                 --crate-type proc-macro \
> -               --crate-name $(patsubst lib%.$(libmacros_extension),%,$(n=
otdir $@)) $<
> +               --crate-name $(patsubst lib%.$(libmacros_extension),%,$(n=
otdir $@)) \
> +               @$(objtree)/include/generated/rustc_cfg $<
>
>  # Procedural macros can only be used with the `rustc` that compiled it.
>  $(obj)/$(libmacros_name): $(src)/macros/lib.rs FORCE
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 1604fb6a5b1b..2659895d4c5d 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -323,7 +323,6 @@ mod tests {
>
>      #[test]
>      fn rust_test_kunit_example_test() {
> -        #![expect(clippy::eq_op)]

How come this vanished?

>          assert_eq!(1 + 1, 2);
>      }
>
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index a3ee27e29a6f..57c3b0f0c194 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -86,3 +86,19 @@ pub(crate) fn function_name(input: TokenStream) -> Opt=
ion<Ident> {
>      }
>      None
>  }
> +
> +pub(crate) fn file() -> String {
> +    #[cfg(not(CONFIG_RUSTC_HAS_SPAN_FILE))]
> +    {
> +        proc_macro::Span::call_site()
> +            .source_file()
> +            .path()
> +            .to_string_lossy()
> +            .into_owned()
> +    }
> +
> +    #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
> +    {
> +        proc_macro::Span::call_site().file()
> +    }
> +}
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index 4f553ecf40c0..eb4f2afdbe43 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -101,6 +101,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Toke=
nStream) -> TokenStream {
>      // ```
>      let mut kunit_macros =3D "".to_owned();
>      let mut test_cases =3D "".to_owned();
> +    let mut assert_macros =3D "".to_owned();

nit: why not String::new() for all these?

> +    let path =3D crate::helpers::file();
>      for test in &tests {
>          let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{}", t=
est);
>          let kunit_wrapper =3D format!(
> @@ -114,6 +116,27 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Tok=
enStream) -> TokenStream {
>              test, kunit_wrapper_fn_name
>          )
>          .unwrap();
> +        writeln!(
> +            assert_macros,
> +            r#"
> +/// Overrides the usual [`assert!`] macro with one that calls KUnit inst=
ead.
> +#[allow(unused)]
> +macro_rules! assert {{
> +    ($cond:expr $(,)?) =3D> {{{{
> +        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
> +    }}}}
> +}}
> +
> +/// Overrides the usual [`assert_eq!`] macro with one that calls KUnit i=
nstead.
> +#[allow(unused)]
> +macro_rules! assert_eq {{
> +    ($left:expr, $right:expr $(,)?) =3D> {{{{
> +        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
> +    }}}}
> +}}
> +        "#
> +        )
> +        .unwrap();
>      }
>
>      writeln!(kunit_macros).unwrap();
> @@ -152,7 +175,10 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Tok=
enStream) -> TokenStream {
>          }
>      }
>
> -    let mut new_body =3D TokenStream::from_iter(new_body);
> +    let body =3D new_body;
> +    let mut new_body =3D TokenStream::new();
> +    new_body.extend::<TokenStream>(assert_macros.parse().unwrap());
> +    new_body.extend(body);

Could we do this (pushing `assert_macros`) before the block above to
avoid this body/new_body name juggling?

>      new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
>
>      tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, new_body))=
);
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 9acaa68c974e..8bd7906276be 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -6,6 +6,10 @@
>  // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, whi=
ch is
>  // touched by Kconfig when the version string from the compiler changes.
>
> +// TODO: check that when Rust 1.88.0 is released, this would be enough:
> +// #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span)=
)]
> +#![feature(proc_macro_span)]
> +
>  #[macro_use]
>  mod quote;
>  mod concat_idents;
> --
> 2.49.0
>
>

