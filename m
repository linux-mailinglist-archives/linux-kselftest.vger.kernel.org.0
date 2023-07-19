Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59D7596D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjGSNan (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGSNam (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:30:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3E9119;
        Wed, 19 Jul 2023 06:30:41 -0700 (PDT)
X-QQ-mid: bizesmtp91t1689773432tb4871u6
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:30:31 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: znfcQSa1hKZ1OQVbZm+fYY1B+tno47akE8kAbUd2dOiIVMXsv+x77PjmcbbxG
        QQwSGPDuT2Ta2tyfCPgJY0MbBj9YfjoJ1G63UpQHS/gKrKTZWF++i0e3ZjQNw/Z8CKGWKdB
        jF77VI+jRPKeoa1A1rgUNQ7srXpFh8OB2c2l1RsiS2WbFGnj7zvSg/1UXBoZ8XXgHrsCP5A
        py/ktvPqt7OISRTjBkt2laot2vDJ1SlnxBw60YFam56zhhmiFedmCPa/SxegPJVvV9KYwEY
        I5kQ3aNo3tF5EmEyMQp9Burv6ssscVMLThU5PMviXGQF8IR99S//QS8OD15WS/+Tu5DLwhg
        JDPLtJcquCPYyBWUNYr/bzIwCulI5ZFzjUAwmBBkFp/BHR0VKvvIHRb0+1A7A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4621016987773429501
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 12/14] selftests/nolibc: add tinyconfig target
Date:   Wed, 19 Jul 2023 21:30:30 +0800
Message-Id: <6c58b9bec8fdf593d5dd1d5ba55aabddb0ce02d1.1689759351.git.falcon@tinylab.org>
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

The original tinyconfig target only enables minimal kernel config
options, it can speed up the kernel build and nolibc test a lot and also
brings us with smaller kernel image size.

But the default enabled options are not enough for qemu boot and console
print, some additional config options should be added for every
architecture individually.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index eec2935672ad..f42782fa78a9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -218,6 +218,9 @@ mrproper:
 defconfig:
 	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
 
+tinyconfig:
+	$(Q)$(MAKE_KERNEL) tinyconfig prepare
+
 PHONY += $(KERNEL_CONFIG)
 $(KERNEL_CONFIG):
 	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig; fi
-- 
2.25.1

