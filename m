Return-Path: <linux-kselftest+bounces-21082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68869B5B21
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 06:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D7F1C20DAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89A19884C;
	Wed, 30 Oct 2024 05:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWa8WGlP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C4BA4A;
	Wed, 30 Oct 2024 05:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265105; cv=none; b=E2qAmTYO7SDWgA36x1X9T6VUAW5WqOdH92QwHKhzxEkrk396X6lrEqSD92XERtcJfj8gkHscXS8vLo8B8OtHF2Zx5o/DPBS4i4WP6uSi334DcXxtTaf9lDLk8j4JwGy03VEGjarPXkQFGgLcO8UGKHNuwyIO6BNmEHC0fXEYPjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265105; c=relaxed/simple;
	bh=pXALggz2ym77jpSdzOlYdW/bKJB7Vkt5kw+J19TZmTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf0bJdEMftdbt3cVhfSctFcnNE0Af4uJxrzdXpXxloeXJIyNfBsY93Qp55zPzkZZULqxBYbHqf9F9sDKEzMV6syvT1w7usBHTW3kHxX/cyTz/rezd+u8TPkOJg86D4vmuxmcLvDW52oyZ+vKq1DfJH17dfQ/ROmPMFzUFhgtwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWa8WGlP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b13ff3141aso475344185a.1;
        Tue, 29 Oct 2024 22:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730265102; x=1730869902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UnVxIYXrRGebGyzXyiocLL8G8iPAsSBtCF8LfQKfdN8=;
        b=EWa8WGlPdKOU3gbgMNuWYwqCfp2q7NAxi3Mrq9i7dv3JNJ3XQMglAKclmXq+TVEXym
         hYVd/4vGNivsK1jZbThF4uRz/C/7NQ1hjakbFcnZVOVGDeEQ6uQYl58SXMIwlVBvOX0s
         MFcoU/y+MFmftR1GuB8zo8ny/gBcK3cw8/sMkom6pCqwPDvJUOc8/Xsj1GUfoc0k5PqL
         uSIC1+MFE7hZ0AmgYU9enDf04fg2WPqZp0uLLo74kcutpzYyPQci7LLs4mTmbXNIbozQ
         2uywBBJyMjORdhtIpnpPK1aBb4TzFkEJLWWX56UQOxORnMgtT7f6g9+FCcfWkdZlLtCU
         ODbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730265102; x=1730869902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnVxIYXrRGebGyzXyiocLL8G8iPAsSBtCF8LfQKfdN8=;
        b=Namu+V6GVwPsoyXEihvzHdPAECR6gI2BU7YJsdB9+hRIhBNR88ExAPRv7UhSv5sGjO
         o5m82BqoVhtn/pdkEN7jkxH10vVr+JuTdoDRgWamimXX3Jn+SUG3YI99rgi1crIWBJCp
         wVbbF8bXDxMsk3baIGZmX6SD9h2lxR8N4UAQWthfHS9GsEUsmDp1Fx2mu2nsiJ645xYP
         o7TyU3un1Qob9uSezT43re14DvwXPHCB2F4XRjCUiYOoR6y9ClNPP3P5LOUv9h2s/Zdi
         zURcLE0aDADGrfOcqxvz5s6jA4t4zRoAQxFRnc/eXMOD91L2wI3iq6wQVgHYmWqY1Iex
         6toA==
X-Forwarded-Encrypted: i=1; AJvYcCUVEFW881JVx0zZV9ariw6u1pPE5wgiKHuP/Ve9UZ+Vv2KDO73SFnP2rR0Q9l/EHal7w7ON23cwPzbO9fhGsvk=@vger.kernel.org, AJvYcCXLn4Md5qf3wnYuYKimLrWNeEiqwAkXWUB5AlG3AySVeaDtlNKFJGwW3fklGWnBmO3bk96+FxSWajAz7nk=@vger.kernel.org, AJvYcCXMP4AA51nKD9I2FLgP2htI9O4v6F8sH0vlXhUlDeKE1G3uMw748ZEC8uT8yOlMN3pcYawtQXpTLCuK3LhoPYNU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuwa85Ey9AB44VJVQ1wvpaov79Z8xx1KK5hLCIAOdBZWqWDzMu
	SCUtlQ4A2sVOvHZCDZu1OhNXFBkmMhDxiHWPbDTLQEM1yWp5ESUOVUm5nQ==
X-Google-Smtp-Source: AGHT+IHC+shSsIPYSspd7qTnfHfJVfDh3R1scgrO8/YWbAArEQ2dSuszg/rNojgre/EMDWWzoDzz+A==
X-Received: by 2002:a05:6214:3388:b0:6cb:e3ec:18c1 with SMTP id 6a1803df08f44-6d345fc9928mr24089276d6.15.1730265101520;
        Tue, 29 Oct 2024 22:11:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d17973d8bdsm48824316d6.18.2024.10.29.22.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:11:40 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 341001200043;
	Wed, 30 Oct 2024 01:11:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 30 Oct 2024 01:11:40 -0400
X-ME-Sender: <xms:DMAhZ6gDcNtkjFjCyX2-Xcjqs6xSZ7-nkosElDaBOMAaaT7QxifrKQ>
    <xme:DMAhZ7Ca0Gh5wsHQwiLI-WdtMYBC-ACufVNeyV7UMDJUdBrY70FAPBsZDdJM4Y0C8
    a56rNDvOw8R8qZNnw>
X-ME-Received: <xmr:DMAhZyFVbD2tg0FNo94OOKrCX7Ptq7of19aivAz5ihN2mgwPVd3CoomtlDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddu
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephffgffehheetieehkeevffdvudfgleeiheek
    vdekjeelffekfffgueelheevgefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpth
    hopghsthhrihhnghdrihhspdhtohgpshhtrhhinhhgrdgrshdprhhushhtqdhlrghnghdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepoh
    hjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshgvrdgvgihpohhsihht
    ohekleesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgvnhgurghnrdhhihhgghhinh
    hssehlihhnuhigrdguvghvpdhrtghpthhtoheprhhmohgrrhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsvghnnhhordhlohhs
    shhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhoth
    honhhmrghilhdrtghomh
X-ME-Proxy: <xmx:DMAhZzRR69jpBTuSG-_hImtjaLkzzR1lewQrKimPsflDTprBqx-Xpg>
    <xmx:DMAhZ3wPWvfZHY7czfgle5lt8X6dw0M5Luvtg-jKO5pe2xqhdL1jPA>
    <xmx:DMAhZx6ceIqlEaJA6RlAJPBvCTdiTku7WhGqrJcyB4JsIxF6KYoH9g>
    <xmx:DMAhZ0z-4rPdjWG0qpOE3EWB-M2l9uySPz_95GQtxkWmo-2AuMyKYw>
    <xmx:DMAhZzhb3-Y8BcMyremHMLThjRaTgTR0XKlm58LLL4qSDZTCC1LiPQ-V>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Oct 2024 01:11:39 -0400 (EDT)
Date: Tue, 29 Oct 2024 22:11:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZyHACjac2gk4M5MX@Boquns-Mac-mini.local>
References: <20241030045719.3085147-2-davidgow@google.com>
 <20241030045719.3085147-6-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030045719.3085147-6-davidgow@google.com>

On Wed, Oct 30, 2024 at 12:57:14PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
> Add a new procedural macro (`#[kunit_tests(kunit_test_suit_name)]`) to
> run KUnit tests using a user-space like syntax.
> 
> The macro, that should be used on modules, transforms every `#[test]`
> in a `kunit_case!` and adds a `kunit_unsafe_test_suite!` registering
> all of them.
> 
> The only difference with user-space tests is that instead of using
> `#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.
> 
> Note that `#[cfg(CONFIG_KUNIT)]` is added so the test module is not
> compiled when `CONFIG_KUNIT` is set to `n`.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> [Updated to use new const fn.]
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20241029092422.2884505-3-davidgow@google.com/
> - Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
> - The proc macro now emits an error if the suite name is too long.
> 
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google.com/
> - Rebased on top of rust-next
> - Make use of the new const functions, rather than the kunit_case!()
>   macro.
> 
> ---
>  MAINTAINERS          |   1 +
>  rust/kernel/kunit.rs |  11 ++++
>  rust/macros/kunit.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
>  rust/macros/lib.rs   |  29 ++++++++
>  4 files changed, 194 insertions(+)
>  create mode 100644 rust/macros/kunit.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b77f4495dcf4..b65035ede675 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12433,6 +12433,7 @@ F:	Documentation/dev-tools/kunit/
>  F:	include/kunit/
>  F:	lib/kunit/
>  F:	rust/kernel/kunit.rs
> +F:	rust/macros/kunit.rs
>  F:	scripts/rustdoc_test_*
>  F:	tools/testing/kunit/
>  
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 27bc4139d352..ac296467a552 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
>      }
>  }
>  
> +use macros::kunit_tests;
> +
>  /// Asserts that a boolean expression is `true` at runtime.
>  ///
>  /// Public but hidden since it should only be used from generated tests.
> @@ -269,3 +271,12 @@ macro_rules! kunit_unsafe_test_suite {
>          };
>      };
>  }
> +
> +#[kunit_tests(rust_kernel_kunit)]
> +mod tests {
> +    #[test]
> +    fn rust_test_kunit_kunit_tests() {
> +        let running = true;
> +        assert_eq!(running, true);
> +    }
> +}
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> new file mode 100644
> index 000000000000..850d268cc96a
> --- /dev/null
> +++ b/rust/macros/kunit.rs
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Procedural macro to run KUnit tests using a user-space like syntax.
> +//!
> +//! Copyright (c) 2023 José Expósito <jose.exposito89@gmail.com>
> +
> +use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
> +use std::fmt::Write;
> +
> +pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    if attr.to_string().is_empty() {
> +        panic!("Missing test name in #[kunit_tests(test_name)] macro")
> +    }
> +
> +    if attr.to_string().as_bytes().len() > 255 {
> +        panic!("The test suite name `{}` exceeds the maximum length of 255 bytes.", attr)
> +    }
> +
> +    let mut tokens: Vec<_> = ts.into_iter().collect();
> +
> +    // Scan for the "mod" keyword.
> +    tokens
> +        .iter()
> +        .find_map(|token| match token {
> +            TokenTree::Ident(ident) => match ident.to_string().as_str() {
> +                "mod" => Some(true),
> +                _ => None,
> +            },
> +            _ => None,
> +        })
> +        .expect("#[kunit_tests(test_name)] attribute should only be applied to modules");
> +
> +    // Retrieve the main body. The main body should be the last token tree.
> +    let body = match tokens.pop() {
> +        Some(TokenTree::Group(group)) if group.delimiter() == Delimiter::Brace => group,
> +        _ => panic!("cannot locate main body of module"),
> +    };
> +
> +    // Get the functions set as tests. Search for `[test]` -> `fn`.
> +    let mut body_it = body.stream().into_iter();
> +    let mut tests = Vec::new();
> +    while let Some(token) = body_it.next() {
> +        match token {
> +            TokenTree::Group(ident) if ident.to_string() == "[test]" => match body_it.next() {
> +                Some(TokenTree::Ident(ident)) if ident.to_string() == "fn" => {
> +                    let test_name = match body_it.next() {
> +                        Some(TokenTree::Ident(ident)) => ident.to_string(),
> +                        _ => continue,
> +                    };
> +                    tests.push(test_name);
> +                }
> +                _ => continue,
> +            },
> +            _ => (),
> +        }
> +    }
> +
> +    // Add `#[cfg(CONFIG_KUNIT)]` before the module declaration.
> +    let config_kunit = "#[cfg(CONFIG_KUNIT)]".to_owned().parse().unwrap();
> +    tokens.insert(
> +        0,
> +        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
> +    );
> +
> +    // Generate the test KUnit test suite and a test case for each `#[test]`.
> +    // The code generated for the following test module:
> +    //
> +    // ```
> +    // #[kunit_tests(kunit_test_suit_name)]
> +    // mod tests {
> +    //     #[test]
> +    //     fn foo() {
> +    //         assert_eq!(1, 1);
> +    //     }
> +    //
> +    //     #[test]
> +    //     fn bar() {
> +    //         assert_eq!(2, 2);
> +    //     }
> +    // ```
> +    //
> +    // Looks like:
> +    //
> +    // ```
> +    // unsafe extern "C" fn kunit_rust_wrapper_foo(_test: *mut kernel::bindings::kunit) {
> +    //     foo();
> +    // }
> +    // static mut KUNIT_CASE_FOO: kernel::bindings::kunit_case =
> +    //     kernel::kunit::kunit_case(foo, kunit_rust_wrapper_foo);
> +    //
> +    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: * mut kernel::bindings::kunit) {
> +    //     bar();
> +    // }
> +    // static mut KUNIT_CASE_BAR: kernel::bindings::kunit_case =
> +    //     kernel::kunit::kunit_case(bar, kunit_rust_wrapper_bar);
> +    //
> +    // static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case = kernel::kunit::kunit_case_null();
> +    //
> +    // static mut TEST_CASES : &mut[kernel::bindings::kunit_case] = unsafe {
> +    //     &mut [KUNIT_CASE_FOO, KUNIT_CASE_BAR, KUNIT_CASE_NULL]
> +    // };
> +    //
> +    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
> +    // ```
> +    let mut kunit_macros = "".to_owned();
> +    let mut test_cases = "".to_owned();
> +    for test in tests {
> +        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
> +        let kunit_case_name = format!("KUNIT_CASE_{}", test.to_uppercase());
> +        let kunit_wrapper = format!(
> +            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit) {{ {}(); }}",
> +            kunit_wrapper_fn_name, test
> +        );
> +        let kunit_case = format!(
> +            "static mut {}: kernel::bindings::kunit_case = kernel::kunit::kunit_case(kernel::c_str!(\"{}\"), {});",
> +            kunit_case_name, test, kunit_wrapper_fn_name
> +        );
> +        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> +        writeln!(kunit_macros, "{kunit_case}").unwrap();
> +        writeln!(test_cases, "{kunit_case_name},").unwrap();
> +    }
> +
> +    writeln!(
> +        kunit_macros,
> +        "static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case = kernel::kunit::kunit_case_null();"
> +    )
> +    .unwrap();
> +
> +    writeln!(
> +        kunit_macros,
> +        "static mut TEST_CASES : &mut[kernel::bindings::kunit_case] = unsafe {{ &mut[{test_cases} KUNIT_CASE_NULL] }};"
> +    )
> +    .unwrap();
> +
> +    writeln!(
> +        kunit_macros,
> +        "kernel::kunit_unsafe_test_suite!({attr}, TEST_CASES);"
> +    )
> +    .unwrap();
> +
> +    let new_body: TokenStream = vec![body.stream(), kunit_macros.parse().unwrap()]
> +        .into_iter()
> +        .collect();
> +
> +    // Remove the `#[test]` macros.
> +    let new_body = new_body.to_string().replace("#[test]", "");

Yeah, I want to see how you do it this time ;-) So if you do a
`.to_string()` on a `TokenStream`, you lose all the span [1] information
("span information" is a term invited by me, hope I get it right ;-))
e.g. if there is a compile error in the test code, the compiler cannot
report the exact line of the error, it can only report there is an
error.

Last time I find how to preserve the Span:

	https://lore.kernel.org/rust-for-linux/ZMba0_XXZuTgWyWY@boqun-archlinux/

Hope it helps!

[1]: https://doc.rust-lang.org/proc_macro/struct.Span.html

Regards,
Boqun

> +    tokens.push(TokenTree::Group(Group::new(
> +        Delimiter::Brace,
> +        new_body.parse().unwrap(),
> +    )));
> +
> +    tokens.into_iter().collect()
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 939ae00b723a..098925b99982 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -10,6 +10,7 @@
>  mod quote;
>  mod concat_idents;
>  mod helpers;
> +mod kunit;
>  mod module;
>  mod paste;
>  mod pin_data;
> @@ -430,3 +431,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
>      zeroable::derive(input)
>  }
> +
> +/// Registers a KUnit test suite and its test cases using a user-space like syntax.
> +///
> +/// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config`) is `n`, the target module
> +/// is ignored.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use macros::kunit_tests;
> +///
> +/// #[kunit_tests(kunit_test_suit_name)]
> +/// mod tests {
> +///     #[test]
> +///     fn foo() {
> +///         assert_eq!(1, 1);
> +///     }
> +///
> +///     #[test]
> +///     fn bar() {
> +///         assert_eq!(2, 2);
> +///     }
> +/// }
> +/// ```
> +#[proc_macro_attribute]
> +pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    kunit::kunit_tests(attr, ts)
> +}
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

