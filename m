Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D594A614720
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 10:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKAJss (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKAJss (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 05:48:48 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1460D10DF;
        Tue,  1 Nov 2022 02:48:45 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="82431855"
X-IronPort-AV: E=Sophos;i="5.95,230,1661785200"; 
   d="scan'208";a="82431855"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Nov 2022 18:48:43 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D14A2C138A;
        Tue,  1 Nov 2022 18:48:42 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 227D2D8C0B;
        Tue,  1 Nov 2022 18:48:42 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 0B3FC40164A60;
        Tue,  1 Nov 2022 18:48:42 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 0/5] Some improvements of resctrl selftest
Date:   Tue,  1 Nov 2022 18:43:36 +0900
Message-Id: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
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
	  parent process, if there is an error occurs after creating 
	  a child process with fork() in the CAT test.
[patch 5] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called
	  twice. Delete once.

This patch series is based on Linux v6.1-rc3

Difference from v2:
Moved [PATCH v2 3/4] to the last and insert patch 4 before it.
[patch 1] Fixed the typo miss in the changelog and initialized
	  *p(resctrl_val_param) before use it. And since there was no 
	  MBM processing in write_schemata(), added it.
[patch 4] A signal handler is introduced in this patch. With this patch, 
	  patch 5 clear duplicate code cat/cmt/mbm/mba_test_cleanup() 
	  without falling into the indicated trap.
	  https://lore.kernel.org/lkml/bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com/

Pervious versions of this series:
[v1] https://lore.kernel.org/lkml/20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com/
[v2] https://lore.kernel.org/lkml/20221005013933.1486054-1-tan.shaopeng@jp.fujitsu.com/

Shaopeng Tan (5):
  selftests/resctrl: Fix set up schemata with 100% allocation on first
    run in MBM test
  selftests/resctrl: Return MBA check result and make it to output
    message
  selftests/resctrl: Flush stdout file buffer before executing fork()
  selftests/resctrl: Cleanup properly when an error occurs in CAT test.
  selftests/resctrl: Remove duplicate codes that clear each test result
    file

 tools/testing/selftests/resctrl/cat_test.c    | 29 +++++++++++++------
 tools/testing/selftests/resctrl/mba_test.c    |  8 ++---
 tools/testing/selftests/resctrl/mbm_test.c    | 13 +++++----
 .../testing/selftests/resctrl/resctrl_tests.c |  4 ---
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c   |  5 +++-
 6 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.27.0

