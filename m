Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080C56143CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 04:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiKAD72 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 23:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAD70 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 23:59:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A451E1263B;
        Mon, 31 Oct 2022 20:59:25 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1bqZ0TVqzHvPm;
        Tue,  1 Nov 2022 11:59:06 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.63) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 11:59:23 +0800
From:   Zhao Gongyi <zhaogongyi@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <brauner@kernel.org>, <shuah@kernel.org>, <joel@joelfernandes.org>,
        Zhao Gongyi <zhaogongyi@huawei.com>
Subject: [PATCH -next] selftests/pidfd_test: Remove the erroneous ','
Date:   Tue, 1 Nov 2022 11:56:02 +0800
Message-ID: <20221101035602.40623-1-zhaogongyi@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.63]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove the erroneous ',', otherwise it might result in wrong output
and report:
 ...
 Bail out! (errno %d)
  test: Unexpected epoll_wait result (c=4208480, events=2)
 ...

Fixes: 740378dc7834 ("pidfd: add polling selftests")
Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 tools/testing/selftests/pidfd/pidfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d36654265b7a..e2dd4ed84984 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -413,7 +413,7 @@ static void poll_pidfd(const char *test_name, int pidfd)

 	c = epoll_wait(epoll_fd, events, MAX_EVENTS, 5000);
 	if (c != 1 || !(events[0].events & EPOLLIN))
-		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x) ",
+		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x) "
 				   "(errno %d)\n",
 				   test_name, c, events[0].events, errno);

--
2.17.1

