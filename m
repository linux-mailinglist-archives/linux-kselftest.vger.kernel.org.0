Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA72773F3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjHHQog (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjHHQnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:43:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDE891A8;
        Tue,  8 Aug 2023 08:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510154; x=1723046154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e71Q+6dkdo7GKNkQOotvTjy2V6wO+hHkaKK74hljBDQ=;
  b=F89qZTFWqrse8lWvaZYNaA5Pj3PQv5jEq2TlITz9BCp7hUlKHMCQZUiD
   OgRB50SUNq5FXyKyXwD8Qa5wWqp3lsi08VI4lEExvaR5jQYPn69l83TxX
   MoZgE/aNjgkfWx/nCPyL9uDMyWgt+GQNV4jXco9Jjz+EolYYYZfdF14+n
   gsoRCIwPdPsgRKRmOOpIqbL1kP1jXXnQe3UD55lqog6MXcTsCGITnD+BE
   s1J5Bwc1UhLamLRdkNsCiSbq+I2o3La/DLZvKGJN2t1hcKKzLsYgxDKaV
   MqiaDQBYqo9xhnTfy3nJNbRgwDy2J0pB8cic/3SUrRMQZ1RS507rscotb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437097728"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437097728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:16:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977776785"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977776785"
Received: from mtofeni-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.48.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:16:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/7] selftests/resctrl: Rework benchmark command handling
Date:   Tue,  8 Aug 2023 12:16:18 +0300
Message-Id: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The benchmark command handling (-b) in resctrl selftests is overly
complicated code. This series turns the benchmark command immutable to
preserve it for all selftests and improves benchmark command related
error handling.

This series also ends up removing the strcpy() calls which were pointed
out earlier.

Ilpo Järvinen (7):
  selftests/resctrl: Ensure the benchmark commands fits to its array
  selftests/resctrl: Correct benchmark command help
  selftests/resctrl: Remove bw_report and bm_type from main()
  selftests/resctrl: Simplify span lifetime
  selftests/resctrl: Use pointers to build benchmark cmd and make it
    const
  selftests/resctrl: remove ben_count variable
  selftests/resctrl: Cleanup benchmark argument parsing

 tools/testing/selftests/resctrl/cache.c       |  5 +-
 tools/testing/selftests/resctrl/cat_test.c    | 13 +--
 tools/testing/selftests/resctrl/cmt_test.c    | 32 +++++--
 tools/testing/selftests/resctrl/mba_test.c    |  4 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  7 +-
 tools/testing/selftests/resctrl/resctrl.h     | 22 +++--
 .../testing/selftests/resctrl/resctrl_tests.c | 88 ++++++++-----------
 tools/testing/selftests/resctrl/resctrl_val.c | 10 ++-
 8 files changed, 98 insertions(+), 83 deletions(-)

-- 
2.30.2

