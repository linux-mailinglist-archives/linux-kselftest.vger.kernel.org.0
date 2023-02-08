Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6275368EB6C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBHJbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBHJbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:31:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E38745BFC;
        Wed,  8 Feb 2023 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675848626; x=1707384626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyPIPU2PhDAGT+DdKMw4IPPATk+uo0Mg3riE8Tl/ifo=;
  b=b1SAUfVNRCdrr4SF6MoIWjF1ivggtlPlWJrv6zezDMiseUKsuHfLxGGh
   nCIXyl48x5k42Qvf4olgTBK8Lo1V3WLQ38FYw+JVj0j/6IDoFAkVDpUqU
   /ppcXmF0oDCyNCgjLavlM4I4BskE0L0aBtYgNT/qKV81/rPvneZNF/YOy
   yCBs/ShAHoQVRKq/T5L8LiVHQotdC1uSrV75vgNt1OHPuxWsyfpGbPnxv
   42jydQK8VUPKA8cbG40OlAHFoYOKQCZLwvqC5PGcj45mu0g5lG7qgy1lM
   miX23D5Y0iuV1bYkSwGyOCmBhXU1rj6mveP++YD68WjDwICrtuDoc0XF1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415974469"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415974469"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697613808"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="697613808"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:23 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/4] selftests/resctrl: Fixes to error handling logic
Date:   Wed,  8 Feb 2023 11:30:12 +0200
Message-Id: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series fixes a few cleanup/error handling problems.

Fenghua Yu (1):
  selftests/resctrl: Return error if memory is not allocated

Ilpo Järvinen (3):
  selftests/resctrl: Move ->setup() call outside of test specific
    branches
  selftests/resctrl: Allow ->setup() to return errors
  selftests/resctrl: Check for return value after write_schemata()

 tools/testing/selftests/resctrl/cache.c       |  4 +++-
 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  2 ++
 tools/testing/selftests/resctrl/mba_test.c    |  9 ++++++--
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  2 ++
 tools/testing/selftests/resctrl/resctrl_val.c | 21 +++++++------------
 8 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.30.2

