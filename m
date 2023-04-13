Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012DA6E07AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 09:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDMHY0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjDMHYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 03:24:21 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211754C19;
        Thu, 13 Apr 2023 00:24:17 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="92663594"
X-IronPort-AV: E=Sophos;i="5.98,339,1673881200"; 
   d="scan'208";a="92663594"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 16:23:05 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id CD97ADF1B6;
        Thu, 13 Apr 2023 16:23:02 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 083E0D94A9;
        Thu, 13 Apr 2023 16:23:02 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id B123B400C07D1;
        Thu, 13 Apr 2023 16:23:01 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v9 4/6] selftests/resctrl: Cleanup properly when an error occurs in CAT test
Date:   Thu, 13 Apr 2023 16:22:57 +0900
Message-Id: <20230413072259.2089348-5-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com>
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

After creating a child process with fork() in CAT test, if an error
occurs when parent process runs cat_val() or check_results(), the child
process will not be killed and also resctrlfs is not unmounted. Also if
an error occurs when child process runs cat_val() or check_results(),
the parent process will wait for the pipe message from the child process
which will never be sent by the child process and the parent process
cannot proceed to unmount resctrlfs.

Synchronize the exits between the parent and child. An error could
occur whether in parent process or child process. The parent process
always kills the child process and runs umount_resctrlfs(). The
child process always waits to be killed by the parent process.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 38c10a8c1814..0880575840f9 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -186,23 +186,20 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
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
 		close(pipefd[0]);
 		pipe_message = 1;
 		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message)) {
-			close(pipefd[1]);
+		    sizeof(pipe_message))
+			/*
+			 * Just print the error message.
+			 * Let while(1) run and wait for itself to be killed.
+			 */
 			perror("# failed signaling parent process");
-			return errno;
-		}
 
 		close(pipefd[1]);
 		while (1)
@@ -226,5 +223,5 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (bm_pid)
 		umount_resctrlfs();
 
-	return 0;
+	return ret;
 }
-- 
2.27.0

