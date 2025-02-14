Return-Path: <linux-kselftest+bounces-26658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C93A360AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E58216CEA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A44266B59;
	Fri, 14 Feb 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzrgPa2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9887266594;
	Fri, 14 Feb 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544098; cv=none; b=raMdlm0ma4AD25cBBQpuHPSvJfd+tcudlsDYxIx4XyT6q6D02LoE646AZl9/iz5T47eHbeJz8Pi6aiS1oNf6u0OGJt2x9vfCH5YXW7DAVY97Nm6iA2IHIkYzP8eblI7Tt/XPTj5Hi+rdEgu8dTjRIRUGqoKDI/nlm5zOttuZOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544098; c=relaxed/simple;
	bh=ZfRtnh0opdJqYaX2tL8rfONWy1Di44FLPzEaVr6P+rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xus+AoyAa770m2KJHQGU6K8CEOpEkpvP9f6XHs76CFuHYvYXDeAxzSZ3cPjWK+m7EwP6IGUgqPZ4EONbaKRthshnUfjUPnOgEqgA1LhoJV3VO/FeIyhh/Yh4mUtLR7kGN7PHHiz795PWanEidr97n3vYBgtm8xBEfNmqz6Zyp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzrgPa2N; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-308f141518cso23190281fa.2;
        Fri, 14 Feb 2025 06:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739544095; x=1740148895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RZaCw8aioU18CTKwC1V4RXQ8vkWM6Ogqxxi8jGM/8s=;
        b=KzrgPa2NgrV92GXYGKjzwLW1meBp3MX7m90xfuWLghs/87XpDNK5p+6HFvzVDtDsqV
         7WMijVxTMZHZ03i5QWubSIRcH/LjCjR67nC9J8RnUV9n1DbfdIPKmt5WOsVKKdJ9qh9T
         bz2Yj3lM3Zteb5X2Te5RXYjLND/0/8eDzgQG8H52GcD1Eh7/MHtaigDG28wlNbPQaJPU
         n6MSX0aO2WynmmaBx33ZywTDzHcuK+Y5nHo7NE6N9AYlJNrsjvbzKgybxnl34EB9Nvvt
         a9vssE+hAelvlCRIiIG/01hgs9h/+2wrP2YqDTDK4nJXNIu2jon6bl27zfsJFSnnKQEV
         9LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544095; x=1740148895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RZaCw8aioU18CTKwC1V4RXQ8vkWM6Ogqxxi8jGM/8s=;
        b=ov/XI1+32CegkTarKuowrJJ+OEeb8mrtSz8x0K2AKvCuNJa3/YKQgOkkhp4ouN79X2
         vBPvkouPvxmnrm5lKN259wUI44xvgOiK04OWRqHE7EgBurFhr+7cabheRqlGeLY1UboO
         6zuOzQq9ZOo/pHBM0zcoy4hSQxhTiuBISpxPtuPVXsdotoIeNNhBarK41UhHXXJ2jfIp
         pyFsI+FLUKwGriZAS/g5dwL+uDVtOMBSAl7rcQqrBDXYKjZwGNHAOmQzDHjL+mZaCqup
         Ll6J9wpoDpXeAhYZB83yIK9et144B9vFza519n1lxRBCgf6pvYxIrhSS18/5anipfGu9
         Ha8A==
X-Forwarded-Encrypted: i=1; AJvYcCUd0VZj1aA/DIJh2IPyLBDJGFcsRcJWG6RQW0cqNynn5z+ZZwmSFtJvROhP9h4mixpEnmAfVDMILiRu5BvI45VF@vger.kernel.org, AJvYcCVNlH8BOxoRm+k7gVnrfBkTiFrZCQGZEAyvCSR4ZNLqiNaDua7IiWs1XPonXlqy3N5oxCBjGrJ6C9DvRumTeZc=@vger.kernel.org, AJvYcCVkWyCpsOo+pgueT2s9yjq+7NbSOakdBaFNd5kUQ6+NK3rcLNejFiPdNfbR7W/9MuIP9LykzgH5mO3D2Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9tyOOZmXYKNJf04LmimMVsI2ba83Pm2xH6hDMHUWqVEJN6iDY
	65BgFDZhyU4wzU5ysZz6dtLueop1cCgDvpWmk436YKFEqmfTsMhapLRo8oauxB8ad1A+aFwwWes
	f6cWpFAXCEOsbS1vn9VvT/J+NrBA=
X-Gm-Gg: ASbGncs2hu9x2jO/0h6K91QZebecOlb8cbzcRe3Vw686cbUfrPhfXDIly57jWgCvCyN
	FEBJxTfSt8Ov4Tcetry5D0OTJkftjcCEtl8tCESW105w80B5iqUTwVj/690qUnpPJM/yHFRfjJM
	jiU8L2VhBjWhOkv1nvPjn2MQZtDos8ugg=
X-Google-Smtp-Source: AGHT+IEChgucSW4r7pLBf+zJk8zdT6uwfp3F+9/Z1adAgQGuxzpoo+9HDeS7xFG9zFbvCciUNtqZPxwRs7IAdBG4sg4=
X-Received: by 2002:a05:651c:4108:b0:309:2012:cc5d with SMTP id
 38308e7fff4ca-3092012d857mr5888901fa.24.1739544094443; Fri, 14 Feb 2025
 06:41:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-3-davidgow@google.com>
In-Reply-To: <20250214074051.1619256-3-davidgow@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 09:40:58 -0500
X-Gm-Features: AWEUYZmZwdH8YqpoMK8jytQ28oUSlH-ooZYgM8zss4JPNCQgWu1EpHyIYgIN-Uc
Message-ID: <CAJ-ks9nAT5ETe3qM-DcY-YqES-pTK0RdMAY_fn1jT0_Dv1HkTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] rust: macros: add macro to easily run KUnit tests
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
>
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
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> Changes since v5:
> https://lore.kernel.org/all/20241213081035.2069066-3-davidgow@google.com/
> - Fix some rustfmt-related formatting shenanigans. (Thanks, Miguel)
> - Fix some documentation comment formatting as well. (Thanks, Miguel)
> - Tidy up the generated code to avoid unneeded &mut[] everywhere.
>   (Thanks, Miguel)
> - Fix a new clippy warning for using .as_bytes().len() instead of .len()
>   directly.
>
> Changes since v4:
> https://lore.kernel.org/linux-kselftest/20241101064505.3820737-3-davidgow=
@google.com/
> - Rebased against 6.13-rc1
> - "Expect" that the sample assert_eq!(1+1, 2) produces a clippy warning
>   due to a redundant assertion. (Thanks Boqun, Miguel)
>
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20241030045719.3085147-6-davidgow=
@google.com/
> - The #[kunit_tests()] macro now preserves span information, so
>   errors can be better reported. (Thanks, Boqun!)
> - The example test has been replaced to no longer use assert_eq!() with
>   a constant bool argument (which triggered a clippy warning now we
>   have the span info). It now checks 1 + 1 =3D=3D 2, to match the C examp=
le.
>   - (The in_kunit_test() test in the next patch uses assert!() to check
>     a bool, so having something different here seemed to make a better
>     example.)
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20241029092422.2884505-3-davidgow=
@google.com/
> - Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
> - The proc macro now emits an error if the suite name is too long.
>
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google.c=
om/
> - Rebased on top of rust-next
> - Make use of the new const functions, rather than the kunit_case!()
>   macro.
>
> ---
>  MAINTAINERS          |   1 +
>  rust/kernel/kunit.rs |  12 ++++
>  rust/macros/kunit.rs | 161 +++++++++++++++++++++++++++++++++++++++++++
>  rust/macros/lib.rs   |  29 ++++++++
>  4 files changed, 203 insertions(+)
>  create mode 100644 rust/macros/kunit.rs
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d9e8187eb0..4e7a6d2f2c49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12677,6 +12677,7 @@ F:      Documentation/dev-tools/kunit/
>  F:     include/kunit/
>  F:     lib/kunit/
>  F:     rust/kernel/kunit.rs
> +F:     rust/macros/kunit.rs
>  F:     scripts/rustdoc_test_*
>  F:     tools/testing/kunit/
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index d34a92075174..9e27b74a605b 100644
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
> @@ -275,6 +277,7 @@ macro_rules! kunit_unsafe_test_suite {
>                  };
>
>              #[used]
> +            #[allow(unused_unsafe)]
>              #[link_section =3D ".kunit_test_suites"]
>              static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings=
::kunit_suite =3D
>                  // SAFETY: `KUNIT_TEST_SUITE` is static.
> @@ -282,3 +285,12 @@ macro_rules! kunit_unsafe_test_suite {
>          };
>      };
>  }
> +
> +#[kunit_tests(rust_kernel_kunit)]
> +mod tests {
> +    #[test]
> +    fn rust_test_kunit_example_test() {
> +        #![expect(clippy::eq_op)]
> +        assert_eq!(1 + 1, 2);
> +    }
> +}
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> new file mode 100644
> index 000000000000..4f553ecf40c0
> --- /dev/null
> +++ b/rust/macros/kunit.rs
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Procedural macro to run KUnit tests using a user-space like syntax.
> +//!
> +//! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.co=
m>
> +
> +use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
> +use std::fmt::Write;
> +
> +pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenSt=
ream {
> +    let attr =3D attr.to_string();
> +
> +    if attr.is_empty() {
> +        panic!("Missing test name in `#[kunit_tests(test_name)]` macro")
> +    }
> +
> +    if attr.len() > 255 {
> +        panic!(
> +            "The test suite name `{}` exceeds the maximum length of 255 =
bytes",
> +            attr
> +        )
> +    }
> +
> +    let mut tokens: Vec<_> =3D ts.into_iter().collect();
> +
> +    // Scan for the `mod` keyword.
> +    tokens
> +        .iter()
> +        .find_map(|token| match token {
> +            TokenTree::Ident(ident) =3D> match ident.to_string().as_str(=
) {
> +                "mod" =3D> Some(true),
> +                _ =3D> None,
> +            },
> +            _ =3D> None,
> +        })
> +        .expect("`#[kunit_tests(test_name)]` attribute should only be ap=
plied to modules");
> +
> +    // Retrieve the main body. The main body should be the last token tr=
ee.
> +    let body =3D match tokens.pop() {
> +        Some(TokenTree::Group(group)) if group.delimiter() =3D=3D Delimi=
ter::Brace =3D> group,
> +        _ =3D> panic!("Cannot locate main body of module"),
> +    };
> +
> +    // Get the functions set as tests. Search for `[test]` -> `fn`.
> +    let mut body_it =3D body.stream().into_iter();
> +    let mut tests =3D Vec::new();
> +    while let Some(token) =3D body_it.next() {
> +        match token {
> +            TokenTree::Group(ident) if ident.to_string() =3D=3D "[test]"=
 =3D> match body_it.next() {
> +                Some(TokenTree::Ident(ident)) if ident.to_string() =3D=
=3D "fn" =3D> {
> +                    let test_name =3D match body_it.next() {
> +                        Some(TokenTree::Ident(ident)) =3D> ident.to_stri=
ng(),
> +                        _ =3D> continue,
> +                    };
> +                    tests.push(test_name);
> +                }
> +                _ =3D> continue,
> +            },
> +            _ =3D> (),
> +        }
> +    }
> +
> +    // Add `#[cfg(CONFIG_KUNIT)]` before the module declaration.
> +    let config_kunit =3D "#[cfg(CONFIG_KUNIT)]".to_owned().parse().unwra=
p();
> +    tokens.insert(
> +        0,
> +        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
> +    );
> +
> +    // Generate the test KUnit test suite and a test case for each `#[te=
st]`.
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
> +    // }
> +    // ```
> +    //
> +    // Looks like:
> +    //
> +    // ```
> +    // unsafe extern "C" fn kunit_rust_wrapper_foo(_test: *mut kernel::b=
indings::kunit) { foo(); }
> +    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut kernel::b=
indings::kunit) { bar(); }
> +    //
> +    // static mut TEST_CASES: [kernel::bindings::kunit_case; 3] =3D [
> +    //     kernel::kunit::kunit_case(kernel::c_str!("foo"), kunit_rust_w=
rapper_foo),
> +    //     kernel::kunit::kunit_case(kernel::c_str!("bar"), kunit_rust_w=
rapper_bar),
> +    //     kernel::kunit::kunit_case_null(),
> +    // ];
> +    //
> +    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES=
);
> +    // ```

This is a really helpful comment. It got me wondering: can we have
host-side unit tests for our proc macros? Code is better than
comments, of course.

> +    let mut kunit_macros =3D "".to_owned();
> +    let mut test_cases =3D "".to_owned();
> +    for test in &tests {
> +        let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{}", t=
est);
> +        let kunit_wrapper =3D format!(
> +            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kun=
it) {{ {}(); }}",
> +            kunit_wrapper_fn_name, test
> +        );
> +        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> +        writeln!(
> +            test_cases,
> +            "    kernel::kunit::kunit_case(kernel::c_str!(\"{}\"), {}),"=
,
> +            test, kunit_wrapper_fn_name
> +        )
> +        .unwrap();
> +    }
> +
> +    writeln!(kunit_macros).unwrap();
> +    writeln!(
> +        kunit_macros,
> +        "static mut TEST_CASES: [kernel::bindings::kunit_case; {}] =3D [=
\n{test_cases}    kernel::kunit::kunit_case_null(),\n];",
> +        tests.len() + 1
> +    )
> +    .unwrap();
> +
> +    writeln!(
> +        kunit_macros,
> +        "kernel::kunit_unsafe_test_suite!({attr}, TEST_CASES);"
> +    )
> +    .unwrap();
> +
> +    // Remove the `#[test]` macros.

This makes sense. I wonder if we should think about being able to
declare a test that runs both on host and in KUnit.



> +    // We do this at a token level, in order to preserve span informatio=
n.
> +    let mut new_body =3D vec![];
> +    let mut body_it =3D body.stream().into_iter();
> +
> +    while let Some(token) =3D body_it.next() {
> +        match token {
> +            TokenTree::Punct(ref c) if c.as_char() =3D=3D '#' =3D> match=
 body_it.next() {
> +                Some(TokenTree::Group(group)) if group.to_string() =3D=
=3D "[test]" =3D> (),
> +                Some(next) =3D> {
> +                    new_body.extend([token, next]);
> +                }
> +                _ =3D> {
> +                    new_body.push(token);
> +                }
> +            },
> +            _ =3D> {
> +                new_body.push(token);
> +            }
> +        }
> +    }
> +
> +    let mut new_body =3D TokenStream::from_iter(new_body);
> +    new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
> +
> +    tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, new_body))=
);
> +
> +    tokens.into_iter().collect()
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index d61bc6a56425..50b58259c577 100644
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
> @@ -492,3 +493,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  pub fn derive_zeroable(input: TokenStream) -> TokenStream {
>      zeroable::derive(input)
>  }
> +
> +/// Registers a KUnit test suite and its test cases using a user-space l=
ike syntax.
> +///
> +/// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config=
`) is `n`, the target module
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
> 2.48.1.601.g30ceb7b040-goog
>
>

