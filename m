Return-Path: <linux-kselftest+bounces-32230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9A4AA7B95
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DB24A8576
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B321C170;
	Fri,  2 May 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzkTLYHI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924D2153DA;
	Fri,  2 May 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746222713; cv=none; b=osVcbt7VM1fDkm28Y5lx7YgMHUwuRFFSjK0np09KwtQoWgBBjHH9s20CR1j8dKhDaWQyZMAUDNafkZm6RdddSYxa+bPseabnTyZHe9a29S3HM8gP+X1bvZjkmRunrm0v+FHHRJT+0TuPRg54V5Rj3yzDgGjG8vNNVNmpAr62g6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746222713; c=relaxed/simple;
	bh=1ROB2ECqCRMXxG3uU2grTJzFUCgEFG5F5Pl5x/9OCXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNHjudJkNTi0nn6oA5cf3hn6HLyJ+xNO6mRdabEXSXnJ18kzFMjMvktcQUu3c7LgGsYG4tlrEnh7PzWCYoy9VhVfQbZ343By85PevNAgsF3WS2peWN7VA3VCTXnpvaU8X0ObRo5LTsqYouC6S4b9harrMZluCkgg/b1ZrnUvB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzkTLYHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B17C4CEED;
	Fri,  2 May 2025 21:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746222712;
	bh=1ROB2ECqCRMXxG3uU2grTJzFUCgEFG5F5Pl5x/9OCXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzkTLYHIlDTRDuzSCnMkf9TZ4FjHbGasKauKRDGMDCDs8lidZ4exNJnYZCZKocCBT
	 WrP/TRRpCHeB4WY1roIYZw4/LrDM3k9iW8qn65hNKq2Ui7hTk1sRsRQaLnCchUo3KD
	 EYLWJRzJEbc6Gu38ELyMiZzBVsHJEUBe5GDaFVWJZVsGJEWX4+f9EhNDNhMNwzgSVS
	 JZAHeRHipJXZ+iol9DUO+6Q3tNTvWTP2LbuwyOPtvJyIuHcP6bxG/FCLWZ0++hbc2S
	 M/sXaadcXQL8RBUMKne/agJVYy9EzyrxjvB4ThFGAmRAikScgGbReTvcP7IUtNPFkG
	 U8lcAPsIjcv3A==
From: Miguel Ojeda <ojeda@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 1/7] rust: kunit: support KUnit-mapped `assert!` macros in `#[test]`s
Date: Fri,  2 May 2025 23:51:26 +0200
Message-ID: <20250502215133.1923676-2-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-1-ojeda@kernel.org>
References: <20250502215133.1923676-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KUnit `#[test]` support that landed recently is very basic and does
not map the `assert*!` macros into KUnit like the doctests do, so they
panic at the moment.

Thus implement the custom mapping in a similar way to doctests, reusing
the infrastructure there.

In Rust 1.88.0, the `file()` method in `Span` may be stable [1]. However,
it was changed recently (from `SourceFile`), so we need to do something
different in previous versions. Thus create a helper for it and use it
to get the path.

With this, a failing test suite like:

    #[kunit_tests(my_test_suite)]
    mod tests {
        use super::*;

        #[test]
        fn my_first_test() {
            assert_eq!(42, 43);
        }

        #[test]
        fn my_second_test() {
            assert!(42 >= 43);
        }
    }

will properly map back to KUnit, printing something like:

    [    1.924325]     KTAP version 1
    [    1.924421]     # Subtest: my_test_suite
    [    1.924506]     # speed: normal
    [    1.924525]     1..2
    [    1.926385]     # my_first_test: ASSERTION FAILED at rust/kernel/lib.rs:251
    [    1.926385]     Expected 42 == 43 to be true, but is false
    [    1.928026]     # my_first_test.speed: normal
    [    1.928075]     not ok 1 my_first_test
    [    1.928723]     # my_second_test: ASSERTION FAILED at rust/kernel/lib.rs:256
    [    1.928723]     Expected 42 >= 43 to be true, but is false
    [    1.929834]     # my_second_test.speed: normal
    [    1.929868]     not ok 2 my_second_test
    [    1.930032] # my_test_suite: pass:0 fail:2 skip:0 total:2
    [    1.930153] # Totals: pass:0 fail:2 skip:0 total

Link: https://github.com/rust-lang/rust/pull/140514 [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig           |  3 +++
 rust/Makefile          |  3 ++-
 rust/kernel/kunit.rs   |  1 -
 rust/macros/helpers.rs | 16 ++++++++++++++++
 rust/macros/kunit.rs   | 28 +++++++++++++++++++++++++++-
 rust/macros/lib.rs     |  4 ++++
 6 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 63f5974b9fa6..5f442c64c47b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -140,6 +140,9 @@ config LD_CAN_USE_KEEP_IN_OVERLAY
 config RUSTC_HAS_COERCE_POINTEE
 	def_bool RUSTC_VERSION >= 108400
 
+config RUSTC_HAS_SPAN_FILE
+	def_bool RUSTC_VERSION >= 108800
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/rust/Makefile b/rust/Makefile
index 3aca903a7d08..075b38a24997 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -402,7 +402,8 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
 		--crate-type proc-macro \
-		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) $<
+		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
+		@$(objtree)/include/generated/rustc_cfg $<
 
 # Procedural macros can only be used with the `rustc` that compiled it.
 $(obj)/$(libmacros_name): $(src)/macros/lib.rs FORCE
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 1604fb6a5b1b..2659895d4c5d 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -323,7 +323,6 @@ mod tests {
 
     #[test]
     fn rust_test_kunit_example_test() {
-        #![expect(clippy::eq_op)]
         assert_eq!(1 + 1, 2);
     }
 
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index a3ee27e29a6f..57c3b0f0c194 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -86,3 +86,19 @@ pub(crate) fn function_name(input: TokenStream) -> Option<Ident> {
     }
     None
 }
+
+pub(crate) fn file() -> String {
+    #[cfg(not(CONFIG_RUSTC_HAS_SPAN_FILE))]
+    {
+        proc_macro::Span::call_site()
+            .source_file()
+            .path()
+            .to_string_lossy()
+            .into_owned()
+    }
+
+    #[cfg(CONFIG_RUSTC_HAS_SPAN_FILE)]
+    {
+        proc_macro::Span::call_site().file()
+    }
+}
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index 4f553ecf40c0..eb4f2afdbe43 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -101,6 +101,8 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     // ```
     let mut kunit_macros = "".to_owned();
     let mut test_cases = "".to_owned();
+    let mut assert_macros = "".to_owned();
+    let path = crate::helpers::file();
     for test in &tests {
         let kunit_wrapper_fn_name = format!("kunit_rust_wrapper_{}", test);
         let kunit_wrapper = format!(
@@ -114,6 +116,27 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
             test, kunit_wrapper_fn_name
         )
         .unwrap();
+        writeln!(
+            assert_macros,
+            r#"
+/// Overrides the usual [`assert!`] macro with one that calls KUnit instead.
+#[allow(unused)]
+macro_rules! assert {{
+    ($cond:expr $(,)?) => {{{{
+        kernel::kunit_assert!("{test}", "{path}", 0, $cond);
+    }}}}
+}}
+
+/// Overrides the usual [`assert_eq!`] macro with one that calls KUnit instead.
+#[allow(unused)]
+macro_rules! assert_eq {{
+    ($left:expr, $right:expr $(,)?) => {{{{
+        kernel::kunit_assert_eq!("{test}", "{path}", 0, $left, $right);
+    }}}}
+}}
+        "#
+        )
+        .unwrap();
     }
 
     writeln!(kunit_macros).unwrap();
@@ -152,7 +175,10 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
         }
     }
 
-    let mut new_body = TokenStream::from_iter(new_body);
+    let body = new_body;
+    let mut new_body = TokenStream::new();
+    new_body.extend::<TokenStream>(assert_macros.parse().unwrap());
+    new_body.extend(body);
     new_body.extend::<TokenStream>(kunit_macros.parse().unwrap());
 
     tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, new_body)));
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 9acaa68c974e..8bd7906276be 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -6,6 +6,10 @@
 // and thus add a dependency on `include/config/RUSTC_VERSION_TEXT`, which is
 // touched by Kconfig when the version string from the compiler changes.
 
+// TODO: check that when Rust 1.88.0 is released, this would be enough:
+// #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
+#![feature(proc_macro_span)]
+
 #[macro_use]
 mod quote;
 mod concat_idents;
-- 
2.49.0


