Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6419A661565
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjAHNKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjAHNKw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:10:52 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF33E0F5;
        Sun,  8 Jan 2023 05:10:45 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id D039C7E5F8;
        Sun,  8 Jan 2023 13:10:42 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183445;
        bh=Iu+KSRgtBFBXIPOukiDoYsH1MtB/b6hleuzKbOVNuSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnnocOuKU7fuxuA9puxJIVyT5DECeLEBmcqhaxL3O+r2N/wvpKz8j8wO5njIUuizq
         lRSPfwRPTjlqoNrTuoKd1Vx0TgqCtEIIUwQLAJBj9kWAGa0bu6qSZDPK81BcbgP2ZC
         iF6ju3iE0a1PMzyVha849cfW0E24Li0s9KfMYwcHTna1NYpi5Mo0Fqqf1qYtCdi/6c
         FyFwEFtgTggjl6+/8KhNhtg5X9jGQ42VrWpbz3btykrGrdHFECmIca2FDR2rJuTh7B
         0HBK4sP61HWD7mrHm3LTDIDwLgIYAsKhPMCyTaMmrrfVzSI98de0qzlD2uy8P6yFv1
         stHBK+D0id+5Q==
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
Subject: [PATCH v2 0/4] nolibc signal handling support
Date:   Sun,  8 Jan 2023 20:10:34 +0700
Message-Id: <20230108131038.841204-1-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
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


## Changes since RFC v1:
  - Separate getpagesize() series.
  - Write __restore_rt function in C instead of in inline Assembly.


Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

Ammar Faizi (4):
  nolibc/sys: Implement `sigaction(2)` function
  nolibc/sys: Implement `signal(2)` function
  selftests/nolibc: Add `fork(2)` selftest
  selftests/nolibc: Add `sigaction(2)` selftest

 tools/include/nolibc/sys.h                   |  97 +++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 172 +++++++++++++++++++
 2 files changed, 269 insertions(+)


base-commit: b6887ec8b0b0c78db414b78e329bf2ce234dedd5
prerequisite-patch-id: 8dd0ca8ecee1732d8f5c0b233f8231dda6ab0d22
prerequisite-patch-id: ff4c08615ebbdc1a04ce39f39f99387ee46b2b31
prerequisite-patch-id: af837a829263849331eb6d73701afd7903146055
-- 
Ammar Faizi

