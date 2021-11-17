Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE6454065
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 06:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhKQFvx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 00:51:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:56168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232934AbhKQFvx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 00:51:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233720252"
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="233720252"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:48:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,240,1631602800"; 
   d="scan'208";a="604603859"
Received: from xinshuob-mobl.ccr.corp.intel.com (HELO lkp-bingo.fnst-test.com) ([10.255.31.178])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 21:48:52 -0800
From:   Li Zhijian <zhijianx.li@intel.com>
To:     shuah@kernel.org, kuba@kernel.org, dcaratti@redhat.com,
        linux-kselftest@vger.kernel.org
Cc:     lizhijian@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        lkp@intel.com, philip.li@intel.com,
        Li Zhijian <zhijianx.li@intel.com>
Subject: [PATCH v2 2/3] selftests/tc-testing: add missing config
Date:   Wed, 17 Nov 2021 13:45:16 +0800
Message-Id: <20211117054517.31847-2-zhijianx.li@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211117054517.31847-1-zhijianx.li@intel.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

qdiscs/fq_pie requires CONFIG_NET_SCH_FQ_PIE, otherwise tc will fail
to create a fq_pie qdisc.

It fixes following issue:
 # not ok 57 83be - Create FQ-PIE with invalid number of flows
 #       Command exited with 2, expected 0
 # Error: Specified qdisc not found.

Signed-off-by: Li Zhijian <zhijianx.li@intel.com>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index b71828df5a6d..b1cd7efa4512 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -60,6 +60,7 @@ CONFIG_NET_IFE_SKBTCINDEX=m
 CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_RED=m
+CONFIG_NET_SCH_FQ_PIE=m
 
 #
 ## Network testing
-- 
2.32.0

