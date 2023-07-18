Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8475732F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGRF3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGRF3H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:29:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CE10C0;
        Mon, 17 Jul 2023 22:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C4F261381;
        Tue, 18 Jul 2023 05:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD072C433C8;
        Tue, 18 Jul 2023 05:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689658119;
        bh=pDq8zAwwItzO8pDih79tVM9FL2q7j+cY2RORNTyXvJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mg7gawPhf5h44Q4Lw0VZmHcJu2Psn4WiMq6k3UMWA4Ilx/OzR/RGky3KmujN/7FNC
         b33Qsf9zyf83HOZ6EkiFugr99E16qCDkgwaeZfKr1GYFgHrfFWYvExq411QL5fCNAG
         WohVVmv+EsMuyCaTkAnG7fqPjF8zck7E6NxCZEGUXD9Gx5UelQfYBW8oADw19m6mPu
         zXdvohtqknr88s3QWR17HvhJkX8pwezvICB1X+92qfinUi/i90IGehr8v+aQkZbnEc
         mOb1CM4ck5yPM396PR/EqqqGgZ9Ivbffy3Qh8Xr3ZGwv2a7Rfz3zYCZn3FYx2rBiWL
         +swgakWgxA4lA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: [PATCH v2 5/7] rust: types: make doctests compilable/testable
Date:   Tue, 18 Jul 2023 07:27:50 +0200
Message-ID: <20230718052752.1045248-6-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-1-ojeda@kernel.org>
References: <20230718052752.1045248-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rust documentation tests are going to be build/run-tested
with the KUnit integration added in a future patch, thus
update them to make them compilable/testable so that we
may start enforcing it.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/types.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 1e5380b16ed5..696d6c5a3b9d 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -109,7 +109,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// In the example below, we have multiple exit paths and we want to log regardless of which one is
 /// taken:
 /// ```
-/// # use kernel::ScopeGuard;
+/// # use kernel::types::ScopeGuard;
 /// fn example1(arg: bool) {
 ///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
 ///
@@ -127,7 +127,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// In the example below, we want to log the same message on all early exits but a different one on
 /// the main exit path:
 /// ```
-/// # use kernel::ScopeGuard;
+/// # use kernel::types::ScopeGuard;
 /// fn example2(arg: bool) {
 ///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
 ///
@@ -148,7 +148,7 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 /// In the example below, we need a mutable object (the vector) to be accessible within the log
 /// function, so we wrap it in the [`ScopeGuard`]:
 /// ```
-/// # use kernel::ScopeGuard;
+/// # use kernel::types::ScopeGuard;
 /// fn example3(arg: bool) -> Result {
 ///     let mut vec =
 ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
-- 
2.41.0

