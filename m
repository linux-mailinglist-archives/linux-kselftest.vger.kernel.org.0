Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA410F38A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 00:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLBXmS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 18:42:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1448 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfLBXmR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 18:42:17 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2NdTdT028819
        for <linux-kselftest@vger.kernel.org>; Mon, 2 Dec 2019 15:42:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=VkzjK4ExkXcMzBf6eib34ENsXWoiFhhtz9DyMkAIWiE=;
 b=j/B7tQfMTUfCZS6/BDJPC+E+R4hXaUoWuFYDc5j8cj5AXm++B7gu5WlERrrkV0F8m5uy
 CHF77j1ux806+44arwpLthUeKasoftrclzGfpLOFz5elxSqmKLnem4mBmmGHOtoD1f2+
 PwlL3TisPlre19V/ZFgCx2AgluVw+fVzNG0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wn6cw25m1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 15:42:16 -0800
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Dec 2019 15:42:15 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A317E1B2B81CA; Mon,  2 Dec 2019 15:42:13 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH kselftest-next 1/2] kselftests: memcg: update the oom group leaf events test
Date:   Mon, 2 Dec 2019 15:42:11 -0800
Message-ID: <20191202234212.4134802-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1011
 bulkscore=0 mlxscore=0 mlxlogscore=702 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020203
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") made
memory.events recursive: all events are propagated upwards by the
tree. It was a change in semantics.

It broke the oom group leaf events test: it assumes that after
an OOM the oom_kill counter is zero on parent's level.

Let's adjust the test: it should have similar expectations
for the child and parent levels.

The test passes after this fix.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c19a97dd02d4..60bfe53c0289 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -1002,7 +1002,8 @@ static int test_memcg_sock(const char *root)
 /*
  * This test disables swapping and tries to allocate anonymous memory
  * up to OOM with memory.group.oom set. Then it checks that all
- * processes in the leaf (but not the parent) were killed.
+ * processes in the leaf were killed. It also checks that oom_events
+ * were propagated to the parent level.
  */
 static int test_memcg_oom_group_leaf_events(const char *root)
 {
@@ -1045,7 +1046,7 @@ static int test_memcg_oom_group_leaf_events(const char *root)
 	if (cg_read_key_long(child, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
-	if (cg_read_key_long(parent, "memory.events", "oom_kill ") != 0)
+	if (cg_read_key_long(parent, "memory.events", "oom_kill ") <= 0)
 		goto cleanup;
 
 	ret = KSFT_PASS;
-- 
2.17.1

