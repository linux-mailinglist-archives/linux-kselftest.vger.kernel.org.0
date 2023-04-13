Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903C06E03A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjDMB17 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMB17 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 21:27:59 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225E6CF;
        Wed, 12 Apr 2023 18:27:56 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id IVO00050;
        Thu, 13 Apr 2023 09:27:50 +0800
Received: from localhost.localdomain.com (10.200.104.82) by
 jtjnmail201603.home.langchao.com (10.100.2.3) with Microsoft SMTP Server id
 15.1.2507.21; Thu, 13 Apr 2023 09:27:53 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <akpm@linux-foundation.org>, <shuah@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] selftests/mm: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 12 Apr 2023 21:27:51 -0400
Message-ID: <20230413012751.4445-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2023413092750fa4388fe447b5709db712d77b7ea7373
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

Replace memalign() with posix_memalign().

As a pointer is passed into posix_memalign(),initialize *map to
NULL,to silence a warning about the function's return value being
used as uninitialized (which is not valid anyway because the
error is properly checked before map is returned).

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 tools/testing/selftests/mm/soft-dirty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 21d8830c5f24..c99350e110ec 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -80,9 +80,9 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 	int i, ret;
 	size_t hpage_len = read_pmd_pagesize();
 
-	map = memalign(hpage_len, hpage_len);
-	if (!map)
-		ksft_exit_fail_msg("memalign failed\n");
+	ret = posix_memalign((void **)(&map), hpage_len, hpage_len);
+	if (ret < 0)
+		ksft_exit_fail_msg("posix_memalign failed\n");
 
 	ret = madvise(map, hpage_len, MADV_HUGEPAGE);
 	if (ret)
-- 
2.27.0

