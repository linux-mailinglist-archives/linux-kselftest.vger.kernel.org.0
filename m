Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FC4B7DB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiBPC3h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:29:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiBPC3g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:29:36 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83CCF5426;
        Tue, 15 Feb 2022 18:29:24 -0800 (PST)
IronPort-SDR: kAYv95AfXj1TF0NFiwp/qvO2X2XGZ0rJ99qXo0mUOPKBPJfHi+ybfLTGIjDZ/7s2p2fkjkzOhV
 xjjWOB4onWgSirX3txJ8sG+8N0lQYy93Na+X+Nqd2m1Ia3p2J0kGiSuiXV4f2ooDNA3WNVZ+3x
 DpF+ajXYdCI4aged/w64pmc2O3/kYuI/Az1LQjk9jBFk+IWONctLpHMGkMqXSTSr2Tm3QIhRAg
 dO/NP0sw6/kWZjdacUvF+2Zzlz4naGM8gKeFuYl4Wz15ilAfRZS2jTNpV6YRBa92T2nm+a/65g
 9NvwW3hQtd6QzOKHEoAvFYGi
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="62683563"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="62683563"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:28:20 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6041FD689C;
        Wed, 16 Feb 2022 11:28:18 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9DB34E6747;
        Wed, 16 Feb 2022 11:28:16 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 767A24007E8D3;
        Wed, 16 Feb 2022 11:28:16 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 1/5] selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
Date:   Wed, 16 Feb 2022 11:26:37 +0900
Message-Id: <20220216022641.2998318-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
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

Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Some important feedbacks from v1&v2 are addressed as follows:

- Change the order so that current patch 3/3 becomes 1/3. Since without
  the SIGTERM fix, the test would hang if run from the kselftest framework.
  => I changed the order and the SIGTERM fix now becomes patch [1/5].

- Describe that the test is run using the timeout utility and
  it will send SIGTERM to the test upon timeout.
  => I updated the changelog to include this information.

- Describe changes in imperative mood, and address this in all patches.
  See Documentation/process/submitting-patches.rst for more details.
  => I described all my patches' changelog in imperative mood and
     deleted "This commit".

- +	    sigaction(SIGTERM, &sigact, NULL) ||
  This snippet is preceded with a comment that describes its usage
  you could also update it with the expanded use of the kselftest framework.
  => I don't think it is necessary to add other comments.
     Since the current comment already states "Register CTRL-C handler for parent,
     as it has to kill benchmark before exiting", So, when SIGTERM comes,
     the benchmark(child process) should be killed before parent process terminates,
     but it was missing.

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

