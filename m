Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232DF6D570E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 05:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjDDDNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 23:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjDDDNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 23:13:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8165419BC;
        Mon,  3 Apr 2023 20:13:07 -0700 (PDT)
X-UUID: 8abd6cf51c9c4d14b95bb4eea84e73c4-20230404
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:f49455d1-09a9-49e1-9532-1954c1b596d7,IP:5,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:25
X-CID-INFO: VERSION:1.1.22,REQID:f49455d1-09a9-49e1-9532-1954c1b596d7,IP:5,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:25
X-CID-META: VersionHash:120426c,CLOUDID:768c502a-564d-42d9-9875-7c868ee415ec,B
        ulkID:2304041113029BDCJM3R,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 8abd6cf51c9c4d14b95bb4eea84e73c4-20230404
X-User: jiangfeng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <jiangfeng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 52235139; Tue, 04 Apr 2023 11:13:00 +0800
From:   Feng Jiang <jiangfeng@kylinos.cn>
To:     akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Feng Jiang <jiangfeng@kylinos.cn>,
        Ming Xie <xieming@kylinos.cn>
Subject: [PATCH] selftests/mm: fix resource leaks in child_vmsplice_memcmp_fn
Date:   Tue,  4 Apr 2023 11:12:56 +0800
Message-Id: <20230404031256.78330-1-jiangfeng@kylinos.cn>
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

When the function returns, the 'new' and 'old' are not freed
and the 'fds[]' are not closed, which can lead to resource leaks.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
Suggested-by: Ming Xie <xieming@kylinos.cn>
---
 tools/testing/selftests/mm/cow.c | 43 ++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index c0dd2dfca51b..b8aec05d56f4 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -193,26 +193,38 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 	char *old, *new;
 	int fds[2];
 	char buf;
+	int ret;
 
 	old = malloc(size);
 	new = malloc(size);
+	if (!old || !new) {
+		ret = -ENOMEM;
+		goto free;
+	}
 
 	/* Backup the original content. */
 	memcpy(old, mem, size);
 
-	if (pipe(fds) < 0)
-		return -errno;
+	if (pipe(fds) < 0) {
+		ret = -errno;
+		goto free;
+	}
 
 	/* Trigger a read-only pin. */
 	transferred = vmsplice(fds[1], &iov, 1, 0);
-	if (transferred < 0)
-		return -errno;
-	if (transferred == 0)
-		return -EINVAL;
+	if (transferred < 0) {
+		ret = -errno;
+		goto close_pipe;
+	} else if (transferred == 0) {
+		ret = -EINVAL;
+		goto close_pipe;
+	}
 
 	/* Unmap it from our page tables. */
-	if (munmap(mem, size) < 0)
-		return -errno;
+	if (munmap(mem, size) < 0) {
+		ret = -errno;
+		goto close_pipe;
+	}
 
 	/* Wait until the parent modified it. */
 	write(comm_pipes->child_ready[1], "0", 1);
@@ -222,11 +234,20 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 	/* See if we still read the old values via the pipe. */
 	for (total = 0; total < transferred; total += cur) {
 		cur = read(fds[0], new + total, transferred - total);
-		if (cur < 0)
-			return -errno;
+		if (cur < 0) {
+			ret = -errno;
+			goto close_pipe;
+		}
 	}
 
-	return memcmp(old, new, transferred);
+	ret = memcmp(old, new, transferred);
+close_pipe:
+	close(fds[0]);
+	close(fds[1]);
+free:
+	free(old);
+	free(new);
+	return ret;
 }
 
 typedef int (*child_fn)(char *mem, size_t size, struct comm_pipes *comm_pipes);
-- 
2.39.2

