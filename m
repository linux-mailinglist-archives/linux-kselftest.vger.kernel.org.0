Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2027D77C8E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 09:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjHOHww (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 03:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjHOHwZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 03:52:25 -0400
X-Greylist: delayed 183 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 00:52:22 PDT
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 050FF173C;
        Tue, 15 Aug 2023 00:52:21 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from cmccmta.chinamobile.com (unknown[172.16.121.91])
        by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee464db2dfcaf7-10c93;
        Tue, 15 Aug 2023 15:49:16 +0800 (CST)
X-RM-TRANSID: 2ee464db2dfcaf7-10c93
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.101])
        by rmsmtp-syy-appsvrnew06-12031 (RichMail) with SMTP id 2eff64db2dfbec0-66fe9;
        Tue, 15 Aug 2023 15:49:16 +0800 (CST)
X-RM-TRANSID: 2eff64db2dfbec0-66fe9
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/arm64: fix a memleak in zt_regs_run()
Date:   Tue, 15 Aug 2023 15:49:15 +0800
Message-Id: <20230815074915.245528-1-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If memcmp() does not return 0, "zeros" need to be freed to prevent memleak

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/testing/selftests/arm64/signal/testcases/zt_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
index e1eb4d5c027a..2e384d731618 100644
--- a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
@@ -65,6 +65,7 @@ int zt_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	if (memcmp(zeros, (char *)zt + ZT_SIG_REGS_OFFSET,
 		   ZT_SIG_REGS_SIZE(zt->nregs)) != 0) {
 		fprintf(stderr, "ZT data invalid\n");
+		free(zeros);
 		return 1;
 	}
 
-- 
2.38.1



