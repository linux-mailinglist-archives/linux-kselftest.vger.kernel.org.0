Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF9763987
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGZOso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjGZOsg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:48:36 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E131FD5;
        Wed, 26 Jul 2023 07:48:32 -0700 (PDT)
X-QQ-mid: bizesmtp62t1690382901tdqnmwb9
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:48:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: PS/N6jJLnDbWPzOemGr4bNmLGhOlX8aAHcyd+lhmPOqpMTHAYgJ0sP+uX6rbD
        RU2EPCx7QW/LeX1uDe7xJp+tu3TGz3E+j6x9+p/w7djS4qrd5CMs4nB07UBDchlnYvYkCDz
        J8yU/f1u0goeJBi8sod/tpVuZmTDaWQ7RK+pc6hEmoL+S3opG/qONZ8C6NKYTjmQln2PqRN
        r4VNW5A8CSbXVgq5BTBk4PL6HOGX8cLlyWAmC1q4J/v/blS+mCdiDNOGlS6CDI2T6H+9Qk5
        9tYb8TP2+ufpWkFhQR3G8qGwNcmGA2/tzWGf0IHYNkGTlNV/yJQi7zcqWPCNix4Uj4IhyqB
        ncWNOd5Ogfmfd8j+LqN7Fuyb81D2Fg5CahmVVmFJtbItIzyw6uyMoKxiZmytg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18036633287261470269
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 0/7] tools/nolibc: add 32/64-bit powerpc support
Date:   Wed, 26 Jul 2023 22:48:11 +0800
Message-Id: <cover.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

The suggestions of v1 nolibc powerpc patchset [1] from you have been applied,
here is v2.

Testing results:

- run with tinyconfig

     arch/board | result
    ------------|------------
    ppc/g3beige | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
    ppc/ppce500 | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
ppc64le/pseries | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
ppc64le/powernv | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
  ppc64/pseries | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
  ppc64/powernv | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.

- run-user

    (Tested with -Os, -O0 and -O2)

    // for 32-bit PowerPC
    $ for arch in powerpc ppc; do make run-user ARCH=$arch CROSS_COMPILE=powerpc-linux-gnu- ; done | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

    // for 64-bit big-endian PowerPC and 64-bit little-endian PowerPC
    $ for arch in ppc64 ppc64le; do make run-user ARCH=$arch CROSS_COMPILE=powerpc64le-linux-gnu- ; done | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

Changes from v1 --> v2:

- tools/nolibc: add support for powerpc

    Add missing arch-powerpc.h lines to arch.h

    Align with the other arch-<ARCH>.h, naming the variables
    with more meaningful words, such as _ret, _num, _arg1 ...

    Clean up the syscall instructions

    No line from musl now.

    Suggestons from Thomas

* tools/nolibc: add support for pppc64

    No change

* selftests/nolibc: add extra configs customize support

    To reduce complexity, merge the commands from the new extraconfig
    target to defconfig target and drop the extconfig target completely.

    Derived from Willy's suggestion of the tinyconfig patchset

* selftests/nolibc: add XARCH and ARCH mapping support

    To reduce complexity, let's use XARCH internally and only reserve
    ARCH as the input variable.

    Derived from Willy's suggestion

* selftests/nolibc: add test support for powerpc

    Add ppc as the default 32-bit variant for powerpc target, allow pass
    ARCH=ppc or ARCH=powerpc to test 32-bit powerpc
    
    Derived from Willy's suggestion

* selftests/nolibc: add test support for pppc64le

    Rename powerpc64le to ppc64le

    Suggestion from Willy

* selftests/nolibc: add test support for pppc64

    Rename powerpc64 to ppc64

    Suggestion from Willy

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1689713175.git.falcon@tinylab.org/

Zhangjin Wu (7):
  tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: add extra configs customize support
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64

 tools/include/nolibc/arch-powerpc.h     | 202 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/testing/selftests/nolibc/Makefile |  48 +++++-
 3 files changed, 244 insertions(+), 8 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h

-- 
2.25.1

