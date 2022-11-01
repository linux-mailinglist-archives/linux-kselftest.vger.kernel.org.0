Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEE614726
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKAJtY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKAJsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:53 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1A19026;
        Tue,  1 Nov 2022 02:48:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="94494670"
X-IronPort-AV: E=Sophos;i="5.95,230,1661785200"; 
   d="scan'208";a="94494670"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Nov 2022 18:48:50 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 329E9CA1E2;
        Tue,  1 Nov 2022 18:48:49 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CF99D55E3;
        Tue,  1 Nov 2022 18:48:48 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 6491340164A60;
        Tue,  1 Nov 2022 18:48:48 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 4/5] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Tue,  1 Nov 2022 18:43:40 +0900
Message-Id: <20221101094341.3383073-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After creating a child process with fork() in CAT test, if there is
an error occurs or such as a SIGINT signal is received, the parent
process will be terminated immediately, but the child process will not
be killed and also umount_resctrlfs() will not be called.

Add a signal handler like other tests to kill child process, umount
resctrlfs, cleanup result files, etc. when an error occurs.

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6a8306b0a109..5f81817f4366 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -98,12 +98,21 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME2);
 }
 
+static void ctrl_handler(int signo)
+{
+	kill(bm_pid, SIGKILL);
+	umount_resctrlfs();
+	tests_cleanup();
+	ksft_print_msg("Ending\n\n");
+
+	exit(EXIT_SUCCESS);
+}
+
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	char pipe_message;
-	pid_t bm_pid;
 
 	cache_size = 0;
 
@@ -181,17 +190,19 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
+	} else {
+		/* set up ctrl-c handler */
+		if (signal(SIGINT, ctrl_handler) == SIG_ERR ||
+		    signal(SIGHUP, ctrl_handler) == SIG_ERR ||
+		    signal(SIGTERM, ctrl_handler) == SIG_ERR)
+			printf("Failed to catch SIGNAL!\n");
 	}
 
 	remove(param.filename);
 
 	ret = cat_val(&param);
-	if (ret)
-		return ret;
-
-	ret = check_results(&param);
-	if (ret)
-		return ret;
+	if (ret == 0)
+		ret = check_results(&param);
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
@@ -201,7 +212,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		    sizeof(pipe_message)) {
 			close(pipefd[1]);
 			perror("# failed signaling parent process");
-			return errno;
 		}
 
 		close(pipefd[1]);
@@ -226,5 +236,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (bm_pid)
 		umount_resctrlfs();
 
-	return 0;
+	return ret;
 }
-- 
2.27.0

