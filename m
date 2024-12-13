Return-Path: <linux-kselftest+bounces-23302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78689F0611
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 09:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD99316506D
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80571AA7B4;
	Fri, 13 Dec 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfkoC/Ns"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAD1A8F87
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077454; cv=none; b=OsivTxoivHbQlqNwRloOwz9oDTNd+VeZPrTnV9A19LwA4SCVxTY90CeoDIZ/AnGTFnk96bYcX5uv8H5JcSjsBL8tNYc/E17DoIEgr358F/V5YjoBpkk0Kc4LIsiRRIEscqO77Eqy6/T9x7LBLfdKC6hh656ZUNM+66+M7TW+yMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077454; c=relaxed/simple;
	bh=7/nW0ckfgKpJRW919MG005R3p7WpMPh+JsAFJlKqdJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQhD/U0Vn1/em822tbE6wK5Ri9p5AF7+fvkYPS9udmxc89XN5zzaGdqB6rA3dBSlUzsDMRC51jGwOuzQM1XKLqK3M4DWhuWUPMRphnmgQcmie9zGcw8UR8o864/y+MMISE9RodcTWr1VeuA/sGB9osHJdc0zkbpOr44eS0AUBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfkoC/Ns; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ee3c2a2188so1160595a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 00:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734077452; x=1734682252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8EsYYrfTRnHJ854mShX5sHUQzRetRLmknKNMm7CO4o=;
        b=RfkoC/NsOwvjgKfgEWsXHi/pqhMK7TNrnoquBYjNjVq/z6i105w9p9/a7czNenw6x1
         0/yvbWDB3ohEIAis+EGVC0f+8GEyVOswHWxZDrfdGARNPeUA+FhIBMepsivUiAy/JDKS
         ZUx48AfJB39IcbREXlUgQYyCUQre5unvKlgXMZKTySHIYtyfLUNd5D34/jSbU/6Vi0nb
         StRgAAaaMgW9WyIu2IiRCxSmFt0JfHIQc0/K7vU4c77Ls3ZCn5bscM/1/221/V7eUcVA
         Yx4sBVMdZiKDet0ees3kcy5T0N9QBfsdAsdvF0w/LgZOiL0Hybcmc6hBJRh/Gi4nLXVz
         MYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734077452; x=1734682252;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8EsYYrfTRnHJ854mShX5sHUQzRetRLmknKNMm7CO4o=;
        b=j/P6If0RwAKq4QqBRjmkxzWtwEYQghbDXuM6u/ikEZxgvf6jcH1nEy3ZtcvVXDIlK8
         XhblWe7K6fU60NPyhf96HtegBRe9WpnFzMhRwDnqYdQN5tLCEu5mSLyVl7ppTo6EYhvM
         TvJDb+HPomfGOxOM8usNtyA0tdHCirXWQ+s5SavEMjND4wsDAeWOSf94Y763sJuPY168
         SNuwZC3e6RUIP5smHHPq8TwEh94prKzfrPS4VEpQR30EkzBhGp7pkQg7/Z2i5Lk7Pb+w
         RqQsAUCbKbuFCvgNfVeZpX1v9LzJkvNv27rU+N49OP0Z+o/+mGldDqv10kdB9jz4hMfP
         3HQw==
X-Forwarded-Encrypted: i=1; AJvYcCVA5NTFX9cpmEYwo7BBruXNLeZP/5+BmkwivgHEJi3TQdpjGyZgyT64MdR8/ffR2qWHs3UrxgbtZjHT8WShxn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5zpo/ahW6X4oLPQJGnb8qKnMjF0kNNwMOpaqV+u40R3TlTZs
	plJHQcY5Ixse50wuipjFK4mzfHxoa1bE8+BWMqbVQ0tyh3boOPaJydrKDPUWiCgu842681/JDUi
	WyMm4TXl7ng==
X-Google-Smtp-Source: AGHT+IE4RG7hSV/cz72bXiXtWdIby/pWoMf5BmapVhhbDHIU0hrQVgg+nN9QGWLHgEq4UDHHiuUYijsgmssyvw==
X-Received: from pfud22.prod.google.com ([2002:a05:6a00:10d6:b0:725:eb13:8be8])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da1:b0:1e1:a48f:1246 with SMTP id adf61e73a8af0-1e1dfe6170dmr2191944637.45.1734077452231;
 Fri, 13 Dec 2024 00:10:52 -0800 (PST)
Date: Fri, 13 Dec 2024 16:10:31 +0800
In-Reply-To: <20241213081035.2069066-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213081035.2069066-3-davidgow@google.com>
Subject: [PATCH v5 2/3] rust: macros: add macro to easily run KUnit tests
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
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
Changes since v4:
https://lore.kernel.org/linux-kselftest/20241101064505.3820737-3-davidgow@g=
oogle.com/
- Rebased against 6.13-rc1
- "Expect" that the sample assert_eq!(1+1, 2) produces a clippy warning
  due to a redundant assertion. (Thanks Boqun, Miguel)

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
 rust/kernel/kunit.rs |  16 ++++-
 rust/macros/kunit.rs | 168 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++++
 4 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 rust/macros/kunit.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index e6e71b05710b..cbe5a99eefea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12562,6 +12562,7 @@ F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
 F:	rust/kernel/kunit.rs
+F:	rust/macros/kunit.rs
 F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
=20
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 5003282cb4c4..a92f12da77d5 100644
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
@@ -272,10 +274,22 @@ macro_rules! kunit_unsafe_test_suite {
                 };
=20
             #[used]
+            #[allow(unused_unsafe)]
             #[link_section =3D ".kunit_test_suites"]
             static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::ku=
nit_suite =3D
                 // SAFETY: `KUNIT_TEST_SUITE` is static.
-                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
+                unsafe {
+                    core::ptr::addr_of_mut!(KUNIT_TEST_SUITE)
+                };
         };
     };
 }
+
+#[kunit_tests(rust_kernel_kunit)]
+mod tests {
+    #[test]
+    fn rust_test_kunit_example_test() {
+        #![expect(clippy::eq_op)]
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
index 4ab94e44adfe..beff19cc6d16 100644
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
@@ -492,3 +493,31 @@ pub fn paste(input: TokenStream) -> TokenStream {
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
2.47.1.613.gc27f4b7a9f-goog


