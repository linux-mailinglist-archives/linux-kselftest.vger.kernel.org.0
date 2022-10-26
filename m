Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7F60DAB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 07:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiJZFqG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 01:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJZFqF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 01:46:05 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A7229C8C;
        Tue, 25 Oct 2022 22:46:03 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 29Q5jtWm019680;
        Wed, 26 Oct 2022 07:45:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH] selftests/nolibc: always rebuild the sysroot when running a test
Date:   Wed, 26 Oct 2022 07:45:08 +0200
Message-Id: <20221026054508.19634-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Paul and myself got trapped a few times by not seeing the effects of
applying a patch to the nolibc source code until a "make clean" was
issued in the nolibc directory. It's particularly annoying when trying
to confirm that a proposed patch really solves a problem (or that
reverting it reintroduces the problem).

The reason for the sysroot not being rebuilt was that it can be quite
slow. But in fact it's only slow after a "make clean" issued at the
kernel's topdir, because it's the main "make headers" that can take a
tens of seconds; as long as "usr/include" still contains headers, the
"headers_install" phase is only a quick "rsync", and rebuilding the
whole nolibc sysroot takes a bit less than one second, which is perfectly
acceptable for a test, even more once the time lost caused by misleading
results if factored in.

This patch marks the sysroot target as phony and starts by clearing
the previous sysroot for the current architecture before reinstalling
it. Thanks to this, applying a patch to nolibc makes the effect
immediately visible to "make nolibc-test":

  $ time make -j -C tools/testing/selftests/nolibc nolibc-test
  make: Entering directory '/k/tools/testing/selftests/nolibc'
    MKDIR   sysroot/x86/include
  make[1]: Entering directory '/k/tools/include/nolibc'
  make[2]: Entering directory '/k'
  make[2]: Leaving directory '/k'
  make[2]: Entering directory '/k'
    INSTALL /k/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/k'
  make[1]: Leaving directory '/k/tools/include/nolibc'
    CC      nolibc-test
  make: Leaving directory '/k/tools/testing/selftests/nolibc'

  real    0m0.869s
  user    0m0.716s
  sys     0m0.149s

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Link: https://lore.kernel.org/all/20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1/
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 69ea659caca9..22f1e1d73fa8 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -95,6 +95,7 @@ all: run
 sysroot: sysroot/$(ARCH)/include
 
 sysroot/$(ARCH)/include:
+	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
 	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
@@ -133,3 +134,5 @@ clean:
 	$(Q)rm -rf initramfs
 	$(call QUIET_CLEAN, run.out)
 	$(Q)rm -rf run.out
+
+.PHONY: sysroot/$(ARCH)/include
-- 
2.35.3

