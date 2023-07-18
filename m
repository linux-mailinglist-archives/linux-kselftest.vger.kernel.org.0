Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AB757325
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 07:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGRF2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 01:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGRF2X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 01:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5151B4;
        Mon, 17 Jul 2023 22:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4BAD61449;
        Tue, 18 Jul 2023 05:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEC8C433C7;
        Tue, 18 Jul 2023 05:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689658098;
        bh=7iXgZG+sAao9EiM/MYrol8iZhmMKSLST94IdeQsuv50=;
        h=From:To:Cc:Subject:Date:From;
        b=K864lF2Cg7Qnz+CSxgiCbk8frVYVdXUQI006XgntrIv9tjtbhWLFQVSJDXissUV36
         zEUBoFNVaYoaAIWKzF/Z+Bm7EX2WiGijPl5fD/ZYnuJtyYrgqoWEhMygoeiGHkJapQ
         vQKfuPAfZFIEPYMi3N4gu2VNRdUNCWgja5kNsmtkwsRyTwyHuFV4c6BO3yvqvSv/ow
         YMK6re0kclBhFo7vDgmwBTkWslaI9AgyS7fAKmq6NjAdVTkaA4ljo9YJ0LnqdQt9mP
         RoXUI6vbaTaqe+PruACFEeKsFL4VoJ8R4ft5iw604hT6xg/je2vKWrkssaj3Sy6SX5
         ZnJvQ/742KEDA==
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
Subject: [PATCH v2 0/7] KUnit integration for Rust doctests
Date:   Tue, 18 Jul 2023 07:27:45 +0200
Message-ID: <20230718052752.1045248-1-ojeda@kernel.org>
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

v1: https://lore.kernel.org/rust-for-linux/20230614180837.630180-1-ojeda@kernel.org/
v2:

  - Rebased on top of v6.5-rc1, which requires a change from
    `kunit_do_failed_assertion` to `__kunit_do_failed_assertion` (since
    the former became a macro) and the addition of a call to
    `__kunit_abort` (since previously the call was done by the old
    function which we cannot use anymore since it is a macro). (David)

  - Added prerequisite patch to KUnit header to include `stddef.h` to
    support the `KUNIT=y` case. (Reported by Boqun)

  - Added comment on the purpose of `trait FromErrno`. (Martin asked
    about it)

  - Simplify code to use `std::fs::write` instead of `write!`, which
    improves code size too. (Suggested by Alice)

  - Fix copy-paste type in docs from "error" to "info" and, to make it
    proper English, copy the `printk` docs style, i.e. from "info"
    to "info-level message" -- and same for the "error" one. (Miguel)

  - Swap `FILE` and `LINE` `static`s to keep the same order as done
    elsewhere. (Miguel)

  - Rename config option from `RUST_KERNEL_KUNIT_TEST` to
    `RUST_KERNEL_DOCTESTS` (and update its title), so that we can use
    the former for the "normal" (i.e. non-doctests, e.g. `#[test]` ones)
    tests in the future. (David)

  - Follow the syntax proposed for declaring test metadata in the KTAP
    v2 spec, which may also get used for the KUnit test attributes API.

    Thus, instead of "# Doctest from line {line}", use
    "# {test_name}.location: {file}.{line}", which ideally will allow to
    migrate to a KUnit attribute later.

    This is done in all cases, i.e. when the tests succeeds, because
    it may be useful for users running KUnit manually, or when passing
    `--raw_output` to `kunit.py`. (David)

    David: I used "location" instead of your suggested "line" alone, in
    order to have both in a single line, which looked nice and closer to
    the "ASSERTION FAILURE" case/line, since now we do have the original
    file (please see below).

  - Figure out the original line. This is done by deploying an anchor
    so that the difference in lines between the beginning of the test
    and the assert, in the generated file, can be computed. Then, we
    offset the line number of the original test, which is given by
    `rustdoc`. (developed by Boqun)

  - Figure out the original file. This is done by walking the
    filesystem, checking directory prefixes to reduce the amount of
    combinations to check, and it is only done once per file (rather
    than per test).

    Ambiguities are detected and reported. It does limit the filenames
    (module names) we can use, but it is unlikely we will hit it soon
    and this should be temporary anyway until `rustdoc` provides us
    with the real path. (Miguel)

    Tested with both in-tree and `O=` builds, but I would appreciate
    extra testing on this one, including via the `kunit.py` script.

  - The three last items combined means that we now see this output even
    for successful cases:

        # rust_doctest_kernel_sync_locked_by_rs_0.location: rust/kernel/sync/locked_by.rs:28
        ok 53 rust_doctest_kernel_sync_locked_by_rs_0

    Which basically gives the user all the information they need to go
    back to the source code of the doctest, while keeping them fairly
    stable for bisection, and while avoiding to require users to write
    test names manually. (David + Boqun + Miguel)

    David: from what I saw in v2 of the RFC for the test attributes API,
    the syntax still contains the test name when it is not a suite, so
    I followed that, but if you prefer to omit it, please feel free to
    do so (for me either way it is fine, and if this is the expected
    attribute syntax, I guess it is worth to follow it to make migration
    easier later on):

        # location: rust/kernel/sync/locked_by.rs:28
        ok 53 rust_doctest_kernel_sync_locked_by_rs_0

  - Collected `Reviewed-by`s and `Tested-by`s, except for the main
    commit due to the substantial changes.

Miguel Ojeda (7):
  kunit: test-bug.h: include `stddef.h` for `NULL`
  rust: init: make doctests compilable/testable
  rust: str: make doctests compilable/testable
  rust: sync: make doctests compilable/testable
  rust: types: make doctests compilable/testable
  rust: support running Rust documentation tests as KUnit ones
  MAINTAINERS: add Rust KUnit files to the KUnit entry

 MAINTAINERS                       |   2 +
 include/kunit/test-bug.h          |   2 +
 lib/Kconfig.debug                 |  13 ++
 rust/.gitignore                   |   2 +
 rust/Makefile                     |  29 ++++
 rust/bindings/bindings_helper.h   |   1 +
 rust/helpers.c                    |   7 +
 rust/kernel/init.rs               |  26 +--
 rust/kernel/kunit.rs              | 163 +++++++++++++++++++
 rust/kernel/lib.rs                |   2 +
 rust/kernel/str.rs                |   4 +-
 rust/kernel/sync/arc.rs           |   9 +-
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs |   1 +
 rust/kernel/types.rs              |   6 +-
 scripts/.gitignore                |   2 +
 scripts/Makefile                  |   4 +
 scripts/rustdoc_test_builder.rs   |  72 +++++++++
 scripts/rustdoc_test_gen.rs       | 260 ++++++++++++++++++++++++++++++
 19 files changed, 591 insertions(+), 15 deletions(-)
 create mode 100644 rust/kernel/kunit.rs
 create mode 100644 scripts/rustdoc_test_builder.rs
 create mode 100644 scripts/rustdoc_test_gen.rs


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

