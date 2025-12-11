Return-Path: <linux-kselftest+bounces-47455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE4CB7036
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8703C303D9CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF50731A7F9;
	Thu, 11 Dec 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4CoQLAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352731A7F4;
	Thu, 11 Dec 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481410; cv=none; b=A10W5xFr3Uumh0KP6VOdkKshralMCljrCZBqmOXoHS0tgOnJPlmo6N3FwZHPMwRCO5c7QQNTpRoy1V63LQGqyH6z333vMpAg0Oz72WqQoa5o58zkdDyBAEhTEWSAlkVEA28nwTGfd52H0XWNnpF++qsEwOTGaVx3tlxiRfj0TD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481410; c=relaxed/simple;
	bh=+8UDMTVpXv4V3aqN0jm/bB5z/livoJ6O+/afgFDPaAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UohGJrQiu3pEiNfCPYTwX593lXAea0YkjRCT5ukHpxUZcaH510/hkIDr40AjLnzpl11NgyS/qNhxWb/mkhxLifS/N0pxUZ2sY/qQb86MNBF/HUYKN4YTOEIXAHxDfG1PKiXopXVotrX32hlOnmG2OpqVSI2JpEt6H5RYBWvnvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4CoQLAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D66EC4CEF7;
	Thu, 11 Dec 2025 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765481410;
	bh=+8UDMTVpXv4V3aqN0jm/bB5z/livoJ6O+/afgFDPaAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=l4CoQLAV7pVveaE3t7gEec12xjpSeH9s4RWqf8T2fFh1x5Lcy6OkjeIr6Ltd8h/D7
	 KjqXtkkp9zVyWdRPoT4uhH9//aUPV1dvUYpMrlp8ZQE2XCvjXwxdhWxFknN5puMYQy
	 aF96wu9+GYGBc4hKVINHo/MIaILzSwLvrpV4XVEDM1vTE6UHn5cJK8NW0Ph2RtfoRb
	 EHQ+TC1BiftUPSdRhPabgLIONKmv7xNKUSvC2bjV/ptWfmyNywHbSR+kWmppTnLuWt
	 1kCr0W3hRczh0jDRcTX7Yp28flH50WvTvTBgzEiEPDYhmavo2j1WSn/mnWRfcO89GH
	 qfVIX6nnnu11A==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <raemoar63@gmail.com>,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	Patrick Miller <paddymills@proton.me>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Tamir Duberstein <tamird@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] rust: macros: convert `#[kunit_tests]` macro to use `syn`
Date: Thu, 11 Dec 2025 18:56:48 +0000
Message-ID: <20251211185805.2835633-9-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251211185805.2835633-1-gary@kernel.org>
References: <20251211185805.2835633-1-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This allows significant cleanups.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/kunit.rs | 274 +++++++++++++++++++------------------------
 rust/macros/lib.rs   |   6 +-
 2 files changed, 123 insertions(+), 157 deletions(-)

diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 7427c17ee5f5c..516219f5b1356 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -4,81 +4,50 @@
 //!
 //! Copyright (c) 2023 José Expósito <jose.exposito89@gmail.com>
 
-use std::collections::HashMap;
-use std::fmt::Write;
-
-use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
-
-pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
-    let attr = attr.to_string();
-
-    if attr.is_empty() {
-        panic!("Missing test name in `#[kunit_tests(test_name)]` macro")
-    }
-
-    if attr.len() > 255 {
-        panic!("The test suite name `{attr}` exceeds the maximum length of 255 bytes")
+use std::ffi::CString;
+
+use proc_macro2::TokenStream;
+use quote::{
+    format_ident,
+    quote,
+    ToTokens, //
+};
+use syn::{
+    parse_quote,
+    Error,
+    Ident,
+    Item,
+    ItemMod,
+    LitCStr,
+    Result, //
+};
+
+pub(crate) fn kunit_tests(test_suite: Ident, mut module: ItemMod) -> Result<TokenStream> {
+    if test_suite.to_string().len() > 255 {
+        return Err(Error::new_spanned(
+            test_suite,
+            "test suite names cannot exceed the maximum length of 255 bytes",
+        ));
     }
 
-    let mut tokens: Vec<_> = ts.into_iter().collect();
-
-    // Scan for the `mod` keyword.
-    tokens
-        .iter()
-        .find_map(|token| match token {
-            TokenTree::Ident(ident) => match ident.to_string().as_str() {
-                "mod" => Some(true),
-                _ => None,
-            },
-            _ => None,
-        })
-        .expect("`#[kunit_tests(test_name)]` attribute should only be applied to modules");
-
-    // Retrieve the main body. The main body should be the last token tree.
-    let body = match tokens.pop() {
-        Some(TokenTree::Group(group)) if group.delimiter() == Delimiter::Brace => group,
-        _ => panic!("Cannot locate main body of module"),
+    // We cannot handle modules that defer to another file (e.g. `mod foo;`).
+    let Some((module_brace, module_items)) = module.content.take() else {
+        Err(Error::new_spanned(
+            module,
+            "`#[kunit_tests(test_name)]` attribute should only be applied to inline modules",
+        ))?
     };
 
-    // Get the functions set as tests. Search for `[test]` -> `fn`.
-    let mut body_it = body.stream().into_iter();
-    let mut tests = Vec::new();
-    let mut attributes: HashMap<String, TokenStream> = HashMap::new();
-    while let Some(token) = body_it.next() {
-        match token {
-            TokenTree::Punct(ref p) if p.as_char() == '#' => match body_it.next() {
-                Some(TokenTree::Group(g)) if g.delimiter() == Delimiter::Bracket => {
-                    if let Some(TokenTree::Ident(name)) = g.stream().into_iter().next() {
-                        // Collect attributes because we need to find which are tests. We also
-                        // need to copy `cfg` attributes so tests can be conditionally enabled.
-                        attributes
-                            .entry(name.to_string())
-                            .or_default()
-                            .extend([token, TokenTree::Group(g)]);
-                    }
-                    continue;
-                }
-                _ => (),
-            },
-            TokenTree::Ident(i) if i.to_string() == "fn" && attributes.contains_key("test") => {
-                if let Some(TokenTree::Ident(test_name)) = body_it.next() {
-                    tests.push((test_name, attributes.remove("cfg").unwrap_or_default()))
-                }
-            }
-
-            _ => (),
-        }
-        attributes.clear();
-    }
+    // Make the entire module gated behind `CONFIG_KUNIT`.
+    module
+        .attrs
+        .insert(0, parse_quote!(#[cfg(CONFIG_KUNIT="y")]));
 
-    // Add `#[cfg(CONFIG_KUNIT="y")]` before the module declaration.
-    let config_kunit = "#[cfg(CONFIG_KUNIT=\"y\")]".to_owned().parse().unwrap();
-    tokens.insert(
-        0,
-        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
-    );
+    let mut processed_items = Vec::new();
+    let mut test_cases = Vec::new();
 
     // Generate the test KUnit test suite and a test case for each `#[test]`.
+    //
     // The code generated for the following test module:
     //
     // ```
@@ -110,98 +79,93 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     //
     // ::kernel::kunit_unsafe_test_suite!(kunit_test_suit_name, TEST_CASES);
     // ```
-    let mut kunit_macros = "".to_owned();
-    let mut test_cases = "".to_owned();
-    let mut assert_macros = "".to_owned();
-    let path = crate::helpers::file();
-    let num_tests = tests.len();
-    for (test, cfg_attr) in tests {
-        let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{test}");
-        // Append any `cfg` attributes the user might have written on their tests so we don't
-        // attempt to call them when they are `cfg`'d out. An extra `use` is used here to reduce
-        // the length of the assert message.
-        let kunit_wrapper = format!(
-            r#"unsafe extern "C" fn {kunit_wrapper_fn_name}(_test: *mut ::kernel::bindings::kunit)
-            {{
-                (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SKIPPED;
-                {cfg_attr} {{
-                    (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SUCCESS;
-                    use ::kernel::kunit::is_test_result_ok;
-                    assert!(is_test_result_ok({test}()));
+    //
+    // Non-function items (e.g. imports) are preserved.
+    for item in module_items {
+        let Item::Fn(mut f) = item else {
+            processed_items.push(item);
+            continue;
+        };
+
+        // TODO: Replace below with `extract_if` when MSRV is bumped above 1.85.
+        // Remove `#[test]` attributes applied on the function and count if any.
+        if !f.attrs.iter().any(|attr| attr.path().is_ident("test")) {
+            processed_items.push(Item::Fn(f));
+            continue;
+        }
+        f.attrs.retain(|attr| !attr.path().is_ident("test"));
+
+        let test = f.sig.ident.clone();
+
+        // Retrieve `#[cfg]` applied on the function which needs to be present on derived items too.
+        let cfg_attrs: Vec<_> = f
+            .attrs
+            .iter()
+            .filter(|attr| attr.path().is_ident("cfg"))
+            .cloned()
+            .collect();
+
+        // Before the test, override usual `assert!` and `assert_eq!` macros with ones that call
+        // KUnit instead.
+        let test_str = test.to_string();
+        let path = crate::helpers::file();
+        processed_items.push(parse_quote! {
+            #[allow(unused)]
+            macro_rules! assert {
+                ($cond:expr $(,)?) => {{
+                    kernel::kunit_assert!(#test_str, #path, 0, $cond);
+                }}
+            }
+        });
+        processed_items.push(parse_quote! {
+            #[allow(unused)]
+            macro_rules! assert_eq {
+                ($left:expr, $right:expr $(,)?) => {{
+                    kernel::kunit_assert_eq!(#test_str, #path, 0, $left, $right);
                 }}
-            }}"#,
+            }
+        });
+
+        // Add back the test item.
+        processed_items.push(Item::Fn(f));
+
+        let kunit_wrapper_fn_name = format_ident!("kunit_rust_wrapper_{test}");
+        let test_cstr = LitCStr::new(
+            &CString::new(test_str.as_str()).expect("identifier cannot contain NUL"),
+            test.span(),
         );
-        writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
-        writeln!(
-            test_cases,
-            "    ::kernel::kunit::kunit_case(::kernel::c_str!(\"{test}\"), {kunit_wrapper_fn_name}),"
-        )
-        .unwrap();
-        writeln!(
-            assert_macros,
-            r#"
-/// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
-#[allow(unused)]
-macro_rules! assert {{
-    ($cond:expr $(,)?) => {{{{
-        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
-    }}}}
-}}
-
-/// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
-#[allow(unused)]
-macro_rules! assert_eq {{
-    ($left:expr, $right:expr $(,)?) => {{{{
-        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
-    }}}}
-}}
-        "#
-        )
-        .unwrap();
-    }
+        processed_items.push(parse_quote! {
+            unsafe extern "C" fn #kunit_wrapper_fn_name(_test: *mut ::kernel::bindings::kunit) {
+                (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SKIPPED;
 
-    writeln!(kunit_macros).unwrap();
-    writeln!(
-        kunit_macros,
-        "static mut TEST_CASES: [::kernel::bindings::kunit_case; {}] = [\n{test_cases}    ::kernel::kunit::kunit_case_null(),\n];",
-        num_tests + 1
-    )
-    .unwrap();
-
-    writeln!(
-        kunit_macros,
-        "::kernel::kunit_unsafe_test_suite!({attr}, TEST_CASES);"
-    )
-    .unwrap();
-
-    // Remove the `#[test]` macros.
-    // We do this at a token level, in order to preserve span information.
-    let mut new_body = vec![];
-    let mut body_it = body.stream().into_iter();
-
-    while let Some(token) = body_it.next() {
-        match token {
-            TokenTree::Punct(ref c) if c.as_char() == '#' => match body_it.next() {
-                Some(TokenTree::Group(group)) if group.to_string() == "[test]" => (),
-                Some(next) => {
-                    new_body.extend([token, next]);
-                }
-                _ => {
-                    new_body.push(token);
+                // Append any `cfg` attributes the user might have written on their tests so we
+                // don't attempt to call them when they are `cfg`'d out. An extra `use` is used
+                // here to reduce the length of the assert message.
+                #(#cfg_attrs)*
+                {
+                    (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SUCCESS;
+                    use ::kernel::kunit::is_test_result_ok;
+                    assert!(is_test_result_ok(#test()));
                 }
-            },
-            _ => {
-                new_body.push(token);
             }
-        }
-    }
-
-    let mut final_body = TokenStream::new();
-    final_body.extend::<TokenStream>(assert_macros.parse().unwrap());
-    final_body.extend(new_body);
-    final_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
+        });
 
-    tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, final_body)));
+        test_cases.push(quote!(
+            ::kernel::kunit::kunit_case(#test_cstr, #kunit_wrapper_fn_name)
+        ));
+    }
 
-    tokens.into_iter().collect()
+    let num_tests_plus_1 = test_cases.len() + 1;
+    processed_items.push(parse_quote! {
+        static mut TEST_CASES: [::kernel::bindings::kunit_case; #num_tests_plus_1] = [
+            #(#test_cases,)*
+            ::kernel::kunit::kunit_case_null(),
+        ];
+    });
+    processed_items.push(parse_quote! {
+        ::kernel::kunit_unsafe_test_suite!(#test_suite, TEST_CASES);
+    });
+
+    module.content = Some((module_brace, processed_items));
+    Ok(module.to_token_stream())
 }
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index bb2dfd4a4dafc..9cfac9fce0d36 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -453,6 +453,8 @@ pub fn paste(input: TokenStream) -> TokenStream {
 /// }
 /// ```
 #[proc_macro_attribute]
-pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
-    kunit::kunit_tests(attr.into(), ts.into()).into()
+pub fn kunit_tests(attr: TokenStream, input: TokenStream) -> TokenStream {
+    kunit::kunit_tests(parse_macro_input!(attr), parse_macro_input!(input))
+        .unwrap_or_else(|e| e.into_compile_error())
+        .into()
 }
-- 
2.51.2


