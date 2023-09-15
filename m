Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C07A22C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjIOPpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjIOPo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:44:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B572111;
        Fri, 15 Sep 2023 08:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792689; x=1726328689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0I3gOLEsvDq3zuYI7Z/tbZQWwODKHgfdCF3R0YJN0/I=;
  b=X7NXvZL5DC5sFAak6Zk402jXKJqXiZD6haG6UzdZmI68XaBJLvdEeSwj
   YAP0z2KreaeacPi4v10CsgULVahRyHwTAVm9EhcoGTIOu3gEp34z1uqSG
   WyKtWXXVviKBtBrep1aEZRk77AaSwPiyUl8HdVCJh7Ww8lFnI9utxdtZp
   Oe6YbGHFSg4nxmd6E67yyodmFObtPoS5Z1AUj+kBNcpvaMGclQn6FbUM9
   OPo5fWv/+LWZwbyKSum3jjEt/kBrtOaitOF6OisOLou1NRfSl3uc7RZq/
   aimneskU/ZJHEjwfoBZS/csM7SrVZmLS7NRelJZu/j5fwc0Zrcf13l0o2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="410217227"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="410217227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991878516"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991878516"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:44:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/6] selftests/resctrl: Fixes to failing tests
Date:   Fri, 15 Sep 2023 18:44:32 +0300
Message-Id: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
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

Fix three issues with resctrl selftests.

The signal handling fix became necessary after the mount/umount fixes.

The other two came up when I ran resctrl selftests across the server
fleet in our lab to validate the upcoming CAT test rewrite (the rewrite
is not part of this series).

These are developed and should apply cleanly at least on top the
benchmark cleanup series (might apply cleanly also w/o the benchmark
series, I didn't test).

v2:
- Include patch to move _GNU_SOURCE to Makefile to allow normal #include
  placement
- Rework the signal register/unregister into patch to use helpers
- Fixed incorrect function parameter description
- Use return !!res to avoid confusing implicit boolean conversion
- Improve MBA/MBM success bound patch's changelog
- Tweak Cc: stable dependencies (make it a chain).

Ilpo Järvinen (6):
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
 .../testing/selftests/resctrl/resctrl_tests.c | 78 +++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++---
 tools/testing/selftests/resctrl/resctrlfs.c   | 69 +++++++---------
 9 files changed, 88 insertions(+), 105 deletions(-)

-- 
2.30.2

