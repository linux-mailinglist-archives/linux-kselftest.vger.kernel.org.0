Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB26B4CB7F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 08:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiCCHei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 02:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCCHei (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 02:34:38 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6815C64E;
        Wed,  2 Mar 2022 23:33:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0V66arbm_1646292822;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V66arbm_1646292822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 15:33:48 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, catalin.marinas@arm.com,
        ashimida@linux.alibaba.com, gregkh@linuxfoundation.org,
        linux@roeck-us.net, keescook@chromium.org,
        luc.vanoostenryck@gmail.com, elver@google.com,
        mark.rutland@arm.com, masahiroy@kernel.org, ojeda@kernel.org,
        nathan@kernel.org, npiggin@gmail.com, ndesaulniers@google.com,
        samitolvanen@google.com, shuah@kernel.org, tglx@linutronix.de,
        will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v3 0/2] AARCH64: Enable GCC-based Shadow Call Stack
Date:   Wed,  2 Mar 2022 23:33:40 -0800
Message-Id: <20220303073340.86008-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shadow call stacks will be available in GCC >= 12, this series makes
the corresponding kernel configuration available when compiling
the kernel with the gcc and adds corresponding tests in lkdtm.

Dan Li (2):
  AARCH64: Add gcc Shadow Call Stack support
  lkdtm: Add Shadow Call Stack tests

 arch/Kconfig                            | 19 +++----
 arch/arm64/Kconfig                      |  2 +-
 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/core.c               |  2 +
 drivers/misc/lkdtm/lkdtm.h              |  4 ++
 drivers/misc/lkdtm/scs.c                | 67 +++++++++++++++++++++++++
 include/linux/compiler-gcc.h            |  4 ++
 tools/testing/selftests/lkdtm/tests.txt |  2 +
 8 files changed, 91 insertions(+), 10 deletions(-)
 create mode 100644 drivers/misc/lkdtm/scs.c

-- 
2.17.1

