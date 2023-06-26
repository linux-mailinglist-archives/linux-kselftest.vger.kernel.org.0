Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07AE73DD03
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 13:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjFZLOI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjFZLOE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 07:14:04 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD04E73;
        Mon, 26 Jun 2023 04:13:58 -0700 (PDT)
X-UUID: b36678e824a54a5e81a959c8b9b35104-20230626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:e78c7cf9-6610-4ece-bd2e-8870fdf8421d,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:5
X-CID-INFO: VERSION:1.1.25,REQID:e78c7cf9-6610-4ece-bd2e-8870fdf8421d,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:5
X-CID-META: VersionHash:d5b0ae3,CLOUDID:1197b13f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2306261913529BB19VNK,BulkQuantity:0,Recheck:0,SF:19|43|38|23|17|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: b36678e824a54a5e81a959c8b9b35104-20230626
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.232.67.169)] by mailgw
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1952147526; Mon, 26 Jun 2023 19:13:52 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, beaub@linux.microsoft.com, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v4 2/3] selftests/user_events: Enable the event before write_fault test in ftrace self-test
Date:   Mon, 26 Jun 2023 19:13:43 +0800
Message-Id: <20230626111344.19136-3-sunliming@kylinos.cn>
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

The user_event has not be enabled in write_fault test in ftrace
self-test, Just enable it.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 tools/testing/selftests/user_events/ftrace_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index abfb49558a26..d33bd31425db 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -373,6 +373,10 @@ TEST_F(user, write_fault) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Enable event */
+	self->enable_fd = open(enable_file, O_RDWR);
+	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
+
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
 
-- 
2.25.1

