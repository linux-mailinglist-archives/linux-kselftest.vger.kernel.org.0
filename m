Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0751059FC90
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbiHXOBe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbiHXOBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 10:01:19 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27429836D;
        Wed, 24 Aug 2022 07:01:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VN7erIR_1661349666;
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0VN7erIR_1661349666)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 22:01:07 +0800
From:   Qiao Ma <mqaio@linux.alibaba.com>
To:     andrii@kernel.org, shuah@kernel.org, mykolal@fb.com,
        linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: fix incorrect fcntl call
Date:   Wed, 24 Aug 2022 22:01:04 +0800
Message-Id: <a46dffe36f2570ec91761b1d604ac52fa0a10efb.1661348961.git.mqaio@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To set socket noblock, we need to use
> fcntl(fd, F_SETFL, O_NONBLOCK);
rather than:
> fcntl(fd, O_NONBLOCK);

Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 0fbaccdc8861..b163b7cfd957 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -598,7 +598,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		fcntl(fd, F_SETFL, fd_flags);
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
-- 
1.8.3.1

