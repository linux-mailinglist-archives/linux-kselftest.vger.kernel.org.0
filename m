Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFC7858DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 15:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjHWNRi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 09:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjHWNRh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049FC10C7;
        Wed, 23 Aug 2023 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692796632; x=1724332632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ck/uF66fZAzSMe9fR0yXLp6aPwaFoEbibLPAlTZkV9M=;
  b=iMXyMzaqgOS+FRyVuyUROemuh8P9SS1nrfxlPh4yYlbeIwY+h/fC8jVG
   RS9ACb0Z76IxZJ+NyOpZyS3NvMnoGcM7R+aCiViNFCjmGxHuDe5FigU4i
   9Vcre+9nqy2y2CD6H0USZgg7D8p0T+nB8K/vjSs/OCBPD3DKJGFLT7CVp
   CkA63Q+7yOk1EBupenoWbZJyXFzik9uah5J4Ge4tgmhJ+rtY72a3DPsVs
   81tJcPss+9VdHzd2hX2OFqoTlt3VEPXr7TPOK5p9yFUc8UFLJFtF6yJu4
   zfScNIKG8PVpa2EWhyAO7dPeri3DaL+FObybdNUavpr3Z2d9ShXJCSq0c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="373043958"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="373043958"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713572690"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713572690"
Received: from amangalo-mobl4.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.55.236])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 06:16:06 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/7] selftests/resctrl: Rework benchmark command handling
Date:   Wed, 23 Aug 2023 16:15:49 +0300
Message-Id: <20230823131556.27617-1-ilpo.jarvinen@linux.intel.com>
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

Ilpo Järvinen (7):
  selftests/resctrl: Ensure the benchmark commands fits to its array
  selftests/resctrl: Correct benchmark command help
  selftests/resctrl: Remove bw_report and bm_type from main()
  selftests/resctrl: Simplify span lifetime
  selftests/resctrl: Make benchmark command const and build it with
    pointers
  selftests/resctrl: Remove ben_count variable
  selftests/resctrl: Cleanup benchmark argument parsing

 tools/testing/selftests/resctrl/cache.c       |   5 +-
 tools/testing/selftests/resctrl/cat_test.c    |  13 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  34 +++--
 tools/testing/selftests/resctrl/mba_test.c    |   4 +-
 tools/testing/selftests/resctrl/mbm_test.c    |   7 +-
 tools/testing/selftests/resctrl/resctrl.h     |  17 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 120 +++++++++---------
 tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
 8 files changed, 120 insertions(+), 90 deletions(-)

-- 
2.30.2

