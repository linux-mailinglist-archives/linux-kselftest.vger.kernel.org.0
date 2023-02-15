Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B769784A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjBOIgl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 03:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjBOIgk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 03:36:40 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29BB25B9C;
        Wed, 15 Feb 2023 00:36:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="86108417"
X-IronPort-AV: E=Sophos;i="5.97,299,1669042800"; 
   d="scan'208";a="86108417"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 17:36:37 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2127CD3EA0;
        Wed, 15 Feb 2023 17:36:34 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 766BBD35E1;
        Wed, 15 Feb 2023 17:36:33 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 531B0400C0298;
        Wed, 15 Feb 2023 17:36:33 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v8 0/6] Some improvements of resctrl selftest
Date:   Wed, 15 Feb 2023 17:32:24 +0900
Message-Id: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
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

Hello,

The aim of this patch series is to improve the resctrl selftest.
Without these fixes, some unnecessary processing will be executed
and test results will be confusing. 
There is no behavior change in test themselves.

[patch 1] Make write_schemata() run to set up shemata with 100% allocation
	  on first run in MBM test.
[patch 2] The MBA test result message is always output as "ok",
	  make output message to be "not ok" if MBA check result is failed.
[patch 3] When a child process is created by fork(), the buffer of the 
	  parent process is also copied. Flush the buffer before
	  executing fork().
[patch 4] An error occurs whether in parents process or child process,
	  the parents process always kills child process and runs
	  umount_resctrlfs(), and the child process always waits to be
	  killed by the parent process.
[patch 5] If a signal received, to cleanup properly before exiting the
	  parent process, commonize the signal handler registered for 
	  CMT/MBM/MBA tests and reuse it in CAT, also unregister the 
	  signal handler at the end of each test.
[patch 6] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called
	  twice. Delete once.

This patch series is based on Linux v6.2-rc7.

Difference from v7:
[patch 4] 
  - Fix commitlog.
[patch 5]
  - Fix commitlog.

Pervious versions of this series:
[v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
[v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/
[v3] https://lore.kernel.org/lkml/20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com/
[v4] https://lore.kernel.org/lkml/20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com/
[v5] https://lore.kernel.org/lkml/20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com/
[v6] https://lore.kernel.org/lkml/20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com/
[v7] https://lore.kernel.org/lkml/20230213062428.1721572-1-tan.shaopeng@jp.fujitsu.com/

Shaopeng Tan (6):
  selftests/resctrl: Fix set up schemata with 100% allocation on first
    run in MBM test
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Flush stdout file buffer before executing fork()
  selftests/resctrl: Cleanup properly when an error occurs in CAT test
  selftests/resctrl: Commonize the signal handler register/unregister
    for all tests
  selftests/resctrl: Remove duplicate codes that clear each test result
    file

 tools/testing/selftests/resctrl/cat_test.c    | 29 ++++----
 tools/testing/selftests/resctrl/cmt_test.c    |  7 +-
 tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
 tools/testing/selftests/resctrl/mba_test.c    | 23 +++----
 tools/testing/selftests/resctrl/mbm_test.c    | 20 +++---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  4 --
 tools/testing/selftests/resctrl/resctrl_val.c | 67 ++++++++++++++-----
 tools/testing/selftests/resctrl/resctrlfs.c   |  5 +-
 9 files changed, 96 insertions(+), 75 deletions(-)

-- 
2.27.0

