Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB21E6DECEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 09:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDLHte (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 03:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDLHtd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 03:49:33 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184493A98;
        Wed, 12 Apr 2023 00:49:29 -0700 (PDT)
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id HBJ00027;
        Wed, 12 Apr 2023 15:49:27 +0800
Received: from localhost.localdomain.com (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.21; Wed, 12 Apr 2023 15:49:26 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] mm: huge_memory: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 12 Apr 2023 03:49:15 -0400
Message-ID: <20230412074915.2303-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2023412154927bed2c8f64373bf4344b6b1b5d5e3769a
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

memalign() is obsolete according to its manpage.

Replace memalign() with posix_memalign() and remove malloc.h include
that was there for memalign().

As a pointer is passed into posix_memalign(), initialize *p to NULL
to silence a warning about the function's return value being used as
uninitialized (which is not valid anyway because the error is properly
checked before p is returned).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 tools/testing/selftests/mm/split_huge_page_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index cbb5e6893cbf..8f48f07bc821 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -96,10 +96,10 @@ void split_pmd_thp(void)
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
 	size_t i;
+	int ret;
 
-	one_page = memalign(pmd_pagesize, len);
-
-	if (!one_page) {
+	ret = posix_memalign((void **)(&one_page), pmd_pagesize, len);
+	if (ret < 0) {
 		printf("Fail to allocate memory\n");
 		exit(EXIT_FAILURE);
 	}
-- 
2.27.0

