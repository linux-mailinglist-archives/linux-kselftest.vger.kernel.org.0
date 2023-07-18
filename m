Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0366B75732B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjGRF2k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGRF2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76810EB;
        Mon, 17 Jul 2023 22:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B317D612E6;
        Tue, 18 Jul 2023 05:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C5AC433C7;
        Tue, 18 Jul 2023 05:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689658111;
        bh=+k0YeMe4IQGy7ZoqQp5D1RAO3qnqR7osUcj8pqI8Br4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tV+phARwLbThccff0pXskdDqdJjjBy0Bk0U6M49OpFLWrcbBJ/qJRxaDwyHomJLi0
         k10sqhmbFO7nj9PN8a50+zgAEa07sD3yeRt5xn2/XCQXqQ7KQ0iO/AadWvmVkDyREF
         c9B5aHaajJSUiVNp0K3VVGuNdCzB7tw1YEa8JkReBvf4XRLwkkM1InFKlTC+R5WNZN
         FO5e02eE4CAQcPt+24ruW8ij39NR3ZKQFjz0LoiO81GwapqGpbpshWpS/brXUlUuls
         BQsfwEbqbsifsJgxNYt7gkwqbcyi3C3YyhQfou10lzRQj1rXF1g1nbfLg/A3tGohDA
         rTxkssQz1tOVQ==
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
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [PATCH v2 3/7] rust: str: make doctests compilable/testable
Date:   Tue, 18 Jul 2023 07:27:48 +0200
Message-ID: <20230718052752.1045248-4-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-1-ojeda@kernel.org>
References: <20230718052752.1045248-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/str.rs | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index c9dd3bf59e34..c41607b2e4fe 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -213,6 +213,7 @@ impl fmt::Display for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
+    /// # use kernel::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -241,6 +242,7 @@ impl fmt::Debug for CStr {
     ///
     /// ```
     /// # use kernel::c_str;
+    /// # use kernel::fmt;
     /// # use kernel::str::CStr;
     /// # use kernel::str::CString;
     /// let penguin = c_str!("🐧");
@@ -529,7 +531,7 @@ fn write_str(&mut self, s: &str) -> fmt::Result {
 /// # Examples
 ///
 /// ```
-/// use kernel::str::CString;
+/// use kernel::{str::CString, fmt};
 ///
 /// let s = CString::try_from_fmt(fmt!("{}{}{}", "abc", 10, 20)).unwrap();
 /// assert_eq!(s.as_bytes_with_nul(), "abc1020\0".as_bytes());
-- 
2.41.0

