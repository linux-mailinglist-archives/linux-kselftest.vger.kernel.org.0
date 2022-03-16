Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37274DAA2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 07:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiCPGDJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 02:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiCPGDJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 02:03:09 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C226606CB;
        Tue, 15 Mar 2022 23:01:55 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="66806628"
X-IronPort-AV: E=Sophos;i="5.90,185,1643641200"; 
   d="scan'208";a="66806628"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Mar 2022 15:01:32 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 744A7E8CFB;
        Wed, 16 Mar 2022 15:01:30 +0900 (JST)
Received: from oym-om3.fujitsu.com (oym-om3.o.css.fujitsu.com [10.85.58.163])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id ACEACD0435;
        Wed, 16 Mar 2022 15:01:29 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om3.fujitsu.com (Postfix) with ESMTP id 4DB55403DFD95;
        Wed, 16 Mar 2022 15:01:29 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v4 0/2] selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel cpu
Date:   Wed, 16 Mar 2022 14:59:38 +0900
Message-Id: <20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com>
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

The aim of this series is to print a message to let users know a possible
cause of failure, if the result of MBM&CMT tests is failed on Intel cpu.
In order to detect Intel vendor, I extended amd vendor detect function.

Difference from v3:
I separated the patch into two patches.
-In order to detect intel vendor, extended the amd vendor detect function. 
 [PATCH V4 1/2]
-The same as before that print a message if the result of MBM&CMT tests
 is failed on Intel cpu.[PATCH V4 2/2]

https://lore.kernel.org/lkml/20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com/

This patch series is based on v5.17-rc8.

Shaopeng Tan (2):
  selftest/resctrl: Extend cpu vendor detection
  selftests/resctrl: Print a message if the result of MBM&CMT tests is
    failed on Intel cpu

 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 4 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.27.0

