Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8CC62D06F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiKQBLr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 20:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiKQBLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 20:11:42 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC3E3C6CF;
        Wed, 16 Nov 2022 17:11:40 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="96352867"
X-IronPort-AV: E=Sophos;i="5.96,169,1665414000"; 
   d="scan'208";a="96352867"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Nov 2022 10:11:39 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 62C0DD4C26;
        Thu, 17 Nov 2022 10:11:37 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A2E99BD696;
        Thu, 17 Nov 2022 10:11:36 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 8D53A40089714;
        Thu, 17 Nov 2022 10:11:36 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 4/5] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Thu, 17 Nov 2022 10:05:40 +0900
Message-Id: <20221117010541.1014481-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
References: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
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
resctrlfs, cleanup result files, etc. if an error occurs in parent
process. To use ctrlc_handler() of other tests to kill child
process(bm_pid), using global bm_pid instead of local bm_pid.

Wait for child process to be killed if an error occurs in child process.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6a8306b0a109..1f8f5cf94e95 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -100,10 +100,10 @@ void cat_test_cleanup(void)
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
+	struct sigaction sigact;
 	unsigned long l_mask, l_mask_1;
 	int ret, pipefd[2], sibling_cpu_no;
 	char pipe_message;
-	pid_t bm_pid;
 
 	cache_size = 0;
 
@@ -181,17 +181,25 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
+	} else {
+		/*
+		 * Register CTRL-C handler for parent, as it has to kill
+		 * child process before exiting
+		 */
+		sigact.sa_sigaction = ctrlc_handler;
+		sigemptyset(&sigact.sa_mask);
+		sigact.sa_flags = SA_SIGINFO;
+		if (sigaction(SIGINT, &sigact, NULL) ||
+		    sigaction(SIGTERM, &sigact, NULL) ||
+		    sigaction(SIGHUP, &sigact, NULL))
+			perror("# sigaction");
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
@@ -199,9 +207,11 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
 		    sizeof(pipe_message)) {
-			close(pipefd[1]);
+			/*
+			 * Just print the error message.
+			 * Let while(1) run and wait for itself to be killed.
+			 */
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

