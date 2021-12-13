Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E194727ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Dec 2021 11:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhLMKGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Dec 2021 05:06:05 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:16668 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237482AbhLMKEE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:04 -0500
IronPort-SDR: kaBtCZP1JuahjalfLthOECjI86x+KNdF13slxeMa65490JGaGf0Le+BEIBGQuaxvT3ihTfCB4l
 LSb8V72rytJSesR4IzgLplHVLkVvkapt1rzOQIgcJyj4GjJlZ2n5TF4MJyL0gugMAT63bsUqjz
 Y7Moa7CVuHS5SQ9vcG7SzhzzotPTIAc38Te4cISEG5IyXkaRLpEAlSvIy99zO/w+a3lSIHsO/Q
 t8L78W/ooOF3WSe0NGvnj3dmfEeyJggw+xgjEKoikdVco0JS1TTPpd9dZMdPYm3mmwn8QLoNOB
 lhwZD7Uaqs1FAKd9+sHgnUmZ
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="55986502"
X-IronPort-AV: E=Sophos;i="5.88,202,1635174000"; 
   d="scan'208";a="55986502"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 13 Dec 2021 19:04:00 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id DA786E6883;
        Mon, 13 Dec 2021 19:03:59 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3375ED95E8;
        Mon, 13 Dec 2021 19:03:59 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 14491403F134C;
        Mon, 13 Dec 2021 19:03:59 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 1/5] selftests/resctrl: Kill the child process created by fork() when the SIGTERM signal comes
Date:   Mon, 13 Dec 2021 19:01:50 +0900
Message-Id: <20211213100154.180599-2-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
References: <20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In kselftest framework there is a limited time for each sub test,
when the time limit comes SIGTEM signal will be sent to sub test by
"timeout --foregroup <seconds>" command.
In resctrl_tests, fork() is used to create a child process.
This commit ensures child process to be killed before parent process
exiting if SIGTERM signal comes.

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

