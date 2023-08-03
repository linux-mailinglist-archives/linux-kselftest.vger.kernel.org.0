Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1276ED07
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjHCOqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjHCOqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:46:14 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB71BC3;
        Thu,  3 Aug 2023 07:46:09 -0700 (PDT)
X-QQ-mid: bizesmtp88t1691073958thq43qfz
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 22:45:57 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: kUim6XnhvqW9dcd6EzLklGa12GVbNXdonLh2Hg+1w3dBPk/x2b5VmNG+MPDn6
        PEFmwIR3cWR5MbUVbtIZAVws1QPogU+mUqaPc8Z5UL+wjlb/HxUYHDFDvWxvxrn7beB6YEn
        BJDzwZdTbH+Pnq0s4jmy5USrmMOGCTiHxvHBDfw/upU5HD5rm6FNcWY2ldr2xYwhSoB3WBs
        PydhNf4Gm9/FF4g1QfFcGO6D/1kY4BgUZfzgZOoFzKDqyTLkcYjUwBmT0W+0+t3inyNao0z
        f/vv2iK7gyd6zVCAbhLmVK+KbTNnHyFRBSR3I1RimV2DcL7oRA9h0E+76pdW21iRRQWUVYs
        X2PNNE2eNamVHpyeMuQ3SnFchCFW33O5RCRXPS9FqjSIWkh1GgEQMKggZnremX9J5q+j9qf
        pKTbbIaUw/s=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2311120515883083357
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Thu,  3 Aug 2023 22:45:52 +0800
Message-Id: <759307255e4ca3b37b67321d333967a21122c422.1691073180.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691073180.git.falcon@tinylab.org>
References: <cover.1691073180.git.falcon@tinylab.org>
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

To avoid pollute the source code tree and avoid mrproper for every
architecture switch, the O= argument must be supported.

Both IMAGE and .config are from the building directory, let's use
objtree instead of srctree for them.

If no O= option specified, means building kernel in source code tree,
objtree should be srctree in such case.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 51fef5e6a152..af590aee063a 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -9,6 +9,9 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
+# add objtree for O= argument, required by IMAGE and .config
+objtree ?= $(srctree)
+
 ifeq ($(ARCH),)
 include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
@@ -217,12 +220,12 @@ kernel: initramfs
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log
-- 
2.25.1

