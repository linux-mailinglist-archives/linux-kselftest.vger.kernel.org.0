Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55EB6E6025
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDRLp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDRLp1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:45:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD9DE78;
        Tue, 18 Apr 2023 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818325; x=1713354325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h8QaAlwFBQycjOdUMX9rLTEF7spqQQ3eBcNWhxwveQU=;
  b=j6/B/twk8u5Ar6ac82CGpL1/LMm2bIQoHYmvTXoNWyvh0BkHqgdEjI9E
   +FNqXXfBE9zCXZgA5PCouZL+ouqYuxRCbO7HPb3Y+bsBadT3XN8FysEhw
   S/seELYU4jwlnJmMef5f0M6lojK1bW0aGq0J5ULAHTJCQFsXlbD0a+a0S
   qLZ+0KNS5j258fKqVZq1/ux3Tzl6uB9MzuIrhrGVSLFpVO0jk+uyhxuX8
   hYup8l/dGGL4tAcCcKmDM3Yq6yFnwTj4ljNpDNLWOU2G+4YTbFY8ATFSt
   xx1i5hona4N1z0qVLdc1XPjWzYjoEMC09yRflWDYHBP9soocyZ5OaWvPx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994263"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601491"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601491"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/24] selftests/resctrl: Fixes, cleanups, and rewritten CAT test
Date:   Tue, 18 Apr 2023 14:44:42 +0300
Message-Id: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here is a series with some fixes and cleanups to resctrl selftests and
rewrite of CAT test into something that really tests CAT working or not
condition.

v2:
- Rebased on top of next to solve the conflicts
- Added 2 patches related to resctrl FS mount/umount (fix + cleanup)
- Consistently use "alloc" in cache_alloc_size()
- CAT test error handling tweaked
- Remove a spurious newline change from the CAT patch
- Small improvements to changelogs

Ilpo Järvinen (24):
  selftests/resctrl: Add resctrl.h into build deps
  selftests/resctrl: Check also too low values for CBM bits
  selftests/resctrl: Move resctrl FS mount/umount to higher level
  selftests/resctrl: Remove mum_resctrlfs
  selftests/resctrl: Make span unsigned long everywhere
  selftests/resctrl: Express span in bytes
  selftests/resctrl: Remove duplicated preparation for span arg
  selftests/resctrl: Don't use variable argument list for ->setup()
  selftests/resctrl: Remove "malloc_and_init_memory" param from
    run_fill_buf()
  selftests/resctrl: Split run_fill_buf() to alloc, work, and dealloc
    helpers
  selftests/resctrl: Remove start_buf local variable from buffer alloc
    func
  selftests/resctrl: Don't pass test name to fill_buf
  selftests/resctrl: Add flush_buffer() to fill_buf
  selftests/resctrl: Remove test type checks from cat_val()
  selftests/resctrl: Refactor get_cbm_mask()
  selftests/resctrl: Create cache_alloc_size() helper
  selftests/resctrl: Replace count_bits with count_consecutive_bits()
  selftests/resctrl: Exclude shareable bits from schemata in CAT test
  selftests/resctrl: Pass the real number of tests to show_cache_info()
  selftests/resctrl: Move CAT/CMT test global vars to func they are used
  selftests/resctrl: Read in less obvious order to defeat prefetch
    optimizations
  selftests/resctrl: Split measure_cache_vals() function
  selftests/resctrl: Split show_cache_info() to test specific and
    generic parts
  selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test

 tools/testing/selftests/resctrl/Makefile      |   2 +-
 tools/testing/selftests/resctrl/cache.c       | 154 ++++++------
 tools/testing/selftests/resctrl/cat_test.c    | 235 ++++++++----------
 tools/testing/selftests/resctrl/cmt_test.c    |  65 +++--
 tools/testing/selftests/resctrl/fill_buf.c    | 105 ++++----
 tools/testing/selftests/resctrl/mba_test.c    |   9 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  17 +-
 tools/testing/selftests/resctrl/resctrl.h     |  32 +--
 .../testing/selftests/resctrl/resctrl_tests.c |  82 ++++--
 tools/testing/selftests/resctrl/resctrl_val.c |   9 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 187 ++++++++++----
 11 files changed, 499 insertions(+), 398 deletions(-)

-- 
2.30.2

