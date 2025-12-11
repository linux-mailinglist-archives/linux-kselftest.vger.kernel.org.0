Return-Path: <linux-kselftest+bounces-47454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E00ECB6FFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3098F3009C05
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C6319847;
	Thu, 11 Dec 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiL+Rq3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF310314A90;
	Thu, 11 Dec 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765481362; cv=none; b=RnC/kzL9I/prHhWVwF4Z0DI6c8M2QfNOyMdI2u6XVs7L0yrOBlf0BA7vI0vVIXXt7OBVZdKVqmyI5/ALkxTkRA6hbyBB6LFOLaxbOIqjUQ/LcU+d2tIs89SVNg5HcfBKkXw0zENpDrbUEGXUF1dYq0y5Vxx72YNI5QCTilRhHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765481362; c=relaxed/simple;
	bh=vKz0OFfO7p2gGtj2C8tssrYW11YP1ZzK7668tdN16o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEoHMCH3sRcQk2/XgJR2YdXClYfIjpTlsnJT5eeRJiK+L+xzbNehi+kYzkDf1UaiXBGg0VOSwSrhQuyncSOvyB17S8jCQRx1TRaTfZT112TGRwW3Io0tL5rr9qdOQLXEgf1roqqXV5i5SafxInw66dFjuAmkYC8nBdSg/Nk2fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiL+Rq3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23BDC4CEF7;
	Thu, 11 Dec 2025 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765481362;
	bh=vKz0OFfO7p2gGtj2C8tssrYW11YP1ZzK7668tdN16o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=HiL+Rq3rHbOcyJ+UoP7pLM8IBvtDfsg4dgi4p5GVAHK+24ePfJXiLqS5x2X4RT8S6
	 aPt0JvwOGPKZspGLpH0qWjsKIQD88LeBqSy2JQBLX3zYMttEp37Bil2UMq9FJslFYQ
	 ixJ6JR6cM66AW+okD2hPvXJc2GkTZaPtpduFClggA2SfMfOFMcSuoCS5bZ87oQqh1c
	 n/4z8oXXCA4bazIicfqig4nia6obRKWLbJGeWLNtPvgQTYwkom74GuUzhAwPAut/Qq
	 Dnd7Rr64Doc1UL8VWdD7g/iz6Obmi/ARkpT10/mVBR+MgwkRJzvKAfPH+h5qUtc1+o
	 YMktNyCnacGMw==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Fiona Behrens <me@kloenk.dev>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH 02/11] rust: macros: use `quote!` from vendored crate
Date: Thu, 11 Dec 2025 18:56:42 +0000
Message-ID: <20251211185805.2835633-3-gary@kernel.org>
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

With `quote` crate now vendored in the kernel, we can remove our custom
`quote!` macro implementation and just rely on that crate instead.

The `quote` crate uses types from the `proc-macro2` library so we also
update to use that, and perform conversion in the top-level lib.rs.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/macros/concat_idents.rs |   2 +-
 rust/macros/export.rs        |   4 +-
 rust/macros/fmt.rs           |   4 +-
 rust/macros/helpers.rs       |   2 +-
 rust/macros/kunit.rs         |   3 +-
 rust/macros/lib.rs           |  21 ++--
 rust/macros/module.rs        |   6 +-
 rust/macros/paste.rs         |   2 +-
 rust/macros/quote.rs         | 182 -----------------------------------
 rust/macros/vtable.rs        |   3 +-
 10 files changed, 28 insertions(+), 201 deletions(-)
 delete mode 100644 rust/macros/quote.rs

diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
index 7e4b450f3a507..12cb231c3d715 100644
--- a/rust/macros/concat_idents.rs
+++ b/rust/macros/concat_idents.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{token_stream, Ident, TokenStream, TokenTree};
+use proc_macro2::{token_stream, Ident, TokenStream, TokenTree};
 
 use crate::helpers::expect_punct;
 
diff --git a/rust/macros/export.rs b/rust/macros/export.rs
index a08f6337d5c8d..92d9b30971929 100644
--- a/rust/macros/export.rs
+++ b/rust/macros/export.rs
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use proc_macro2::TokenStream;
+use quote::quote;
+
 use crate::helpers::function_name;
-use proc_macro::TokenStream;
 
 /// Please see [`crate::export`] for documentation.
 pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStream {
diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
index 2f4b9f6e22110..19f709262552b 100644
--- a/rust/macros/fmt.rs
+++ b/rust/macros/fmt.rs
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{Ident, TokenStream, TokenTree};
 use std::collections::BTreeSet;
 
+use proc_macro2::{Ident, TokenStream, TokenTree};
+use quote::quote_spanned;
+
 /// Please see [`crate::fmt`] for documentation.
 pub(crate) fn fmt(input: TokenStream) -> TokenStream {
     let mut input = input.into_iter();
diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index e2602be402c10..853527b5d9567 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{token_stream, Group, Ident, TokenStream, TokenTree};
+use proc_macro2::{token_stream, Group, Ident, TokenStream, TokenTree};
 
 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
     if let Some(TokenTree::Ident(ident)) = it.next() {
diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
index b395bb0536959..7427c17ee5f5c 100644
--- a/rust/macros/kunit.rs
+++ b/rust/macros/kunit.rs
@@ -4,10 +4,11 @@
 //!
 //! Copyright (c) 2023 José Expósito <jose.exposito89@gmail.com>
 
-use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
 use std::collections::HashMap;
 use std::fmt::Write;
 
+use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
+
 pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
     let attr = attr.to_string();
 
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 793f712dbf7c0..8e0f49ac783b2 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -11,8 +11,6 @@
 // to avoid depending on the full `proc_macro_span` on Rust >= 1.88.0.
 #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
 
-#[macro_use]
-mod quote;
 mod concat_idents;
 mod export;
 mod fmt;
@@ -101,7 +99,7 @@
 ///     the kernel module.
 #[proc_macro]
 pub fn module(ts: TokenStream) -> TokenStream {
-    module::module(ts)
+    module::module(ts.into()).into()
 }
 
 /// Declares or implements a vtable trait.
@@ -176,7 +174,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
 /// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VTABLE_DEFAULT_ERROR.html
 #[proc_macro_attribute]
 pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
-    vtable::vtable(attr, ts)
+    vtable::vtable(attr.into(), ts.into()).into()
 }
 
 /// Export a function so that C code can call it via a header file.
@@ -199,7 +197,7 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
 /// automatically exported with `EXPORT_SYMBOL_GPL`.
 #[proc_macro_attribute]
 pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
-    export::export(attr, ts)
+    export::export(attr.into(), ts.into()).into()
 }
 
 /// Like [`core::format_args!`], but automatically wraps arguments in [`kernel::fmt::Adapter`].
@@ -217,7 +215,7 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
 /// [`pr_info!`]: ../kernel/macro.pr_info.html
 #[proc_macro]
 pub fn fmt(input: TokenStream) -> TokenStream {
-    fmt::fmt(input)
+    fmt::fmt(input.into()).into()
 }
 
 /// Concatenate two identifiers.
@@ -275,7 +273,7 @@ pub fn fmt(input: TokenStream) -> TokenStream {
 /// ```
 #[proc_macro]
 pub fn concat_idents(ts: TokenStream) -> TokenStream {
-    concat_idents::concat_idents(ts)
+    concat_idents::concat_idents(ts.into()).into()
 }
 
 /// Paste identifiers together.
@@ -413,9 +411,12 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
 /// [`paste`]: https://docs.rs/paste/
 #[proc_macro]
 pub fn paste(input: TokenStream) -> TokenStream {
-    let mut tokens = input.into_iter().collect();
+    let mut tokens = proc_macro2::TokenStream::from(input).into_iter().collect();
     paste::expand(&mut tokens);
-    tokens.into_iter().collect()
+    tokens
+        .into_iter()
+        .collect::<proc_macro2::TokenStream>()
+        .into()
 }
 
 /// Registers a KUnit test suite and its test cases using a user-space like syntax.
@@ -442,5 +443,5 @@ pub fn paste(input: TokenStream) -> TokenStream {
 /// ```
 #[proc_macro_attribute]
 pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
-    kunit::kunit_tests(attr, ts)
+    kunit::kunit_tests(attr.into(), ts.into()).into()
 }
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 8cef6cc958b54..6974fb04f58fa 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::helpers::*;
-use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTree};
 use std::fmt::Write;
 
+use proc_macro2::{token_stream, Delimiter, Literal, TokenStream, TokenTree};
+
+use crate::helpers::*;
+
 fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
     let group = expect_group(it);
     assert_eq!(group.delimiter(), Delimiter::Bracket);
diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
index cce712d19855b..2181e312a7d32 100644
--- a/rust/macros/paste.rs
+++ b/rust/macros/paste.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
+use proc_macro2::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
 
 fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Span)> {
     let mut tokens = tokens.iter();
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
deleted file mode 100644
index ddfc21577539c..0000000000000
--- a/rust/macros/quote.rs
+++ /dev/null
@@ -1,182 +0,0 @@
-// SPDX-License-Identifier: Apache-2.0 OR MIT
-
-use proc_macro::{TokenStream, TokenTree};
-
-pub(crate) trait ToTokens {
-    fn to_tokens(&self, tokens: &mut TokenStream);
-}
-
-impl<T: ToTokens> ToTokens for Option<T> {
-    fn to_tokens(&self, tokens: &mut TokenStream) {
-        if let Some(v) = self {
-            v.to_tokens(tokens);
-        }
-    }
-}
-
-impl ToTokens for proc_macro::Group {
-    fn to_tokens(&self, tokens: &mut TokenStream) {
-        tokens.extend([TokenTree::from(self.clone())]);
-    }
-}
-
-impl ToTokens for proc_macro::Ident {
-    fn to_tokens(&self, tokens: &mut TokenStream) {
-        tokens.extend([TokenTree::from(self.clone())]);
-    }
-}
-
-impl ToTokens for TokenTree {
-    fn to_tokens(&self, tokens: &mut TokenStream) {
-        tokens.extend([self.clone()]);
-    }
-}
-
-impl ToTokens for TokenStream {
-    fn to_tokens(&self, tokens: &mut TokenStream) {
-        tokens.extend(self.clone());
-    }
-}
-
-/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
-/// the given span.
-///
-/// This is a similar to the
-/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
-/// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
-macro_rules! quote_spanned {
-    ($span:expr => $($tt:tt)*) => {{
-        let mut tokens = ::proc_macro::TokenStream::new();
-        {
-            #[allow(unused_variables)]
-            let span = $span;
-            quote_spanned!(@proc tokens span $($tt)*);
-        }
-        tokens
-    }};
-    (@proc $v:ident $span:ident) => {};
-    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) => {
-        $crate::quote::ToTokens::to_tokens(&$id, &mut $v);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) => {
-        for token in $id {
-            $crate::quote::ToTokens::to_tokens(&token, &mut $v);
-        }
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
-        #[allow(unused_mut)]
-        let mut tokens = ::proc_macro::TokenStream::new();
-        quote_spanned!(@proc tokens $span $($inner)*);
-        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
-            ::proc_macro::Delimiter::Parenthesis,
-            tokens,
-        ))]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) => {
-        let mut tokens = ::proc_macro::TokenStream::new();
-        quote_spanned!(@proc tokens $span $($inner)*);
-        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
-            ::proc_macro::Delimiter::Bracket,
-            tokens,
-        ))]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) => {
-        let mut tokens = ::proc_macro::TokenStream::new();
-        quote_spanned!(@proc tokens $span $($inner)*);
-        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::new(
-            ::proc_macro::Delimiter::Brace,
-            tokens,
-        ))]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident :: $($tt:tt)*) => {
-        $v.extend([::proc_macro::Spacing::Joint, ::proc_macro::Spacing::Alone].map(|spacing| {
-            ::proc_macro::TokenTree::Punct(::proc_macro::Punct::new(':', spacing))
-        }));
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident : $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident , $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident @ $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident ! $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident ; $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident + $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident = $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident # $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident & $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Punct(
-            ::proc_macro::Punct::new('&', ::proc_macro::Spacing::Alone),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident _ $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Ident(
-            ::proc_macro::Ident::new("_", $span),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
-        $v.extend([::proc_macro::TokenTree::Ident(
-            ::proc_macro::Ident::new(stringify!($id), $span),
-        )]);
-        quote_spanned!(@proc $v $span $($tt)*);
-    };
-}
-
-/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
-/// mixed site span ([`Span::mixed_site()`]).
-///
-/// This is a similar to the [`quote!`](https://docs.rs/quote/latest/quote/macro.quote.html) macro
-/// from the `quote` crate but provides only just enough functionality needed by the current
-/// `macros` crate.
-///
-/// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.Span.html#method.mixed_site
-macro_rules! quote {
-    ($($tt:tt)*) => {
-        quote_spanned!(::proc_macro::Span::mixed_site() => $($tt)*)
-    }
-}
diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
index ee06044fcd4f3..f209216785745 100644
--- a/rust/macros/vtable.rs
+++ b/rust/macros/vtable.rs
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
 use std::collections::HashSet;
 use std::fmt::Write;
 
+use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
+
 pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
     let mut tokens: Vec<_> = ts.into_iter().collect();
 
-- 
2.51.2


