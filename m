Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC6511105
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Apr 2022 08:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358047AbiD0GVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Apr 2022 02:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358040AbiD0GVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Apr 2022 02:21:18 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1481487;
        Tue, 26 Apr 2022 23:18:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VBR1fxf_1651040277;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VBR1fxf_1651040277)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 14:18:05 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] selftests: cgroup: Fix unsigned expression compared with zero
Date:   Wed, 27 Apr 2022 14:17:56 +0800
Message-Id: <20220427061756.56893-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

./tools/testing/selftests/cgroup/cgroup_util.c:566:8-12: WARNING:
Unsigned expression compared with zero: size < 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 2 +-
 tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index 4c52cc6f2f9c..661e06b94a43 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -552,7 +552,7 @@ int proc_mount_contains(const char *option)
 	return strstr(buf, option) != NULL;
 }
 
-ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
+ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, ssize_t size)
 {
 	char path[PATH_MAX];
 
diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index c92df4e5d395..7b3865805f50 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -53,7 +53,7 @@ extern int set_oom_adj_score(int pid, int score);
 extern int cg_wait_for_proc_count(const char *cgroup, int count);
 extern int cg_killall(const char *cgroup);
 int proc_mount_contains(const char *option);
-extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
+extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, ssize_t size);
 extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
 extern pid_t clone_into_cgroup(int cgroup_fd);
 extern int clone_reap(pid_t pid, int options);
-- 
2.20.1.7.g153144c

