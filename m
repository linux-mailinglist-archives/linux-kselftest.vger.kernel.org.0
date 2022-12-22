Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20F653B06
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLVDwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVDwP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:15 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210E183BB;
        Wed, 21 Dec 2022 19:52:14 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 35309819E8;
        Thu, 22 Dec 2022 03:52:09 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681134;
        bh=ctfL3IPeMOTbGILYsO0YelFrNOG+80gl6emPmcMwO50=;
        h=From:To:Cc:Subject:Date:From;
        b=U2NQs+ViudUGNkX7v1zVqEra5R4HSo2oNFR3uNsgpPZ/5OZM0/fVe7KKT2cSegfTd
         BYmb+xqrGh9REoO0T68B3Q1hOBGMOj3lM65tNMn6ZND+jv6OANFttWzvrjwnOCZkvm
         jjGKFjhy0U2HQsBAtBmrHbVlbNk+ekxWBNa7p4LZGvYwaBYaol5FIKbUJ5I9IFIq5f
         FjG0MCI9elimDtWUrn4vtxM/wSwqCAnrGbBewuH5NJDutKbSZyJr/HM1qg0Weoeoyu
         KtLjK38aSdZ6tpgW/nYDBMNft6hVQfsDL4bNr7Jtf/bwj1bc8awD9Nne8c3SFvuoNN
         +4Bc/Keejc10g==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 0/8] nolibc signal handling support
Date:   Thu, 22 Dec 2022 10:51:26 +0700
Message-Id: <20221222035134.3467659-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Hi,

This series adds signal handling support to the nolibc subsystem.

1)  Initial implementation of nolibc sigaction(2) function.

    Currently, this implementation is only available on the x86-64 arch.

    sigaction() needs an architecture-dependent "signal trampoline"
    function that invokes the __rt_sigreturn syscall to resume the process
    after a signal gets handled.

    On Linux x86-64, the "signal trampoline" function has to be written in
    inline Assembly to prevent the compiler from controlling the %rsp
    (e.g., with -fno-omit-frame-pointer, every function has a pushq
    %rbp that makes the %rsp no longer point to struct rt_sigframe).

    The "signal trampoline" function is called __arch_restore_rt in this
    implementation.

2)  signal(2) function.

    signal() function is the simpler version of sigaction(). Unlike
    sigaction(), which fully controls the struct sigaction, the caller
    only cares about the sa_handler when calling the signal() function.

    signal() internally calls sigaction(). This implementation is
    currently only available on the x86-64 arch. When the sigaction()
    function support is expanded to other architectures, this function
    will automatically support those architectures. It's basically just
    a sigaction() wrapper.

3)  Extra nolibc updates.

    Apart from the signal handling support. This series also contains
    nolibc updates, they are:

      - getpagesize() support.
      - CFLAGS update.
      - fork(2) selftest.
      - sigaction(2) selftest.
      - signal(2) selftest.
      - getpagesize(2) selftest.

There 8 patches in this series. It has been tested on Linux x86-64 arch
and all tests OK.

    $ sudo ./nolibc-test
    Running test 'syscall'
    ...
    ...
    66 wait_child = -1 ECHILD                [OK]
    67 waitpid_min = -1 ESRCH                [OK]
    68 waitpid_child = -1 ECHILD             [OK]
    69 write_badf = -1 EBADF                 [OK]
    70 write_zero = 0                        [OK]
    Errors during this test: 0


    Running test 'stdlib'
    ...
    ...
    14 memcmp_60_20 = 64                     [OK]
    15 memcmp_20_e0 = -192                   [OK]
    16 memcmp_e0_20 = 192                    [OK]
    17 memcmp_80_e0 = -96                    [OK]
    18 memcmp_e0_80 = 96                     [OK]
    Errors during this test: 0

    Total number of errors: 0
    Exiting with status 0

    $ make run -j8
    Kernel: arch/x86/boot/bzImage is ready  (#3)
    ...
    82 test(s) passed.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

It's also available in the Git repository.

The following changes since commit caf5c36025ec9395c8d7c78957b016a284812d23:

  srcu: Update comment after the index flip (2022-12-21 09:01:53 -0800)

are available in the Git repository at:

  https://github.com/ammarfaizi2/linux-block testing/rfc.v1.2022-12-22.nolibc

for you to fetch changes up to ac79aca684125907bfbefadfd6c6be0ccdfe8b33:

  selftests/nolibc: Add `getpagesize(2)` selftest (2022-12-22 09:57:31 +0700)

----------------------------------------------------------------
Ammar Faizi (8):
    nolibc/sys: Implement `sigaction(2)` function
    nolibc/sys: Implement `signal(2)` function
    nolibc/sys: Implement `getpagesize(2)` function
    selftests/nolibc: Add `-Wall` and `-Wno-unsed-function` to the CFLAGS
    selftests/nolibc: Add `fork(2)` selftest
    selftests/nolibc: Add `sigaction(2)` selftest
    selftests/nolibc: Add `signal(2)` selftest
    selftests/nolibc: Add `getpagesize(2)` selftest

 tools/include/nolibc/arch-x86_64.h           |  12 +
 tools/include/nolibc/sys.h                   | 224 +++++++++++++++++++
 tools/testing/selftests/nolibc/Makefile      |   2 +-
 tools/testing/selftests/nolibc/nolibc-test.c | 219 +++++++++++++++++-
 4 files changed, 454 insertions(+), 3 deletions(-)


base-commit: caf5c36025ec9395c8d7c78957b016a284812d23
-- 
Ammar Faizi

