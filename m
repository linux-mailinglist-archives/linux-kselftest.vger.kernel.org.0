Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B076E72F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjHCLnj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbjHCLnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 07:43:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8412D7E;
        Thu,  3 Aug 2023 04:43:26 -0700 (PDT)
X-QQ-mid: bizesmtp63t1691062991t0zm8hh2
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 19:43:10 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4lznXfczr6G1t9NCj67hAkubVgxBvxPLPz+GeZ878pi4g1Vp6XCr
        aZeKWFdZsfhkNu0Eutv8sEBXAPMxZ4jxOmvEJZUGCGfcL6t3reRKIU84YK6PG/KjUxRlDLk
        2fQgFtuK7167+iSCXXLeIi5JKU2AwUckPksH3meyGQv9i83z4mOk/8fyRWQigsfzlEnGnh+
        lYGU9h3q/IrXNK2z3/+o3n2HQhPSQc/6CJtUcJ28TkpzNTneMps72JJMi1wCdV+2uECTIW3
        +djV5uJpSPld5p1IVoYR2PJdtzQe5OGiLYOSdVsZsJC6zw+KslrFObgJNGkQmajrhDzd3O0
        w7ZaW/LefjMz5bXkfUPsubvSCbfqWFMa+yxcNA1+sRGOPAiTzfDQ7J0GgMwm4oQ7Ic3dFSG
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15103492080593092378
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v5 0/8] tools/nolibc: add 32/64-bit powerpc support
Date:   Thu,  3 Aug 2023 19:43:09 +0800
Message-Id: <cover.1691062722.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Here is the v5, purely include the ppc parts, with two critical fixups
for the latest gcc 13.1.0 toolchain, now, both run and run-user pass.

Here is the run-user test report:

    // with local toolchains
    $ for arch in ppc ppc64 ppc64le; do make run-user XARCH=$arch | grep "status: "; done
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

    // with latest toolchains
    $ for arch in ppc ppc64 ppc64le; do make run-user XARCH=$arch CC=/path/to/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc | grep status; file nolibc-test; done
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    nolibc-test: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), statically linked, stripped
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    nolibc-test: ELF 64-bit MSB executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), statically linked, stripped
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    nolibc-test: ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), statically linked, stripped

Since the missing serial console enabling patch [1] for ppc32 has
already gotten a Reviewed-by line from the ppc maintainer, now, the ppc
defconfig aligns with the others', and it is able to simply move the
nolibc-test-config related stuff to the next tinyconfig series.

Based on v4 [2], beside removing several nolibc-test-config related
patches, two bugs with the latest gcc 13.1.0 have been fixed.

Changes from v4 --> v5:  

* tools/nolibc: add support for powerpc64
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add test support for ppc64
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

    Almost the same as v4.

* tools/nolibc: add support for powerpc

    For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
    "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
    works with __attribute__((__optimize__("-fno-stack-protector")))

    Using the later for ppc32 to workaround the issue.

* selftests/nolibc: add test support for ppc

    Add default CFLAGS for ppc to allow build with the
    latest powerpc64-linux-gcc toolchain from
    https://mirrors.edge.kernel.org/pub/tools/crosstool/ 

* selftests/nolibc: add test support for ppc64le

    Align with kernel, prefer elfv2 ABI to elfv1 ABI when the toolchain
    support, otherwise, ABI mismatched binary will not run.

Best regards,
Zhangjin Wu
---
[1]: https://lore.kernel.org/lkml/bb7b5f9958b3e3a20f6573ff7ce7c5dc566e7e32.1690982937.git.tanyuan@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1690916314.git.falcon@tinylab.org/

Zhangjin Wu (8):
  tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

 tools/include/nolibc/arch-powerpc.h     | 213 ++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/testing/selftests/nolibc/Makefile |  74 ++++++--
 3 files changed, 277 insertions(+), 12 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h

-- 
2.25.1

