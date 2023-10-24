Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E977D4C1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjJXJ1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjJXJ1K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5019A6;
        Tue, 24 Oct 2023 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139607; x=1729675607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TXQG/j4qvhoKkDk8zRyUy/euiPkSzK5kqiV3iWJ9S1Y=;
  b=RFEXQ/AYIOS/RiDk6JGKMcvoA3YzCcG+JXhz96sMGgzF92w9XpaCUnIU
   edzrgXuKle4BmlsntaRsHl+dwZgFEllZs7E6CYbRYKjQ3+GzbkzfLAJ1Q
   LoeUB+OErMiKTZ1HkkUk1lnC3F/HG0A6E08yanw7u/b09Zs9OII/qzKb4
   +tIXB6tn496RVF4Ez8arf/xodWzzPYWtyjkdvIMuf8Vs/98KvgHH8kZrm
   GiMMs8tiqb/9dg+O+wAGs+JYES6ZEL3rfQfF27Z3uqZ1+0u0Y3ZKcHjIv
   lKI+PlbXkAxBDxzX2gqVrwXhXHkYwyazUs1jh/Q3FCCkuAWXMDBcoUnL5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8570058"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="8570058"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708223410"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708223410"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:26:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/24] selftests/resctrl: CAT test improvements & generalized test framework
Date:   Tue, 24 Oct 2023 12:26:10 +0300
Message-Id: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi all,

Here's a series to improve resctrl selftests. It contains following
improvements:

- Excludes shareable bits from CAT test allocation to avoid interference
- Alters read pattern to defeat HW prefetcher optimizations
- Rewrites CAT test to make the CAT test reliable and truly measure
  if CAT is working or not
- Introduces generalized test framework making easier to add new tests
- Adds L2 CAT test
- Lots of other cleanups & refactoring

The patches up to CAT test rewrite have been earlier on the mailing list.
I've tried to address all the comments made against them back then.

This series have been tested across a large number of systems from
different generations.

Ilpo Järvinen (24):
  selftests/resctrl: Split fill_buf to allow tests finer-grained control
  selftests/resctrl: Refactor fill_buf functions
  selftests/resctrl: Refactor get_cbm_mask()
  selftests/resctrl: Mark get_cache_size() cache_type const
  selftests/resctrl: Create cache_size() helper
  selftests/resctrl: Exclude shareable bits from schemata in CAT test
  selftests/resctrl: Split measure_cache_vals() function
  selftests/resctrl: Split show_cache_info() to test specific and
    generic parts
  selftests/resctrl: Remove unnecessary __u64 -> unsigned long
    conversion
  selftests/resctrl: Remove nested calls in perf event handling
  selftests/resctrl: Consolidate naming of perf event related things
  selftests/resctrl: Improve perf init
  selftests/resctrl: Convert perf related globals to locals
  selftests/resctrl: Move cat_val() to cat_test.c and rename to
    cat_test()
  selftests/resctrl: Read in less obvious order to defeat prefetch
    optimizations
  selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test
  selftests/resctrl: Create struct for input parameter
  selftests/resctrl: Introduce generalized test framework
  selftests/resctrl: Pass write_schemata() resource instead of test name
  selftests/resctrl: Add helper to convert L2/3 to integer
  selftests/resctrl: Get resource id from cache id
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT
  selftests/resctrl: Add L2 CAT test
  selftests/resctrl: Ignore failures from L2 CAT test with <= 2 bits

 tools/testing/selftests/resctrl/cache.c       | 263 +++---------
 tools/testing/selftests/resctrl/cat_test.c    | 386 ++++++++++++------
 tools/testing/selftests/resctrl/cmt_test.c    |  72 +++-
 tools/testing/selftests/resctrl/fill_buf.c    | 114 +++---
 tools/testing/selftests/resctrl/mba_test.c    |  24 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  26 +-
 tools/testing/selftests/resctrl/resctrl.h     | 102 ++++-
 .../testing/selftests/resctrl/resctrl_tests.c | 202 ++++-----
 tools/testing/selftests/resctrl/resctrl_val.c |   6 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 234 +++++++----
 10 files changed, 807 insertions(+), 622 deletions(-)

-- 
2.30.2

