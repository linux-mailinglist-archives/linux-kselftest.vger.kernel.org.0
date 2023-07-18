Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40588757331
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGRF33 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGRF3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AD19B3;
        Mon, 17 Jul 2023 22:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C27FB61453;
        Tue, 18 Jul 2023 05:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC44C433B9;
        Tue, 18 Jul 2023 05:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689658128;
        bh=5/I2Oo1+eHlrU9kha5F8okWuBWfq/jmwWetfxpBFOJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdH81+504C2TaP6gx9HufIlfw8IIMaE9uFiGR3yaVJJRfnpL3rpnKiANN+/eBP7hl
         m15PXsyYE1OfIkODRedBtuxMAQtsq3BqcMPqD0pO1aF5Bh9J3vHTISRGHE4fc2LAky
         F7HdpvrowMyClU6BmlV4JZrM8BZh7poS7VgHThJxlII8LreS/vzyTsQcxJSTVK9bwb
         ipNAID5mW1qj68kXATmFM5b+ncEcRB70jS5eEmD0Q4w9VatpCWakqWR3YxtTNg7YeE
         ppfrzrjUBXAWMd/qereojk/RCkrT4PuDKMnVTnE8U/AkfHnY2nS7kbJmnHOfmAgltX
         L2MtbmqHjEKVg==
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
Subject: [PATCH v2 7/7] MAINTAINERS: add Rust KUnit files to the KUnit entry
Date:   Tue, 18 Jul 2023 07:27:52 +0200
Message-ID: <20230718052752.1045248-8-ojeda@kernel.org>
In-Reply-To: <20230718052752.1045248-1-ojeda@kernel.org>
References: <20230718052752.1045248-1-ojeda@kernel.org>
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

The KUnit maintainers would like to maintain these files on their
side too (thanks!), so add them to their entry.

With this in place, `scripts/get_maintainer.pl` prints both sets
of maintainers/reviewers (i.e. KUnit and Rust) for those files,
which is the behavior we are looking for.

Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..2a942fe59144 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11372,6 +11372,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git k
 F:	Documentation/dev-tools/kunit/
 F:	include/kunit/
 F:	lib/kunit/
+F:	rust/kernel/kunit.rs
+F:	scripts/rustdoc_test_*
 F:	tools/testing/kunit/
 
 KERNEL USERMODE HELPER
-- 
2.41.0

