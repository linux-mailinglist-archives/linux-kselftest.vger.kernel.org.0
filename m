Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D504697CB5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBONGV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBONGV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:21 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5542036FFE;
        Wed, 15 Feb 2023 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466380; x=1708002380;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=baMT0q8X0zAbOQmjS3gfzG3jChQUZ/evY8aN7yuTgbM=;
  b=Tdcr0luUdv3zl+JqUPqKxG9/epuqxBd1huQ4FO5J2K2nNH/grpkq6N8P
   Tpse8OEfpqxlBgR1+sh1UOjiXGxAcDK6+HoBU8+S3HRb+VPrIl0Juv9Ii
   7CiKgcEl9Ga89HS9XAO90kjfSKG4OVgznmVC+RKKq+Y/CiRc7K9doLHWZ
   YNAbf5kuWIOYvFcaD9aC35BRtz9jOuJW5TAO9dPhMoytC96/Vmm8A65Cm
   iVevtBAM1piPJOf3eCToENGONRrbgFZ2EF5sbVjBHW3FfA5Q4D+605k9L
   RRp3PSPSwob+KQB4RwCaoS+3sOkJYylmvonO6o0QBOsEsL1ZS3rxCJ121
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456221"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436007"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436007"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:17 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic and cleanups
Date:   Wed, 15 Feb 2023 15:05:56 +0200
Message-Id: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
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

This series fixes a few cleanup/error handling problems and cleans up
code.

v2:
- Improved changelogs
- Return NULL directly from malloc_and_init_memory()
- Added patch to convert memalign() to posix_memalign()
- Added patch to correct function comment parameter
- Dropped literal -> define patch for now (likely superceded soon)

Fenghua Yu (1):
  selftests/resctrl: Change name from CBM_MASK_PATH to INFO_PATH

Ilpo Järvinen (8):
  selftests/resctrl: Return NULL if malloc_and_init_memory() did not
    alloc mem
  selftests/resctrl: Move ->setup() call outside of test specific
    branches
  selftests/resctrl: Allow ->setup() to return errors
  selftests/resctrl: Check for return value after write_schemata()
  selftests/resctrl: Replace obsolete memalign() with posix_memalign()
  selftests/resctrl: Change initialize_llc_perf() return type to void
  selftests/resctrl: Use remount_resctrlfs() consistently with boolean
  selftests/resctrl: Correct get_llc_perf() param in function comment

 tools/testing/selftests/resctrl/cache.c       | 17 +++++++--------
 tools/testing/selftests/resctrl/cat_test.c    |  4 ++--
 tools/testing/selftests/resctrl/cmt_test.c    |  9 ++++----
 tools/testing/selftests/resctrl/fill_buf.c    |  7 +++++--
 tools/testing/selftests/resctrl/mba_test.c    | 11 +++++++---
 tools/testing/selftests/resctrl/mbm_test.c    |  4 ++--
 tools/testing/selftests/resctrl/resctrl.h     |  6 ++++--
 tools/testing/selftests/resctrl/resctrl_val.c | 21 +++++++------------
 tools/testing/selftests/resctrl/resctrlfs.c   |  2 +-
 9 files changed, 41 insertions(+), 40 deletions(-)

-- 
2.30.2

