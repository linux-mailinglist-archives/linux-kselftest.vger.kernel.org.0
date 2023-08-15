Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4177CFB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjHOP5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbjHOP4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A4CA1B6;
        Tue, 15 Aug 2023 08:56:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A37C11FB;
        Tue, 15 Aug 2023 08:57:13 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2773F6C4;
        Tue, 15 Aug 2023 08:56:29 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] selftests: cachestat: properly link in librt
Date:   Tue, 15 Aug 2023 16:56:10 +0100
Message-Id: <20230815155612.2535947-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815155612.2535947-1-andre.przywara@arm.com>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Libraries should be listed last on the compiler's command line, so that
the linker can look for and find still unresolved symbols. The librt
library, required for the shm_* functions, was announced using CFLAGS,
which puts the library *before* the source files, and fails compilation
on my system:
======================
gcc -isystem /src/linux-selftests/usr/include -Wall -lrt test_cachestat.c
  -o /src/linux-selftests/kselftest/cachestat/test_cachestat
/usr/bin/ld: /tmp/cceQWO3u.o: in function `test_cachestat_shmem':
test_cachestat.c:(.text+0x890): undefined reference to `shm_open'
/usr/bin/ld: test_cachestat.c:(.text+0x99c): undefined reference to `shm_unlink'
collect2: error: ld returned 1 exit status
make[4]: *** [../lib.mk:181: /src/linux-selftests/kselftest/cachestat/test_cachestat] Error 1
======================

Announce the library using the LDLIBS variable, which ensures the proper
ordering on the command line.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/cachestat/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/Makefile b/tools/testing/selftests/cachestat/Makefile
index fca73aaa7d141..778b54ebb0364 100644
--- a/tools/testing/selftests/cachestat/Makefile
+++ b/tools/testing/selftests/cachestat/Makefile
@@ -3,6 +3,6 @@ TEST_GEN_PROGS := test_cachestat
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
-CFLAGS += -lrt
+LDLIBS += -lrt
 
 include ../lib.mk
-- 
2.25.1

