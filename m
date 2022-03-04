Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745574CD284
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 11:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiCDKkH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 05:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiCDKkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 05:40:06 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33515470D;
        Fri,  4 Mar 2022 02:39:17 -0800 (PST)
IronPort-SDR: g6dqHpVDV44/E8otWBN4C4sfb/AB//wSPKMxI7V8vHPT25UGtBR+PuAwJQ5zwBvnJCJ//MpcGM
 0rL7JRUrEtJBvImpya8o/+LN+TP9mBPHgCUTzSMFHwmd8oCNOfo3JomO/ukjkNVJQELEeJ0kzy
 odUaj9+VOwUINiL2wzsth8VorFLl8ILrHDPDF6q1Pv1g+S4PhDwVXrESyJrv0/qBmVGKZSidzi
 2zBcqEyqht48nwzDUxdfru/pkbZaNeaEV5ACcAu57dGgvrV1XNMeFztso/+j8UgET6+DspYE5F
 vuymswNb814mU/LfpliGjxpN
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="65137593"
X-IronPort-AV: E=Sophos;i="5.90,154,1643641200"; 
   d="scan'208";a="65137593"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Mar 2022 19:39:15 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7517FC68A7;
        Fri,  4 Mar 2022 19:39:14 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B614ED5070;
        Fri,  4 Mar 2022 19:39:13 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id 8441140450F7F;
        Fri,  4 Mar 2022 19:39:13 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 0/6] selftests/resctrl: Add resctrl_tests into kselftest set
Date:   Fri,  4 Mar 2022 19:38:28 +0900
Message-Id: <20220304103834.486892-1-tan.shaopeng@jp.fujitsu.com>
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

Difference from v3:
- I reodered all patches of this patch series.
- I updated the print message of ksft_exit_skip() to give more information. [PATCH v4 3/6]
- I simplified tools/testing/selftests/resctrl/Makefile to use kselftest's lib.mk. [PATCH v4 4/6]
- I improved README of resctrl_tests. [PATCH v4 5/6]
- I moved license patch to this patch series. [PATCH v4 6/6]
https://lore.kernel.org/lkml/20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com/ [PATCH V3]

This patch series is based on v5.16.

Thanks,

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
 tools/testing/selftests/resctrl/Makefile      | 18 +++--------
 tools/testing/selftests/resctrl/README        | 31 ++++++++++++++++++-
 .../testing/selftests/resctrl/resctrl_tests.c |  4 +--
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/settings      |  1 +
 6 files changed, 39 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

-- 
2.27.0

