Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66167715C33
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjE3Kse (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 06:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjE3Kr5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 06:47:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D8102;
        Tue, 30 May 2023 03:47:50 -0700 (PDT)
X-QQ-mid: bizesmtp68t1685443664twnpak60
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 18:47:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: C46Rb8GPIEfLZaiD+Tj2Qw68S6CmHsgj7w+vsvgLRgBtK+77c1nm1Y+dZQciE
        yMI6X0Dlof9TqnGRL08Kb5tY/A2buyMdyGThpzwm1QqEHoKx4+PP5RZVSQGL6e09Ea2ij32
        pPlQiDnGe+eyZW3rXAOllns96irDaF1DQpNSoiDmefKR8ZO5cCnENDJLPXotANFNbd81R+Y
        MiTH03hSIMCL7dPxdORkEpZqOKy7IzSF54yu/EZozLuPdDxiZXEZkCLD9UtK56W3I2zckfd
        HIY0mB8eeNxgNNPDkUCYIK9Awd6LZ1jompcNnI9riAwkgLIieRr3LCP0yt7i4pzAAoUxlcU
        4jPq803VQxMD7rewyydupUZpW5wDtbxi7hA247/bsd/DPeXpc4lyUaSL+QCT5H2ADuk79yh
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14120017678416040009
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 0/4] selftests/nolibc: add user-space 'efault' handler
Date:   Tue, 30 May 2023 18:47:38 +0800
Message-Id: <cover.1685443199.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

This is not really for merge, but only let it work as a demo code to
test whether it is possible to restore the next test when there is a bad
pointer access in user-space [1].

Besides, a new 'run' command is added to 'NOLIBC_TEST' environment
variable or arguments to control the running iterations, this may be
used to test the reentrancy issues, but no failures found currently ;-)

With glibc, it works as following:

    $ ./nolibc-test run:2,syscall:28-30,stdlib:1
    Running iteration(s): 2

    Current iteration: 1

    Running test 'syscall', from 28 to 30
    28 dup3_m1 = -1 EBADF                                            [OK]
    29 efault_handler ! 11 SIGSEGV                                   [OK]
    30 execve_root = -1 EACCES                                       [OK]
    Errors during this test: 0

    Running test 'stdlib'
    1 getenv_blah = <(null)>                                         [OK]
    Errors during this test: 0

    Total number of errors in the 1 iteration(s): 0

    Current iteration: 2

    Running test 'syscall'
    28 dup3_m1 = -1 EBADF                                            [OK]
    29 efault_handler ! 11 SIGSEGV                                   [OK]
    30 execve_root = -1 EACCES                                       [OK]
    Errors during this test: 0

    Running test 'stdlib'
    1 getenv_blah = <(null)>                                         [OK]
    Errors during this test: 0

    Total number of errors in the 2 iteration(s): 0

With nolibc, it will be skipped (run:2,syscall:28-30,stdlib:10):

    Running iteration(s): 2

    Current iteration: 1

    Running test 'syscall', from 28 to 30
    28 dup3_m1 = -1 EBADF                                            [OK]
    29 efault_handler                                               [SKIPPED]
    30 execve_root = -1 EACCES                                       [OK]
    Errors during this test: 0

    Running test 'stdlib', from 10 to 10
    10 strrchr_foobar_o = <obar>                                     [OK]
    Errors during this test: 0

    Total number of errors in the 1 iteration(s): 0

    Current iteration: 2

    Running test 'syscall', from 28 to 30
    28 dup3_m1 = -1 EBADF                                            [OK]
    29 efault_handler                                               [SKIPPED]
    30 execve_root = -1 EACCES                                       [OK]
    Errors during this test: 0

    Running test 'stdlib', from 10 to 10
    10 strrchr_foobar_o = <obar>                                     [OK]
    Errors during this test: 0

    Total number of errors in the 2 iteration(s): 0

Best regards,
Zhangjin
---

[1]: https://lore.kernel.org/linux-riscv/20230529113143.GB2762@1wt.eu/ 

Zhangjin Wu (4):
  selftests/nolibc: allow rerun with the same settings
  selftests/nolibc: add rerun support
  selftests/nolibc: add user space efault handler
  selftests/nolibc: add user-space efault restore test case

 tools/testing/selftests/nolibc/nolibc-test.c | 247 +++++++++++++++++--
 1 file changed, 221 insertions(+), 26 deletions(-)

-- 
2.25.1

