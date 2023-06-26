Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9296273DD02
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjFZLOF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjFZLN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 07:13:59 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BC510D;
        Mon, 26 Jun 2023 04:13:56 -0700 (PDT)
X-UUID: 9f50b0d02be14173b8e22440a5e5c13c-20230626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:dcaf8dd7-589b-4ef9-b48e-d0d8deb021eb,IP:10,
        URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-15
X-CID-INFO: VERSION:1.1.25,REQID:dcaf8dd7-589b-4ef9-b48e-d0d8deb021eb,IP:10,UR
        L:0,TC:0,Content:-20,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-15
X-CID-META: VersionHash:d5b0ae3,CLOUDID:b5c8803f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230626191346S428MXED,BulkQuantity:0,Recheck:0,SF:19|43|38|23|17|102,
        TC:nil,Content:1,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 9f50b0d02be14173b8e22440a5e5c13c-20230626
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.232.67.169)] by mailgw
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1873551291; Mon, 26 Jun 2023 19:13:46 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     rostedt@goodmis.org, beaub@linux.microsoft.com, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH v4 0/3] tracing/user_events: Fix incorrect return value for writes when events are disabled and add its tests
Date:   Mon, 26 Jun 2023 19:13:41 +0800
Message-Id: <20230626111344.19136-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Now the writing operation return the count of writes regardless of whether
events are enabled or disabled. Fix this by just return -EBADF when events
are disabled.

v3 -> v4:
- Change the return value from zero to -EBADF

v2 -> v3:
- Change the return value from -ENOENT to zero

v1 -> v2:
- Change the return value from -EFAULT to -ENOENT

sunliming (3):
  tracing/user_events: Fix incorrect return value for writing operation
    when events are disabled
  selftests/user_events: Enable the event before write_fault test in
    ftrace self-test
  selftests/user_events: Add test cases when event is disabled

 kernel/trace/trace_events_user.c                  | 3 ++-
 tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.25.1

