Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094776655A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 09:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjAKIDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 03:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjAKIDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 03:03:05 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Jan 2023 00:02:28 PST
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A1C9
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jan 2023 00:02:28 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="82239538"
X-IronPort-AV: E=Sophos;i="5.96,315,1665414000"; 
   d="scan'208";a="82239538"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Jan 2023 16:59:16 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 341DFE8520;
        Wed, 11 Jan 2023 16:59:16 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7D81AD5077;
        Wed, 11 Jan 2023 16:59:15 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 584414007AF34;
        Wed, 11 Jan 2023 16:59:15 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v5 0/5] Some improvements of resctrl selftest
Date:   Wed, 11 Jan 2023 16:57:57 +0900
Message-Id: <20230111075802.3556803-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

This patch series is based on Linux v6.2-rc3.

Difference from v4:
[patch 4] 
  - Reuse signal handler of other tests(MBM/MBA/CAT).
  - Unregister signal handler when tests finished.
  - Fix change log.

Pervious versions of this series:
[v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
[v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/
[v3] https://lore.kernel.org/lkml/20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com/
[v4] https://lore.kernel.org/lkml/20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com/

Shaopeng Tan (5):
  selftests/resctrl: Fix set up schemata with 100% allocation on first
    run in MBM test
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Flush stdout file buffer before executing fork()
  selftests/resctrl: Cleanup properly when an error occurs in CAT test
  selftests/resctrl: Remove duplicate codes that clear each test result
    file

 tools/testing/selftests/resctrl/cat_test.c    | 27 +++++----
 tools/testing/selftests/resctrl/cmt_test.c    |  7 +--
 tools/testing/selftests/resctrl/fill_buf.c    | 14 -----
 tools/testing/selftests/resctrl/mba_test.c    | 23 ++++----
 tools/testing/selftests/resctrl/mbm_test.c    | 20 +++----
 tools/testing/selftests/resctrl/resctrl.h     |  2 +
 .../testing/selftests/resctrl/resctrl_tests.c |  4 --
 tools/testing/selftests/resctrl/resctrl_val.c | 57 ++++++++++++++-----
 tools/testing/selftests/resctrl/resctrlfs.c   |  5 +-
 9 files changed, 89 insertions(+), 70 deletions(-)

-- 
2.27.0

