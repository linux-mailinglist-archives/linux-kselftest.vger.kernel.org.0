Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601D376BDDE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjHATgR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjHATgQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:36:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446EC19A4;
        Tue,  1 Aug 2023 12:36:14 -0700 (PDT)
X-QQ-mid: bizesmtp74t1690918563tu5j6iav
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:36:02 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: 7YFKcddXaghqkRBpLDziBfBC85h2DKn+U6m/sBmgHfGSmVRsmTQhKYsQg42hM
        MbfkwiUcFRNNJuoTaXsSiXS7+l5BAw/+2gsQPjsjJCZS8j+tw8fE8TimR7dYP9i1pQmJd3Q
        c9DmXh2DVR4RUZSa3saIisYRc5H+xZjDn+A413a+sxEn2ZmTPqIFwfTpvjh5mtk0xgFouFP
        5vFSMa/l0ry511IC8G5iPzbNfNyK8jp1dajb+L8zxLptNVhupr5A9Vnf2x6fiJJu+xGDYO8
        KUwus8Az8FFaUzbZQgMVcHWqm7MP715tAg5aKS/fGqF5G15bJXniVmTqa3sP/YhjaHLoU83
        S8aC+rEioUrlAskK/E=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8572330015572247094
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 00/12] tools/nolibc: add 32/64-bit powerpc support
Date:   Wed,  2 Aug 2023 03:36:02 +0800
Message-Id: <cover.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Hi, Willy, Hi Thomas

v4 here is mainly with a new nolibc-test-config target from your
suggestions and with the reordering of some patches to make
nolibc-test-config be fast forward.

run-user tests for all of the powerpc variants:

    $ for arch in ppc ppc64 ppc64le; do make run-user XARCH=$arch | grep status; done
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

and defconfig + run for ppc:

    $ make nolibc-test-config XARCH=ppc
    $ make run XARCH=ppc 
    165 test(s): 159 passed,   6 skipped,   0 failed => status: warning


* tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64

    No change.

* selftests/nolibc: fix up O= option support
  selftests/nolibc: add macros to reduce duplicated changes

    From tinyconfig-part1 patchset, required by our nolibc-test-config target

    Let nolibc-test-config be able to use objtree and the kernel related
    macros directly.

* selftests/nolibc: add XARCH and ARCH mapping support

    Moved before nolibc-test-config, for the NOLIBC_TEST_CONFIG macro used by
    nolibc-test-config target
    
    Willy talked about this twice, let nolibc-test-config be able to use
    nolibc-test-$(XARCH).config listed in NOLIBC_TEST_CONFIG  directly.

* selftests/nolibc: add nolibc-test-config target
  selftests/nolibc: add help for nolibc-test-config target

    A new generic nolibc-test-config target is added, allows to enable
    additional options for a top-level config target.

    defconfig is reserved as an alias of nolibc-test-config.

    As suggested by Thomas and Willy.

* selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64

    Renamed from $(XARCH).config to nolibc-test-$(XARCH).config

    As suggested by Willy.

* selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

    Moved here as suggested by Willy.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1690468707.git.falcon@tinylab.org/

 
 
Zhangjin Wu (12):
  tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: fix up O= option support
  selftests/nolibc: add macros to reduce duplicated changes
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add nolibc-test-config target
  selftests/nolibc: add help for nolibc-test-config target
  selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

 tools/include/nolibc/arch-powerpc.h           | 202 ++++++++++++++++++
 tools/include/nolibc/arch.h                   |   2 +
 tools/testing/selftests/nolibc/Makefile       | 157 ++++++++++----
 .../nolibc/configs/nolibc-test-ppc.config     |   3 +
 4 files changed, 327 insertions(+), 37 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h
 create mode 100644 tools/testing/selftests/nolibc/configs/nolibc-test-ppc.config

-- 
2.25.1

