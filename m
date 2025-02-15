Return-Path: <linux-kselftest+bounces-26713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C4A36CC1
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 10:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4AF1895F52
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65FE1A262D;
	Sat, 15 Feb 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EF0k0G8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34131A2385
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610403; cv=none; b=DJ4giBLvyekBb5XQU2w+YULAM23iWtjo9dshkdsQvI17/KePAhSq8d9ma99GSN8lR4gPGHQVEKyQjNPj6hydCOAPph/dI9bpZf3YnmotFDo5VY9pKEozER+Mng6SFA1BpJYE5FLIl4lFwX77oRIIiduLJD6hIF4WnlnNnfAvXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610403; c=relaxed/simple;
	bh=Nbtx1ZZG8G7zpHKsLhRI5JfHcsoGpOWh6u+1onWJlzc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iOXhgtUi/hIijAgbQjZYVqS/CbvueLzXBS0l7yVGSAUitlhpoaXsc63+xphCI7pFtfrAWABAXs+HT1oCRfbPuBRRGfDTiMWdqBR3v7mlzyFJkrAdu78tinTBj5dX/z1zPKTPc5oMhYamvXahTvPVzCNCdJQCYk3fDa1sOxeDxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EF0k0G8r; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220f0382404so31102085ad.1
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 01:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610400; x=1740215200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZQS1//8LDuq5E99gzZTq+mP8zSK2QukTZe2LwXRVVI=;
        b=EF0k0G8rg4xi++VIPxZd6YX69oqtCQxUNTNKjDs7o2rhkr/i28q8n0JDEP+EB2DdTu
         SICgdOPOf7Z8Lzqx3GzZDVT23jQtmpzzCtogvr0FEU6K5GIwFOkHgSTkXK9PM4tcodVO
         YA+BRnsMzK6G/Vl5eDEwrFZRGdbndp7xb+TnKv8bdhe6FoNwV8YnF8KfKfO/YTPxtg7r
         NgMCSFH51f55Fy3PA1EDsWclhW5qQOPkX+1f6AMMnHspJLj5Ex/SlayaDezpmdEFZBvH
         l+GcieXL6GzTT6oOwhZAEx7ZI8VMDT5Hsju62qaTSF8yT8lt/U3jkHZnjzJhJ9v1U+U/
         Sx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610400; x=1740215200;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZQS1//8LDuq5E99gzZTq+mP8zSK2QukTZe2LwXRVVI=;
        b=L4WlfT8f2I3nwktsUGTgqnKiCixzkpUTPGmxeWq9rPyQsPJxmUdBitIWserPmcfUdQ
         tOFGV4KVd41z1spU20fKuojMDn3i4PIw8DXEfWCctUymHgGfu3CWv0/48EPZPajDqJB5
         Atm40X5JwmIXMmt7w54OZLql1umUHE0yI4mfkA+zZ6NC0pqzSicUTfWl4Lwsly1DtLow
         Vn2DDDyPlLDRibiNEicCEOhpfaugdlznL4wPGE6SACa6xDo62ZkVo5NorTshy8OgRytT
         P5YqvCAhzvXEuLWO/6tcALYvp4DSOzzAUCEXvSXxn6wNOpW4X3qH8V/iVnl69SGKqPoX
         eukw==
X-Forwarded-Encrypted: i=1; AJvYcCVazdb9IHjPPyI5WNIKHCEwInRitr9MYAxhKUCKMYvMjBL9Dx9MSishV4+nD97SGQMLflk/JAlTcWsehanu62k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4q5KXzT8fUeXT++NjVF95AmQi/FcnmYMIJboQPscT3KLCViJ
	ekyR/o7uH0E/arhEdOtkH2O1Y3qIaUt/eK5Bu0Flty/wtCVDXxzq/vyBKObj6DR+Y5a+GbqSupn
	T2cBOusTK+Q==
X-Google-Smtp-Source: AGHT+IHmQuuP8sHvg+8cVuSmaU83MYhNZBI7kGvCYKd0VfQryt/GZhhRmPZcConpYuh4c8yfjPhUocc+on2+3Q==
X-Received: from pgn7.prod.google.com ([2002:a63:d47:0:b0:ad5:52c1:c4dc])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68d:b0:220:efa7:7bd3 with SMTP id d9443c01a7336-221040c0838mr33342275ad.43.1739610400078;
 Sat, 15 Feb 2025 01:06:40 -0800 (PST)
Date: Sat, 15 Feb 2025 17:06:19 +0800
In-Reply-To: <20250215090622.2381038-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215090622.2381038-1-davidgow@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215090622.2381038-3-davidgow@google.com>
Subject: [PATCH v7 2/3] rust: macros: add macro to easily run KUnit tests
From: David Gow <davidgow@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, 
	"=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?=" <jose.exposito89@gmail.com>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Matt Gilbride <mattgilbride@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Tamir Duberstein <tamird@gmail.com>
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
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v6:
https://lore.kernel.org/rust-for-linux/20250214074051.1619256-3-davidgow@go=
ogle.com/
- Fixed an [allow(unused_unsafe)] which ended up in patch 2 instead of
  patch 1. (Thanks, Tamir!)
- Add Tamir's Reviewed-by tag.

Changes since v5:
https://lore.kernel.org/all/20241213081035.2069066-3-davidgow@google.com/
- Fix some rustfmt-related formatting shenanigans. (Thanks, Miguel)
- Fix some documentation comment formatting as well. (Thanks, Miguel)
- Tidy up the generated code to avoid unneeded &mut[] everywhere.
  (Thanks, Miguel)
- Fix a new clippy warning for using .as_bytes().len() instead of .len()
  directly.

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
 rust/kernel/kunit.rs |  11 +++
 rust/macros/kunit.rs | 161 +++++++++++++++++++++++++++++++++++++++++++
 rust/macros/lib.rs   |  29 ++++++++
 4 files changed, 202 insertions(+)
 create mode 100644 rust/macros/kunit.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d9e8187eb0..4e7a6d2f2c49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12677,6 +12677,7 @@ F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
 F:	rust/kernel/kunit.rs
+F:	rust/macros/kunit.rs
 F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
=20
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index ffb3606f748c..2131443a5f1e 100644
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
@@ -283,3 +285,12 @@ macro_rules! kunit_unsafe_test_suite {
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
index 000000000000..4f553ecf40c0
--- /dev/null
+++ b/rust/macros/kunit.rs
@@ -0,0 +1,161 @@
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
+    let attr =3D attr.to_string();
+
+    if attr.is_empty() {
+        panic!("Missing test name in `#[kunit_tests(test_name)]` macro")
+    }
+
+    if attr.len() > 255 {
+        panic!(
+            "The test suite name `{}` exceeds the maximum length of 255 by=
tes",
+            attr
+        )
+    }
+
+    let mut tokens: Vec<_> =3D ts.into_iter().collect();
+
+    // Scan for the `mod` keyword.
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
+        .expect("`#[kunit_tests(test_name)]` attribute should only be appl=
ied to modules");
+
+    // Retrieve the main body. The main body should be the last token tree=
.
+    let body =3D match tokens.pop() {
+        Some(TokenTree::Group(group)) if group.delimiter() =3D=3D Delimite=
r::Brace =3D> group,
+        _ =3D> panic!("Cannot locate main body of module"),
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
+    // }
+    // ```
+    //
+    // Looks like:
+    //
+    // ```
+    // unsafe extern "C" fn kunit_rust_wrapper_foo(_test: *mut kernel::bin=
dings::kunit) { foo(); }
+    // unsafe extern "C" fn kunit_rust_wrapper_bar(_test: *mut kernel::bin=
dings::kunit) { bar(); }
+    //
+    // static mut TEST_CASES: [kernel::bindings::kunit_case; 3] =3D [
+    //     kernel::kunit::kunit_case(kernel::c_str!("foo"), kunit_rust_wra=
pper_foo),
+    //     kernel::kunit::kunit_case(kernel::c_str!("bar"), kunit_rust_wra=
pper_bar),
+    //     kernel::kunit::kunit_case_null(),
+    // ];
+    //
+    // kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
+    // ```
+    let mut kunit_macros =3D "".to_owned();
+    let mut test_cases =3D "".to_owned();
+    for test in &tests {
+        let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{}", tes=
t);
+        let kunit_wrapper =3D format!(
+            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kunit=
) {{ {}(); }}",
+            kunit_wrapper_fn_name, test
+        );
+        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
+        writeln!(
+            test_cases,
+            "    kernel::kunit::kunit_case(kernel::c_str!(\"{}\"), {}),",
+            test, kunit_wrapper_fn_name
+        )
+        .unwrap();
+    }
+
+    writeln!(kunit_macros).unwrap();
+    writeln!(
+        kunit_macros,
+        "static mut TEST_CASES: [kernel::bindings::kunit_case; {}] =3D [\n=
{test_cases}    kernel::kunit::kunit_case_null(),\n];",
+        tests.len() + 1
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
+            TokenTree::Punct(ref c) if c.as_char() =3D=3D '#' =3D> match b=
ody_it.next() {
+                Some(TokenTree::Group(group)) if group.to_string() =3D=3D =
"[test]" =3D> (),
+                Some(next) =3D> {
+                    new_body.extend([token, next]);
+                }
+                _ =3D> {
+                    new_body.push(token);
+                }
+            },
+            _ =3D> {
+                new_body.push(token);
+            }
+        }
+    }
+
+    let mut new_body =3D TokenStream::from_iter(new_body);
+    new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
+
+    tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, new_body)));
+
+    tokens.into_iter().collect()
+}
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index d61bc6a56425..50b58259c577 100644
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
2.48.1.601.g30ceb7b040-goog


