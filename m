Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194575A6B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 08:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjGTGk7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjGTGkn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 02:40:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1053594
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57704aace46so5101437b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689835200; x=1690440000;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPm0nt3jgFstVkuP2L4I35/ImZIIIbkQiLEGJDnMhOQ=;
        b=68FGNx3i914y2L8NGEkfyE+WJUK8YVUoYjjrHxNQrhrZIS5NkcY4CsAhDke0igeMZq
         lqjYx2csTSo+bHRoVhMFJu7BQZhHOwmsLJCXdBV264iGosUApSlREqcy4sHpzdlKj4Po
         Wxq/0PhkHH4a3epUVcE6b8NK3sR3Vpm/TwFf/25FmBGvknU3Fm6pMZDQQxeuj3mMa/6e
         wo9Wz0HQFTnTM+ZeIzLa5c9iBam6dxhVY2sPT/RCU1lAPVaoLuEFK2YXLcQdF/6fpn1p
         LevtoOgLMWrWL/nIN+VGRpCMG3P8cPAXLf02SCcDM/PMG9Vc7OrfxQWokQUkg8xmiaZM
         OdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835200; x=1690440000;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EPm0nt3jgFstVkuP2L4I35/ImZIIIbkQiLEGJDnMhOQ=;
        b=jzOHlUFktXY00W8S20YRbcoSeTNB6OSwQEPjknx4tSSt/ORfHZEDlESVzsEoCvdSi5
         r9muz+jjRT47d9v0HpI6vOFYmdp804W1A9ph0kjgDKkp2XAM46tqGTorSPSF7AEtj++H
         g/f8fwY3h9s4xJk8ZCqHSClyK2KwTX/pBZnSmX/Fze1ZqcVxn886rRA3ZHF8juaTUziq
         8DKnNx18H2o7BDIXs1tNzg3+xf8lJIBWCPcUp5HJtuv5knbFPJ7uIcVOYQKxMTrIVK6a
         qQCMU0KTYnESxlnsvp9LpAm9HfHxD/TWlmCNTyzTT4Ey/pZTe/+ASBOfNeqAcVPf922I
         3gOg==
X-Gm-Message-State: ABy/qLba6mJkjVDd8ZzS4jfNu2bpNiB4JQbIxR06IWLkicKmi8chgg2k
        vmNmGvA4sme6aXy1bu3PcmBEC7F6BVGnQw==
X-Google-Smtp-Source: APBJJlEYtOGTyGW4H6yu13iwVeXqAIY5pd2NT3yxl3I7xNQAl6xpuQJ70UqwBpQ/xc2eQZIsIITWEtYoegc0Fw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:c50a:0:b0:55a:3133:86fa with SMTP id
 k10-20020a81c50a000000b0055a313386famr199503ywi.3.1689835200553; Wed, 19 Jul
 2023 23:40:00 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:38:52 +0800
In-Reply-To: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
Mime-Version: 1.0
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20230720-rustbind-v1-1-c80db349e3b5@google.com>
Subject: [PATCH 1/3] rust: kunit: add KUnit case and suite macros
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>
Cc:     David Gow <davidgow@google.com>,
        "=?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?=" <jose.exposito89@gmail.com>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Add a couple of Rust macros to allow to develop KUnit tests without
relying on generated C code:

 - The `kunit_unsafe_test_suite!` Rust macro is similar to the
   `kunit_test_suite` C macro.
 - The `kunit_case!` Rust macro is similar to the `KUNIT_CASE` C macro.
   It can be used with parameters to generate a test case or without
   parameters to be used as delimiter in `kunit_test_suite!`.

While these macros can be used on their own, a future patch will
introduce=C2=A0another macro to create KUnit tests using a user-space like
syntax.

Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
---
 rust/kernel/kunit.rs | 92 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 rust/kernel/lib.rs   |  1 +
 2 files changed, 93 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 722655b2d62d..4cffc71e463b 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -161,3 +161,95 @@ macro_rules! kunit_assert_eq {
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
 test cases. This macro
+/// can be invoked without parameters to generate the delimiter.
+#[macro_export]
+macro_rules! kunit_case {
+    () =3D> {
+        $crate::bindings::kunit_case {
+            run_case: None,
+            name: core::ptr::null_mut(),
+            generate_params: None,
+            status: $crate::bindings::kunit_status_KUNIT_SUCCESS,
+            log: core::ptr::null_mut(),
+        }
+    };
+    ($name:ident, $run_case:ident) =3D> {
+        $crate::bindings::kunit_case {
+            run_case: Some($run_case),
+            name: $crate::c_str!(core::stringify!($name)).as_char_ptr(),
+            generate_params: None,
+            status: $crate::bindings::kunit_status_KUNIT_SUCCESS,
+            log: core::ptr::null_mut(),
+        }
+    };
+}
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
it_case!(name, test_fn);
+/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crate::kun=
it_case!();
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
+                while i < name_u8.len() {
+                    ret[i] =3D name_u8[i] as i8;
+                    i +=3D 1;
+                }
+
+                ret
+            };
+
+            // SAFETY: `test_cases` is valid as it should be static.
+            static mut KUNIT_TEST_SUITE: core::cell::UnsafeCell<$crate::bi=
ndings::kunit_suite> =3D
+                core::cell::UnsafeCell::new($crate::bindings::kunit_suite =
{
+                    name: KUNIT_TEST_SUITE_NAME,
+                    test_cases: unsafe { $test_cases.as_mut_ptr() },
+                    suite_init: None,
+                    suite_exit: None,
+                    init: None,
+                    exit: None,
+                    status_comment: [0; 256usize],
+                    debugfs: core::ptr::null_mut(),
+                    log: core::ptr::null_mut(),
+                    suite_init_err: 0,
+                });
+
+            // SAFETY: `KUNIT_TEST_SUITE` is static.
+            #[used]
+            #[link_section =3D ".kunit_test_suites"]
+            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::ku=
nit_suite =3D
+                unsafe { KUNIT_TEST_SUITE.get() };
+        };
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3642cadc34b1..ec81fd28d71a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,7 @@
 #![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
+#![feature(const_mut_refs)]
=20
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.

--=20
2.41.0.255.g8b1d071c50-goog

