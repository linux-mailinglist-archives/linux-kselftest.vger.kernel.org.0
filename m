Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358F7779886
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHKU1O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHKU1N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:27:13 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D56D3;
        Fri, 11 Aug 2023 13:27:10 -0700 (PDT)
X-QQ-mid: bizesmtp82t1691785623tn8i0b23
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:27:02 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: UMQM+3VOEYtGKY/+1RDGuawm8rkjGCQuCQAGJ2FUNUZ6aMw2+CvbuX2q1pE7b
        U7AvHo+/7jkvDO9464KN7cXxLY9djefK3Wm1D/aHAZdWeFyWFAv3Jn9tQflcFBTPV4WXWZb
        pyk8zg8lzDUuf/+U18j1RAgFluZGW6YgGxLKLIF7QSCYAVsvbaGqb72nCfseSem0fEip0xd
        pu61mSJHtbMQ1CkokRVgyBvKOtkpv8BTWspjL4OGeH+pAjaw2Z9f3cCqTU35s4e5JdHSOwF
        Ch7fODDhYFhonkpizP2dWZ9ZHM6frTZOlR5m5RJQK/XTJMFSQdc5TdoyZaY1K0oRCAByjgc
        5tXQld38MLO4SWyGRN65EzM4sLoC4kuBdTp4Lep
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13364104683118344947
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 0/7] selftests/nolibc: customize CROSS_COMPILE for all supported architectures
Date:   Sat, 12 Aug 2023 04:27:01 +0800
Message-Id: <cover.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Here is v2 of the customized CROSS_COMPILE support, this helps a lot
during the testing of the other cross-arch nolibc changes:

    $ ARCHS="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390"
    $ for arch in ${ARCHS[@]}; do printf "%9s: " $arch; make run-user XARCH=$arch | grep status; done

Based on your suggestion, we did this changes:

- The qemu notes patch [1] is removed, welcome your doc file ;-)
- Arnd's crosstools are customized by default
- Import cc-cross-prefix to support local cross toolchains too
- Use mips64 toolchains for mips like x86_64 toolchains for i386, allow
  download less toolchains
- Use HOSTCC for libc-test compiling

Changes from v1 --> v2:

* selftests/nolibc: allow use x86_64 toolchain for i386

    No change.

* selftests/nolibc: allow use mips64 toolchain for mips

    Allow download less toolchains, save time save storage space

* selftests/nolibc: libc-test: use HOSTCC instead of CC

    libc-test is mainly for local test, use HOSTCC

* selftests/nolibc: allow customize CROSS_COMPILE by architecture

    Moved the ../../../scripts/Makefile.include after our customized
    CROSS_COMPILE, to let it prefix CC with $(CROSS_COMPILE) for us.

* selftests/nolibc: customize CROSS_COMPILE for all architectures

    Use Arnd's crosstools as the default ones

* selftests/nolibc: import cc-cross-prefix macro
  selftests/nolibc: allow use cross toolchains from software repository

    Import cc-cross-prefix to allow customize a list of the cross
    compilers, the ones from local repositories are appended in.

    If already installed ones from local repos, why not use them, let's
    do it.

Willy, since this series is really important to test the coming
patchsets, I send it here before the others to simplify the testing, but
we can delay its review, it is not urgent.

And here [2] is the simple script I wrote to download, decompress and
configure the PATH variable for Anrd's crosstools, hope it helps.

Best regards,
Zhangjin Wu
---
[1]: https://lore.kernel.org/lkml/6de680acbc2d87e13a680d4453ef022568bf489b.1691263493.git.falcon@tinylab.org/
[2]: https://gitee.com/tinylab/linux-lab/blob/next/tools/nolibc/crosstool.sh
 v1: https://lore.kernel.org/lkml/cover.1691263493.git.falcon@tinylab.org/ 

Zhangjin Wu (7):
  selftests/nolibc: allow use x86_64 toolchain for i386
  selftests/nolibc: allow use mips64 toolchain for mips
  selftests/nolibc: libc-test: use HOSTCC instead of CC
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for all architectures
  selftests/nolibc: import cc-cross-prefix macro
  selftests/nolibc: allow use cross toolchains from software repository

 tools/testing/selftests/nolibc/Makefile | 38 +++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.25.1

