Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06467722E21
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjFESCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjFESCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F029C7;
        Mon,  5 Jun 2023 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988131; x=1717524131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VDLALtK2AJdAyCo9kQBeq6ZlaKcBgCzq1beplRvxrsk=;
  b=BebsTIgzxiB+1OiVhOd5l2pqkBN40xzQZ8yqj8+Y9MrFQB6AF9SK8KEL
   MEJS6ZbFWcEGYg/9T0OS3aB18EYtVcsSZ8LAENAZIYvVib8hpBks7myfE
   I5U14NrJYAW27ZsHHgId2xEQPxH1Z1qyneQjVRzXMBG8/KTvonGsc9kjL
   rV1dzMsHnFDdniZR/hnjGXGepz+IGqjb48YrqLuum9H5gArTM/E4r9TnU
   wC3KFXXCEAnvZxZrQaBuMOG6w7vUQJzCtziMbPV8oP0BOLLCCogNvbBjt
   0i8le1IGcpaoSb03jGFTZkJMn18IqqYgpWDc4xeXcPk8shDckTgmIQ1np
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442814810"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442814810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:01:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821273962"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821273962"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:01:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 00/19] selftests/resctrl: Fixes and cleanups
Date:   Mon,  5 Jun 2023 21:01:26 +0300
Message-Id: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here is a series with some fixes and cleanups to resctrl selftests. In
v3, the rewritten CAT test is not included as an issue was discovered
in one of its components requiring further work before it can be
included to mainline.

v3:
- Don't include rewritten CAT test into this series!
- Tweak wildcard style in Makefile
- Fix many changelog typos, remove some wrong claims, and generally
  improve them.
- Add fix to PARENT_EXIT() to unmount resctrl FS
- Add unmounting resctrl FS before starting any tests
- Add fix for buf leak
- Add fix for perf fd closing
- Split mount/remount/umount patches differently
- Use size_t and %zu for span
- Keep MBM print as MB, only internally use span in bytes
- Drop start_buf global from fill_buf


v2 (was sent with CAT test rewrite which is no longer included in v3):
- Rebased on top of next to solve the conflicts
- Added 2 patches related to resctrl FS mount/umount (fix + cleanup)
- Consistently use "alloc" in cache_alloc_size()
- CAT test error handling tweaked
- Remove a spurious newline change from the CAT patch
- Small improvements to changelogs

Ilpo Järvinen (19):
  selftests/resctrl: Add resctrl.h into build deps
  selftests/resctrl: Don't leak buffer in fill_cache()
  selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
  selftests/resctrl: Close perf value read fd on errors
  selftests/resctrl: Unmount resctrl FS before starting the first test
  selftests/resctrl: Move resctrl FS mount/umount to higher level
  selftests/resctrl: Refactor remount_resctrl(bool mum_resctrlfs) to
    mount_resctrl()
  selftests/resctrl: Remove mum_resctrlfs from struct resctrl_val_param
  selftests/resctrl: Convert span to size_t
  selftests/resctrl: Express span internally in bytes
  selftests/resctrl: Remove duplicated preparation for span arg
  selftests/resctrl: Remove "malloc_and_init_memory" param from
    run_fill_buf()
  selftests/resctrl: Remove unnecessary startptr global from fill_buf
  selftests/resctrl: Improve parameter consistency in fill_buf
  selftests/resctrl: Don't pass test name to fill_buf
  selftests/resctrl: Don't use variable argument list for ->setup()
  selftests/resctrl: Move CAT/CMT test global vars to function they are
    used in
  selftests/resctrl: Pass the real number of tests to show_cache_info()
  selftests/resctrl: Remove test type checks from cat_val()

 tools/testing/selftests/resctrl/Makefile      |  2 +-
 tools/testing/selftests/resctrl/cache.c       | 64 +++++++-------
 tools/testing/selftests/resctrl/cat_test.c    | 28 ++----
 tools/testing/selftests/resctrl/cmt_test.c    | 29 ++-----
 tools/testing/selftests/resctrl/fill_buf.c    | 87 +++++++------------
 tools/testing/selftests/resctrl/mba_test.c    |  9 +-
 tools/testing/selftests/resctrl/mbm_test.c    | 17 ++--
 tools/testing/selftests/resctrl/resctrl.h     | 17 ++--
 .../testing/selftests/resctrl/resctrl_tests.c | 82 +++++++++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  7 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 57 ++++++------
 11 files changed, 169 insertions(+), 230 deletions(-)

-- 
2.30.2

