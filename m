Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D42639F30
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 03:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiK1CET (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Nov 2022 21:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1CES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Nov 2022 21:04:18 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FBAD2F9;
        Sun, 27 Nov 2022 18:04:17 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NL7zv0ShszRpQL;
        Mon, 28 Nov 2022 10:03:39 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 10:04:15 +0800
Received: from localhost.localdomain (10.90.53.65) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 28 Nov 2022 10:04:15 +0800
From:   limin <limin100@huawei.com>
To:     <shuah@kernel.org>, <mic@digikod.net>,
        <linux-kselftest@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <songmuchun@bytedance.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>
Subject: [PATCH -next] selftests/landlock: Fix selftest ptrace_test run fail
Date:   Mon, 28 Nov 2022 10:04:09 +0800
Message-ID: <20221128020409.1545717-1-limin100@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.65]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent,
trace parent return -1 when child== 0
How to reproduce warning:
$ make -C tools/testing/selftests TARGETS=landlock run_tests

Signed-off-by: limin <limin100@huawei.com>
---
 tools/testing/selftests/landlock/ptrace_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index c28ef98ff3ac..88c4dc63eea0 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -267,12 +267,11 @@ TEST_F(hierarchy, trace)
 		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
 		err_proc_read = test_ptrace_read(parent);
 		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
 		if (variant->domain_child) {
-			EXPECT_EQ(-1, ret);
-			EXPECT_EQ(EPERM, errno);
 			EXPECT_EQ(EACCES, err_proc_read);
 		} else {
-			EXPECT_EQ(0, ret);
 			EXPECT_EQ(0, err_proc_read);
 		}
 		if (ret == 0) {
-- 
2.33.0

