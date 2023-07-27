Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF982765D65
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjG0UcK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjG0UcI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:32:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05E30DB;
        Thu, 27 Jul 2023 13:31:50 -0700 (PDT)
X-QQ-mid: bizesmtp71t1690489900tiuhvymd
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:31:39 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3iio5UHKEhK5b2ClrY+IfoQsoiyLkp16KXoPNZd6NKJ6Hq2TkPOp
        lxuEVdu0iqSsDofWqZLbsQNWgPuh4dTi3eZroNw+JgJBygfCJFjpuRtgX7H8WMWgkbAg4Lx
        HpQCjdORRam1SuzECvY3se07e0xnOANa0+i63yBaLR2iLK1CL3yVwmcFjZ0ZptN7WavMAhs
        1X1RMFp4Mcb7h8SZhMJ966izSIJvKs6VM+7Rz+6TqgzWp+/SYLMiOQ2LhWCqRvqE0Dyva9V
        8Df/r12xiCcEP4zb1cAwJ/yl39Tid5XJd1HShHLXUqPMkt7sEpx1X+eF8Rhcs7sGJ55iMFe
        iFUzR0cIPJ1QNBsh8JfDO5wzHsY2Eha/SLBOaLqj3UT0zUcKgLDQppuzwPvIQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8403613974557991608
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 09/12] selftests/nolibc: customize QEMU_TIMEOUT for ppc64/ppc64le
Date:   Fri, 28 Jul 2023 04:31:39 +0800
Message-Id: <fefba2df5bcffc5f03478da1b595ec5a418b04dd.1690489039.git.falcon@tinylab.org>
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

Both ppc64 and ppc64le use slow bios in some qemu versions, let's
increase the timeout to make sure the running qemu would not be killed
before the test finish.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9a57de3b283c..ad2538ec5eb0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -106,6 +106,8 @@ QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=N
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
+QEMU_TIMEOUT_ppc64     = 15
+QEMU_TIMEOUT_ppc64le   = 25
 QEMU_TIMEOUT           = $(or $(QEMU_TIMEOUT_$(XARCH)),10)
 
 # OUTPUT is only set when run from the main makefile, otherwise
-- 
2.25.1

