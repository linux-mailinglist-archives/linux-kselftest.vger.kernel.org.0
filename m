Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57758773F53
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjHHQpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjHHQoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:44:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897B16BEA;
        Tue,  8 Aug 2023 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510170; x=1723046170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AeU9lpwdIgg6JAGy78XCxFAm43MZcs3KmWVwRImfAe0=;
  b=U3K7xplWsUTOpjXOQ8lTEMmLiWQx+BXH0NUyighRKQb/HEYoKORI0rNo
   TkMcZrvy1QZW4Kpo/ypvDpqCZ/bOEgAVmleiOV4/XfbYvc/pN3zFXL5zb
   QRhmLyECnx+MR9v7kajyZkBbW1r5psq2h32DDS7Hf8iXJZTWJP3oqyd7E
   9CDXhRCeaONYi0aVE2LJE4zwu8t16SSaARZbtElxCw3/Pmd0jMXkRVYzH
   SVIcUSWTJ7z4oZrJDKECcfgEo5zirpQrBmYgMQrId1/wvO6qg7JxWH32w
   NZowpYmtzEwKZTdqVbh58Cn+2MniAyNUZVS8zOvkkVCdPEUkK6bEdx8pT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437097954"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437097954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977776964"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977776964"
Received: from mtofeni-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.48.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/7] selftests/resctrl: remove ben_count variable
Date:   Tue,  8 Aug 2023 12:16:24 +0300
Message-Id: <20230808091625.12760-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
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

ben_count is only used to write the terminator for the list. It is
enough to use i from the loop so no need for another variable.

Remove ben_count variable as it is not needed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 74a10abeb01d..81c2ed299e6f 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -176,13 +176,12 @@ int main(int argc, char **argv)
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	const char *benchmark_cmd[BENCHMARK_ARGS];
-	int ben_ind, ben_count, tests = 0;
+	int ben_ind, tests = 0;
 	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
 			ben_ind = i + 1;
-			ben_count = argc - ben_ind;
 			argc_new = ben_ind - 1;
 			has_ben = true;
 			break;
@@ -259,7 +258,7 @@ int main(int argc, char **argv)
 		/* Extract benchmark command from command line. */
 		for (i = 0; i < argc - ben_ind; i++)
 			benchmark_cmd[i] = argv[i + ben_ind];
-		benchmark_cmd[ben_count] = NULL;
+		benchmark_cmd[i] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
 		benchmark_cmd[0] = "fill_buf";
-- 
2.30.2

