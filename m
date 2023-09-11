Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9379B55D
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbjIKVTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjIKLTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 07:19:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF646CDD;
        Mon, 11 Sep 2023 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431181; x=1725967181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yqt71S8DV4uklxfQ6XN+QALw6bb2cljgW00oOz7TuTU=;
  b=ciYUWcejtKBTfUhYTwHCGH4i82PHXa/3HTo5BPWZ0Jok4G4tDn8H4Vf4
   FYqKMTwYEmtBUBgKeo2i1DHI0STcL2+otooOi3+crM57FZZErdWxwpzb+
   W33xOJqsz7YK+B6s3mKgKlxANAU2txwXASU+CEohJtHKJgqsN4/wPTn90
   p7gpi8mrjXI+oJf+lDZVMQh7DFlEQB+XCGHM/r4H1EJtgnSGPtQ9MmmOd
   PAoFUDHv7p4wNb8VyBxQalmDEAHeRK4vtm2q8d5pIkP79q+GDExO4xJhk
   +YETy+pcyvegANSXMJHQkk8bSqkfsV7VeSZCMXW7LU1T6OQe9krTUx+nW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464428583"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464428583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916990544"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916990544"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:38 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/5] selftests/resctrl: Fixes to failing tests
Date:   Mon, 11 Sep 2023 14:19:25 +0300
Message-Id: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Ilpo Järvinen (5):
  selftests/resctrl: Extend signal handler coverage to unmount on
    receiving signal
  selftests/resctrl: Remove duplicate feature check from CMT test
  selftests/resctrl: Refactor feature check to use resource and feature
    name
  selftests/resctrl: Fix feature checks
  selftests/resctrl: Reduce failures due to outliers in MBA/MBM tests

 tools/testing/selftests/resctrl/cat_test.c    |  8 ---
 tools/testing/selftests/resctrl/cmt_test.c    |  3 -
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  6 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 37 ++++++++--
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++---
 tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
 8 files changed, 73 insertions(+), 76 deletions(-)

-- 
2.30.2

