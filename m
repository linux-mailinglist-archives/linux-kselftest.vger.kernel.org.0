Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3617AAD64
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjIVJH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjIVJH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:07:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF29E;
        Fri, 22 Sep 2023 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373641; x=1726909641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmtbaUEMxqVPjG+oZX6DU2I4wi1rrd3OfTC/l3qFAxM=;
  b=HW2ENCAzUrXbVQ+XkxYiX8rCQYV2A9poGt6OHlHaFcxd2JqANRgEMpjk
   jum3LTXN0nxr1usfeM3W5HIaTVHL3L+ARSkplTt1T1ZtvMFXumSix+N/z
   PUDTXCgfNAu2HGfv04J2DYx/8nY7LuQO7UY4//YHgT6k3AJpLw2YK1Aih
   CN5gvvEubCLqH6RfSCXSGGuqx2RrvDxLzvcBggqe/jKO4xKQyPySdxYoI
   Qp6YdzuSdQz7RosckQ11R0lHQOdEEo1s3vjOIf4X1yTMJIRweVIyDNRj2
   J0OA7QFQTvquAdb8KEHQkriG+4IUeLsOn5IG9fbsLq1mc4QA9iH0ydTQN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="378070831"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="378070831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="837663808"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="837663808"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:07:18 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Kellner <christian@kellner.me>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 4/8] selftests/pidfd: Fix ksft print formats
Date:   Fri, 22 Sep 2023 11:06:40 +0200
Message-ID: <96c418fe819e24522ebe72c2c842dcd7fe85352d.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
References: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Many calls to ksft print functions have format strings that don't match
with other passed arguments. One call expects a string but doesn't
provide any argument after the format string.

Fix format specifiers so they match the passed variables.

Add a missing variable to ksft_test_result_pass() inside
pidfd_fdinfo_test() so it matches other cases in the switch statement.

Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Add fixes tag to patch message.

 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 4e86f927880c..01cc37bf611c 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -62,7 +62,7 @@ static void error_report(struct error *err, const char *test_name)
 		break;
 
 	case PIDFD_PASS:
-		ksft_test_result_pass("%s test: Passed\n");
+		ksft_test_result_pass("%s test: Passed\n", test_name);
 		break;
 
 	default:
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 00a07e7c571c..c081ae91313a 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -381,13 +381,13 @@ static int test_pidfd_send_signal_syscall_support(void)
 
 static void *test_pidfd_poll_exec_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	ksft_print_msg("Child Thread: doing exec of sleep\n");
 
 	execl("/bin/sleep", "sleep", str(CHILD_THREAD_MIN_WAIT), (char *)NULL);
 
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n",
 			getpid(), syscall(SYS_gettid));
 	return NULL;
 }
@@ -427,7 +427,7 @@ static int child_poll_exec_test(void *args)
 {
 	pthread_t t1;
 
-	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
+	ksft_print_msg("Child (pidfd): starting. pid %d tid %ld\n", getpid(),
 			syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
 	/*
@@ -480,10 +480,10 @@ static void test_pidfd_poll_exec(int use_waitpid)
 
 static void *test_pidfd_poll_leader_exit_thread(void *priv)
 {
-	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+	ksft_print_msg("Child Thread: starting. pid %d tid %ld ; and sleeping\n",
 			getpid(), syscall(SYS_gettid));
 	sleep(CHILD_THREAD_MIN_WAIT);
-	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child Thread: DONE. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	return NULL;
 }
 
@@ -492,7 +492,7 @@ static int child_poll_leader_exit_test(void *args)
 {
 	pthread_t t1, t2;
 
-	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child: starting. pid %d tid %ld\n", getpid(), syscall(SYS_gettid));
 	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
 
-- 
2.42.0

