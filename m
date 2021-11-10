Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59044BDF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhKJJoK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 04:44:10 -0500
Received: from esa10.hc1455-7.c3s2.iphmx.com ([139.138.36.225]:23931 "EHLO
        esa10.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhKJJoJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 04:44:09 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Nov 2021 04:44:09 EST
IronPort-SDR: bWkE/8CVZN6aB59nqE37nke6m5X/XtuRrZroitYpMQdjef8ChAQvu8mUpTX9ygOcby4KEUuMg4
 S8poeq+YVmBGyr5EBC7/9H17WcZgJiqxj1OMNrht8Toe0so/Xkw1COITSI5rnbCCTTKdgP0eBC
 IY/JMEfiCbVVY010txtUtyaY8TGhEVx2KvqTIV/omYk0Sj/hWn0/LdOxU92FFvq6UTkp0XlYDh
 MOlSmI8gnAYkW1aRQ3j7gcIf+pEfirkXObW5MvU5XO156q8HlEjldFEoZXc4TSooZ9qGtjM9S2
 dHzyhI7636GaSg6rMulimBqy
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="39914653"
X-IronPort-AV: E=Sophos;i="5.87,223,1631545200"; 
   d="scan'208";a="39914653"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP; 10 Nov 2021 18:34:05 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 250C91013BD;
        Wed, 10 Nov 2021 18:34:05 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 1524EE681E;
        Wed, 10 Nov 2021 18:34:04 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id F30924006D3A2;
        Wed, 10 Nov 2021 18:34:02 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 3/3] selftests/resctrl: Kill the child process created by fork() when the SIGTERM signal comes
Date:   Wed, 10 Nov 2021 18:33:15 +0900
Message-Id: <20211110093315.3219191-4-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Tan, Shaopeng" <tan.shaopeng@jp.fujitsu.com>

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
index 9522434..b32b963 100644
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
1.8.3.1

