Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A286C4CD286
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiCDKkU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbiCDKkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:40:18 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120117ED9B;
        Fri,  4 Mar 2022 02:39:29 -0800 (PST)
IronPort-SDR: 99OgVtSJNOWFx2gCepKjFLs5kcjH1fJ6ZO63J02raI5ccdKOqseXVitSmv/sgnPa+R688bXjH3
 P9/JMZKPg1S9TTRWW+171oSUishiu6cUg8XfD1CxPOGgravV77kfeOyw5WNFM0jQwCzWkxdbBw
 IgqimyPzYRgWbo4J0JWF4oFUzQgTqanyx4iq5vGzb5Fh2soHbXNQG1ubZKEIIXV43mnBXb3LCc
 55jGpVsqciT7EE1Bgd+zd9/6CVdV5iw8KC/sH0hlnDR0PcWrT6OfzkoVABz4K8xqu7IIthFN1n
 y0V5aDqgcfpJ8XwfqwSC/YO6
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="44657797"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="44657797"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:39:26 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 13263D7704;
        Fri,  4 Mar 2022 19:39:26 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A55DF1ED62F;
        Fri,  4 Mar 2022 19:39:24 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 6797340450F6A;
        Fri,  4 Mar 2022 19:39:24 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 1/6] selftests/resctrl: Kill child process before parent process terminates if SIGTERM is received
Date:   Fri,  4 Mar 2022 19:38:29 +0900
Message-Id: <20220304103834.486892-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
References: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
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

