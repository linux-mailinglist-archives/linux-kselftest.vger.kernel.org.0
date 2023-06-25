Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1B73D21C
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjFYQZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYQZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:25:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCA4A8;
        Sun, 25 Jun 2023 09:25:36 -0700 (PDT)
X-QQ-mid: bizesmtp64t1687710327t7nggopr
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:25:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: LE7C6P2vL8T0B3PKGrZcHQ0BTeQiRu2DlqZ7sGIG0uR51RWmpLUTcegpB6InK
        CCVs7YfKvpjQoKPFVDpuimCYFIVaewN3N15vb+WlMFVzP5OiTYDHzymJeYhIXO/DJiqtCGy
        EUxD4V59l44dI/wgm/siwof/WJNJsY7oXoF/7KEX1lyPqOL/H1pL5HSmA3T4s8JgSytC6un
        LxZfNJTm+aAgmGA6mzz2/1HgZ9YYnp/le4VtYuidOs9SrQ8GsrwcR2DwLHWHoEP3t0ey9uW
        vIiiSZPaNybdwX2APMlAWicvsu2dBHZX0bCcn8Y4KhT1nqW84ZWyW2mA1iYEWTpdoa5e+pG
        DRe5Tz3qlokEDuW+AaaHy+FJ214aDN/3iEU+Swc
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6478744900005020789
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 09/22] selftests/nolibc: add procfs, shmem and tmpfs
Date:   Mon, 26 Jun 2023 00:25:07 +0800
Message-Id: <df20ff46d0fdef3b6bb78bfbb590d0b900dae285.1687706332.git.falcon@tinylab.org>
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

Some test cases want to use procfs and tmpfs, let's enable them.

Because tmpfs depends on shmem, let's enable it too.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ae8519fb1b49..1cddacbeb95e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -54,6 +54,8 @@ EXTCONFIG_COMMON    += --set-val PANIC_TIMEOUT 1
 EXTCONFIG_COMMON    += -e PRINTK -e TTY
 EXTCONFIG_COMMON    += -e BINFMT_ELF
 EXTCONFIG_COMMON    += -e POWER_RESET -e POWER_RESET_SYSCON
+EXTCONFIG_COMMON    += -e PROC_FS
+EXTCONFIG_COMMON    += -e SHMEM -e TMPFS
 
 # extra kernel configs by architecture
 EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
-- 
2.25.1

