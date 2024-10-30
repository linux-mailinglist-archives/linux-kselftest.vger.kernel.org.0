Return-Path: <linux-kselftest+bounces-21077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F19B5AF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0241F2488F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6719922D;
	Wed, 30 Oct 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoWi7NnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C7194143
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264271; cv=none; b=O/xGhaut88Nj7xvMe+v0YD96xF+uwpOhEFEKek/U20qYgxN1SM7KsiAHgtP+dEjX6G+AQBiGh5ale575xP800+iHGFbWP582h1S/V6GwsqPpe3F302I+LNbH/jJ0SLkNOf4xkc7PfxUgBNOwmLDYAhAlTOf+WZGvfhH45ueCrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264271; c=relaxed/simple;
	bh=ofdkUPJlxuL46W/T+59jOFZ2yuwS+E3iRYMwYsa9j/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sixaIJr0gxW9sWsYG3Kdt1p+McpzkDAEuIIUyEPU1c+WaGSuNpx3SOLAAmzpPATiUElCwLx5N/ejWEpIjxUAB3R4YPss8azIhA9jWIrjQB+Nh+rC5Movva6sMObmAp4bMAvx2+gaOq/nWTPSoHN2tTGR4VRAQl4NYsuB0hJJm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoWi7NnR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so24748257b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 21:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730264267; x=1730869067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTuusXd3hhJ3dEnI/ZXmmiM2jcBROg0gUL5aBvA3L34=;
        b=WoWi7NnR+5gSaFf9rO1jbp/vBouE/beMz9Jdeion2GKx2mFbvhsbPfKpLOFcvTaKN8
         zMdsCzMWCXduV6H14H/VJkVhml2LpideFtGVHZw/6i//Hxv8VahEcm/AnH8MbUBiaWD9
         4zVC4zVS012LB6+a4XVz81LgGl6ajbOoBJB/ND9f8IopSV0gpCJWp1TP2bm/cp3WAYyX
         xZygOju41BtfjU5IqOki+XpyisYpvVlMLz3IL42/o7bzuNjRNJG5Bdn2myLRrdWD4vRc
         ZJgW2HUTRll9IfsnA0MPAKD54Rx15zrJCtkCMPIhV4+mzoNWemCD8lrBO0v4vCLPL2Bp
         c63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264267; x=1730869067;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTuusXd3hhJ3dEnI/ZXmmiM2jcBROg0gUL5aBvA3L34=;
        b=PfLBpkljbYLKw8qdGRX+wJzWHO49iE25JQfJptx3EsFxWH71sJvYlAafCH3BRAGQzf
         xOnzMcAA3oJA1pe60GRwR6u4q0kSxRuzFgZz9dL5T00ofxDvXt6MM26n3LhVks1FAnUn
         qHqte7T7JWcO2QK6+hX0PTJZ005kssMiRaGo/UlwsQxIhjNbyz2jUwC15eI7YfCB12GJ
         c/1+N8F0HTf87AsBVnIXXSUogtsuS0PAhFlf9tUEX1xR33J46z76qbrJZNYisR7ym59z
         uuKRmEKH5l1dgfoIJzNX3aYojLbhtaO7NWd/si7OGuCHW2bUTKbagzUhTM2u1DqWRhU2
         l/VA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXYt4ZfxiDb5MR5BAYaUfvnk20v2rqJjHi1KgYydZavlzkSTLokaH4f0oyb80vURXvcy5IX8Rc2a700L0iwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9XVIFQVAIUajOm4OgSRdUCEng9b1m1/8ZTph64Bv1kzX54eV
	nuypKP6XLP/OztgRSMR6DweETJh9oTTDFH3XM8a57ef+MuyonSk+z/0GnsvQok27/jm4xLTZGZF
	keAAHX/1IQA==
X-Google-Smtp-Source: AGHT+IFNeZ/cLwpQ1iHhtQMFGT9RXhAzCHnLFR9ILDekhdgcluikbDQVZ32PNJA8Ev+3bAXCQgkuRsdVRWhYVQ==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:b1:7045:ac11:6237])
 (user=davidgow job=sendgmr) by 2002:a81:a884:0:b0:6e7:e493:2da6 with SMTP id
 00721157ae682-6e9d8b16e66mr2494047b3.6.1730264266742; Tue, 29 Oct 2024
 21:57:46 -0700 (PDT)
Date: Wed, 30 Oct 2024 12:57:12 +0800
In-Reply-To: <20241030045719.3085147-2-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241030045719.3085147-2-davidgow@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241030045719.3085147-4-davidgow@google.com>
Subject: [PATCH v3 1/3] rust: kunit: add KUnit case and suite macros
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

Add a couple of Rust const functions and macros to allow to develop
KUnit tests without relying on generated C code:

 - The `kunit_unsafe_test_suite!` Rust macro is similar to the
   `kunit_test_suite` C macro. It requires a NULL-terminated array of
   test cases (see below).
 - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C macro.
   It generates as case from the name and function.
 - The `kunit_case_null` Rust function generates a NULL test case, which
   is to be used as delimiter in `kunit_test_suite!`.

While these functions and macros can be used on their own, a future
patch will introduce=C2=A0another macro to create KUnit tests using a
user-space like syntax.

Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
Co-developed-by: Matt Gilbride <mattgilbride@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v2:
https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidgow@g=
oogle.com/
- The kunit_unsafe_test_suite!() macro will truncate the name of the
  suite if it is too long. (Thanks Alice!)
- We no longer needlessly use UnsafeCell<> in
  kunit_unsafe_test_suite!(). (Thanks Alice!)

Changes since v1:
https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.com=
/
- Rebase on top of rust-next
- As a result, KUnit attributes are new set. These are hardcoded to the
  defaults of "normal" speed and no module name.
- Split the kunit_case!() macro into two const functions, kunit_case()
  and kunit_case_null() (for the NULL terminator).

---
 rust/kernel/kunit.rs | 108 +++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs   |   1 +
 2 files changed, 109 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 824da0e9738a..27bc4139d352 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,111 @@ macro_rules! kunit_assert_eq {
         $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);
     }};
 }
+
+/// Represents an individual test case.
+///
+/// The test case should have the signature
+/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.
+///
+/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of=
 test cases.
+/// Use `kunit_case_null` to generate such a delimeter.
+const fn kunit_case(name: &'static kernel::str::CStr, run_case: unsafe ext=
ern "C" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {
+    kernel::bindings::kunit_case {
+        run_case: Some(run_case),
+        name: name.as_char_ptr(),
+        attr: kernel::bindings::kunit_attributes {
+            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
+        },
+        generate_params: None,
+        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
+        module_name: core::ptr::null_mut(),
+        log: core::ptr::null_mut(),
+    }
+}
+
+/// Represents the NULL test case delimiter.
+///
+/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list of=
 test cases. This
+/// function retuns such a delimiter.
+const fn kunit_case_null() -> kernel::bindings::kunit_case {
+    kernel::bindings::kunit_case {
+        run_case: None,
+        name: core::ptr::null_mut(),
+        generate_params: None,
+        attr: kernel::bindings::kunit_attributes {
+            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
+        },
+        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
+        module_name: core::ptr::null_mut(),
+        log: core::ptr::null_mut(),
+    }
+}
+
+
+/// Registers a KUnit test suite.
+///
+/// # Safety
+///
+/// `test_cases` must be a NULL terminated array of test cases.
+///
+/// # Examples
+///
+/// ```ignore
+/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {
+///     let actual =3D 1 + 1;
+///     let expected =3D 2;
+///     assert_eq!(actual, expected);
+/// }
+///
+/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crate::kun=
it_case(name, test_fn);
+/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crate::kun=
it_case_null();
+/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =3D uns=
afe {
+///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
+/// };
+/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
+/// ```
+#[macro_export]
+macro_rules! kunit_unsafe_test_suite {
+    ($name:ident, $test_cases:ident) =3D> {
+        const _: () =3D {
+            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {
+                let name_u8 =3D core::stringify!($name).as_bytes();
+                let mut ret =3D [0; 256];
+
+                let mut i =3D 0;
+                while i < name_u8.len() && i < 256 {
+                    ret[i] =3D name_u8[i] as i8;
+                    i +=3D 1;
+                }
+
+                ret
+            };
+
+            static mut KUNIT_TEST_SUITE: $crate::bindings::kunit_suite =3D
+                $crate::bindings::kunit_suite {
+                    name: KUNIT_TEST_SUITE_NAME,
+                    // SAFETY: User is expected to pass a correct `test_ca=
ses`, hence this macro
+                    // named 'unsafe'.
+                    test_cases: unsafe { $test_cases.as_mut_ptr() },
+                    suite_init: None,
+                    suite_exit: None,
+                    init: None,
+                    exit: None,
+                    attr: $crate::bindings::kunit_attributes {
+                        speed: $crate::bindings::kunit_speed_KUNIT_SPEED_N=
ORMAL,
+                    },
+                    status_comment: [0; 256usize],
+                    debugfs: core::ptr::null_mut(),
+                    log: core::ptr::null_mut(),
+                    suite_init_err: 0,
+                    is_init: false,
+                };
+
+            #[used]
+            #[link_section =3D ".kunit_test_suites"]
+            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::ku=
nit_suite =3D
+                // SAFETY: `KUNIT_TEST_SUITE` is static.
+                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
+        };
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b62451f64f6e..d662aa37070f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 #![feature(inline_const)]
 #![feature(lint_reasons)]
 #![feature(unsize)]
+#![feature(const_mut_refs)]
=20
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
--=20
2.47.0.163.g1226f6d8fa-goog


