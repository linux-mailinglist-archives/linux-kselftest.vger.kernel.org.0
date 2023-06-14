Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA740730724
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241923AbjFNSLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 14:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbjFNSLT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 14:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BDA295F;
        Wed, 14 Jun 2023 11:10:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7384645A6;
        Wed, 14 Jun 2023 18:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F014C433C0;
        Wed, 14 Jun 2023 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686766187;
        bh=0ayyCNVLvQE2fk7z+0Ei1x6tEumXh4v5ec9O/CPruY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNZyTTxJc9utGF/3mf0rAOtZQR+boC8DqmZxwZyydUlpvmlVQXjANtWERlTthIZZY
         EqDtj5dgu7lZSg3LliI8UAvQT6mPbUbQV+FeTrvi4xGAX+X1tbgRTdeAJVksh54PTW
         YekVTKn5gPS9uftsbBK83DGujHWAksD7EiHhBvhn1kvXFeNely0QZO8QQFjzJX0s9H
         uAOPIVhleWc3HBvZXt6/aDd+QbZ4alocbt929MZZEQ8YKA79lgpwTFq72kKaa0Ab4S
         AfcPHrZfahrJ13TogluIsMD1gld6H6vjja2dhr1m4FrTMxbaLzHOTPrw19lezqcMNX
         Iu6KyR6h0QDDg==
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
Subject: [PATCH 6/6] MAINTAINERS: add Rust KUnit files to the KUnit entry
Date:   Wed, 14 Jun 2023 20:08:30 +0200
Message-ID: <20230614180837.630180-7-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-1-ojeda@kernel.org>
References: <20230614180837.630180-1-ojeda@kernel.org>
MIME-Version: 1.0
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

The KUnit maintainers would like to maintain these files on their
side too (thanks!), so add them to their entry.

With this in place, `scripts/get_maintainer.pl` prints both sets
of maintainers/reviewers (i.e. KUnit and Rust) for those files,
which is the behavior we are looking for.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250518fc70ff..f4c9ce1b685f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11323,6 +11323,8 @@ W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
 F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
+F:	rust/kernel/kunit.rs
+F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
 
 KERNEL USERMODE HELPER
-- 
2.41.0

