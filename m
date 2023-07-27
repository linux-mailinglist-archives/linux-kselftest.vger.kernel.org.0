Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710A4765D6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjG0UdL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjG0Uc6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:32:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45940F5;
        Thu, 27 Jul 2023 13:32:57 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690489968tjf0ydyx
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:32:46 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: +ynUkgUhZJkRxmTCWl75yKqo2fa1gLrTMSfYGM0V6uWTshSZ0cgdrv7cH/mZn
        dmX2sbf39Iyx1LX2kZa+vgxT8UOo4T5hxuT7dgpiJ6+3y3K8zuQZcX3CaCxWmcYdHJ9+ScP
        GtJIUU3bQdI6s8wWEomWlMCiLYKRgcLvtXD2NlwTiAdCGYpeChxDvfT3AIwmNa6xpnjdykf
        F476R5yc11Cn8Ive9Q1+bHgrFnZOLe3e+4hNszy2MRvJMbavTSgYGQ1JdwFqfWcDQg0qmSe
        yA9ajOz5duRz1dhmUpw0ZewPx1EkoNjQ0VE0Jla10GreyzUpKEo4XLv7AHBjcaVVYGxDTFp
        zmSCihnPDQlMRJptYUFdN3udt3VV2nKnCwfQYajztRIpHI0bFhWt7qZn1o9bw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7408932279377289764
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 10/12] selftests/nolibc: tinyconfig: add extra common options
Date:   Fri, 28 Jul 2023 04:32:46 +0800
Message-Id: <c14aa7052c31ad5c5b65ca0796f66293c598c2b7.1690489039.git.falcon@tinylab.org>
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

The tinyconfig target from top-level Makefile has already enabled some
common options, but they are not enough to enable boot and print.

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

