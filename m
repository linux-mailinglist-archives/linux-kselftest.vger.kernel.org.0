Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC73757327
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjGRF2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRF2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7BA1B6;
        Mon, 17 Jul 2023 22:28:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFDA0612ED;
        Tue, 18 Jul 2023 05:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1525C433C8;
        Tue, 18 Jul 2023 05:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689658102;
        bh=xI4obn244cY8Q+3uoNdU7rfmCYQDFQ/FNZ5BuI7JKb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ki79avhf+MFTmpgrn762d3n7YkOcX4RD6ODRBckw0ziZHddezjRCbKIOMR4bwmL4u
         du/EL3U2xedsGeqmeMFAuKQjh/Ox1ZMTFNEnOdI/IvIcbdqFn6/emN/zjgaqMHKwuV
         LEqfm+0AFHa8ARWPgZMsk0VTR64Gwnc0OFzy7w5GGcd/n+a4BNr7SSZ4JPhzx+JMty
         e2a7iXsNCy4HqRPVmrSbvJ3ad58C2Bf6l5/s1NXO7I/x11/NxlTgR4UcCf4bwlA3UB
         rkNRJvK/fBvMuz13D+25s6VAGm+so+BaZDPxr1QpY2RMvHmWHT8p1VFpev7et6pA4E
         jlOjjsDW8thSA==
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
        patches@lists.linux.dev
Subject: [PATCH v2 1/7] kunit: test-bug.h: include `stddef.h` for `NULL`
Date:   Tue, 18 Jul 2023 07:27:46 +0200
Message-ID: <20230718052752.1045248-2-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-1-ojeda@kernel.org>
References: <20230718052752.1045248-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The header uses `NULL` in both `CONFIG_KUNIT=y` and `=n` cases,
but does not include it explicitly.

When `CONFIG_KUNIT=y`, the header is already getting included via
the other headers, so it is not a problem for users.

However, when `CONFIG_KUNIT=n`, it is not, and thus a user could hit
a build error when including `kunit/test-bug.h`, like we are doing
later in this series [1].

Thus include `linux/stddef.h`, and do so outside the `#if`, since it
is used in both cases.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Closes: https://lore.kernel.org/rust-for-linux/ZJ8cNUW3oR2p+gL1@boqun-archlinux/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 include/kunit/test-bug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
index 30ca541b6ff2..47aa8f21ccce 100644
--- a/include/kunit/test-bug.h
+++ b/include/kunit/test-bug.h
@@ -9,6 +9,8 @@
 #ifndef _KUNIT_TEST_BUG_H
 #define _KUNIT_TEST_BUG_H
 
+#include <linux/stddef.h> /* for NULL */
+
 #if IS_ENABLED(CONFIG_KUNIT)
 
 #include <linux/jump_label.h> /* For static branch */
-- 
2.41.0

