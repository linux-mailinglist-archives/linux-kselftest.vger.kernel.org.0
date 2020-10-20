Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E346629458E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439401AbgJTXvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:11172 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439386AbgJTXvi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:38 -0400
IronPort-SDR: btX0oEPhJSc8spxAYl2KzOX9o9lQndrgNkmW/pdE/hmnXTrnA23b0QmQx7ByI9Kmb/0rYbxZmT
 WpedWoVN9ZXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486359"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:31 -0700
IronPort-SDR: GZhf/SJEjG338i/Gnxvsbhmhqh7s1dJfNMmF2b1xaxjQyefwUqlRzi17lbf2BPJ2GOpWA/4Fsa
 iTBFHBzbpYdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833836"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:30 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 08/21] selftests/resctrl: Ensure sibling CPU is not same as original CPU
Date:   Tue, 20 Oct 2020 23:51:13 +0000
Message-Id: <20201020235126.1871815-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The resctrl tests can accept a CPU on which the tests are run and use
default of CPU #1 if it is not provided. In the CAT test a "sibling CPU"
is determined that is from the same package where another thread will be
run.

The current algorithm with which a "sibling CPU" is determined does not
take the provided/default CPU into account and when that CPU is the
first CPU in a package then the "sibling CPU" will be selected to be the
same CPU since it starts by picking the first CPU from core_siblings_list.

Fix the "sibling CPU" selection by taking the provided/default CPU into
account and ensuring a sibling that is a different CPU is selected.

Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 67d775d03271..05956319d9ce 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -268,7 +268,7 @@ int get_core_sibling(int cpu_no)
 	while (token) {
 		sibling_cpu_no = atoi(token);
 		/* Skipping core 0 as we don't want to run test on core 0 */
-		if (sibling_cpu_no != 0)
+		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
 			break;
 		token = strtok(NULL, "-,");
 	}
-- 
2.29.0

