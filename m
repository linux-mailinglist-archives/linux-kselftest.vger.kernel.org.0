Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCA1D8A73
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgERWNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWNy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:54 -0400
IronPort-SDR: XHtaScW65e4JLKiI8QiAhNR9sAVyOTnEf0oAMHVr+hszpyO6LdwctVUfjxa8RPHSfQQLK4tywd
 e8wnLrqzl6yQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:54 -0700
IronPort-SDR: Az5gOzGHo+JSUDV4mvnUrYKbRulaoJ4lbN0C5YG5ovQZwhhMWDWJ1w4B4d3CNTirrjr+XHEEYj
 23XKHjv/63WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420338"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:53 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 03/19] selftests/resctrl: Fix typo in help text
Date:   Mon, 18 May 2020 15:08:23 -0700
Message-Id: <5c0a4f45083c9bdfa514d95389b5d3c31c1c5863.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Add a missing newline to the help text printed and fixup the next line
to line it up to previous line for improved readability.

Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 35a91cab1b88..b2a560c0c5dc 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -37,8 +37,8 @@ void detect_amd(void)
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
-	printf("\t default benchmark is builtin fill_buf\n");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT\n");
+	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
 	printf("e.g. -t mbm, mba, cmt, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
-- 
2.19.1

