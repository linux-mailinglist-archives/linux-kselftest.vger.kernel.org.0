Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F3A59F0F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 03:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiHXBbP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 21:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiHXBbO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 21:31:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307146DB2;
        Tue, 23 Aug 2022 18:31:12 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MC7m35KtHznTfM;
        Wed, 24 Aug 2022 09:28:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 09:31:10 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 09:31:09 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <bpf@vger.kernel.org>
CC:     <sdf@google.com>, <kafai@fb.com>, <ast@kernel.org>,
        <andrii@kernel.org>, <mykolal@fb.com>
Subject: [PATCH -next] selftests/bpf: fix wrong size passed to bpf_setsockopt()
Date:   Wed, 24 Aug 2022 09:39:07 +0800
Message-ID: <20220824013907.380448-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sizeof(new_cc) is not real memory size that new_cc point to, introduce
new_cc_len to store size then pass it to bpf_setsockopt().

Fixes: 31123c0360e0 ("selftests/bpf: bpf_setsockopt tests")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 4a4cb44a4a15..40606ef47a38 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -305,15 +305,19 @@ static int bpf_test_tcp_sockopt(__u32 i, struct loop_ctx *lc)
 	if (t->opt == TCP_CONGESTION) {
 		char old_cc[16], tmp_cc[16];
 		const char *new_cc;
+		int new_cc_len;
 
 		if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, old_cc, sizeof(old_cc)))
 			return 1;
-		if (!bpf_strncmp(old_cc, sizeof(old_cc), cubic_cc))
+		if (!bpf_strncmp(old_cc, sizeof(old_cc), cubic_cc)) {
 			new_cc = reno_cc;
-		else
+			new_cc_len = sizeof(reno_cc);
+		} else {
 			new_cc = cubic_cc;
+			new_cc_len = sizeof(cubic_cc);
+		}
 		if (bpf_setsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, (void *)new_cc,
-				   sizeof(new_cc)))
+				   new_cc_len))
 			return 1;
 		if (bpf_getsockopt(ctx, IPPROTO_TCP, TCP_CONGESTION, tmp_cc, sizeof(tmp_cc)))
 			return 1;
-- 
2.25.1

