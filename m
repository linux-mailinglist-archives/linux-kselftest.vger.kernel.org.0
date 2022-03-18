Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4474DD5AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 08:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiCRIAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiCRIAj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 04:00:39 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C9717539E;
        Fri, 18 Mar 2022 00:59:19 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="67121803"
X-IronPort-AV: E=Sophos;i="5.90,191,1643641200"; 
   d="scan'208";a="67121803"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 18 Mar 2022 16:59:18 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F1D6CCF85;
        Fri, 18 Mar 2022 16:59:16 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CD66CD0918;
        Fri, 18 Mar 2022 16:59:15 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 8AC0C400C3320;
        Fri, 18 Mar 2022 16:59:15 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v6 0/6] selftests/resctrl: Add resctrl_tests into kselftest set
Date:   Fri, 18 Mar 2022 16:58:01 +0900
Message-Id: <20220318075807.2921063-1-tan.shaopeng@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
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

Hello,

The aim of this series is to make resctrl_tests run by using
kselftest framework.
- I modify resctrl_test Makefile and kselftest Makefile,
  to enable build/run resctrl_tests by using kselftest framework.
  Of course, users can also build/run resctrl_tests without
  using framework as before.
- I change the default limited time for resctrl_tests to 120 seconds, to
  ensure the resctrl_tests finish in limited time on different environments.
- When resctrl file system is not supported by environment or
  resctrl_tests is not run as root, return skip code of kselftest framework.
- If resctrl_tests does not finish in limited time, terminate it as
  same as executing ctrl+c that kills parent process and child process.

Difference from v5:
- Changed skip message when resctrlfs is not supported. [PATCH v6 3/6]
- Changed resctrl's Makefile to always build with latest kernel headers and
  keep enabling gcc checks to detect buffer overflows. [PATCH v6 4/6]
- Made README easier to understand. [PATCH v6 5/6]
https://lore.kernel.org/lkml/20220311072147.3301525-1-tan.shaopeng@jp.fujitsu.com/ [PATCH V5]

This patch series is based on v5.17-rc8.

Shaopeng Tan (6):
  selftests/resctrl: Kill child process before parent process terminates
    if SIGTERM is received
  selftests/resctrl: Change the default limited time to 120 seconds
  selftests/resctrl: Fix resctrl_tests' return code to work with
    selftest framework
  selftests/resctrl: Make resctrl_tests run using kselftest framework
  selftests/resctrl: Update README about using kselftest framework to
    build/run resctrl_tests
  selftests/resctrl: Add missing SPDX license to Makefile

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/resctrl/Makefile      | 19 +++------
 tools/testing/selftests/resctrl/README        | 39 +++++++++++++++----
 .../testing/selftests/resctrl/resctrl_tests.c |  4 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/settings      |  3 ++
 6 files changed, 45 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

-- 
2.27.0

