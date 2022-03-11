Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A4B4D5C32
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 08:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiCKHYo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 02:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbiCKHYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 02:24:41 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A153318623A;
        Thu, 10 Mar 2022 23:23:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="65496854"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="65496854"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 16:23:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 71185E07E1;
        Fri, 11 Mar 2022 16:23:36 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A982ADD746;
        Fri, 11 Mar 2022 16:23:35 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 5C014401110B2;
        Fri, 11 Mar 2022 16:23:35 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 1/6] selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
Date:   Fri, 11 Mar 2022 16:21:42 +0900
Message-Id: <20220311072147.3301525-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
References: <20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com>
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

In kselftest framework, a sub test is run using the timeout utility
and it will send SIGTERM to the test upon timeout.

In resctrl_tests, a child process is created by fork() to
run benchmark but SIGTERM is not set in sigaction().
If SIGTERM signal is received, the parent process will be killed,
but the child process still exists.

kill child process before parent process terminates
if SIGTERM signal is received.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 95224345c78e..b32b96356ec7 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -678,6 +678,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	sigemptyset(&sigact.sa_mask);
 	sigact.sa_flags = SA_SIGINFO;
 	if (sigaction(SIGINT, &sigact, NULL) ||
+	    sigaction(SIGTERM, &sigact, NULL) ||
 	    sigaction(SIGHUP, &sigact, NULL)) {
 		perror("# sigaction");
 		ret = errno;
-- 
2.27.0

