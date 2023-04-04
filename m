Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87C56D570A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 05:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjDDDMs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 23:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDDDMr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 23:12:47 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887E91705;
        Mon,  3 Apr 2023 20:12:45 -0700 (PDT)
X-UUID: c5cabca270304178abb617f394213a67-20230404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:dc36bc4e-3d52-4bd6-ae7a-aab48546efa6,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-INFO: VERSION:1.1.22,REQID:dc36bc4e-3d52-4bd6-ae7a-aab48546efa6,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:25
X-CID-META: VersionHash:120426c,CLOUDID:bbb131b5-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:230404111238YBN49KMO,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c5cabca270304178abb617f394213a67-20230404
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <jiangfeng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1792328679; Tue, 04 Apr 2023 11:12:37 +0800
From:   Feng Jiang <jiangfeng@kylinos.cn>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Feng Jiang <jiangfeng@kylinos.cn>,
        Ming Xie <xieming@kylinos.cn>
Subject: [PATCH] selftests/mm: fix memory leak in child_memcmp_fn
Date:   Tue,  4 Apr 2023 11:12:34 +0800
Message-Id: <20230404031234.78272-1-jiangfeng@kylinos.cn>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The allocated memory should be freed on return.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Suggested-by: Ming Xie <xieming@kylinos.cn>
---
 tools/testing/selftests/mm/cow.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 0eb2e8180aa5..c0dd2dfca51b 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -162,6 +162,10 @@ static int child_memcmp_fn(char *mem, size_t size,
 {
 	char *old = malloc(size);
 	char buf;
+	int ret;
+
+	if (!old)
+		return -ENOMEM;
 
 	/* Backup the original content. */
 	memcpy(old, mem, size);
@@ -172,7 +176,10 @@ static int child_memcmp_fn(char *mem, size_t size,
 		;
 
 	/* See if we still read the old values. */
-	return memcmp(old, mem, size);
+	ret = memcmp(old, mem, size);
+	free(old);
+
+	return ret;
 }
 
 static int child_vmsplice_memcmp_fn(char *mem, size_t size,
-- 
2.39.2

