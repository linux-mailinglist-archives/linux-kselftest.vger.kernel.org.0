Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4752922A26
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 05:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfETDCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 May 2019 23:02:00 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41498 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbfETDB7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 May 2019 23:01:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TSAay54_1558321316;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSAay54_1558321316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 May 2019 11:01:56 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure on test_memcontrol
Date:   Mon, 20 May 2019 11:01:38 +0800
Message-Id: <20190520030140.203605-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
References: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The cgroup testing relies on the root cgroup's subtree_control setting,
If the 'memory' controller isn't set, all test cases will be failed
as following:

$ sudo ./test_memcontrol
not ok 1 test_memcg_subtree_control
not ok 2 test_memcg_current
ok 3 # skip test_memcg_min
not ok 4 test_memcg_low
not ok 5 test_memcg_high
not ok 6 test_memcg_max
not ok 7 test_memcg_oom_events
ok 8 # skip test_memcg_swap_max
not ok 9 test_memcg_sock
not ok 10 test_memcg_oom_group_leaf_events
not ok 11 test_memcg_oom_group_parent_events
not ok 12 test_memcg_oom_group_score_events

To correct this unexpected failure, this patch write the 'memory' to
subtree_control of root to get a right result.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Jay Kamat <jgkamat@fb.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Roman Gushchin <guro@fb.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 6f339882a6ca..73612d604a2a 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1205,6 +1205,10 @@ int main(int argc, char **argv)
 	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
 		ksft_exit_skip("memory controller isn't available\n");
 
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+	    if (cg_write(root, "cgroup.subtree_control", "+memory"))
+		ksft_exit_skip("Failed to set root memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.19.1.856.g8858448bb

