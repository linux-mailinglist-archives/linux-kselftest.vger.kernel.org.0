Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7577AFEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjHNDP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 23:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjHNDPN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 23:15:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32B0124;
        Sun, 13 Aug 2023 20:15:07 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPKFR0hlyz2Bd2B;
        Mon, 14 Aug 2023 11:12:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 11:15:05 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <andrii@kernel.org>, <mykolal@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>, <shuah@kernel.org>,
        <benjamin.tissoires@redhat.com>, <void@manifault.com>,
        <memxor@gmail.com>, <iii@linux.ibm.com>, <colin.i.king@gmail.com>,
        <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <zouyipeng@huawei.com>
Subject: [bpf-next] selftests/bpf: fix repeat option when kfunc_call verify fail
Date:   Mon, 14 Aug 2023 11:14:34 +0800
Message-ID: <20230814031434.3077944-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no way to set topts.repeat=1 when tc_test going to verify fail.

Maybe it's clerical error, fix it directly.

Fixes: fb66223a244f ("selftests/bpf: add test for accessing ctx from syscall program type")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Reviewed-by: Li Zetao <lizetao1@huawei.com>
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index a543742cd7bd..2eb71559713c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -173,8 +173,8 @@ static void verify_fail(struct kfunc_test_params *param)
 	case tc_test:
 		topts.data_in = &pkt_v4;
 		topts.data_size_in = sizeof(pkt_v4);
-		break;
 		topts.repeat = 1;
+		break;
 	}
 
 	skel = kfunc_call_fail__open_opts(&opts);
-- 
2.34.1

