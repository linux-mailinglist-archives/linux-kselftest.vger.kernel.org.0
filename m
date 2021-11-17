Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5533454069
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 06:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhKQFv7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 00:51:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:56168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233405AbhKQFv4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 00:51:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233720259"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="233720259"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:48:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="604603865"
Received: from xinshuob-mobl.ccr.corp.intel.com (HELO lkp-bingo.fnst-test.com) ([10.255.31.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:48:55 -0800
From:   Li Zhijian <zhijianx.li@intel.com>
To:     shuah@kernel.org, kuba@kernel.org, dcaratti@redhat.com,
        linux-kselftest@vger.kernel.org
Cc:     lizhijian@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com, philip.li@intel.com,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH v2 3/3] selftests/tc-testing: Fix cannot create /sys/bus/netdevsim/new_device: Directory nonexistent
Date:   Wed, 17 Nov 2021 13:45:17 +0800
Message-Id: <20211117054517.31847-3-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117054517.31847-1-zhijianx.li@intel.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Install netdevsim to provide /sys/bus/netdevsim/new_device interface.

It helps to fix:
 # ok 97 9a7d - Change ETS strict band without quantum # skipped - skipped - previous setup failed 11 ce7d
 #
 #
 # -----> prepare stage *** Could not execute: "echo "1 1 4" > /sys/bus/netdevsim/new_device"
 #
 # -----> prepare stage *** Error message: "/bin/sh: 1: cannot create /sys/bus/netdevsim/new_device: Directory nonexistent
 # "
 #
 # -----> prepare stage *** Aborting test run.
 #
 #
 # <_io.BufferedReader name=5> *** stdout ***
 #

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 tools/testing/selftests/tc-testing/config | 1 +
 tools/testing/selftests/tc-testing/tdc.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index b1cd7efa4512..a3239d5e40c7 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -61,6 +61,7 @@ CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_FQ_PIE=m
+CONFIG_NETDEVSIM=m
 
 #
 ## Network testing
diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 7fe38c76db44..afb0cd86fa3d 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+modprobe netdevsim
 ./tdc.py -c actions --nobuildebpf
 ./tdc.py -c qdisc
-- 
2.32.0

