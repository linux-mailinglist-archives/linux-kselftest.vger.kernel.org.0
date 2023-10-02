Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C17B4F69
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjJBJsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjJBJsi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:48:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA5BD;
        Mon,  2 Oct 2023 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240114; x=1727776114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pmtfWXMI20eJN8ahNBeDBXwc3u2yQV2h67SqlOWlpQ=;
  b=GM98pN79RLVzYkQeYQe5HRrIA0yGrz13YMwe1IX6ODD0xCuyfrOb1MBs
   Ow/pOfF6ObmgzF2phOpifosbbKgpg2uVuQQgqyhg+m+oH1f3pnABsil10
   CSr0A12ZGeBFoO/P7Bv3bvGTb94vjLNU+jvQZCPvjqQjwOBGxlTHiu1Xg
   IpOWdqQ0Q6oYA0KNPOnhk3fMwO8Po1wT8v05vgowvUR0dO4bMiM/z4RaA
   /Nop38L5A0QehXrYf0ft5NN/jGhuZWOeyKNhQR0IXLnlCMPF/oFMxTccc
   fVG/urisyefso4Vo1/yRkzZ1SgNJEbzrlSvL8Vpf3gP3XxJY0lRTOdsio
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382517286"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382517286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:48:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081593242"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081593242"
Received: from aanantha-mobl.gar.corp.intel.com (HELO localhost) ([10.251.221.191])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:48:30 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/7] selftests/resctrl: Fix uninitialized .sa_flags
Date:   Mon,  2 Oct 2023 12:48:07 +0300
Message-Id: <20231002094813.6633-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
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

signal_handler_unregister() calls sigaction() with uninitializing
sa_flags in the struct sigaction.

Make sure sa_flags is always initialized in signal_handler_unregister()
by initializing the struct sigaction when declaring it. Also add the
initialization to signal_handler_register() even if there are no know
bugs in there because correctness is then obvious from the code itself.

Fixes: 73c55fa5ab55 ("selftests/resctrl: Commonize the signal handler register/unregister for all tests")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 51963a6f2186..01bbe11a8983 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -482,7 +482,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
  */
 int signal_handler_register(void)
 {
-	struct sigaction sigact;
+	struct sigaction sigact = {};
 	int ret = 0;
 
 	sigact.sa_sigaction = ctrlc_handler;
@@ -504,7 +504,7 @@ int signal_handler_register(void)
  */
 void signal_handler_unregister(void)
 {
-	struct sigaction sigact;
+	struct sigaction sigact = {};
 
 	sigact.sa_handler = SIG_DFL;
 	sigemptyset(&sigact.sa_mask);
-- 
2.30.2

