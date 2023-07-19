Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A4E7596DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGSNbz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGSNby (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:31:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30900CD;
        Wed, 19 Jul 2023 06:31:52 -0700 (PDT)
X-QQ-mid: bizesmtp81t1689773502tmfcw477
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:31:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: vrqOr+ppv0tG8gKNCr4DgHiL+u0a/TSKoOLUX8xn2sq9UVKoRAsfkpAEyQPY9
        oCQR51MHuWU/N+/ngwuvVtATNosU7ftdsbnXbegbY13KJwm+Kkt/dFGRLUVMwD98dDw7JYa
        hlSJOBi7BbAM/z0kuz9ftpQyqi6FoMzGdXYJ6Yx399eyEvzRu+E+mmKVKhaW/+9yXI3vOr6
        zASQQARGKlU3nvkQNtGspRwEiAuHDGTzmOkXeBfkQH26Ix6eUke+idAdo7qbJcop0WWvewr
        PFjspLHtPixWHs7x0RX3OxwmZD3Nb5il4lMd9IDj1q27M1pjwzLzAbxp5UIBdUeFk/nCvx/
        8VQFB8K41rAmRRiM3PQhV3hfqHan9+GHCl8B41LGXT3lb5+/SbW8cVN0oXWRwhgSm8FH3Zn
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13303215670408081190
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 13/14] selftests/nolibc: tinyconfig: add extra common options
Date:   Wed, 19 Jul 2023 21:31:36 +0800
Message-Id: <7ae0bec89a7d810415fb2728e48465458ba364bd.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The original kernel tinyconfig target has already enabled some common
options, but they are not enough to enable boot and print.

    $ find kernel/ arch/*/ -name "tiny*.config"
    kernel/configs/tiny-base.config
    kernel/configs/tiny.config
    arch/x86/configs/tiny.config

To enable qemu boot and console print, additional kernel config options
are required, include the common parts and the architecture specific
parts.

Here adds minimal extra common parts for all architectures:

* for initrd: CONFIG_BLK_DEV_INITRD
* for init executable: CONFIG_BINFMT_ELF
* for test result print: CONFIG_PRINTK, CONFIG_TTY

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/configs/common.config | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/configs/common.config

diff --git a/tools/testing/selftests/nolibc/configs/common.config b/tools/testing/selftests/nolibc/configs/common.config
new file mode 100644
index 000000000000..3957f812faac
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/common.config
@@ -0,0 +1,4 @@
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_BINFMT_ELF=y
+CONFIG_PRINTK=y
+CONFIG_TTY=y
-- 
2.25.1

