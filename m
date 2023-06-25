Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F256F73D285
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFYQoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:44:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB80B9;
        Sun, 25 Jun 2023 09:44:19 -0700 (PDT)
X-QQ-mid: bizesmtp78t1687711448t7y8lnvs
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:44:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3jkxQ1nfJIDUjtpCEo7hFHklIWcIzySUOaPurOu8rwjLO/y2+NUO
        W93KshJtFv7+VMr/QSSxuIHeHKMJciFIpJD22TFiR/mDO7IAKpBt3Aat95kyxQPfY1k2XvN
        lGtpzVqYYKxbkWqZkaIKhwtf/g3AyjEUxhpw0zIZsyWJ9f+pRVx5g2Lz2H2oTc4JBITSyxk
        QkCRCrmVpE+12c9DWpZIGBhmzubclG5C6Jo1xwuTDZwQ6+hxClW1060y6JB3/mZK3I17r/F
        Q/Zlv6OAzOeFDMBEtgfzXniU4GYvqXEtMVATn0SAc44gAaFSMV5wSBx/QN6JmZd0vBE3Y4O
        zAsgT7eZlE8eefnLAISYwteNq3qhcqfjE3sj3S9MQNgNv54YLNyF6CGBEPhUQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11520936945867067429
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 21/22] selftests/nolibc: allow run tests on all targets
Date:   Mon, 26 Jun 2023 00:43:48 +0800
Message-Id: <49a3c3f75e2f433f42112a246b20488bf7c9e7f4.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This lists all of the supported architectures and allow testing for all
of them.

These targets are supported:

- run-user-all: testing run-user for all architectures
- run-all / run-default-all: testing run-default for all architectures
- run-tiny-all: testing run-tiny for all architectures

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3e7e51bd7082..470923dc10e1 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -164,6 +164,18 @@ ifeq (run-default, $(MAKECMDGOALS))
 AUTOCONFIG ?= defconfig
 endif
 
+# allow run tests on all architectures: run-user-all, run-all (=run-default-all), run-tiny-all
+ARCHS   ?= $(shell sed -ne 's/^DEFCONFIG_\([^ ]*\) .*/\1/p' $(CURDIR)/Makefile)
+GOALS   ?= run-user run-tiny run-default
+RUN_ALL ?= _t=$@; t=$${_t%-all}; [ "$$t" = "run" ] && t=run-default; \
+	   if echo $(GOALS) | grep -wq "$$t"; then \
+		for a in $(ARCHS); do echo "Testing $$t for $${a}:"; make $$t ARCH=$$a; cp $(CURDIR)/run.out $(CURDIR)/run-$$a.out; done; \
+		echo "\n\nTesting summary of $$t:\n"; \
+		for a in $(ARCHS); do echo $${a}:; echo; $(REPORT) $(CURDIR)/run-$$a.out; echo; done; \
+	   else \
+		echo "Ignoring unknown target: $$t, available targets: $(GOALS)"; \
+	   fi
+
 # allow switch nolibc headers include method: 1 for sysroot, 0 for nolibc.h
 SYSROOT ?= 1
 
@@ -255,6 +267,10 @@ rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) $(LOG_OUTPUT)
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# test for all architectures
+%-all:
+	$(Q)$(RUN_ALL)
+
 clean:
 	$(call QUIET_CLEAN, sysroot)
 	$(Q)rm -rf sysroot
-- 
2.25.1

