Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C64E4DE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 09:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiCWIP0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 04:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiCWIPZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 04:15:25 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665A5BE47;
        Wed, 23 Mar 2022 01:13:54 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="55203849"
X-IronPort-AV: E=Sophos;i="5.90,203,1643641200"; 
   d="scan'208";a="55203849"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Mar 2022 17:13:51 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 257ACC68AE;
        Wed, 23 Mar 2022 17:13:51 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C20414320;
        Wed, 23 Mar 2022 17:13:50 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 22759405732E7;
        Wed, 23 Mar 2022 17:13:50 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v7 1/6] selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
Date:   Wed, 23 Mar 2022 17:12:22 +0900
Message-Id: <20220323081227.1603991-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
References: <20220323081227.1603991-1-tan.shaopeng@jp.fujitsu.com>
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

Kill child process before the parent process terminates
if SIGTERM signal is received.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
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

