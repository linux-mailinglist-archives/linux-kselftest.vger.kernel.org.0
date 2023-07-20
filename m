Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9784075A6B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjGTGlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 02:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjGTGks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 02:40:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7641E2121
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff7b4feefso5303877b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689835205; x=1690440005;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5518GRtCGTsC8V9nNP/WKn16Z2CeoFYtE0lstBJ/N+g=;
        b=1ZKBxBRQ8hr4t0f2fuCNrFrn4dVRrOB6k/W3B8yh2hmnDX0msPZaC3KW7iaO1yTpTv
         8A21ffDBmMrYqzsQ02KbKfYzWSZ+2Dla0TWdlOdqVvTkbf8UnzXr6Isgr79pevYXVW44
         e6ewqZrUl9aH/pwdEjta0HEAbJE68LID+WSqtbZVlgQ6odfKtceeIY7lJLe9cxbzD7Tc
         +il22mA7Y/hPjRjEj+Ovug2wGYNGFEzdFObQ3ijlfKHHLXAMUPeiYNA+1mL3fO5fl/WS
         2WgQczr7iYs2up+RP+gotFd2veL/q9aPpKtBPV/JNXR4GIWoVOfgZSjhEqezKXxc/lL9
         ATmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835205; x=1690440005;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5518GRtCGTsC8V9nNP/WKn16Z2CeoFYtE0lstBJ/N+g=;
        b=TQeuS18333YxEidJP5YikuFSaJqDoxeGSc8ADUCwcjkhcvoR6S5b0esjNxqBRIx5YV
         gQIAMDSKdvZIH3piiGBFRqrjiDBt0L4hdizm9Q5JNihli4EpEVE/h3MzPbIPjZAqcee5
         qmr+G34TQjUFz/GpdBmnmI1j4g07NNTZfS/oXt1EkZfBwmCXZgc6JOie7BCdjz7lzzZK
         09yJN1ChKkl1P3uYZCXDY7WaCPeVaGn6nhNb1HPvpb2wJ7h2s4H5tL4Yzu7NmCvXfUcL
         lyXpRaedDQuq/zf/7v336lsNWCsT/nUjJ2kd+G1V3KJmKL85BzsNSOH+WmhbFA2GlMYy
         M06w==
X-Gm-Message-State: ABy/qLZHRwPZOlZ+FSUgQGV5jxZWP+50XFsoOUhiwHkgv29yQkn8atUK
        /teN91XM8GRVwNGx+9kG8xF+9zSzRFJ/6w==
X-Google-Smtp-Source: APBJJlF+2fk/0p2V+Xl5MJNU7gz9mu5vwQOhK0hvthv7tiePAy+WIH1O9jj+S07+eAo/eSI/2QO//6WK5b1jAg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:69ce:0:b0:ce8:e6f:440c with SMTP id
 e197-20020a2569ce000000b00ce80e6f440cmr36778ybc.6.1689835205186; Wed, 19 Jul
 2023 23:40:05 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:38:53 +0800
In-Reply-To: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
Mime-Version: 1.0
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20230720-rustbind-v1-2-c80db349e3b5@google.com>
Subject: [PATCH 2/3] rust: macros: add macro to easily run KUnit tests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     David Gow <davidgow@google.com>,
        "=?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Add a new procedural macro (`#[kunit_tests(kunit_test_suit_name)]`) to
run KUnit tests using a user-space like syntax.

The macro, that should be used on modules, transforms every `#[test]`
in a `kunit_case!` and adds a `kunit_unsafe_test_suite!` registering
all of them.

The only difference with user-space tests is that instead of using
`#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.

Note that `#[cfg(CONFIG_KUNIT)]` is added so the test module is not
compiled when `CONFIG_KUNIT` is set to `n`.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
---
 MAINTAINERS          |   1 +
 rust/kernel/kunit.rs |  11 ++++
 rust/macros/kunit.rs | 149 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/macros/lib.rs   |  29 ++++++++++
 4 files changed, 190 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a942fe59144..c32ba6b29a96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11373,6 +11373,7 @@ F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
 F:	rust/kernel/kunit.rs
+F:	rust/macros/kunit.rs
 F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
=20
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 4cffc71e463b..44ea67028316 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
     }
 }
=20
+use macros::kunit_tests;
+
 /// Asserts that a boolean expression is `true` at runtime.
 ///
 /// Public but hidden since it should only be used from generated tests.
@@ -253,3 +255,12 @@ macro_rules! kunit_unsafe_test_suite {
         };
     };
 }
+
+#[kunit_tests(rust_kernel_kunit)]
+mod tests {
+    #[test]
+    fn rust_test_kunit_kunit_tests() {
+        let running =3D true;
+        assert_eq!(running, true);
+    }
+}
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
new file mode 100644
index 000000000000..69dac253232f
--- /dev/null
+++ b/rust/macros/kunit.rs
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Procedural macro to run KUnit tests using a user-space like syntax.
+//!
+//! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
+
+use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
+use std::fmt::Write;
+
+pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStre=
am {
+    if attr.to_string().is_empty() {
+        panic!("Missing test name in #[kunit_tests(test_name)] macro")
+    }
+
+    let mut tokens: Vec<_> =3D ts.into_iter().collect();
+
+    // Scan for the "mod" keyword.
+    tokens
+        .iter()
+        .find_map(|token| match token {
+            TokenTree::Ident(ident) =3D> match ident.to_string().as_str() =
{
+                "mod" =3D> Some(true),
+                _ =3D> None,
+            },
+            _ =3D> None,
+        })
+        .expect("#[kunit_tests(test_name)] attribute should only be applie=
d to modules");
+
+    // Retrieve the main body. The main body should be the last token tree=
.
+    let body =3D match tokens.pop() {
+        Some(TokenTree::Group(group)) if group.delimiter() =3D=3D Delimite=
r::Brace =3D> group,
+        _ =3D> panic!("cannot locate main body of module"),
+    };
+
+    // Get the functions set as tests. Search for `[test]` -> `fn`.
+    let mut body_it =3D body.stream().into_iter();
+    let mut tests =3D Vec::new();
+    while let Some(token) =3D body_it.next() {
+        match token {
+            TokenTree::Group(ident) if ident.to_string() =3D=3D "[test]" =
=3D> match body_it.next() {
+                Some(TokenTree::Ident(ident)) if ident.to_string() =3D=3D =
"fn" =3D> {
+                    let test_name =3D match body_it.next() {
+                        Some(TokenTree::Ident(ident)) =3D> ident.to_string=
(),
+                        _ =3D> continue,
+                    };
+                    tests.push(test_name);
+                }
+                _ =3D> continue,
+            },
+            _ =3D> (),
+        }
+    }
+
+    // Add `#[cfg(CONFIG_KUNIT)]` before the module declaration.
+    let config_kunit =3D "#[cfg(CONFIG_KUNIT)]".to_owned().parse().unwrap(=
);
+    tokens.insert(
+        0,
+        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
+    );
+
+    // Generate the test KUnit test suite and a test case for each `#[test=
]`.
+    // The code generated for the following test module:
+    //
+    // ```
+    // #[kunit_tests(kunit_test_suit_name)]
+    // mod tests {
+    //     #[test]
+    //     fn foo() {
+    //         assert_eq!(1, 1);
+    //     }
+    //
+    //     #[test]
+    //     fn bar() {
+    //         assert_eq!(2, 2);
+    //     }
+    // ```
+    //
+    // Looks like:
+    //
+    // ```
+    // unsafe extern "C" fn kunit_rust_wrapper_foo(_test: *mut kernel::bin=
dings::kunit) {
+    //     foo();
+    // }
+    // static mut KUNIT_CASE_FOO: kernel::bindings::kunit_case =3D
+    //     kernel::kunit_case!(foo, kunit_rust_wrapper_foo);
+    //
+    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: * mut kernel::bi=
ndings::kunit) {
+    //     bar();
+    // }
+    // static mut KUNIT_CASE_BAR: kernel::bindings::kunit_case =3D
+    //     kernel::kunit_case!(bar, kunit_rust_wrapper_bar);
+    //
+    // static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case =3D kernel=
::kunit_case!();
+    //
+    // static mut TEST_CASES : &mut[kernel::bindings::kunit_case] =3D unsa=
fe {
+    //     &mut [KUNIT_CASE_FOO, KUNIT_CASE_BAR, KUNIT_CASE_NULL]
+    // };
+    //
+    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
+    // ```
+    let mut kunit_macros =3D "".to_owned();
+    let mut test_cases =3D "".to_owned();
+    for test in tests {
+        let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{}", tes=
t);
+        let kunit_case_name =3D format!("KUNIT_CASE_{}", test.to_uppercase=
());
+        let kunit_wrapper =3D format!(
+            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit=
) {{ {}(); }}",
+            kunit_wrapper_fn_name, test
+        );
+        let kunit_case =3D format!(
+            "static mut {}: kernel::bindings::kunit_case =3D kernel::kunit=
_case!({}, {});",
+            kunit_case_name, test, kunit_wrapper_fn_name
+        );
+        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
+        writeln!(kunit_macros, "{kunit_case}").unwrap();
+        writeln!(test_cases, "{kunit_case_name},").unwrap();
+    }
+
+    writeln!(
+        kunit_macros,
+        "static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case =3D kern=
el::kunit_case!();"
+    )
+    .unwrap();
+
+    writeln!(
+        kunit_macros,
+        "static mut TEST_CASES : &mut[kernel::bindings::kunit_case] =3D un=
safe {{ &mut[{test_cases} KUNIT_CASE_NULL] }};"
+    )
+    .unwrap();
+
+    writeln!(
+        kunit_macros,
+        "kernel::kunit_unsafe_test_suite!({attr}, TEST_CASES);"
+    )
+    .unwrap();
+
+    let new_body: TokenStream =3D vec![body.stream(), kunit_macros.parse()=
.unwrap()]
+        .into_iter()
+        .collect();
+
+    // Remove the `#[test]` macros.
+    let new_body =3D new_body.to_string().replace("#[test]", "");
+    tokens.push(TokenTree::Group(Group::new(
+        Delimiter::Brace,
+        new_body.parse().unwrap(),
+    )));
+
+    tokens.into_iter().collect()
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 3fc74cb4ea19..cd0b720514ff 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -6,6 +6,7 @@
 mod quote;
 mod concat_idents;
 mod helpers;
+mod kunit;
 mod module;
 mod pin_data;
 mod pinned_drop;
@@ -246,3 +247,31 @@ pub fn pin_data(inner: TokenStream, item: TokenStream)=
 -> TokenStream {
 pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
     pinned_drop::pinned_drop(args, input)
 }
+
+/// Registers a KUnit test suite and its test cases using a user-space lik=
e syntax.
+///
+/// This macro should be used on modules. If `CONFIG_KUNIT` (in `.config`)=
 is `n`, the target module
+/// is ignored.
+///
+/// # Examples
+///
+/// ```ignore
+/// # use macros::kunit_tests;
+///
+/// #[kunit_tests(kunit_test_suit_name)]
+/// mod tests {
+///     #[test]
+///     fn foo() {
+///         assert_eq!(1, 1);
+///     }
+///
+///     #[test]
+///     fn bar() {
+///         assert_eq!(2, 2);
+///     }
+/// }
+/// ```
+#[proc_macro_attribute]
+pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
+    kunit::kunit_tests(attr, ts)
+}

--=20
2.41.0.255.g8b1d071c50-goog

