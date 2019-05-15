Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 053F41EAA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2019 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfEOJHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 May 2019 05:07:50 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39263 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbfEOJHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 May 2019 05:07:50 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TRnXhxa_1557911259;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TRnXhxa_1557911259)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 May 2019 17:07:39 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     alex.shi@linux.alibaba.com
Cc:     Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Claudio Zumbo <claudioz@fb.com>,
        Claudio <claudiozumbo@gmail.com>
Subject: [PATCH 2/3] kselftest/cgroup: fix unexcepted testing failure on test_core
Date:   Wed, 15 May 2019 17:07:03 +0800
Message-Id: <20190515090704.56929-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190515090704.56929-1-alex.shi@linux.alibaba.com>
References: <20190515090704.56929-1-alex.shi@linux.alibaba.com>
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

To correct this unexcepted failure, this patch write the 'memory' to
subtree_control of root to get a right result.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Claudio Zumbo <claudioz@fb.com>
Cc: Claudio <claudiozumbo@gmail.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/cgroup/test_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index be59f9c34ea2..b1a570d7c557 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -376,6 +376,11 @@ int main(int argc, char *argv[])
 
 	if (cg_find_unified_root(root, sizeof(root)))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+	    if (cg_write(root, "cgroup.subtree_control", "+memory"))
+		ksft_exit_skip("Failed to set root memory controller\n");
+
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
-- 
2.19.1.856.g8858448bb

