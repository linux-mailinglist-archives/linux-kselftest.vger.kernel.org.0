Return-Path: <linux-kselftest+bounces-42935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CDBC9F3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 502D73549CD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17402F0C6C;
	Thu,  9 Oct 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGfWLkcz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38342ED843;
	Thu,  9 Oct 2025 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025531; cv=none; b=VTnU7aggNUcD6LTbF6RxRqjsS09Y6HyxbQzd1JJpjb81LSxZ9fI3tR+GcdQLOyRKqBehlhLNycASufUGisGaP/pOeQG4gK4xJv6WPZaHRN/5NHzImMKfZbTVx+WQAiQGVtRP3qHdt7xzZnfSoiYFGzfGZo32QdXLJiUszF27UFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025531; c=relaxed/simple;
	bh=cWfVExySnxg9HveIFDJ5+KXFgjKH4j/0JNkeqQkZ+4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfnHkFW+NfF9gjlMvHrpFQGz9OP2aFFxnqu5uoUHru32Cg0+F6Unkliw/PHerTqJJQfmzujL7aXxUZp96MA0oZM7SPHOYQGIxzx91sZg+9ljt8//guyWNPbCLHGQQOTpDt2AR06IaQ6fbInAjDLc1l+9KXG0dmYWuGPiSutH2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGfWLkcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52425C4CEE7;
	Thu,  9 Oct 2025 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025531;
	bh=cWfVExySnxg9HveIFDJ5+KXFgjKH4j/0JNkeqQkZ+4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGfWLkczKgq0uPQeq+LHAi839mJ8de+3Bf4laRrDURJwec87Nyk7LP6sb0KhNjSkx
	 3+CWb0P7b1dXz8BqABwYlAiSJU+hgueQIpZmBSeYnb5wM68G/oiaf8XSGsfctMeBsi
	 1Glv2yrLgHxjaCXrJj1dhdBHuNFymhKxyGGb362UL5G6zmJy5Bm7UIVUPQ+zlsPw8j
	 o6ZLuD3uwaF4Y7fb0PNxj2AJaSUfomABjswe6wORTAV/1ugCG+F2LsjYkX0PxGwX5x
	 ZBEX3u0IwACU5MenKNBAF/Hgdr2T/fMCcYvdkVcsuPVhA4z81fY+TQLXkDBQAbS57n
	 BfOpJlLkuD+8A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaibo Ma <ent3rm4n@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	alex.gaynor@gmail.com,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.16] rust: kunit: allow `cfg` on `test`s
Date: Thu,  9 Oct 2025 11:54:58 -0400
Message-ID: <20251009155752.773732-32-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaibo Ma <ent3rm4n@gmail.com>

[ Upstream commit c652dc44192d96820d73a7ecd89d275ca7e4355d ]

The `kunit_test` proc macro only checks for the `test` attribute
immediately preceding a `fn`. If the function is disabled via a `cfg`,
the generated code would result in a compile error referencing a
non-existent function [1].

This collects attributes and specifically cherry-picks `cfg` attributes
to be duplicated inside KUnit wrapper functions such that a test function
disabled via `cfg` compiles and is marked as skipped in KUnit correctly.

Link: https://lore.kernel.org/r/20250916021259.115578-1-ent3rm4n@gmail.com
Link: https://lore.kernel.org/rust-for-linux/CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com/ [1]
Closes: https://github.com/Rust-for-Linux/linux/issues/1185
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Suggested-by: David Gow <davidgow@google.com>
Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- User-visible bug fixed. Without this change, a Rust KUnit test
  function annotated with a cfg which disables the function causes a
  compile error because the generated wrapper still references a non-
  existent function. In v6.17, the macro only looks for a “[test]”
  immediately followed by “fn” and blindly emits a wrapper which calls
  the function (see rust/macros/kunit.rs:1-80 and
  rust/macros/kunit.rs:112-132 in v6.17). The tree itself even carries a
  workaround comment noting “Kunit #[test]s do not support `cfg` yet”
  and gates inside the function body instead of on the attribute
  (rust/kernel/bitmap.rs:554-569).

- Small, contained fix in the Rust KUnit macro. The patch augments only
  the KUnit proc-macro and sample tests:
  - Attribute collection: It now collects consecutive attributes and
    tracks them by name, specifically picking up “cfg” next to “test” so
    it can be reused (rust/macros/kunit.rs:42-71). This makes test
    detection tolerant to attribute ordering while still requiring a
    “test” attribute.
  - Wrapper guarding + skip semantics: The generated wrapper sets the
    test status to SKIPPED by default, then encloses the test call
    inside the copied cfg-guard. If the cfg disables the test, the
    guarded block is not compiled and the wrapper reports SKIPPED;
    otherwise it sets SUCCESS and runs the test, with failures correctly
    recorded via KUnit’s assert mapping (rust/macros/kunit.rs:116-133).
    The array size computation is slightly refactored but functionally
    identical (rust/macros/kunit.rs:162-168).
  - A disabled example test is added to validate the behavior
    (rust/kernel/kunit.rs:365-371).

- No architectural or ABI changes; limited blast radius.
  - This affects only the Rust KUnit test infrastructure and is active
    only when KUnit is enabled: the module is `#[cfg(CONFIG_KUNIT="y")]`
    (rust/macros/kunit.rs:73-78).
  - Production kernels without KUnit are unaffected. Runtime code paths
    are unchanged; only test wrappers and macro expansion change.

- Correctness and behavior details.
  - The new wrapper’s pre-set status to SUCCESS before the assert is
    benign: KUnit assert macros report failures and abort the test,
    overriding status (see kunit_assert! and related handling in
    rust/kernel/kunit.rs:55-151). When cfg is false, the function symbol
    is not referenced because the guarded block is not compiled,
    avoiding the previous compile error entirely.
  - Only cfg attributes are duplicated into the wrapper, leaving other
    attributes intact on the original function; the macro still strips
    only the #[test] attribute from the function body
    (rust/macros/kunit.rs:176-195).

- Stable backport considerations.
  - Clean backport target: v6.17.y and newer. v6.17 already has KUnit’s
    Rust assert mapping and the `is_test_result_ok()` plumbing that this
    wrapper uses (rust/macros/kunit.rs:112-156 in v6.17;
    rust/kernel/kunit.rs:169-192). The patch slots in cleanly there.
  - Older stable series (e.g., v6.15.y/v6.16.y) use an earlier version
    of the macro (e.g., rust/macros/kunit.rs in v6.15) lacking assert
    mapping and absolute paths. Backporting to those would require
    additional prerequisite commits (“use absolute paths in macros
    referencing core and kernel”, KUnit assert mapping, and Result
    support). Without those prerequisites, this patch won’t apply or
    compile as-is. For those older trees, either adapt the patch to that
    macro baseline or avoid backporting.
  - No explicit “Cc: stable@vger.kernel.org” in the commit, but this is
    a low-risk build fix for KUnit/Rust that prevents compile errors and
    reports disabled tests correctly as SKIPPED. It aligns with stable
    policies for important, contained fixes in test infrastructure.

- Risk assessment.
  - Low regression risk: confined to test macro expansion with KUnit
    enabled; no impact on production code paths.
  - Attribute scanning remains conservative: it still requires a #[test]
    attribute and does not broaden test discovery beyond that. It only
    improves tolerance to preceding attributes and adds cfg duplication
    for correctness.

Given the above, this is a good candidate for backporting to stable
trees which already contain the modern Rust KUnit macro (notably
v6.17.y+).

 rust/kernel/kunit.rs |  7 +++++++
 rust/macros/kunit.rs | 48 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd87595d6e..32640dfc968fe 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -357,4 +357,11 @@ fn rust_test_kunit_example_test() {
     fn rust_test_kunit_in_kunit_test() {
         assert!(in_kunit_test());
     }
+
+    #[test]
+    #[cfg(not(all()))]
+    fn rust_test_kunit_always_disabled_test() {
+        // This test should never run because of the `cfg`.
+        assert!(false);
+    }
 }
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 81d18149a0cc9..b395bb0536959 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -5,6 +5,7 @@
 //! Copyright (c) 2023 José Expósito <jose.exposito89@gmail.com>
 
 use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
+use std::collections::HashMap;
 use std::fmt::Write;
 
 pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
@@ -41,20 +42,32 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // Get the functions set as tests. Search for `[test]` -> `fn`.
     let mut body_it = body.stream().into_iter();
     let mut tests = Vec::new();
+    let mut attributes: HashMap<String, TokenStream> = HashMap::new();
     while let Some(token) = body_it.next() {
         match token {
-            TokenTree::Group(ident) if ident.to_string() == "[test]" => match body_it.next() {
-                Some(TokenTree::Ident(ident)) if ident.to_string() == "fn" => {
-                    let test_name = match body_it.next() {
-                        Some(TokenTree::Ident(ident)) => ident.to_string(),
-                        _ => continue,
-                    };
-                    tests.push(test_name);
+            TokenTree::Punct(ref p) if p.as_char() == '#' => match body_it.next() {
+                Some(TokenTree::Group(g)) if g.delimiter() == Delimiter::Bracket => {
+                    if let Some(TokenTree::Ident(name)) = g.stream().into_iter().next() {
+                        // Collect attributes because we need to find which are tests. We also
+                        // need to copy `cfg` attributes so tests can be conditionally enabled.
+                        attributes
+                            .entry(name.to_string())
+                            .or_default()
+                            .extend([token, TokenTree::Group(g)]);
+                    }
+                    continue;
                 }
-                _ => continue,
+                _ => (),
             },
+            TokenTree::Ident(i) if i.to_string() == "fn" && attributes.contains_key("test") => {
+                if let Some(TokenTree::Ident(test_name)) = body_it.next() {
+                    tests.push((test_name, attributes.remove("cfg").unwrap_or_default()))
+                }
+            }
+
             _ => (),
         }
+        attributes.clear();
     }
 
     // Add `#[cfg(CONFIG_KUNIT="y")]` before the module declaration.
@@ -100,11 +113,22 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     let mut test_cases = "".to_owned();
     let mut assert_macros = "".to_owned();
     let path = crate::helpers::file();
-    for test in &tests {
+    let num_tests = tests.len();
+    for (test, cfg_attr) in tests {
         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{test}");
-        // An extra `use` is used here to reduce the length of the message.
+        // Append any `cfg` attributes the user might have written on their tests so we don't
+        // attempt to call them when they are `cfg`'d out. An extra `use` is used here to reduce
+        // the length of the assert message.
         let kunit_wrapper = format!(
-            "unsafe extern \"C\" fn {kunit_wrapper_fn_name}(_test: *mut ::kernel::bindings::kunit) {{ use ::kernel::kunit::is_test_result_ok; assert!(is_test_result_ok({test}())); }}",
+            r#"unsafe extern "C" fn {kunit_wrapper_fn_name}(_test: *mut ::kernel::bindings::kunit)
+            {{
+                (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SKIPPED;
+                {cfg_attr} {{
+                    (*_test).status = ::kernel::bindings::kunit_status_KUNIT_SUCCESS;
+                    use ::kernel::kunit::is_test_result_ok;
+                    assert!(is_test_result_ok({test}()));
+                }}
+            }}"#,
         );
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
@@ -139,7 +163,7 @@ macro_rules! assert_eq {{
     writeln!(
         kunit_macros,
         "static mut TEST_CASES: [::kernel::bindings::kunit_case; {}] = [\n{test_cases}    ::kernel::kunit::kunit_case_null(),\n];",
-        tests.len() + 1
+        num_tests + 1
     )
     .unwrap();
 
-- 
2.51.0


