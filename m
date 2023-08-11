Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B647799E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjHKVt7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 17:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjHKVt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 17:49:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1880271B;
        Fri, 11 Aug 2023 14:49:56 -0700 (PDT)
X-QQ-mid: bizesmtp72t1691790579tkj0p149
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 05:49:37 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: 6ArnuSDJ+imdjIsPAg2aZv30ftS7gvrLOQT/s0i2uZr+N4GpwHnJHt6VK7wh1
        biDC0h/O025nReykwSJTCXH4DssW37zZS2dabtY5B8HJJyugPHl7OCNk1vZxxinSkLiHt7S
        vWhchCv0HLIiYyUZIEKbr8nTMF98Q055kZ6rRhXBi0A99EbJgVXlyvbmcdEI782kV4x4oW5
        RKA6bd1xqCeZHTYnyN/B/UZj1WMwoARd76OGsVfQOBVawQfNPrCi3LSz9GH+F5dD36imZeI
        p5sfHu+dxqKC4p8WBz8Z78SnxkaQ0OrqsNDXInn7CORNGUBHyCMim8fguBq4jTdm+5ucvpN
        r9i9gQpb2cEFCWyRUOXgW5B5PYK+9misFDfHikwHi3UbSpGVhgXszGBMBApW+dmeBRsLg/B
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10591784151840439354
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, david.laight@aculab.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v6 0/2] tools/nolibc: fix up size inflat regression
Date:   Sat, 12 Aug 2023 05:49:36 +0800
Message-Id: <cover.1691788036.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

As we discussed in v5, I have proposed a my_syscall() macro, it can
convert all of the sys_* functions to macros, and such macros can simply
preserve input types from library routines and inherit the 'long' return
type from my_syscall<N>. As a result, our __sysret() helper will only
require to accept integer types and therefore we can simply revert it to
our old sign comparison version (but as macro).

I have already prepared a series of my_syscall() patchset but it
includes several not that simple patches, before sending it for review,
to directly solve the __sysret() issue at first, it is better to only
convert the current three sys_* functions to return 'long' instead of
pointer, which will make things easier.

Here is the testing result on all archs (except loongarch) with Arnd's
gcc 13.2.0, before testing it, we'd better apply the CROSS_COMPILE
patchset [1] manually:

    // before
    $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch 2>/dev/null | grep status | tr '\n' ' '; \
	size nolibc-test | tail -1 | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f2; done
         i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19654
       x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22337
        arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26292
          arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 23140
         mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 23164
          ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26812
        ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27380
      ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 28004
        riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22062
         s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22592 

    // after
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch 2>/dev/null | grep status | tr '\n' ' '; \
	size nolibc-test | tail -1 | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f2; done
         i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19502
       x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22000
        arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 25860
          arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 23108
         mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22908
          ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26616
        ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27192
      ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27816
        riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21790
         s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22184

    // compare
         i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19654 -> 19502
       x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22337 -> 22000
        arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26292 -> 25860
          arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 23140 -> 23108
         mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 23164 -> 22908
          ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26812 -> 26616
        ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27380 -> 27192
      ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 28004 -> 27816
        riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22062 -> 21790
         s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22592 -> 22184

After these two patches, will send the proposed my_syscall() patchset
tomorrow, it can even further reduce more type conversions and therefore
reduce more binary bytes, here is a preview of the testing result:

   // with the coming my_syscall() patchset, sys_* from functionsn to macros
     i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19250
   x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21733
    arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 25804
      arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22828
     mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22740
      ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26376
    ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26752
  ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27360
    riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 21746
     s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 21928

   // compare: __sysret() function -> __sysret() macro -> sys_* macros
         i386: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 19654 -> 19502 -> 19250 
       x86_64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22337 -> 22000 -> 21733
        arm64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26292 -> 25860 -> 25804
          arm: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 23140 -> 23108 -> 22828
         mips: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 23164 -> 22908 -> 22740
          ppc: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 26812 -> 26616 -> 26376
        ppc64: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 27380 -> 27192 -> 26752
      ppc64le: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 28004 -> 27816 -> 27360
        riscv: 160 test(s): 158 passed,   2 skipped,   0 failed => status: warning 22062 -> 21790 -> 21746
         s390: 160 test(s): 157 passed,   3 skipped,   0 failed => status: warning 22592 -> 22184 -> 21928

It can also shrink the whole sys.h from 1171 lines to around 738 lines.

Changes from v5 --> v6:

* The method introduced in v5 works but it is too complex ;-)

* Convert the return type of sys_brk/mmap/mmap2 from pointer to 'long'
  (like my_syscall<N> does), after this, all of the sys_* functions
  return integer.

* Restore __sysret() helper to sign comparison as originally, but also
  use macro instead of inline function to avoid useless input type and
  return type conversion.

Changes from v4 --> v5:

* Use __typeof__((arg) + 0) to lose the 'const' flag for old gcc
  versions.

* Import the famous __is_constexpr() macro from kernel side and add a
  __is_pointer() macro based on it. (David, to avoid introduce extra
  discuss on the prove-in-use __is_constexpr macro, this patch uses the
  original version instead of your suggested version, more info here:
  https://lore.kernel.org/lkml/20220131204357.1133674-1-keescook@chromium.org/)

* Use __builtin_choose_expr() to merge two comparisons to share the same
  errno setting code and the -1L assignment code.

Changes from v3 --> v4:

* fix up a new warning about 'ret < 0' when the input arg type is (void *)

Changes from v2 --> v3:

* define a __GXX_HAS_AUTO_TYPE_WITH_CONST_SUPPORT for gcc >= 11.0 (ABI_VERSION >= 1016)
* split __sysret() to two versions by the macro instead of a mixed unified and unreadable version
* use shorter __ret instead of __sysret_arg

Changes from v1 --> v2:

* fix up argument with 'const' in the type
* support "void *" argument


Best regards,
Zhangjin Wu
---

v5: https://lore.kernel.org/lkml/b6ff2684f557f6ce00151905990643e651391614.1691437328.git.falcon@tinylab.org/
v4: https://lore.kernel.org/lkml/a4084f7fac7a89f861b5582774bc7a98634d1e76.1691392805.git.falcon@tinylab.org/
v3: https://lore.kernel.org/lkml/8eaab5da2dcbba42e3f3efc2ae686a22c95f84f0.1691386601.git.falcon@tinylab.org/
v2: https://lore.kernel.org/lkml/95fe3e732f455fab653fe1427118d905e4d04257.1691339836.git.falcon@tinylab.org/
v1: https://lore.kernel.org/lkml/20230806131921.52453-1-falcon@tinylab.org/

[1]: https://lore.kernel.org/lkml/cover.1691783604.git.falcon@tinylab.org/

Zhangjin Wu (2):
  tools/nolibc: let sys_brk, sys_mmap and sys_mmap2 return long
  tools/nolibc: fix up size inflate regression

 tools/include/nolibc/arch-s390.h |  4 +--
 tools/include/nolibc/sys.h       | 43 +++++++++++++-------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

-- 
2.25.1

