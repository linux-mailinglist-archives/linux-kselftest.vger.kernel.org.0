Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5092B5F4D76
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Oct 2022 03:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJEBoq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Oct 2022 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJEBop (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Oct 2022 21:44:45 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 18:44:41 PDT
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD40B4B2;
        Tue,  4 Oct 2022 18:44:40 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="70639148"
X-IronPort-AV: E=Sophos;i="5.95,159,1661785200"; 
   d="scan'208";a="70639148"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 05 Oct 2022 10:43:34 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id E663BB63B1;
        Wed,  5 Oct 2022 10:43:33 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A7C9CFBC2;
        Wed,  5 Oct 2022 10:43:33 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 26728405D4705;
        Wed,  5 Oct 2022 10:43:33 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v2 0/4] Some improvements of resctrl selftest
Date:   Wed,  5 Oct 2022 10:39:29 +0900
Message-Id: <20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com>
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
[patch 3] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called
	  twice.  Delete once.
[patch 4] When a child process is created by fork(), the buffer of the 
	  parent process is also copied. Flush the buffer before
	  executing fork().

This patch series is based on Linux v6.0-rc7

Difference from v1:
[patch 1] Make write_schemata() always be called, and use 
	  resctrl_val_param->num_of_runs instead of static num_of_runs.
[patch 2] Add Reviewed-by tag.
[patch 3] Remove cat/cmt/mbm/mba_test_cleanup() from run_cmt/mbm/mba_test()
	  and modify changelog.
[patch 4] Add Reviewed-by tag.

Notice that I dropped the one patch from v1 in this series
("[PATCH 4/5] selftests/resctrl: Kill the child process before exiting
the parent process if an exception occurs").
This is because the bug will take some time to fix, I will submit it
separately in the future.

Shaopeng Tan (4):
  selftests/resctrl: Fix set up shemata with 100% allocation on first
    run in MBM test.
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Remove duplicate codes that clear each test result
    file
  selftests/resctrl: Flush stdout file buffer before executing fork()

 tools/testing/selftests/resctrl/cat_test.c      | 1 +
 tools/testing/selftests/resctrl/mba_test.c      | 8 ++++----
 tools/testing/selftests/resctrl/mbm_test.c      | 6 +++---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ----
 tools/testing/selftests/resctrl/resctrl_val.c   | 1 +
 tools/testing/selftests/resctrl/resctrlfs.c     | 1 +
 6 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.27.0

