Return-Path: <linux-kselftest+bounces-21281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB619B8B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 07:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6873B21F38
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 06:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2477D1552FD;
	Fri,  1 Nov 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etGVuIzq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE215443C
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Nov 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443523; cv=none; b=PwWBvtVsFzSbC+xP1S7nuizZKLSor/LmicABmIKkGOKrMaboU6EOlA87Ri6DdDbilCSTR378icMlpkVcl3UDqGfxD1dhaCedv7dr9ju1Nrcy19Jby2qnKFgvFskEjDMibWqu0l2Rnh1SAunIlQt/ZK4kpP8XHqwnF2HxvZ/I/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443523; c=relaxed/simple;
	bh=v0JWh6mI0misBYz0RyrCman5gMCJ1WpGSVem5xwGrw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dnThhCyW64rYB7AX9gFlmeoJXi6TKoLwSUhGAvv+tmarmAfHEwQRQbfg9APEZuEaucTJ8WE3glgbBAmsVhqr+pWm69wCNpU4zxLuc4YAwlmqI4WPg1t1dk/yda4WxihGFuB0mi4xiHvCf/hiqqmVZ8JdrrolWpasTO5EAm/kLsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etGVuIzq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so22718057b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 23:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730443519; x=1731048319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZbS75Dycs4k+d5IOrNhPypH5FLb4D2VKY1Jt0cnz5w=;
        b=etGVuIzqDJs28bL6EBbWr9IfBHiWJtx0z7FlEu+GLMsBd/hVuDCgGz7viZxoWOSZIq
         FXG46tZB7s18hpOUC+nadVQyTBg8bkmS7cgGrxQWSNbPveGAkV1abOM7qBAPCyWjzEJI
         4Jwg4Gw90hiDfJeVzlppE3kJZjLz860KeArDnPznNOg87RATdrnXbHpi49CuOkNL6alF
         89ENoUT0RSZJI5E+5TSGbhQ8rvAq9XkQZaE+H5f4NJPSb/Zkl6EFB8aIey/nKDjIgUpH
         3f+GNr5AadZ+kGlxQkB0zaNtbB/6DqSr4eVQdJLZXZWYykIrjMHBtEF9MIDhpDLRNLIi
         jPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443519; x=1731048319;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZbS75Dycs4k+d5IOrNhPypH5FLb4D2VKY1Jt0cnz5w=;
        b=FAGA84PZCffXnAzfe4bMnPF+EXqtHpSA/OnGyXI8lje9RX0KE8mTD43upe9/mY38/z
         EDD+3zPe/wmrEq61plNr3kzkUwl90Ajt2euBhEii5MJf1OeZWBIiRzUycDDvJQWJcDTs
         YtnyAC8v594iJpLm8SKNm0iKfzk6NcK6nNda6VRPZOlS4CcrMH5Lw/r5p4zd1pRd48qi
         w/yaG+0WbZ1S0j0H998QF7rASPN7sdjr/mlL4+y1lDz+3oFJF3DRFYiFxeGo90PpiUk9
         gs7XYkVeGFP7NP3mm0J5/HIWJFW3N66IEVaK/UzTpAd5ok4ZQ68LbxAQSGdmfmboL5gt
         JVWg==
X-Forwarded-Encrypted: i=1; AJvYcCXAlkqThvgqt8kp7rokkdOeiTEj4hLLdI5YbK6FVbt14kyhb3r5OI9PaRJ+P3VM9g9vkDye1Dawek2zRK6J7Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhIDfAsQnoeY9xFz8NJ1p3oZ1KHyMqUfcndXQYn3IoIjxSIIh
	Uh9QKqUu0QHiAXpVBcjf1h8aDq6pMJY+yLsiFEJufqAwm2DjgbweLDs/1bUanQTnfgqF9WGCILB
	j0oS/pe0RZw==
X-Google-Smtp-Source: AGHT+IHxZZTQXlNfO5k0ws+jUpv4gaUJ0UXJ7lVBWsEwZtqCS4NybFDz7nc9Jr66DptLBLlha83xvxa6s7Hd1A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a05:690c:f11:b0:6db:e464:addc with SMTP
 id 00721157ae682-6ea557c5a77mr560787b3.4.1730443519481; Thu, 31 Oct 2024
 23:45:19 -0700 (PDT)
Date: Fri,  1 Nov 2024 14:45:01 +0800
In-Reply-To: <20241101064505.3820737-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241101064505.3820737-3-davidgow@google.com>
Subject: [PATCH v4 2/3] rust: macros: add macro to easily run KUnit tests
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
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20241030045719.3085147-6-davidgow@g=
oogle.com/
- The #[kunit_tests()] macro now preserves span information, so
  errors can be better reported. (Thanks, Boqun!)
- The example test has been replaced to no longer use assert_eq!() with
  a constant bool argument (which triggered a clippy warning now we
  have the span info). It now checks 1 + 1 =3D=3D 2, to match the C example=
.
  - (The in_kunit_test() test in the next patch uses assert!() to check
    a bool, so having something different here seemed to make a better
    example.)

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
 rust/kernel/kunit.rs |  10 +++
 rust/macros/kunit.rs | 168 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++++
 4 files changed, 208 insertions(+)
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
index 85bc1faff0d5..71ce1d145be8 100644
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
@@ -273,3 +275,11 @@ macro_rules! kunit_unsafe_test_suite {
         };
     };
 }
+
+#[kunit_tests(rust_kernel_kunit)]
+mod tests {
+    #[test]
+    fn rust_test_kunit_example_test() {
+        assert_eq!(1 + 1, 2);
+    }
+}
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
new file mode 100644
index 000000000000..c421ff65f7f9
--- /dev/null
+++ b/rust/macros/kunit.rs
@@ -0,0 +1,168 @@
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
+    // Remove the `#[test]` macros.
+    // We do this at a token level, in order to preserve span information.
+    let mut new_body =3D vec![];
+    let mut body_it =3D body.stream().into_iter();
+
+    while let Some(token) =3D body_it.next() {
+        match token {
+            TokenTree::Punct(ref c) if c.as_char() =3D=3D '#' =3D> {
+                match body_it.next() {
+                    Some(TokenTree::Group(group)) if group.to_string() =3D=
=3D "[test]" =3D> (),
+                    Some(next) =3D> { new_body.extend([token, next]); },
+                    _ =3D> { new_body.push(token); },
+                }
+            },
+            _ =3D> { new_body.push(token); },
+        }
+    }
+
+    let mut new_body =3D TokenStream::from_iter(new_body);
+    new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
+
+    tokens.push(TokenTree::Group(Group::new(
+        Delimiter::Brace,
+        new_body
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
2.47.0.199.ga7371fff76-goog


