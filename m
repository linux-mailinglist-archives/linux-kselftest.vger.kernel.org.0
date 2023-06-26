Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B9773DD05
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 13:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFZLOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjFZLOH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 07:14:07 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B091010CB;
        Mon, 26 Jun 2023 04:14:00 -0700 (PDT)
X-UUID: 67455abb2ffa49c6924eb7ea88480e97-20230626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e137a920-093b-482b-a944-003c1b683ee7,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.25,REQID:e137a920-093b-482b-a944-003c1b683ee7,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:1897b13f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230626191352F17JRK00,BulkQuantity:0,Recheck:0,SF:17|19|43|38|23|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 67455abb2ffa49c6924eb7ea88480e97-20230626
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.232.67.169)] by mailgw
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1512709045; Mon, 26 Jun 2023 19:13:51 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, beaub@linux.microsoft.com, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v4 1/3] tracing/user_events: Fix incorrect return value for writing operation when events are disabled
Date:   Mon, 26 Jun 2023 19:13:42 +0800
Message-Id: <20230626111344.19136-2-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626111344.19136-1-sunliming@kylinos.cn>
References: <20230626111344.19136-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The writing operation return the count of writes regardless of whether events
are enabled or disabled. Switch it to return -EBADF to indicates that the event
is disabled.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 1ac5ba5685ed..146bb2e9758f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1957,7 +1957,8 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 		if (unlikely(faulted))
 			return -EFAULT;
-	}
+	} else
+		return -EBADF;
 
 	return ret;
 }
-- 
2.25.1

