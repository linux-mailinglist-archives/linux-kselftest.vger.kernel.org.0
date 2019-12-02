Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0A10F38C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 00:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbfLBXmS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 18:42:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22530 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725954AbfLBXmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 18:42:18 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB2NcU9s029846
        for <linux-kselftest@vger.kernel.org>; Mon, 2 Dec 2019 15:42:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=uxmNRueyd7miyY/gd74G4GVj0i0RrTsGpZE9jNZv6UI=;
 b=eiSQ2vKRIuYN1zCkmjN8KD5Q44NrMlx1FEEClRNljfugIP4WNGpPhX7Bg2nkulF6f7g2
 SnKXCDR/lxEkDHfmx/FOi8/9QwEqDEdvtPJW6wFVZC3pS33yjHjZGQbKyAplhzLgYrqb
 Erggq6AcdbE6zXjvkPDaGOu19eMC0y7SYoA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wnanp0j1s-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 15:42:17 -0800
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Dec 2019 15:42:15 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A65BE1B2B81CC; Mon,  2 Dec 2019 15:42:13 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-kselftest@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH kselftest-next 2/2] kselftests: memcg: speed up the memory.high test
Date:   Mon, 2 Dec 2019 15:42:12 -0800
Message-ID: <20191202234212.4134802-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202234212.4134802-1-guro@fb.com>
References: <20191202234212.4134802-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-02_06:2019-11-29,2019-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 phishscore=0 mlxlogscore=643 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912020203
X-FB-Internal: deliver
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After commit 0e4b01df8659 ("mm, memcg: throttle allocators when
failing reclaim over memory.high") allocating memory over memory.high
became very time consuming. But it's exactly what the memory.high
test from cgroup kselftests is doing: it tries to allocate 100M with
30M memory.high value. It takes forever to complete.

In order to keep it passing (or failing) in a reasonable amount of
time let's try to allocate only a little over 30M: 31M to be precise.

With this change test_memcontrol finishes in a reasonable amount of
time:
  $ time ./test_memcontrol
  ok 1 test_memcg_subtree_control
  ok 2 test_memcg_current
  ok 3 test_memcg_min
  ok 4 test_memcg_low
  ok 5 test_memcg_high
  ok 6 test_memcg_max
  ok 7 test_memcg_oom_events
  ok 8 test_memcg_swap_max
  ok 9 test_memcg_sock
  ok 10 test_memcg_oom_group_leaf_events
  ok 11 test_memcg_oom_group_parent_events
  ok 12 test_memcg_oom_group_score_events

  real	0m2.273s
  user	0m0.064s
  sys	0m0.739s

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Chris Down <chris@chrisdown.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 60bfe53c0289..739fa90448f6 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -606,7 +606,7 @@ static int test_memcg_high(const char *root)
 	if (cg_write(memcg, "memory.high", "30M"))
 		goto cleanup;
 
-	if (cg_run(memcg, alloc_anon, (void *)MB(100)))
+	if (cg_run(memcg, alloc_anon, (void *)MB(31)))
 		goto cleanup;
 
 	if (!cg_run(memcg, alloc_pagecache_50M_check, NULL))
-- 
2.17.1

