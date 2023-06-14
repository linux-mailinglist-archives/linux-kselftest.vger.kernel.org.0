Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307BC730728
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbjFNSLy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbjFNSLe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 14:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981C2D45;
        Wed, 14 Jun 2023 11:11:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EADC60B50;
        Wed, 14 Jun 2023 18:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D662C433C9;
        Wed, 14 Jun 2023 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686766178;
        bh=ehcluNxu9TSlphXGqNkHOa/SpBNYxUq22Vm5jtRhQQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT2G6znf/4h74wnGmSfriDkF2nvXPdzTqMI4UMOv+vWu3KFM9VaVXeGXH0g5Vjy7Z
         SORLaZWOttT/1lVnc56iIxYDSGEfBO2/dwxvZLgyKUDvn9wS0NJRNaoKliVqZKPruh
         FC30wTiLC7Tp5k0qFdl8brvltePdc0M3OOlTgOxfrGRizWVOgmldXKqq7mTuV+3ykb
         3QpJjdx+pyFADdUWuF989LJjFAPWyTNjfCS1yvN6TPdSfITrg81O41ACS5aEbIDsrM
         TR7hBTRSuNiDqYDj2va8BL3InVnvLJyTdUmE6QddoICDQFNSI5Rj7bDkBLkB2LZAEu
         fa3Bs9ZYFGmZQ==
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
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 4/6] rust: types: make doctests compilable/testable
Date:   Wed, 14 Jun 2023 20:08:28 +0200
Message-ID: <20230614180837.630180-5-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-1-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

