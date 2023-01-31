Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89659682422
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 06:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjAaFud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 00:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaFuc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 00:50:32 -0500
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031593B0E6;
        Mon, 30 Jan 2023 21:50:30 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="93176204"
X-IronPort-AV: E=Sophos;i="5.97,259,1669042800"; 
   d="scan'208";a="93176204"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:50:28 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 64218D66A3;
        Tue, 31 Jan 2023 14:50:26 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B104DD3552;
        Tue, 31 Jan 2023 14:50:25 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 8D4374005E9BC;
        Tue, 31 Jan 2023 14:50:25 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v6 0/5] Some improvements of resctrl selftest
Date:   Tue, 31 Jan 2023 14:46:50 +0900
Message-Id: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
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
[patch 4] Add a signal handler to cleanup properly before exiting the 
	  parent process if there is an error occurs after creating 
	  a child process with fork() in the CAT test, and unregister
	  signal handler when each test finished.
[patch 5] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called
	  twice. Delete once.

This patch series is based on Linux v6.2-rc6.

Difference from v5:
[patch 4] 
  - If an error occurs in signal_handler_register() return -1, 
    and if an error occurs in signal_handler_unregister() does 
    not return any value.
  - If signal_handler_register() fails, stop the running
    parents&child process.
  - Ignore the result of signal_handler_unregister() 
    so as not to overwrite earlier value of ret.
  - Fix change log.

Shaopeng Tan (5):
  selftests/resctrl: Fix set up schemata with 100% allocation on first
    run in MBM test
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Flush stdout file buffer before executing fork()
  selftests/resctrl: Cleanup properly when an error occurs in CAT test
  selftests/resctrl: Remove duplicate codes that clear each test result
    file

 tools/testing/selftests/resctrl/cat_test.c    | 29 ++++----
 tools/testing/selftests/resctrl/cmt_test.c    |  7 +-
 tools/testing/selftests/resctrl/fill_buf.c    | 14 ----
 tools/testing/selftests/resctrl/mba_test.c    | 23 +++---
 tools/testing/selftests/resctrl/mbm_test.c    | 20 +++---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  4 --
 tools/testing/selftests/resctrl/resctrl_val.c | 71 +++++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   |  5 +-
 9 files changed, 98 insertions(+), 77 deletions(-)

-- 
2.27.0

