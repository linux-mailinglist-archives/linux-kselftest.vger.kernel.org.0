Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF3F791770
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbjIDMp5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjIDMpz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8208CCE;
        Mon,  4 Sep 2023 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831547; x=1725367547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ur7uZoww6FS6EfbpNkxHkTWp9s13PDMr1Npv7yNc/3U=;
  b=QPRTv9OeGPvpJjbv5xgTMYsSIQZ4aGidcoINN2KENtCi/Ok0trOVr7P1
   S9CbQSd+6VVm32TYdFSMMldMM1DYyKcVIRD07w3yfNNB9tvviUvfVyIcn
   kqYrLIdPGnH9H0UfC9++DDdyOrfQeSj9TLB0wTk/7UiJ7St4uFL+FPqLy
   lfnhzQp2UTaQ3XKD3CpzRcfFtrgu2muwD/yeAA8rQ8ATdpcCdCibEYdQp
   h/vCDpcNgUFbj0YVJY0Wqal2INiDsGG5tI8NFe8LR0chIXa9hIN9g/K9g
   dHntr9AzCunrCUSYJzFJ17TonR9Euwx8ADscrfSodTyDV/0YMWgeaEuAD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="440555404"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="440555404"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="914497823"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="914497823"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:28 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Kellner <christian@kellner.me>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/8] selftests/pidfd: Fix ksft print formats
Date:   Mon,  4 Sep 2023 14:44:27 +0200
Message-ID: <0ac871f5a15392dac7f308b8759cb17707faf789.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
References: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
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

