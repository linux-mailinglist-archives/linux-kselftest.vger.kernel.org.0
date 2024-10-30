Return-Path: <linux-kselftest+bounces-21078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7F99B5AF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494A61F24DBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12121990B3;
	Wed, 30 Oct 2024 04:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x+QwqxXp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A41198E9E
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 04:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264291; cv=none; b=Oly/YT53l+cEhWW2pkwDDoYeOf+W1+LAi28NJfHrTEno4MkPZceBe4jpoxxFhostJPF6SDAJYl3x/gQ/Wdv+NZp6UkROh9QlTQjxe10AjRhGKO2RrxHj6koYsbllCS55xZs+bZ2y1x9nO/0TwDKTCpKn3wo3BZFx0+pNFdm1IuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264291; c=relaxed/simple;
	bh=IsP2QsBuhSMQv2TLDNhGZT53gA6T/nJME1+2FfZ8xF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UszThU1e0cBGYmXKK3/R3aDCfzX7m4COhAd59NCGuBUoV3tlare8fn7L9QGQoAg1BkoVp34WC8tt7M04Us8CcLPCyZpTPrpc+vWr+NbtuicOuApgJcwsRkeYm06PuGtufaJZLlz0GLXslFbu9bRIMFApZzTjeLz38RKft0yMXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x+QwqxXp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7f633af02so88858937b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 21:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730264288; x=1730869088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku4FplA1xCd+FjxcfF6HZsAqyqZMYh/cz6ZleWHy2rE=;
        b=x+QwqxXp04ARLsal/ffxExQ2en5/uxSkbkpC/mB6ZjptRMrV4TQYgJai8tReibRz0V
         B9sGKLMEqLq9JGuTMlu13pY9umg7d2TqNmMSls4ZfPLbBD30vhxoyMZjNT9WPJpj1p7V
         P+ULM+1R9Swfsz6REayBYyKXztxzvG7wzZ1c+1Ne9KwDh4AjcFYJMgMQgBvSe4uUksQd
         pMdLwhCfUDR2Ivpfe0Dc8MaLC4wH34wSf441xfDE+FCwUY+L7dZlLlZaA3t4i9HFY4Cm
         za8Kjz1HQKw+zwxX1T8Ja/oLd17ZV95EWSCQMfnWzKSPD0Z7VSLdHMZuUkBUx5YjB9kZ
         4KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264288; x=1730869088;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku4FplA1xCd+FjxcfF6HZsAqyqZMYh/cz6ZleWHy2rE=;
        b=RXuwrr2Ucysxn4RSRt9WinZIi8kzfXjacW6P0davbxTT6nUJriYmewR4wp4jEqer0l
         F8seTn70psex0e1aayjtPr5dlaNo1/hC3NEn1RzTHhEeN9Rm31vOc1oHkMzWiuN4mKtp
         wIXzTQZWwBa8OHtRrKdChiGsVxTFqGS/9BrqKJnLsYZJsOu3U9pZDLPmbzkLqaNDQDho
         IUp9FmQyLUWnodrvnGvyPIh36lKS4QBV4tUdyQSUX28N4Zbp8xPQKxWeb0qCvkGnsk/r
         xloFpUQIT8KX5b+3hCNgl2oZrQzeqksXOu2hrI/ODx4Ri4cNJZMQO5d/+7atcEyU51R5
         e+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA8Q4n0tfoQweyQ6wHoefUbre/7IxWBob+gYQ7CZk45UyrLcebLhS5tbXrkpN0b9m5G8QSNbWr4x4FCNuZvTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIo+THm8mohmsOwx9itJkfEXkBMlYb3j0R1LCi+rBDeNLCyc/4
	xXTBnQOlvXa14U30comwT8HlpAAJlyu/fOaUmkFRmzUvwf6vbrMAVCXWUwl1mmrPvXCDkeVpEui
	Q6W44sSso5A==
X-Google-Smtp-Source: AGHT+IH2/QGIvkRbQn2mHuCqyA9ZUpW+z3HCpJCs203sNfUQXCp7VWprsRKrCkWkAC5om8Zlsmlm97Q+Vvb4Yg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:6e13:b0:6e3:6597:2225 with SMTP
 id 00721157ae682-6e9d8c2a7b3mr9752737b3.7.1730264288352; Tue, 29 Oct 2024
 21:58:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:57:14 +0800
In-Reply-To: <20241030045719.3085147-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030045719.3085147-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030045719.3085147-6-davidgow@google.com>
Subject: [PATCH v3 2/3] rust: macros: add macro to easily run KUnit tests
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
[Updated to use new const fn.]
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-3-davidgow@g=
oogle.com/
- Include missing rust/macros/kunit.rs file from v2. (Thanks Boqun!)
- The proc macro now emits an error if the suite name is too long.

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-2-c80db349e3b5@google.com=
/
- Rebased on top of rust-next
- Make use of the new const functions, rather than the kunit_case!()
  macro.

---
 MAINTAINERS          |   1 +
 rust/kernel/kunit.rs |  11 ++++
 rust/macros/kunit.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 rust/macros/kunit.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index b77f4495dcf4..b65035ede675 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12433,6 +12433,7 @@ F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
 F:	rust/kernel/kunit.rs
+F:	rust/macros/kunit.rs
 F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
=20
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 27bc4139d352..ac296467a552 100644
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
@@ -269,3 +271,12 @@ macro_rules! kunit_unsafe_test_suite {
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
index 000000000000..850d268cc96a
--- /dev/null
+++ b/rust/macros/kunit.rs
@@ -0,0 +1,153 @@
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
+    if attr.to_string().as_bytes().len() > 255 {
+        panic!("The test suite name `{}` exceeds the maximum length of 255=
 bytes.", attr)
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
+    //     kernel::kunit::kunit_case(foo, kunit_rust_wrapper_foo);
+    //
+    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: * mut kernel::bi=
ndings::kunit) {
+    //     bar();
+    // }
+    // static mut KUNIT_CASE_BAR: kernel::bindings::kunit_case =3D
+    //     kernel::kunit::kunit_case(bar, kunit_rust_wrapper_bar);
+    //
+    // static mut KUNIT_CASE_NULL: kernel::bindings::kunit_case =3D kernel=
::kunit::kunit_case_null();
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
::kunit_case(kernel::c_str!(\"{}\"), {});",
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
el::kunit::kunit_case_null();"
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
index 939ae00b723a..098925b99982 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -10,6 +10,7 @@
 mod quote;
 mod concat_idents;
 mod helpers;
+mod kunit;
 mod module;
 mod paste;
 mod pin_data;
@@ -430,3 +431,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input)
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
2.47.0.163.g1226f6d8fa-goog


