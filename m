Return-Path: <linux-kselftest+bounces-40911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D0B47DD5
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 22:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7365E3A5EB9
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 20:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2BF1AF0B6;
	Sun,  7 Sep 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diCLX3JH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C814BFA2;
	Sun,  7 Sep 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276222; cv=none; b=BFpZpUCkdW1dxPQZI1mqTwsYL7uZEQYZoShSvolDlIl9l+y9j1pDIsMOwA0Z282tZ36hu3zGeaRl4ciNdwhcBKcSc6pdsRczO05SoRenXVb0jeXepaTy7QoU/RM933Bp3cRMQGO11+Ekw9L83PEjSqfL2Sf7j7sgjNDHDi8ZsRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276222; c=relaxed/simple;
	bh=cNojSBMt+YfxQsujviRAp683aUg68rwuxadaZOxr3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MhMZr6WVKODDbIDm0l9lNes3wYFgMGAejWsqSF54NFJJJAvQ4i5O6zhtmr8LrS+CrZC4RXA0+HkCPhl0Tt6E9dN9XsYaIVepZ5nyInbjUImNiTTfgy0D7xC2dvIXc4gk0zzU7PPFEKutWX6Ieln3wkZLUZsxkRiu6rWpVkxFIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diCLX3JH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b34a3a6f64so31887101cf.3;
        Sun, 07 Sep 2025 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757276219; x=1757881019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djX+PIcw/n3yRglWL6IpB17mo/z4VhsgMnNGUIE3HOg=;
        b=diCLX3JHaB/dwx8Q+FXXfhE1625iOiBg4ct4RbZvh7sNBNjJe8IB4eztD3vXu0gBUo
         grBRLetIRjBK/3Jvj7Axq6F97bAPXaP8WR+D6KTaDL5HX9y0C24sF7Luyb0dR6StcpOv
         Y/HVLliB4SKFTeSvHV3DcX+oz+UHFgzbqNy8XYnu4IokomiwJL8CsGO6rm1fG9rN74FI
         wIAaSqx6Je1Ea/3Rb0Mj+uyrHBumYpk2vOlWJaRhVfyOhiG4v6Sg1TELf2aTONvT82si
         JpbR+dclRENrZdjQSy09qhxUO4IdLkjeyV85a6sPxHGmoiFDXxQjHUFqwG3B6puigtmT
         2i1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757276219; x=1757881019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djX+PIcw/n3yRglWL6IpB17mo/z4VhsgMnNGUIE3HOg=;
        b=O9AdPZzDQhr1x86IHrZMjC4ARgazqjZHCRN7P+K7H5kddEp4VHyWBWkI/Y+CZC3zJf
         HN2jxqSwzmGtXckQryqVebbteql4ckgBMfdUOIuouGHGblg9guHlVKqoVo5suZDekbQj
         hDoNJ8ZEJINEg41UVLs1yQzklDM99QRrBIRDDq2Fwa9a+XJTYxMATUSUa/NJ6RbsYqwt
         tbKE64T5RsYOG4/X/5IGjtGmMGoQCHGPZGIfzNWxRkhmXkbZSTB8lwJwDSiLEDBZtTu1
         o6SXQ09JVKUlwa9PBrM5RySfz+kLCe724HADNccp+hEj+WQ2G9Pppj7TfjLyiRYjq1HA
         LH/w==
X-Forwarded-Encrypted: i=1; AJvYcCUubv68PN9WBTPZeQqfBD0OfeM+7yQkmt5sVfiZWFqJC1SmAdOgNo0MS5sSjY5duGOb/fqCzmbHRlVGWypMzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvCCrdgD3Iy/HSy45H0Kmewh4vDF5QLs3QQz5Gc4ktXXBrlnT2
	RXeYPreQuEi1G0O/jlmEgooX9qcBYhu1NRdKqkhjQkVhwuPDFwPVTCG5
X-Gm-Gg: ASbGncszXAWXumDCHpEDmwKf2b8+P/Wmr8duiTUCopdRoFR/q/dWve0k+EufqUM0xjU
	4TUlyACpyr9vgA+ik9KyniMn/CV/ZtJl+kidkZ0iTs4a9WZob8jDAFhrfNWccSkMVyZbJhIQHWw
	qde0jydshFYofAYvddlvkkef9ZmbhSl21vCVz69yOguLgFm+Xg21VyU0JUr9hQmZca1OeSVfqO3
	JBR2E4YF8Z6xY1knyrkpCzpFpB/cD7f/q90iaHhHlsmimV2Kr1mkfjb8oEv5Pgqa6j0gQSTEvNr
	6MGTlUlMaXtQ43fLTAvkPrYnscbcBesMx1/XhxKS4PZSb9638FoyRB1K589VJS6GvTKPbAk1ntr
	e0L40m1dh3lv09LoQbmqF9EZTH1WJnSQZaTUKumHiWdodHcukF1gJ7OGn50Voorqr3/MUiGfshh
	YtIZA=
X-Google-Smtp-Source: AGHT+IEeG0lU8p32peNX4sl3pI+uZIwv77dUwplkzv4s6yCtreH3uH5BfpmdRrv1AoxdfI0dKUhu/g==
X-Received: by 2002:ac8:5d8d:0:b0:4b5:f6c5:cfc with SMTP id d75a77b69052e-4b5f83add94mr65215831cf.19.1757276219144;
        Sun, 07 Sep 2025 13:16:59 -0700 (PDT)
Received: from ovo.uwaterloo.ca (wn-res-nat-129-97-125-62.dynamic.uwaterloo.ca. [129.97.125.62])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b5d79165efsm66877031cf.50.2025.09.07.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 13:16:58 -0700 (PDT)
From: Kaibo Ma <ent3rm4n@gmail.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Kaibo Ma <ent3rm4n@gmail.com>
Subject: [PATCH] rust: kunit: allow `cfg` on `test`s
Date: Sun,  7 Sep 2025 16:15:57 -0400
Message-ID: <20250907201558.104566-2-ent3rm4n@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The `kunit_test` proc macro only checks for the `test` attribute
immediately preceding a `fn`. If the function is disabled via a `cfg`,
the generated code would result in a compile error referencing a
non-existent function [1].

This collects attributes and specifically cherry-picks `cfg` attributes
to be duplicated inside KUnit wrapper functions such that a test function
disabled via `cfg` compiles and is ignored correctly.

Link: https://lore.kernel.org/rust-for-linux/CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com/ [1]
Closes: https://github.com/Rust-for-Linux/linux/issues/1185
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Kaibo Ma <ent3rm4n@gmail.com>
---
 rust/kernel/kunit.rs |  7 +++++++
 rust/macros/kunit.rs | 46 ++++++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 41efd8759..32640dfc9 100644
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
index 81d18149a..850a321e5 100644
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
@@ -100,11 +113,20 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
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
+                {cfg_attr} {{
+                    use ::kernel::kunit::is_test_result_ok;
+                    assert!(is_test_result_ok({test}()));
+                }}
+            }}"#,
         );
         writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
         writeln!(
@@ -139,7 +161,7 @@ macro_rules! assert_eq {{
     writeln!(
         kunit_macros,
         "static mut TEST_CASES: [::kernel::bindings::kunit_case; {}] = [\n{test_cases}    ::kernel::kunit::kunit_case_null(),\n];",
-        tests.len() + 1
+        num_tests + 1
     )
     .unwrap();
 
-- 
2.50.1


