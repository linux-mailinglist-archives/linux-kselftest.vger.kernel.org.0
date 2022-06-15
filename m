Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50A54C4DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jun 2022 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiFOJkO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jun 2022 05:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbiFOJjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jun 2022 05:39:55 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 02:39:37 PDT
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CBFA3DDF8
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jun 2022 02:39:36 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.87])
        by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb62a9a81b5ec-42973;
        Wed, 15 Jun 2022 17:36:30 +0800 (CST)
X-RM-TRANSID: 2eeb62a9a81b5ec-42973
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvrnew04-12029 (RichMail) with SMTP id 2efd62a9a81d15b-c5d4a;
        Wed, 15 Jun 2022 17:36:30 +0800 (CST)
X-RM-TRANSID: 2efd62a9a81d15b-c5d4a
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: vm: Fix resource leak when return error
Date:   Wed, 15 Jun 2022 17:36:29 +0800
Message-Id: <20220615093629.1330809-1-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When return on an error path, file handle need to be closed
to prevent resource leak

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/testing/selftests/vm/ksm_tests.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 2fcf24312da8..f5e4e0bbd081 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -54,6 +54,7 @@ static int ksm_write_sysfs(const char *file_path, unsigned long val)
 	}
 	if (fprintf(f, "%lu", val) < 0) {
 		perror("fprintf");
+		fclose(f);
 		return 1;
 	}
 	fclose(f);
@@ -72,6 +73,7 @@ static int ksm_read_sysfs(const char *file_path, unsigned long *val)
 	}
 	if (fscanf(f, "%lu", val) != 1) {
 		perror("fscanf");
+		fclose(f);
 		return 1;
 	}
 	fclose(f);
-- 
2.31.1



