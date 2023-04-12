Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BFC6DF6E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDLNWI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLNWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170958A75;
        Wed, 12 Apr 2023 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305714; x=1712841714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tq0l1fHeAs4nVKmblmjii4w6uTzZLvcJhUEt4dDgpHY=;
  b=aA9tIMEHo9MXk1x8VSqQqJKUBn0EeGobQSvl3/yttqfclJ32jUmM/LOw
   uX8NsdJLGV0HDtgo92T8/4LH2NQ5YTmc9H/pZvqOQZqvSnU9ATZKiIfLH
   ZCG1KUWWfYbkSowU2dlCeHcK2AmnhgMbVp9GbUvjLM8WdpMV3jGK56kZV
   CXcHFLq5iMm9jJ0RFQxRVtrYEWX9YQomZyW4cTh4b6BktSgVY57JlmqPq
   PYPB7NSJEkUYhWqmdl2xXi9zTYjfPvkUwnc0ZFD0FGTq2hHFfk0467PnH
   Mme/qt0yTlf6dSCEvqPJxdbKk/dwp4yxMiw8i/PO2UgceeHQ3dQP4Hjhy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332589997"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332589997"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230005"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230005"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/22] selftests/resctrl: Fixes, cleanups, and rewritten CAT test
Date:   Wed, 12 Apr 2023 16:21:00 +0300
Message-Id: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here is a series with some fixes and cleanups to resctrl selftests and
rewrite of CAT test into something that really tests CAT working or not
condition.

I know that this series will conflict with some of patches from
Shaopeng Tan that so far have not made it into the kselftest tree. Due
to CAT test rewrite done in this series, some of those patches would no
longer be relevant anyway but some of them are still very valid (I've
not tried to reinvent the fixes in Shaopeng's series in this series).

Ilpo Järvinen (22):
  selftests/resctrl: Add resctrl.h into build deps
  selftests/resctrl: Check also too low values for CBM bits
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
 tools/testing/selftests/resctrl/cat_test.c    | 221 +++++++++---------
 tools/testing/selftests/resctrl/cmt_test.c    |  60 +++--
 tools/testing/selftests/resctrl/fill_buf.c    | 107 +++++----
 tools/testing/selftests/resctrl/mba_test.c    |   8 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  16 +-
 tools/testing/selftests/resctrl/resctrl.h     |  28 ++-
 .../testing/selftests/resctrl/resctrl_tests.c |  34 ++-
 tools/testing/selftests/resctrl/resctrl_val.c |   4 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 160 ++++++++++---
 11 files changed, 447 insertions(+), 347 deletions(-)

-- 
2.30.2

