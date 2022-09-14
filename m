Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F337A5B7ED9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiINCSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 22:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 22:18:43 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B8558E1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 19:18:41 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="76604947"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="76604947"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:55:07 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D6F41D6252;
        Wed, 14 Sep 2022 10:55:06 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C70FD35C1;
        Wed, 14 Sep 2022 10:55:06 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id F031F403E0598;
        Wed, 14 Sep 2022 10:55:05 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 4/5] selftests/resctrl: Kill the child process before exiting the parent process if an exception occurs
Date:   Wed, 14 Sep 2022 10:51:46 +0900
Message-Id: <20220914015147.3071025-6-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After creating a child process with fork() in CAT test, if there is
an exception occurs, the parent process will be terminated immediately,
but the child process will not be killed and umount_resctrlfs() will not
be called.

When fork() is used in CMT/MBA/MBM tests.
If an exception occurs, before parent process exiting,
the child process is killed and umount_resctrlfs() is called.

Kill the child process before exiting the parent process
if an exception occurs in CAT test, like in CMT/MBA/MBM tests.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index d1134f66469f..f62da445acbb 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -186,11 +186,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	ret = cat_val(&param);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = check_results(&param);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
@@ -200,7 +200,8 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		    sizeof(pipe_message)) {
 			close(pipefd[1]);
 			perror("# failed signaling parent process");
-			return errno;
+			ret = errno;
+			goto out;
 		}
 
 		close(pipefd[1]);
@@ -218,11 +219,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 			}
 		}
 		close(pipefd[0]);
-		kill(bm_pid, SIGKILL);
 	}
 
-	if (bm_pid)
-		umount_resctrlfs();
+out:
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
 
-	return 0;
+	return ret;
 }
-- 
2.27.0

