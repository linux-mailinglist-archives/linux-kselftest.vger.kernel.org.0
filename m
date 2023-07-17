Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE72975640F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGQNPU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjGQNPT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:15:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5963CC;
        Mon, 17 Jul 2023 06:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599718; x=1721135718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fvOB1l0Uuqn/59FEBEmvMzBLXuxXxZafzX0y/y5Zb/Y=;
  b=Mki8LNmuar8aGFdU+KDzkCoBy875pCP9LkiUgt1wIvK8TYPMi+eo5UQb
   fxl/VDX/ownGXOSyP7Uxn7Uu2qJ7J/ipItXFqmM7hzk00UoSZsyY298a7
   VSy3L011ANweSy/DG5CQIyemFkYuLvmCWrMTLiA4w30sF9162+vMD1pay
   H902YqARyJv6n9ndiOoBMb4UBXJdQxRlRexzC/K1FEgNbmYne1umyZpqD
   V95ZECsSDMEbkblCpO+YYS1ddkzMzJdyGmsWKY1m7BtzwMHkPTYRoeWpo
   1Qj4NbvA84/V70JJO6KYm94FJh6kvYGP7hm/3qLCCddk0NhazkelQCjvv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568794"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568794"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246671"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246671"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 00/19] selftests/resctrl: Fixes and cleanups
Date:   Mon, 17 Jul 2023 16:14:48 +0300
Message-Id: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here is a series with some fixes and cleanups to resctrl selftests.

v5:
- Improve changelogs
- Close fd_lm only in cat_val()
- Improve unmount error handling

v4:
- Move resctrlfs (unconditional) umount after resctrl fs support check

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
 tools/testing/selftests/resctrl/cache.c       | 66 +++++++-------
 tools/testing/selftests/resctrl/cat_test.c    | 28 ++----
 tools/testing/selftests/resctrl/cmt_test.c    | 29 ++-----
 tools/testing/selftests/resctrl/fill_buf.c    | 87 +++++++------------
 tools/testing/selftests/resctrl/mba_test.c    |  9 +-
 tools/testing/selftests/resctrl/mbm_test.c    | 17 ++--
 tools/testing/selftests/resctrl/resctrl.h     | 17 ++--
 .../testing/selftests/resctrl/resctrl_tests.c | 83 ++++++++++++------
 tools/testing/selftests/resctrl/resctrl_val.c |  7 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 64 +++++++-------
 11 files changed, 178 insertions(+), 231 deletions(-)

-- 
2.30.2

