Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864A177AFE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 05:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHNDIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 23:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjHNDI0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 23:08:26 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCE9B;
        Sun, 13 Aug 2023 20:08:24 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RPK5g3zp8z2Bd3M;
        Mon, 14 Aug 2023 11:05:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 11:08:22 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.ne>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <john.fastabend@gmail.com>,
        <kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
        <jolsa@kernel.org>, <mykolal@fb.com>, <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
        <toke@redhat.com>
CC:     <zouyipeng@huawei.com>
Subject: [bpf-next] selftests/bpf: clean-up fmod_ret in bench_rename test script
Date:   Mon, 14 Aug 2023 11:07:27 +0800
Message-ID: <20230814030727.3010390-1-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[root@localhost bpf]# ./benchs/run_bench_rename.sh
base      :    0.819 ± 0.012M/s
kprobe    :    0.538 ± 0.009M/s
kretprobe :    0.503 ± 0.004M/s
rawtp     :    0.779 ± 0.020M/s
fentry    :    0.726 ± 0.007M/s
fexit     :    0.691 ± 0.007M/s
benchmark 'rename-fmodret' not found

The bench_rename_fmod_ret has been removed in the commit [1], clean-up
it in test script.

[1] b000def2e052 ("selftests: Remove fmod_ret from test_overhead").

Fixes: b000def2e052 ("selftests: Remove fmod_ret from test_overhead")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 tools/testing/selftests/bpf/benchs/run_bench_rename.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
index 16f774b1cdbe..7b281dbe4165 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base kprobe kretprobe rawtp fentry fexit fmodret
+for i in base kprobe kretprobe rawtp fentry fexit
 do
 	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-10s: %s\n" $i "$summary"
-- 
2.34.1

