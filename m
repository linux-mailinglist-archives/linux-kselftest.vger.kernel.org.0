Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E359A77117B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjHESih (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESig (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:38:36 -0400
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0EB7;
        Sat,  5 Aug 2023 11:38:33 -0700 (PDT)
X-QQ-mid: bizesmtp73t1691260702tguljiwh
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:38:21 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: b+hmI1kBZ2/hxcBf0Koj5y0uX2XNXtX4qBs7ULCP73q4T4FRMsQHk2KrVXF9g
        nUZPQMTfY+YM5+8MkX4FX2fNfY1vC5MVSPJloDp9ctyishM5lgyF9JzRzNNF2PbUsv5RJhx
        GQKWmNreEoPSq/8u8nXCjew8OXpA8Yb3wF3MxAwsKc8fEV3Fgs1mqOInn9X7NajuCySnarp
        DWCxfipSmjnUJeTl+kxxXwwNwKxG6WEaqfG5MX7N5Liw7eKNaJkI7FxsMh5G+dz3XSfdyzc
        GkIarPZsZsTwS0jGN1vadIagDEokOpby8ihlMcwTJTZuE/56mwsKlp/hMa+20MR+SA6gvOD
        kMv/GgmMRbfrSXkQVwxxUJ8JvmfEFkk1JU0IR/nkccLVxn94zFS9v3u2N4CjQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1465333361310842956
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v6 0/8] tools/nolibc: add 32/64-bit powerpc support
Date:   Sun,  6 Aug 2023 02:38:20 +0800
Message-Id: <cover.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

Now, the dependent pmac32_defconfig patch has been merged into the
powerpc next-test branch [1] ;-)

v6 here with a clean up of the CFLAGS for ppc variants, removed the
redundant -Wl options and call cc-option to check the -mmultiple option
for llvm as kernel does. v5 is [2].

Tests run with local toolchains and latest toolchains.

    $ for arch in ppc ppc64 ppc64le; do \
        make run-user XARCH=$arch | grep "status: "; \
      done
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

    $ for arch in ppc ppc64 ppc64le; do \
        make run-user XARCH=$arch CC=/labs/linux-lab/prebuilt/toolchains/ppc64/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc | grep "status: "; \
      done
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

Changes from v5 --> v6:

* selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64

    Removed the -Wl options.

    As comment from arch/powerpc/Makefile, use -mmultiple with cc-option for llvm has no such options.

* tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

    No changes.


BR,
Zhangjin Wu
---
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next-test
[2]: https://lore.kernel.org/lkml/cover.1691062722.git.falcon@tinylab.org/

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

