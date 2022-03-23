Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0C4E4DD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Mar 2022 09:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242461AbiCWINL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 04:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiCWING (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 04:13:06 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A8F43AC5;
        Wed, 23 Mar 2022 01:11:36 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="55203557"
X-IronPort-AV: E=Sophos;i="5.90,203,1643641200"; 
   d="scan'208";a="55203557"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 23 Mar 2022 17:11:34 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6CBCDF034A;
        Wed, 23 Mar 2022 17:11:33 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9AAA3E6A3C;
        Wed, 23 Mar 2022 17:11:32 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 5C31B404AFD0D;
        Wed, 23 Mar 2022 17:11:32 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v5 0/2] selftests/resctrl: Print a message if the result of MBM&CMT tests is failed on Intel CPU 
Date:   Wed, 23 Mar 2022 17:09:26 +0900
Message-Id: <20220323080928.1586408-1-tan.shaopeng@jp.fujitsu.com>
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
cause of failure, if the result of MBM&CMT tests is failed on Intel CPU.
In order to detect Intel vendor, I extended AMD vendor detect function.

Difference from v4:
- Fixed the typos.
- Changed "get_vendor() != ARCH_AMD" to "get_vendor() == ARCH_INTEL".
- Reorder the declarations based on line length from longest to shortest.
https://lore.kernel.org/lkml/20220316055940.292550-1-tan.shaopeng@jp.fujitsu.com/ [PATCH v4]

This patch series is based on v5.17.

Shaopeng Tan (2):
  selftests/resctrl: Extend CPU vendor detection
  selftests/resctrl: Print a message if the result of MBM&CMT tests is
    failed on Intel CPU

 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  5 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 45 +++++++++++++------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 4 files changed, 37 insertions(+), 17 deletions(-)

-- 
2.27.0

