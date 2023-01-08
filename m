Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCB66159B
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjAHN7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjAHN7L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:11 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E236DE99;
        Sun,  8 Jan 2023 05:59:11 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 43D2B7E500;
        Sun,  8 Jan 2023 13:59:08 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186351;
        bh=GTUZnCbGV/UWFXA7BcCYjMcKchB8a7OfQh/kkhPzwLA=;
        h=From:To:Cc:Subject:Date:From;
        b=FVpcN3GUI1xGzqnS0IYPQevi4phQ4IgCjHI5gq/WhWwKGWLjgUxuPnpHuTt9GWZsV
         +CEjy8ktVdHJb5xSYX8+e0ahe6H2f8pl7j6LInpZ59JhwwaRfTc6VldMChnCgFnuuA
         IGK+5QxBUkVktnk6Qju37UZrZFYwhhiJ02eRYQmWT5HnBGIxB/QavIWvalOG+ChSPO
         JWurRuoD9T5DSEwroXsVUaFbGisIJQ+qqBSp/O4kyQDBFpdLDDdtkaHj1J6yLCCKko
         dcha1wlK/2IgpBvBNQZwZLjJW1d9sNol+c9EOvIylSVpub2VwZ1PJ3Yk6bYCGgqJ3a
         q2XrSpnHaldOA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 0/5] nolibc signal handling support
Date:   Sun,  8 Jan 2023 20:58:59 +0700
Message-Id: <20230108135904.851762-1-ammar.faizi@intel.com>
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

Hi Willy,

On top of the series titled "nolibc auxiliary vector retrieval support".
The prerequisite patches of this series are in that series.

This is v2 of nolibc signal handling support. It adds signal handling
support to the nolibc subsystem:

1)  Initial implementation of nolibc sigaction(2) function.

    `sigaction()` needs an architecture-dependent "signal trampoline"
    function that invokes __rt_sigreturn syscall to resume the process
    after a signal gets handled.

    The "signal trampoline" function is called `__restore_rt` in this
    implementation. The naming `__restore_rt` is important for GDB. It
    also has to be given a special optimization attribute
    "omit-frame-pointer" to prevent the compiler from creating a stack
    frame that makes the `%rsp` value no longer points to the `struct
    rt_sigframe` that the kernel constructed.


2)  signal(2) function.

    signal() function is the simpler version of sigaction(). Unlike
    sigaction(), which fully controls the struct sigaction, the caller
    only cares about the sa_handler when calling the signal() function.
    signal() internally calls sigaction().


3)  More selftests.

    This series also adds selftests for:
      - fork(2)
      - sigaction(2)
      - signal(2)


Side note for __restore_rt:
This has been tested on x86-64 arch and `__restore_rt` generates the
correct code. The `__restore_rt` codegen correctness on other
architectures need to be evaluated as well. If it can't generate the
correct code, it has to be written in inline Assembly.

The current codegen for __restore_rt looks like this (gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0):

  00000000004038e3 <__restore_rt>:
    4038e3:  endbr64 
    4038e7:  mov    $0xf,%eax
    4038ec:  syscall

## Changes since v2:
  - Fix unintentionally squashed patch. The signal() selftest patch
    was squashed into the sigaction selftest patch.

## Changes since RFC v1:
  - Separate getpagesize() series.
  - Write __restore_rt function in C instead of in inline Assembly.


Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (5):
  nolibc/sys: Implement `sigaction(2)` function
  nolibc/sys: Implement `signal(2)` function
  selftests/nolibc: Add `fork(2)` selftest
  selftests/nolibc: Add `sigaction(2)` selftest
  selftests/nolibc: Add `signal(2)` selftest

 tools/include/nolibc/sys.h                   |  97 +++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 172 +++++++++++++++++++
 2 files changed, 269 insertions(+)


base-commit: b6887ec8b0b0c78db414b78e329bf2ce234dedd5
prerequisite-patch-id: 8dd0ca8ecee1732d8f5c0b233f8231dda6ab0d22
prerequisite-patch-id: ff4c08615ebbdc1a04ce39f39f99387ee46b2b31
prerequisite-patch-id: af837a829263849331eb6d73701afd7903146055
-- 
Ammar Faizi

