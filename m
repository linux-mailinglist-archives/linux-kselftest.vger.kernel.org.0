Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281957502A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjGLJPo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGLJPn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:15:43 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770A8FB;
        Wed, 12 Jul 2023 02:15:40 -0700 (PDT)
X-QQ-mid: bizesmtp78t1689153330t5p9jpia
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:15:29 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: aBJFcW+uBGY71Xw51Pe1VJBZqwvWdfJudhp8fr67SS8yC+nzmZ3yNaYAkBZ9Z
        0KoDdePXRy7AD5YTUUYWPlEGt0VlVeybPyqOLrF+nHwjvp19vX3qfpAvqqqCpBtkNORNZ+h
        ZraN06Z40Y5k6J2sO9vWuI/osGFxCfKwNl689WfAHzTQLmEk7lJvB2A1GturBchy+jglFv1
        XxO5lZF7F1eVW8vzZpuKUBbyivMpwDUYZQIGSQ8Q/fcZhu8nBboLJaYGSG88JdLh9E5tpE5
        SkQto6Apu9lK+jztXYtXZckKklQsc3FACntjPRZMoBhyDkc5vZSs6s4jGB+ZBUfd7X+BfMJ
        Tnvz0qYVsSIwUfs05aQd0GgX+1olLfhjcxz9ieW8mRVK3MJu6mEkUd9gL8aNDxLPJt67A2h
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3322903985340973383
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 00/11] tools/nolibc: shrink arch support
Date:   Wed, 12 Jul 2023 17:15:28 +0800
Message-Id: <cover.1689150149.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

Here is the revision of the v2 arch support shrink patchset [1], it
mainly applies suggestions from you.

It is based on the 20230710-nolibc-ser2-tom-syscall-configv4-report
branch of nolibc repo.

Tested for all of the supported archs:

           arch/board | result
          ------------|------------
      arm/versatilepb | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
      arm/vexpress-a9 | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
             arm/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
         aarch64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
              i386/pc | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
            x86_64/pc | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
         mipsel/malta | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
     loongarch64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
         riscv64/virt | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.
         riscv32/virt | 151 test(s): 122 passed,   7 skipped,  22 failed => status: failure.
s390x/s390-ccw-virtio | 151 test(s): 144 passed,   7 skipped,   0 failed => status: warning.

Changes from v2 --> v3:

* tools/nolibc: remove the old sys_stat support

    Revert the reorg operation, basically the same as v1

* tools/nolibc: add new crt.h with _start_c

    Revert the reorg operation
    Add crt.h in Makefile
    Add _nolibc_main alias for main to silence the compile warning about 

* tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c

    Revert the reorg operation, but still use post-whitespaces instead of post-tab.
    Include "crt.h" in arch-<ARCH>.h

* tools/nolibc: arch-*.h: add missing space after ','

    Fix up the errors reported by scripts/checkpatch.pl

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1688828139.git.falcon@tinylab.org/

Zhangjin Wu (11):
  tools/nolibc: remove the old sys_stat support
  tools/nolibc: add new crt.h with _start_c
  tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c
  tools/nolibc: arch-*.h: add missing space after ','

 tools/include/nolibc/Makefile         |  1 +
 tools/include/nolibc/arch-aarch64.h   | 56 ++----------------
 tools/include/nolibc/arch-arm.h       | 82 +++------------------------
 tools/include/nolibc/arch-i386.h      | 61 +++-----------------
 tools/include/nolibc/arch-loongarch.h | 45 ++-------------
 tools/include/nolibc/arch-mips.h      | 76 ++++---------------------
 tools/include/nolibc/arch-riscv.h     | 68 +++-------------------
 tools/include/nolibc/arch-s390.h      | 63 ++------------------
 tools/include/nolibc/arch-x86_64.h    | 57 +++----------------
 tools/include/nolibc/crt.h            | 59 +++++++++++++++++++
 tools/include/nolibc/sys.h            | 63 ++++----------------
 tools/include/nolibc/types.h          |  4 +-
 12 files changed, 133 insertions(+), 502 deletions(-)
 create mode 100644 tools/include/nolibc/crt.h

-- 
2.25.1

