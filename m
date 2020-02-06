Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF01540A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 09:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgBFIv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 03:51:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38873 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFIv4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 03:51:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so2773303pfc.5;
        Thu, 06 Feb 2020 00:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=t0ZkRPw1qrQ0f8z2RbPGrKw+AhhQtmfGX+r47zBC98M=;
        b=jFNMZpN4IFFd7xlgs1ZxDnyah6Ow817U7LGePFtJ+sgo4JsuNfZmjidc7Sj7wx6Peb
         Sntu4XWIWJDfaZqeimicxI1mut1EltEoC+RUk0tvVrYwYZh5iQGaSRXb1fajv9u8sL5t
         /HmZYkPtqtREnJnpgPZgX8PnTNxF26SGplC6LxkXNrqFbEI4rsCCxVxvhc0vksuFPRU0
         93GXN9sTOZMF6apAdNSGV3JMMVc/CtRqHnaQNR4qt0l9GS6sFcYhlOGqrqhfFhCTXl18
         uw68LhzkLbceRUHCCmnIzeaG1o88dqe5zkwS+sQC1DgN9JFTZmxiKk78PoHaJHB7r82p
         XmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=t0ZkRPw1qrQ0f8z2RbPGrKw+AhhQtmfGX+r47zBC98M=;
        b=QvgdIcU8y+lRl5bwOYrLm2QAqDtTx62LbXgGEpCTazRy9ejOtEoWvT18+oksqHGV9l
         wf9xB7YGljZjfnq2QqkKHmBuHjNlRx4EzMWwYOxIfE+VgL/hKmpPrgW08UAYg5FTVEt3
         qmvcb4A5htolk0/1GZIBV3FjMvByjsGXmmdCqfAoqx/Eavl8rEJBNR7HOhxINi2FWeor
         3ldqB1sfgJw2il8VCA+Mf1PzdTpbZ3us9lk3/VnMC7lO5lXCcx/4BB8NR+0Cen1Zd6lv
         pVnxntxCLRZ6uEopu/N9s+LDVpwRhZ0nzUl8lxCzN8Ksq1PMRfDWJtrl1eLFcISJ56m6
         hXiQ==
X-Gm-Message-State: APjAAAVw4Py/2Y1Q5UYJ32tMzRyjyhe+ZoZZPjxKb/gA2RbykovS6XyE
        YECIMj3Wuqzmm8TNgFwyeYM=
X-Google-Smtp-Source: APXvYqz7zwqjfYp7765xQJVFaYWE1h56slZ8fsZD1XutBVqtq8ln44kJyOJ1auv9oH3SAWPbyYUoUw==
X-Received: by 2002:aa7:95a3:: with SMTP id a3mr2701203pfk.193.1580979115652;
        Thu, 06 Feb 2020 00:51:55 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id b3sm2432450pfr.88.2020.02.06.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:51:54 -0800 (PST)
From:   sj38.park@gmail.com
To:     shuah@kernel.org, akpm@linux-foundation.org
Cc:     urezki@gmail.com, mhiramat@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] selftests/vm: Add missed tests in run_vmtests
Date:   Thu,  6 Feb 2020 08:51:44 +0000
Message-Id: <20200206085144.29126-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The commits introducing 'mlock-random-test'[1], 'map_fiex_noreplace'[2],
and 'thuge-gen'[3] have not added those in the 'run_vmtests' script and
thus the 'run_tests' command of kselftests doesn't run those.  This
commit adds those in the script.

'gup_benchmark' and 'transhuge-stress' are also not included in the
'run_vmtests', but this commit does not add those because those are for
performance measurement rather than pass/fail tests.

[1] commit 26b4224d9961 ("selftests: expanding more mlock selftest")
[2] commit 91cbacc34512 ("tools/testing/selftests/vm/map_fixed_noreplace.c: add test for MAP_FIXED_NOREPLACE")
[3] commit fcc1f2d5dd34 ("selftests: add a test program for variable huge page sizes in mmap/shmget")

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/vm/run_vmtests | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index a692ea828317..f33714843198 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -112,6 +112,17 @@ echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
 
+echo "---------------------------"
+echo "running map_fixed_noreplace"
+echo "---------------------------"
+./map_fixed_noreplace
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 echo "-------------------"
 echo "running userfaultfd"
 echo "-------------------"
@@ -186,6 +197,17 @@ else
 	echo "[PASS]"
 fi
 
+echo "-------------------------"
+echo "running mlock-random-test"
+echo "-------------------------"
+./mlock-random-test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 echo "--------------------"
 echo "running mlock2-tests"
 echo "--------------------"
@@ -197,6 +219,17 @@ else
 	echo "[PASS]"
 fi
 
+echo "-----------------"
+echo "running thuge-gen"
+echo "-----------------"
+./thuge-gen
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 if [ $VADDR64 -ne 0 ]; then
 echo "-----------------------------"
 echo "running virtual_address_range"

base-commit: d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
-- 
2.17.1

