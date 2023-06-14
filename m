Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412D173071F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbjFNSLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbjFNSKu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 14:10:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FCD30C4;
        Wed, 14 Jun 2023 11:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 427A16455E;
        Wed, 14 Jun 2023 18:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA94C433C0;
        Wed, 14 Jun 2023 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686766161;
        bh=fXHMpfERvexjC1cBZRBzlkhrqEdvS6t8XukfGExQ9rE=;
        h=From:To:Cc:Subject:Date:From;
        b=T0w5Clw6D4NpCHTogWpArssUXW2986IdhYro40TmZhV+LtKFz6dSaRaikAvt5XheN
         gns0l1bPss9Nt4D/PIWJTOti/EYwrF5vvVwflkW8e5n1OccZ39RQNJ9l4K29zn/qQ0
         Yhc31ewVSDSm5RRWPdKyHSSFaFETQYbBMr2xeZh+9eYsg5ov906SSTX52WUs38mQtF
         AAaZlNB2T49Ix361pzTvDWu0aqP/ZDnjPAlSTdJzy3QgCUYIZaua0jK/tzd4TuS17p
         0DRXPAM1lXrOe1bf0wqzLqcfJXNaIrXp85SBe8sLyJIgec60v35blJICTjgZAAh/Wq
         veL2T6ul3pjPw==
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
Subject: [PATCH 0/6] KUnit integration for Rust doctests
Date:   Wed, 14 Jun 2023 20:08:24 +0200
Message-ID: <20230614180837.630180-1-ojeda@kernel.org>
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

This is the initial KUnit integration for running Rust documentation
tests within the kernel.

Thank you to the KUnit team for all the input and feedback on this
over the months, as well as the Intel LKP 0-Day team!

This may be merged through either the KUnit or the Rust trees. If
the KUnit team wants to merge it, then that would be great.

Please see the message in the main commit for the details.


Miguel Ojeda (6):
  rust: init: make doctests compilable/testable
  rust: str: make doctests compilable/testable
  rust: sync: make doctests compilable/testable
  rust: types: make doctests compilable/testable
  rust: support running Rust documentation tests as KUnit ones
  MAINTAINERS: add Rust KUnit files to the KUnit entry

 MAINTAINERS                       |   2 +
 lib/Kconfig.debug                 |  13 +++
 rust/.gitignore                   |   2 +
 rust/Makefile                     |  29 ++++++
 rust/bindings/bindings_helper.h   |   1 +
 rust/helpers.c                    |   7 ++
 rust/kernel/init.rs               |  25 +++--
 rust/kernel/kunit.rs              | 156 ++++++++++++++++++++++++++++
 rust/kernel/lib.rs                |   2 +
 rust/kernel/str.rs                |   4 +-
 rust/kernel/sync/arc.rs           |   9 +-
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs |   1 +
 rust/kernel/types.rs              |   6 +-
 scripts/.gitignore                |   2 +
 scripts/Makefile                  |   4 +
 scripts/rustdoc_test_builder.rs   |  73 ++++++++++++++
 scripts/rustdoc_test_gen.rs       | 162 ++++++++++++++++++++++++++++++
 18 files changed, 484 insertions(+), 15 deletions(-)
 create mode 100644 rust/kernel/kunit.rs
 create mode 100644 scripts/rustdoc_test_builder.rs
 create mode 100644 scripts/rustdoc_test_gen.rs


base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
-- 
2.41.0

