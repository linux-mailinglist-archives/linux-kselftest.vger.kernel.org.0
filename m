Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E3765D21
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjG0UXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjG0UW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:22:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F236F2D67;
        Thu, 27 Jul 2023 13:22:53 -0700 (PDT)
X-QQ-mid: bizesmtp88t1690489363tb8slm3z
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:22:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: q+EIYT+FhZqrDLdu2684eR5Czllj1f6+FLo1hVSobBXoXKvq/9go9/jOS6tRf
        PMdHGvcVLRKu36l8VlpvSphXqPDUm3AUSHxcqiESgvAcL7AJo+WmsIjTUO/LxAoBSM0eJU/
        blFkSG7ZX8zYzDeZgvyOUJg0tFPY5bmbL2H8e9Lts7azb/kRUQHD7ehMUHtHtImPOD7thfl
        OhnAOBmITZ1+AEG1C7T0101m/QGw6Kknh6cL9Pql4xM5AQTaHrlGCNgwc2JNzdWxOWSHf/X
        YJzlOtdku2Qhpw0/ME39BXaXp8mT7DfTn4tgzoyamTd6f9g7PxTUCXGIA9PrQOZ8wUZMkn0
        w0RWIrpNYFUtwKfwf1M27fgCeRVlzRFEgVPq66fNTfowH1QQ/nLUuArh7OLjg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5556135556970039063
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 01/12] selftests/nolibc: allow report with existing test log
Date:   Fri, 28 Jul 2023 04:22:42 +0800
Message-Id: <50b239f40ddbf4bd3e067c39330f99bf63c71147.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After the tests finish, it is valuable to report and summarize with
existing test log.

This avoid rerun or run the tests again when not necessary.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 2e9694370913..75419b695f0d 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -207,6 +207,10 @@ rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# report with existing test log
+report:
+	$(Q)$(REPORT_RUN_OUT)
+
 clean:
 	$(call QUIET_CLEAN, sysroot)
 	$(Q)rm -rf sysroot
-- 
2.25.1

