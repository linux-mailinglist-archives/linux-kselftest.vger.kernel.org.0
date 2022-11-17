Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709BA62D069
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 02:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiKQBLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 20:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiKQBLd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 20:11:33 -0500
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F91DF11;
        Wed, 16 Nov 2022 17:11:31 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="96213577"
X-IronPort-AV: E=Sophos;i="5.96,169,1665414000"; 
   d="scan'208";a="96213577"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Nov 2022 10:11:30 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 49BCB7C06D;
        Thu, 17 Nov 2022 10:11:29 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5FD1D1582F;
        Thu, 17 Nov 2022 10:11:28 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 4B5F640089713;
        Thu, 17 Nov 2022 10:11:28 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 0/5] Some improvements of resctrl selftest
Date:   Thu, 17 Nov 2022 10:05:36 +0900
Message-Id: <20221117010541.1014481-1-tan.shaopeng@jp.fujitsu.com>
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
	  a child process with fork() in the CAT test.
[patch 5] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called
	  twice. Delete once.

This patch series is based on Linux v6.1-rc5

Difference from v3:
[patch 2] 
	Rename "failed" to "ret" to avoid confusion.
[patch 4] 
	- Use sigaction(2) instead of signal().
	- Add a description of using global bm_pid in commit message.
	- Add comments to clarify why let the child continue to its
	  infinite loop after the write() failed.
[patch 5] 
	Ensure to run cat/cmt/mbm/mba_test_cleanup() to clear test result 
	file before return if an error occurs.


Pervious versions of this series:
[v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
[v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/
[v3] https://lore.kernel.org/lkml/20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com/

Shaopeng Tan (5):
  selftests/resctrl: Fix set up schemata with 100% allocation on first
    run in MBM test
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Flush stdout file buffer before executing fork()
  selftests/resctrl: Cleanup properly when an error occurs in CAT test
  selftests/resctrl: Remove duplicate codes that clear each test result
    file

 tools/testing/selftests/resctrl/cat_test.c    | 31 +++++++++++++------
 tools/testing/selftests/resctrl/cmt_test.c    |  7 ++---
 tools/testing/selftests/resctrl/mba_test.c    | 23 +++++++-------
 tools/testing/selftests/resctrl/mbm_test.c    | 20 ++++++------
 .../testing/selftests/resctrl/resctrl_tests.c |  4 ---
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c   |  5 ++-
 7 files changed, 50 insertions(+), 41 deletions(-)

-- 
2.27.0

