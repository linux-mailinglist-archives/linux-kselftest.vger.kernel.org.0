Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D112B770E03
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHEGKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 02:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHEGKQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 02:10:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D934ED0;
        Fri,  4 Aug 2023 23:10:13 -0700 (PDT)
X-QQ-mid: bizesmtp64t1691215799t7z7uzec
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 14:09:58 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: QityeSR92A3gbNDFPhPkOKhTf88+3peFT35F7/3eUiboDR7f37GWnwpwapJmz
        rMbA7hYOKcn4xFz+GEE2tLbdxYlGB3zH+XF9G1wmLGwYgPUR9Lf8XCegHEqrJGvgJuFshh1
        tiASfgNkOiCxQhelU2F515xVOZaDIXmKrl5B/ZaJ/+8u3pE8NnLDr2AvSdJBzfB+RizdTL/
        0RE8uUNaR6kL2TioLKninLlqrNc6W3qDpdi6ZzznMeZo/HeTQixLLars6FgqHpBL0QU7rAi
        SGbysSc8e6kEcdHUttkbprRhOHKxdi4lrnl1Q2K9eYhtgYQg45L03uJMjXwDwWyTMVEPXKT
        +Vuw7YWmy9Sdl/hXyAEcM9/zlO3xwomxTPBXZUvirpZXCfWI8T3UdQKIDLsFg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16134705412048347800
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] selftests/nolibc: add misc improvments
Date:   Sat,  5 Aug 2023 14:09:57 +0800
Message-Id: <cover.1691215074.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Hi Thomas

Based on Thomas' suggestion, V2 comes here with relative path support
for O= option, v1 is [1].

    // subdir
    $ pwd
    /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out
    Makefile:125: OUTPUT=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

    // topdir
    $ pwd
    /labs/linux-lab/src/linux-stable
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/src/linux-stable/out
    Makefile:125: OUTPUT=/labs/linux-lab/src/linux-stable/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

    // outside
    $ pwd
    /labs/linux-lab/build
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/build/out
    Makefile:125: OUTPUT=/labs/linux-lab/build/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

Changes from v1 --> v2:

* selftests/nolibc: allow report with existing test log
  tools/nolibc: stackprotector.h: make __stack_chk_init static

    Add Reviewed-by line from Thomas

* selftests/nolibc: fix up O= option support

    Now with relative path support with the help of $(COMMAND_O).

    Suggested by Thomas.

Thanks!
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1691073180.git.falcon@tinylab.org/

Zhangjin Wu (3):
  selftests/nolibc: allow report with existing test log
  tools/nolibc: stackprotector.h: make __stack_chk_init static
  selftests/nolibc: fix up O= option support

 tools/include/nolibc/crt.h              |  2 +-
 tools/include/nolibc/stackprotector.h   |  5 ++---
 tools/testing/selftests/nolibc/Makefile | 19 +++++++++++++------
 3 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.25.1

