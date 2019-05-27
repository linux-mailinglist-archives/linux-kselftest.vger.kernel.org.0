Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94AA2AEA7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2019 08:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfE0G3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 May 2019 02:29:02 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49005 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbfE0G3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 May 2019 02:29:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TSmVaYn_1558938539;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSmVaYn_1558938539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 May 2019 14:28:59 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Claudio Zumbo <claudioz@fb.com>,
        Claudio <claudiozumbo@gmail.com>
Subject: [PATCH v3 2/3] kselftest/cgroup: fix unexpected testing failure on test_core
Date:   Mon, 27 May 2019 14:28:06 +0800
Message-Id: <20190527062807.93404-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190527062807.93404-1-alex.shi@linux.alibaba.com>
References: <20190527062807.93404-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cgroup testing relys on the root cgroup's subtree_control setting,
If the 'memory' controller isn't set, some test cases will be failed
as following:

$sudo  ./test_core
not ok 1 test_cgcore_internal_process_constraint
ok 2 test_cgcore_top_down_constraint_enable
not ok 3 test_cgcore_top_down_constraint_disable
...

To correct this unexpected failure, this patch write the 'memory' to
subtree_control of root to get a right result.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Claudio Zumbo <claudioz@fb.com>
Cc: Claudio <claudiozumbo@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 tools/testing/selftests/cgroup/test_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index be59f9c34ea2..d78f1c5366d3 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -376,6 +376,11 @@ int main(int argc, char *argv[])
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.19.1.856.g8858448bb

