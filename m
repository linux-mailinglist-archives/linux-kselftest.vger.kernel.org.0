Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6212C78EB63
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbjHaLJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbjHaLI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 07:08:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FAACF9;
        Thu, 31 Aug 2023 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480137; x=1725016137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2mlwvXTSt1lvbyKS4CHxkmhsIyUhuPIZqJZBpNXshsE=;
  b=gAzaUh8NA3goTK7K4lja0T9CzHrKfcZnibtzTftEJbpm9rxvB+62HDjV
   R6vk1/PISDGxtCm1YBYf4jrxWIcyiNG44xV1fCtleFOpHJf+Fpg+hhak/
   X/7l552SkeMg1dxiXca5Bx9jlJOvcsSU2t2Rl9k/siDpxPpLxtBuiraY6
   vdaaPV5qqd8aC+2CNR5x3lVGW36whWQKia1H4YOzO58pXYr+z3FCALKk1
   nxHY9N5LW7vO2ZJLxUnui8HUPxZPHcQgSLkhqKiGMCmIzuoLtEQTc7IIf
   6K05N6/+03glOIkAVqsbkSWo75hAGCvHjNpQIm/L1vZyK3OLmW8QNiiiE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439852191"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439852191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:08:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863020901"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863020901"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.214.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:08:53 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/8] selftests/resctrl: Rework benchmark command handling
Date:   Thu, 31 Aug 2023 14:08:35 +0300
Message-Id: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
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

The benchmark command handling (-b) in resctrl selftests is overly
complicated code. This series turns the benchmark command immutable to
preserve it for all selftests and improves benchmark command related
error handling.

This series also ends up removing the strcpy() calls which were pointed
out earlier.

v4:
- Correct off-by-one error in -b processing
- Reordered code in main() to make freeing span_str simpler (in new patch)
- Use consistent style for const char * const *

v3:
- Removed DEFAULT_SPAN_STR for real and the duplicated copy of defines
  that made to v2 likely due to my incorrect conflict resolutions

v2:
- Added argument length check into patch 1/7
- Updated also -b line in help message.
- Document -b argument related "algorithm"
- Use asprintf() to convert defined constant int to string
- Improved changelog texts
- Added \n to ksft_exit_fail_msg() call messages.
- Print DEFAULT_SPAN with %u instead of %zu to avoid need to cast it

Ilpo Järvinen (8):
  selftests/resctrl: Ensure the benchmark commands fits to its array
  selftests/resctrl: Correct benchmark command help
  selftests/resctrl: Remove bw_report and bm_type from main()
  selftests/resctrl: Simplify span lifetime
  selftests/resctrl: Reorder resctrl FS prep code and benchmark_cmd init
  selftests/resctrl: Make benchmark command const and build it with
    pointers
  selftests/resctrl: Remove ben_count variable
  selftests/resctrl: Cleanup benchmark argument parsing

 tools/testing/selftests/resctrl/cache.c       |   5 +-
 tools/testing/selftests/resctrl/cat_test.c    |  13 +--
 tools/testing/selftests/resctrl/cmt_test.c    |  34 ++++--
 tools/testing/selftests/resctrl/mba_test.c    |   4 +-
 tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
 tools/testing/selftests/resctrl/resctrl.h     |  16 +--
 .../testing/selftests/resctrl/resctrl_tests.c | 100 ++++++++----------
 tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
 8 files changed, 104 insertions(+), 85 deletions(-)

-- 
2.30.2

