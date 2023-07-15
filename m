Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08286754AC6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGOShA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOSg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:36:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B23184;
        Sat, 15 Jul 2023 11:36:57 -0700 (PDT)
X-QQ-mid: bizesmtp84t1689446208taw11kdj
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:36:46 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: TLc+rbMvNaHwLbZOoSPZzfCsEz7BedXTG9f14xmkWI71WWiDDdKXSMepZaaQn
        5D1RaYvDBzJADNj6Fz5d2lKIAse9JlnNE+KDWke5CmfIrdGt4o4i4NfLGAioJ4zUvDm6l3D
        5yT0cEQlGNCikJpJ+jraUNQ5tv1+UlNev2AWqXRs7wyCZLsW1xe2tHTE2yd8aDYXaV7n8qp
        YmBJuvRayO48oxK8pntFwce1eMNaLu+eLqSRlWrIXGN79Jx5w7TdV0JiMEU0obIXwBlsbOy
        RK1Zwv0r7GEtysMu4UD04l4+D4Oda5+z45i+dU09oEhmTSqLZ6w8SNPp2WOwp3BTJt5CDnt
        oEn3Oz3/PTw1ntQhql7mH8bmUJPSxFIE6byW8UumMtUXauuKo4Hvy2tS2aTaXzixF2T8mIp
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10759426770899697064
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 18/18] selftests/nolibc: allow test -include /path/to/nolibc.h
Date:   Sun, 16 Jul 2023 02:36:46 +0800
Message-Id: <9d362d475a39f4924f2b0adeb6ccdfa1f851edd4.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the head comment of nolibc-test.c shows, it can be built in 3 ways:

    $(CC) -nostdlib -include /path/to/nolibc.h => NOLIBC already defined
    $(CC) -nostdlib -I/path/to/nolibc/sysroot  => _NOLIBC_* guards are present
    $(CC) with default libc                    => NOLIBC* never defined

Only last two of them are tested currently, let's allow test the first one too.

This may help to find issues about using nolibc.h to build programs. it
derives from this change:

    commit 3a8039e289a3 ("tools/nolibc: Fix build of stdio.h due to header ordering")

Usage:

    // test with sysroot by default
    $ make run-user

    // test without sysroot, using nolibc.h directly
    $ make run-user NOLIBC_SYSROOT=0

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b42e67b1a7e2..f42adef87e12 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -126,9 +126,15 @@ sysroot/$(ARCH)/include:
 	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
+ifneq ($(NOLIBC_SYSROOT),0)
 nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
+else
+nolibc-test: nolibc-test.c
+	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc
+endif
 
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
-- 
2.25.1

