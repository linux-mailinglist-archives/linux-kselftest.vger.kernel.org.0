Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21AB7826F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjHUKXH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 06:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjHUKXG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 06:23:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6E8F;
        Mon, 21 Aug 2023 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692613385; x=1724149385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nOqdlfLJwlVzC+5Z569Jtn/i+qjqgbFrXh3CCzn+Qso=;
  b=hYpTkpr3vvz/xUPTVLmjoH6OTeEmFAgCIyN9pukDE+MQgQ48fIXyNsNw
   ePgiETv54gbIiEs4wZcUxSGyDgiZ1RdnzwEe1X70AcIxfe1sJvSAmEw75
   4A7mrA/wIOuDRWleaIRF+sf03r+erMP4a81q9zJy0XEyRxlmp8lnVfsnf
   Yd1yNzQaGag7MmU1UbrDXLVjiNzc2kfDBvE9bUyGyrf6KnDR4NbHASN8p
   gebXnyJNE82TxuZpX3tlTGyFa+tH6nnae+y3Z4FxUc/Kp+JnaPsvmpPa1
   OPCr/wwmbOejfl0nhSzANxarv8flmt+iMBo5vy8DUM+aPEVchgl22HpTe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="358530250"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="358530250"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="735798048"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="735798048"
Received: from nsnaveen-mobl.gar.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.54.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/7] selftests/resctrl: Rework benchmark command handling
Date:   Mon, 21 Aug 2023 13:22:38 +0300
Message-Id: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
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

The benchmark command handling (-b) in resctrl selftests is overly
complicated code. This series turns the benchmark command immutable to
preserve it for all selftests and improves benchmark command related
error handling.

This series also ends up removing the strcpy() calls which were pointed
out earlier.

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
 tools/testing/selftests/resctrl/resctrl.h     |  19 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 122 ++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c |  10 +-
 8 files changed, 125 insertions(+), 89 deletions(-)

-- 
2.30.2

