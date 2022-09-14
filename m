Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC05B7EDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 04:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiINCSp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Sep 2022 22:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Sep 2022 22:18:44 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A31564E2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Sep 2022 19:18:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="76604921"
X-IronPort-AV: E=Sophos;i="5.93,313,1654527600"; 
   d="scan'208";a="76604921"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 14 Sep 2022 10:54:59 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id BBBB5D6253;
        Wed, 14 Sep 2022 10:54:58 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 179182757E;
        Wed, 14 Sep 2022 10:54:58 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id DC7E0403DF707;
        Wed, 14 Sep 2022 10:54:57 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH 0/5] selftests/resctrl: Some improvements of resctrl selftest
Date:   Wed, 14 Sep 2022 10:51:41 +0900
Message-Id: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

The aim of this patch series is to improve the resctrl selftest.
The first three patches clear redundant code. 
The last two patches are bug fixes. Without the two fixes, 
some unnecessary processing will be executed and test results 
will be confusing. There is no behavior change in test themselves.
[patch 1] Because the default schemata is 100% , in MBM test
          it is not necessary to reset schemata by write_schemata().
[patch 2] Delete CMT-related processing in write_schemata() which is 
	  not called by CMT.
[patch 3] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
	  files function cat/cmt/mbm/mba_test_cleanup() are called twice. 
	  Delete once.
[patch 4] If there is an exception occurs after creating a child 
	  process with fork() in the CAT test, kill the child process 
	  before terminating the parent process.
[patch 5] When a child process is created by fork(), the buffer of the 
	  parent process is also copied. Flush the buffer before executing fork().

This patch series is based on Linux v6.0-rc5

Shaopeng Tan (5):
  selftests/resctrl: Clear unused initalization code in MBM tests
  selftests/resctrl: Clear unused common codes called by CAT/MBA tests
  testing/selftests: Remove duplicate codes that clear each test result
    file
  selftests/resctrl: Kill the child process before exiting the parent
    process if an exception occurs
  selftests/resctrl: Flush stdout file buffer before executing fork()

 tools/testing/selftests/resctrl/cat_test.c    | 17 +++++++++--------
 tools/testing/selftests/resctrl/cmt_test.c    |  2 --
 tools/testing/selftests/resctrl/mba_test.c    |  2 --
 tools/testing/selftests/resctrl/mbm_test.c    | 19 ++++++-------------
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c   |  7 +++----
 6 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.27.0

