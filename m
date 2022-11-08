Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5563620665
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 03:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiKHCCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 21:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiKHCCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 21:02:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C841B1E9;
        Mon,  7 Nov 2022 18:02:11 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5rqy1kt5zJnYZ;
        Tue,  8 Nov 2022 09:59:10 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:02:10 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 10:02:09 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] selftests/bpf: Fix test_progs compilation failure in 32-bit arch
Date:   Tue, 8 Nov 2022 09:58:57 +0800
Message-ID: <20221108015857.132457-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test_progs fails to be compiled in the 32-bit arch, log is as follows:

  test_progs.c:1013:52: error: format '%ld' expects argument of type 'long int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
   1013 |                 sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
        |                                                  ~~^
        |                                                    |
        |                                                    long int
        |                                                  %d
   1014 |                         strlen(msg->test_log.log_buf),
        |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                         |
        |                         size_t {aka unsigned int}

Fix it.

Fixes: 91b2c0afd00c ("selftests/bpf: Add parallelism to test_progs")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0e9a47f97890..3fef451d8831 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1010,7 +1010,7 @@ static inline const char *str_msg(const struct msg *msg, char *buf)
 			msg->subtest_done.have_log);
 		break;
 	case MSG_TEST_LOG:
-		sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
+		sprintf(buf, "MSG_TEST_LOG (cnt: %zu, last: %d)",
 			strlen(msg->test_log.log_buf),
 			msg->test_log.is_last);
 		break;
-- 
2.30.GIT

