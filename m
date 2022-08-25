Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7655A072B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiHYCLy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 22:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiHYCLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 22:11:49 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD958DF2;
        Wed, 24 Aug 2022 19:11:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VNB6M88_1661393504;
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0VNB6M88_1661393504)
          by smtp.aliyun-inc.com;
          Thu, 25 Aug 2022 10:11:45 +0800
From:   Qiao Ma <mqaio@linux.alibaba.com>
To:     andrii@kernel.org, shuah@kernel.org, mykolal@fb.com,
        alexei.starovoitov@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: fix incorrect fcntl call (test_sockmap.c)
Date:   Thu, 25 Aug 2022 10:11:43 +0800
Message-Id: <38269a1610deebf8d51127f15b1c55d00caa4283.1661392989.git.mqaio@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In test_sockmap.c, the testcase sets socket nonblock first, and then
calls select() and recvmsg() to receive data.
If some error occur, nonblock setting will make recvmsg() return
immediately, rather than blocking forever.

However, the way to call fcntl() to set nonblock is wrong.
To set socket noblock, we need to use
> fcntl(fd, F_SETFL, O_NONBLOCK);
rather than:
> fcntl(fd, O_NONBLOCK);

Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0fbaccdc8861..abb4102f33b0 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -598,7 +598,12 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		err = fcntl(fd, F_SETFL, fd_flags);
+		if (err < 0) {
+			perror("fcntl failed");
+			goto out_errno;
+		}
+
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
-- 
1.8.3.1

