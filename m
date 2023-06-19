Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2766D735B41
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFSPkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSPkg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:40:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CF113;
        Mon, 19 Jun 2023 08:40:32 -0700 (PDT)
X-QQ-mid: bizesmtp74t1687189213tv6onhfr
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:40:12 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: vLOCICHxEeCdPu6sxmPtsZK2JR41RQr69IIe96Zy/WgX2mbiQUxlN61O1ndW5
        UXzJ/B3lyJL6i/R4h2zRfxILs4UT4iZK/xKxFXfZAStwRkWnCA54CN1R+h240f1a7vUDO3/
        vMoRBnTqis9myq4zdL+BbIlnDjNPZ962VZv3wXbhNiRgYZI2w3Dj/SdjGuNHQO3j1f6zjKM
        UZTSf39u/FPW9KwavQfUU+v5KDVtC11x9oecSsl8y8FJPAOhzbc0MbKcryZKBLiVLdItFmA
        aUj65E8V8cq0Uv3Npj72F0SD/lHFd0Ewb7iBcLfUmCR1xMxTG+vhiFhjqf20Jl7rfolA9lw
        PeOBTP07LE3SqrAjWC6NlCkB2M4sTqroI+QAmozZOxeapmlPnk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11779720520343571934
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 00/10] tools/nolibc: add a new syscall helper
Date:   Mon, 19 Jun 2023 23:40:10 +0800
Message-Id: <cover.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas, David, Willy

Thanks very much for your kindly review.

This is the revision of v3 "tools/nolibc: add a new syscall helper" [1],
this mainly applies the suggestion from David in this reply [2] and
rebased everything on the dev.2023.06.14a branch of linux-rcu [3].

The old __sysret() doesn't support the syscalls with pointer return
value, this revision now supports such syscalls. The left mmap() syscall
is converted to use this new __sysret() with additional test cases.

Changes from v3 -> v4:

* tools/nolibc: sys.h: add a syscall return helper
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper

  The original v3 series, no code change, except the Reviewed-by lines
  from Thomas.

* tools/nolibc: unistd.h: reorder the syscall macros

  reorder the syscall macros in using order and align most of them.

* tools/nolibc: add missing my_syscall6() for mips

  required by mmap() syscall, this is the last missing my_syscall6().

* tools/nolibc: __sysret: support syscalls who return a pointer

  Apply suggestion from David.  

  Let __sysret() also supports syscalls with pointer return value, so, the
  return value is converted to unsigned long and the comparing of < 0 is
  converted to the comparing of [(unsigned long)-MAX_ERRNO, (unsigned long)-1].

  This also allows return a huge value (not pointer) with highest bit as 1.

  It is able to merge this one to the first one if necessary.

* tools/nolibc: clean up mmap() support

  Apply new __sysret(), clean up #ifdef and some macros.

* selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting
  selftests/nolibc: add mmap and munmap test cases

  Add some mmap & munmap test cases and the corresponding helpers, to
  verify one of the new helpers, a sbrk_0 test case is also added.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/linux-riscv/87e7a391-b97b-4001-b12a-76d20790563e@t-8ch.de/
[2]: https://lore.kernel.org/linux-riscv/94dd5170929f454fbc0a10a2eb3b108d@AcuMS.aculab.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/

Zhangjin Wu (10):
  tools/nolibc: sys.h: add a syscall return helper
  tools/nolibc: unistd.h: apply __sysret() helper
  tools/nolibc: sys.h: apply __sysret() helper
  tools/nolibc: unistd.h: reorder the syscall macros
  tools/nolibc: add missing my_syscall6() for mips
  tools/nolibc: __sysret: support syscalls who return a pointer
  tools/nolibc: clean up mmap() support
  selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
  selftests/nolibc: add sbrk_0 to test current brk getting
  selftests/nolibc: add mmap and munmap test cases

 tools/include/nolibc/arch-mips.h             |  26 ++
 tools/include/nolibc/nolibc.h                |   9 +-
 tools/include/nolibc/sys.h                   | 391 +++----------------
 tools/include/nolibc/types.h                 |  11 +
 tools/include/nolibc/unistd.h                |  13 +-
 tools/testing/selftests/nolibc/nolibc-test.c |  90 +++++
 6 files changed, 191 insertions(+), 349 deletions(-)

-- 
2.25.1

