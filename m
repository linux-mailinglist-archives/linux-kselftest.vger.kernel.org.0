Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C55768888
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 23:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjG3VuA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 17:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjG3Vt7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 17:49:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C71B5;
        Sun, 30 Jul 2023 14:49:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5221cf2bb8cso5808245a12.1;
        Sun, 30 Jul 2023 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690753793; x=1691358593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opHOyZive7ntpmiWMXgz7SUFPRMq9K3nF76YJxo3aoM=;
        b=rK5OlV75K1xTCqnK2O4OGf+PuumQ/qXk0alHbyNy64RHbRkyj7bkh0JyrWZl4Zoe8C
         xbcKyMVUVPzZEQjjpX7M1aNMAJbQRu7rcKD5couFtBdf8YKBIIbobIVcl9E5ttihW7HS
         UXKFl3pqut95fyZbe0PA0t/EO6UKEK5rdQEutSp2ic4sdzOtCvCCRlHcodjU+3ewUHe3
         snv59UatI3Cbz6XkVrHu+MKQtm2JMworgZwkw99JP9pIot6sSziuy+qNhERzZOc31xH9
         F98wI6EpT/BWdF2DEp4+s1jleeCQAkqxDzSYUjJZjAPVqRSA1Xy4zbcAXe0Y5gSYRQap
         oIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690753793; x=1691358593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opHOyZive7ntpmiWMXgz7SUFPRMq9K3nF76YJxo3aoM=;
        b=jTeIYfBd3GliZrmiEACk1TIZ/NztvT5GQjttflB9wHP+6/2a06umnf4DWBi2/NAAcx
         8kny6C1qxlbbnYhSKWmOUacFJkFQT7c9Bv7jjv43WLm3jOWTFyio+kFrC6DRwpPSj4Ub
         1etyf+supv2eUUVacjONG1ShUvxp1MN2JicQUpbghQOxzAA1fuSbs7sfotYESd9S7gzR
         aTZIn1PCDc4hQ/D0AanFriGH8+Jlqa9PN9jByNiygyUqTuPQbPPnyxVQB+4hpnY1y8OB
         Eq7ZUD1Ifc6nVBdaflVPAlLqagzXnpQniC/ME5T0YC1gf1lWYWKNv3eS8B/QlZLLr/oP
         u4Yg==
X-Gm-Message-State: ABy/qLYBCUnJZNpNdgMGACwOkz526+Os6eLXCzQ9KTYhmBWWaYb8JNDc
        zEnUW6VPa3/JPPk1/nmN4Hs=
X-Google-Smtp-Source: APBJJlGlqVpVw6cH7zY2TrLmhQwq+z+8/jbTpRWJqf7H50T+yv/HMD20KvFLWJ3IAV3QSu//wqiI3g==
X-Received: by 2002:aa7:c983:0:b0:522:50b9:a177 with SMTP id c3-20020aa7c983000000b0052250b9a177mr7308350edt.39.1690753792354;
        Sun, 30 Jul 2023 14:49:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w5-20020aa7d285000000b005227ead61d0sm4552290edq.83.2023.07.30.14.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 14:49:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC89527C0054;
        Sun, 30 Jul 2023 17:49:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 30 Jul 2023 17:49:49 -0400
X-ME-Sender: <xms:_NrGZHoWQxPQ39lkaAvryv9IS_44vdRTaPUmuQevLQznEj8QpD2uZw>
    <xme:_NrGZBpKMEYrN8VDinDkdH_7i8S3dOqPE2C12LWe3vRUGdbq9ObAZKcgvdDKP-7nQ
    YqBHY4LdljUvtlCLg>
X-ME-Received: <xmr:_NrGZENBexhNiR0Q-egQq-kv7L2qU0ddkAqNk8FrspdtTvfwQgAz2SCU9Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtgeehleevffdujeffgedvlefghffhleekieeifeegveetjedvgeevueff
    ieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_NrGZK5nxLEoxMmUvwCpuX-GcLSE0Wr6tiK8LTJL-YgS0b-CqB-UTw>
    <xmx:_NrGZG49ctrAkRlVjhQBTwZiOCTdjMFgjPhSQ_q548ORqukEmysk4A>
    <xmx:_NrGZCiYIyysG0MRrEFHeNCR167d9FXl4Bc5Bd_O0yIAmIO6cXM4lA>
    <xmx:_drGZGwKReWrAscI3723OrmIix0mvgE0kf565s4yTfNVwOXxVNdBMw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jul 2023 17:49:48 -0400 (EDT)
Date:   Sun, 30 Jul 2023 14:49:07 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZMba0_XXZuTgWyWY@boqun-archlinux>
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
 <20230720-rustbind-v1-2-c80db349e3b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720-rustbind-v1-2-c80db349e3b5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 02:38:53PM +0800, David Gow wrote:
> From: José Expósito <jose.exposito89@gmail.com>
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
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> ---
>  MAINTAINERS          |   1 +
>  rust/kernel/kunit.rs |  11 ++++
>  rust/macros/kunit.rs | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/macros/lib.rs   |  29 ++++++++++
>  4 files changed, 190 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a942fe59144..c32ba6b29a96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11373,6 +11373,7 @@ F:	Documentation/dev-tools/kunit/
>  F:	include/kunit/
>  F:	lib/kunit/
>  F:	rust/kernel/kunit.rs
> +F:	rust/macros/kunit.rs
>  F:	scripts/rustdoc_test_*
>  F:	tools/testing/kunit/
>  
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 4cffc71e463b..44ea67028316 100644
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
> @@ -253,3 +255,12 @@ macro_rules! kunit_unsafe_test_suite {
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
> index 000000000000..69dac253232f
> --- /dev/null
> +++ b/rust/macros/kunit.rs
> @@ -0,0 +1,149 @@
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
> +    //     kernel::kunit_case!(foo, kunit_rust_wrapper_foo);
> +    //
> +    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: * mut kernel::bindings::kunit) {
> +    //     bar();
> +    // }
> +    // static mut KUNIT_CASE_BAR: kernel::bindings::kunit_case =
> +    //     kernel::kunit_case!(bar, kunit_rust_wrapper_bar);
> +    //
> +    // static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case = kernel::kunit_case!();
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
> +            "static mut {}: kernel::bindings::kunit_case = kernel::kunit_case!({}, {});",
> +            kunit_case_name, test, kunit_wrapper_fn_name
> +        );
> +        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> +        writeln!(kunit_macros, "{kunit_case}").unwrap();
> +        writeln!(test_cases, "{kunit_case_name},").unwrap();
> +    }
> +
> +    writeln!(
> +        kunit_macros,
> +        "static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case = kernel::kunit_case!();"
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

I've played this with some extra tests, one thing I notice is that
Span/code location information is lost if we do this, for example, if I
have a compile error in the test code (I introduced one on purpose in
the `rust_kernel_kunit` test), I will get information like:

	error[E0384]: cannot assign twice to immutable variable `running`
	   --> ../rust/kernel/kunit.rs:329:1
	    |
	329 | #[kunit_tests(rust_kernel_kunit)]
	    | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    | |
	    | cannot assign twice to immutable variable
	    | help: consider making this binding mutable: `mut running`

the location information is not very usefull. However if we do the
following:

diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 69dac253232f..913879765d24 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -134,15 +134,29 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     )
     .unwrap();
 
-    let new_body: TokenStream = vec![body.stream(), kunit_macros.parse().unwrap()]
-        .into_iter()
-        .collect();
-
     // Remove the `#[test]` macros.
-    let new_body = new_body.to_string().replace("#[test]", "");
+    let mut new_body = vec![];
+    let mut body_it = body.stream().into_iter();
+
+    while let Some(token) = body_it.next() {
+        match token {
+            TokenTree::Punct(ref c) if c.as_char() == '#' => {
+                match body_it.next() {
+                    Some(TokenTree::Group(g)) if g.to_string() == "[test]" => (),
+                    Some(next) => { new_body.extend([token, next]);},
+                    _ => {new_body.push(token);},
+                }
+            }
+            _ => { new_body.push(token); }
+        }
+    }
+
+    let mut new_body = TokenStream::from_iter(new_body);
+    new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
+
     tokens.push(TokenTree::Group(Group::new(
         Delimiter::Brace,
-        new_body.parse().unwrap(),
+        new_body
     )));
 
     tokens.into_iter().collect()


then we get better information:

	   --> ../rust/kernel/kunit.rs:335:13
	    |
	335 |         let running = true;
	    |             ^^^^^^^
	    |
	    = help: maybe it is overwritten before being read?
	    = note: `#[warn(unused_assignments)]` on by default

	error[E0384]: cannot assign twice to immutable variable `running`
	   --> ../rust/kernel/kunit.rs:336:9
	    |
	335 |         let running = true;
	    |             -------
	    |             |
	    |             first assignment to `running`
	    |             help: consider making this binding mutable: `mut running`
	336 |         running = false;
	    |         ^^^^^^^^^^^^^^^ cannot assign twice to immutable variable


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
> index 3fc74cb4ea19..cd0b720514ff 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -6,6 +6,7 @@
>  mod quote;
>  mod concat_idents;
>  mod helpers;
> +mod kunit;
>  mod module;
>  mod pin_data;
>  mod pinned_drop;
> @@ -246,3 +247,31 @@ pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
>  pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
>      pinned_drop::pinned_drop(args, input)
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
> 
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
