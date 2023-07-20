Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A30775A6B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 08:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjGTGlU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 02:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGTGk6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 02:40:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD2B35A6
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5cea5773e8so445963276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689835209; x=1690440009;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3Gim78LlW0ImU8Nf7KfkXlFKv0mM0hU/1p3btyr4nM=;
        b=5f9C5eFXQp0hGJsDoxGCFRckc7Px3DcrknxoAjktifh5StDa+zVV6XWxRyWl4wpUPD
         2biiL+iilf0AgDI5sxpf7W8VW2o0Ux3ZuggzoLmM7PLy8Z3I7GtxySWk8m0rZZelUNRE
         b5/PlSp8f59mHceQUG85M8pnRcVcV4A8ywL9iY1GwLH8GJZ7rvmTDJSt7644yc1aLCaA
         ZhyM3Rj69OEIFlI4947vSLvC36fFxWnjkMCqrdbw/aScWuf6p3TgnB15frSw0eE8uYlm
         /9lOVmJGVLAqX/jHl5ozL85NB1xCDQNkvCsYR2J83zbZ+G9ODeeKJ8pYFrPrxCvliuaF
         uocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835209; x=1690440009;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i3Gim78LlW0ImU8Nf7KfkXlFKv0mM0hU/1p3btyr4nM=;
        b=ZJoXcz+tV9A0LxCaTTmRUnzuOW6p+FBtKomrmxTWEMeY+8bvyf60/rPcOeJdttCYbe
         ZDamR0zpq4NxUBJJpGC4fLjQot22gGj2LFZT1i8HdxfvZ1zIhc4MctQXnJjRMpDPwkFS
         HNQ0vLB6ri5gRlX2XND+qv6XxaOqFkgLMqHCAyHjnNA4mTKtdVvb3xmoxeXGOddWaACk
         8FZPyIUcrmn30dewLr0I/teyur0J6NNI+zL14RgMwGKixGnmnY9KCNypQumNe3F1t1Rm
         Ymi7Fd2PEi8tnTMoEZi9Nrf5HUBRhIBeiaO85FmQenCsDS1mQikl40jKs0UQ8dJoZAn0
         kQvA==
X-Gm-Message-State: ABy/qLZVRnytmlFtHY+ja5jUOxidz6llvvIa3htclzIVeGxVygh/663i
        J/AbWtInrdtFuYphFtIUALJjDaaT4El9Qw==
X-Google-Smtp-Source: APBJJlHksrDL5l4lPhnUlz0GtDMHq3IdfMTmcbYys5NVadOWYhr90nEPMgb/oWaI2BQLgYCE4qQc7zXkQFJhtw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1709:b0:ccf:6bfa:2a03 with SMTP
 id by9-20020a056902170900b00ccf6bfa2a03mr37240ybb.7.1689835209388; Wed, 19
 Jul 2023 23:40:09 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:38:54 +0800
In-Reply-To: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
Mime-Version: 1.0
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20230720-rustbind-v1-3-c80db349e3b5@google.com>
Subject: [PATCH 3/3] rust: kunit: allow to know if we are in a test
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

In some cases, you need to call test-only code from outside the test
case, for example, to mock a function or a module.

In order to check whether we are in a test or not, we need to test if
`CONFIG_KUNIT` is set.
Unfortunately, we cannot rely only on this condition because some
distros compile KUnit in production kernels, so checking at runtime
that `current->kunit_test !=3D NULL` is required.

Note that the C function `kunit_get_current_test()` can not be used
because it is not present in the current Rust tree yet. Once it is
available we might want to change our Rust wrapper to use it.

This patch adds a function to know whether we are in a KUnit test or
not and examples showing how to mock a function and a module.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
---
 rust/kernel/kunit.rs | 78 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 78 insertions(+)

diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 44ea67028316..dcaac19bb108 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -40,6 +40,8 @@ pub fn info(args: fmt::Arguments<'_>) {
     }
 }
=20
+use crate::task::Task;
+use core::ops::Deref;
 use macros::kunit_tests;
=20
 /// Asserts that a boolean expression is `true` at runtime.
@@ -256,11 +258,87 @@ macro_rules! kunit_unsafe_test_suite {
     };
 }
=20
+/// In some cases, you need to call test-only code from outside the test c=
ase, for example, to
+/// create a function mock. This function can be invoked to know whether w=
e are currently running a
+/// KUnit test or not.
+///
+/// # Examples
+///
+/// This example shows how a function can be mocked to return a well-known=
 value while testing:
+///
+/// ```
+/// # use kernel::kunit::in_kunit_test;
+/// #
+/// fn fn_mock_example(n: i32) -> i32 {
+///     if in_kunit_test() {
+///         100
+///     } else {
+///         n + 1
+///     }
+/// }
+///
+/// let mock_res =3D fn_mock_example(5);
+/// assert_eq!(mock_res, 100);
+/// ```
+///
+/// Sometimes, you don't control the code that needs to be mocked. This ex=
ample shows how the
+/// `bindings` module can be mocked:
+///
+/// ```
+/// // Import our mock naming it as the real module.
+/// #[cfg(CONFIG_KUNIT)]
+/// use bindings_mock_example as bindings;
+///
+/// // This module mocks `bindings`.
+/// mod bindings_mock_example {
+///     use kernel::kunit::in_kunit_test;
+///     use kernel::bindings::u64_;
+///
+///     // Make the other binding functions available.
+///     pub(crate) use kernel::bindings::*;
+///
+///     // Mock `ktime_get_boot_fast_ns` to return a well-known value when=
 running a KUnit test.
+///     pub(crate) unsafe fn ktime_get_boot_fast_ns() -> u64_ {
+///         if in_kunit_test() {
+///             1234
+///         } else {
+///             unsafe { kernel::bindings::ktime_get_boot_fast_ns() }
+///         }
+///     }
+/// }
+///
+/// // This is the function we want to test. Since `bindings` has been moc=
ked, we can use its
+/// // functions seamlessly.
+/// fn get_boot_ns() -> u64 {
+///     unsafe { bindings::ktime_get_boot_fast_ns() }
+/// }
+///
+/// let time =3D get_boot_ns();
+/// assert_eq!(time, 1234);
+/// ```
+pub fn in_kunit_test() -> bool {
+    if cfg!(CONFIG_KUNIT) {
+        // SAFETY: By the type invariant, we know that `*Task::current().d=
eref().0` is valid.
+        let test =3D unsafe { (*Task::current().deref().0.get()).kunit_tes=
t };
+        !test.is_null()
+    } else {
+        false
+    }
+}
+
 #[kunit_tests(rust_kernel_kunit)]
 mod tests {
+    use super::*;
+
     #[test]
     fn rust_test_kunit_kunit_tests() {
         let running =3D true;
         assert_eq!(running, true);
     }
+
+    #[test]
+    fn rust_test_kunit_in_kunit_test() {
+        let in_kunit =3D in_kunit_test();
+        assert_eq!(in_kunit, true);
+    }
 }

--=20
2.41.0.255.g8b1d071c50-goog

