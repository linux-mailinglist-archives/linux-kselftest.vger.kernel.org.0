Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1F7B4F67
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjJBJs3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjJBJs1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:48:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383B2A7;
        Mon,  2 Oct 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240105; x=1727776105;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IZ04flaM+gh3eNQmfe1Szfitj8qEmKU9aHqincz+DA8=;
  b=aliqrT7hEAkrWoMbcLeZvuqY/WHOimajtWIr2xigj1XvKioxC67PmtDm
   /RQULfVmX6rtwHo3aXOJXzWQMizKNLQPAkZAQR5XigMvAbuFcvvCoQ3o0
   Ds/hr44vB0LA7ScIvfWkxlpKbF2GFa6Vo2YSRqWHPAffgEt+U1d+pxBRq
   87yaC29rknLWzuxCfZbgT6sFtryHHdIt3c8n3ZYxRkT1ssUkoopVWEdKp
   v4GiAlJDQ04PREmP2r9tazVi37SCToJP/bzhjbnjs0mezkE4v0eWowZrC
   btwREw/dnOMT119L5Mrn/bLsQzdD88kCz4ciMeGRyMgOlkkC35YBJzlIF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="413523698"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="413523698"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="874301805"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="874301805"
Received: from aanantha-mobl.gar.corp.intel.com (HELO localhost) ([10.251.221.191])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:48:21 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/7] selftests/resctrl: Fixes to failing tests
Date:   Mon,  2 Oct 2023 12:48:06 +0300
Message-Id: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix four issues with resctrl selftests.

The signal handling fix became necessary after the mount/umount fixes
and the uninitialized member bug was discovered during the review.

The other two came up when I ran resctrl selftests across the server
fleet in our lab to validate the upcoming CAT test rewrite (the rewrite
is not part of this series).

These are developed and should apply cleanly at least on top the
benchmark cleanup series (might apply cleanly also w/o the benchmark
series, I didn't test).

v4:
- Use func(void) for functions taking no arguments
- Correct Fixes tag formatting

v3:
- Add fix to uninitialized sa_flags
- Handle ksft_exit_fail_msg() in per test functions
- Make signal handler register fails to also exit
- Improve changelogs

v2:
- Include patch to move _GNU_SOURCE to Makefile to allow normal #include
  placement
- Rework the signal register/unregister into patch to use helpers
- Fixed incorrect function parameter description
- Use return !!res to avoid confusing implicit boolean conversion
- Improve MBA/MBM success bound patch's changelog
- Tweak Cc: stable dependencies (make it a chain).


Ilpo Järvinen (7):
  selftests/resctrl: Fix uninitialized .sa_flags
  selftests/resctrl: Extend signal handler coverage to unmount on
    receiving signal
  selftests/resctrl: Remove duplicate feature check from CMT test
  selftests/resctrl: Move _GNU_SOURCE define into Makefile
  selftests/resctrl: Refactor feature check to use resource and feature
    name
  selftests/resctrl: Fix feature checks
  selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

 tools/testing/selftests/resctrl/Makefile      |  2 +-
 tools/testing/selftests/resctrl/cat_test.c    |  8 --
 tools/testing/selftests/resctrl/cmt_test.c    |  3 -
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  7 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 82 ++++++++++++-------
 tools/testing/selftests/resctrl/resctrl_val.c | 26 +++---
 tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++----------
 9 files changed, 97 insertions(+), 104 deletions(-)

-- 
2.30.2

