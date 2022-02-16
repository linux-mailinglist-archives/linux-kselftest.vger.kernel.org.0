Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D294D4B7DE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiBPC3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:29:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiBPC3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:29:14 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0DF5408;
        Tue, 15 Feb 2022 18:29:02 -0800 (PST)
IronPort-SDR: aNryIlvJOTe14jwYtjGyHTLN0IkSMTY1dHspYMGgrGDvqEL/rdAEb4fkslS1uhdCMQ7GskvErM
 5YhrVTZoqMF93O/twrEcJCWm2/zkTo9zOtxax4Q22c2qoh9wSVEToBS+yIoXEgORr0u7iS2Jos
 vMEnvq9fzyDg+y8YjjdXz08d1p6ty5jCkjjF8sSgJ1L/NdNQMPC5mbXc5jpN2pmpregffRGQTL
 jCP2HaWOV8CxJnuZnK/utv/GRNYoXYEwuNLJuOgoQ8y9Zro12ZflzCD8o3rV02+28RgN9u+Etx
 xuIB8EDtW2X3dXmCMYSIuvPJ
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="62683520"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="62683520"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Feb 2022 11:27:57 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C599CA244;
        Wed, 16 Feb 2022 11:27:55 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A9830D95FF;
        Wed, 16 Feb 2022 11:27:54 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id AFB114007E8D1;
        Wed, 16 Feb 2022 11:27:53 +0900 (JST)
From:   Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tan.shaopeng@jp.fujitsu.com
Subject: [PATCH v3 0/5] selftests/resctrl: Add resctrl_tests into kselftest set
Date:   Wed, 16 Feb 2022 11:26:36 +0900
Message-Id: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
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

Difference from v2:
- I reworte changelog of this patch series.
- I added how to use framework to run resctrl to README. [PATCH v3 2/5]
- License has no dependencies on this patch series, I separated from it this patch series to another patch.
https://lore.kernel.org/lkml/20211213100154.180599-1-tan.shaopeng@jp.fujitsu.com/

With regard to the limited time, I think 120s is not a problem since some tests have a longer
timeout (e.g. net test is 300s). Please let me know if this is wrong.

Thanks,

Shaopeng Tan (5):
  selftests/resctrl: Kill child process before parent process terminates
    if SIGTERM is received
  selftests/resctrl: Make resctrl_tests run using kselftest framework
  selftests/resctrl: Update README about using kselftest framework to
    build/run resctrl_tests
  selftests/resctrl: Change the default limited time to 120 seconds
  selftests/resctrl: Fix resctrl_tests' return code to work with
    selftest framework

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/resctrl/Makefile      | 20 ++++-------
 tools/testing/selftests/resctrl/README        | 34 +++++++++++++++++++
 .../testing/selftests/resctrl/resctrl_tests.c |  4 +--
 tools/testing/selftests/resctrl/resctrl_val.c |  1 +
 tools/testing/selftests/resctrl/settings      |  1 +
 6 files changed, 45 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/settings

-- 
2.27.0

