Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871CD752386
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjGMNW1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjGMNVs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360A3A86;
        Thu, 13 Jul 2023 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254468; x=1720790468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReRBurQsGT7Fx6kcQMK28MT5AqfN9HI/hJmNwwtabwY=;
  b=BnRdYpen7PLkJ50BgpCdFPcY41nVfSdp014hYo7XYw/FB5hjSqCcq5k5
   R393md294KEDhZ/w4sJJrODGYeth7RNBq8da2bIhr1LIv4msRFhz0Ogdj
   wYoWm9Yvv/lz1PS9XUg/Njn7UYSjQ+gwHgP6SrmexRx123lWF0FtXn4MK
   siq9TkiIJBfOjJp6EAucLcdNqc6FDU6/4EOSVX7EJJka8//I31OYVmL9i
   8ZUE1Kzw5OPoWomn2UC3RVb6dEA1RZGMDYysHsIKAqNGouq1H/9C53FmW
   H1Jw0LlDCIiF8G2vNpLVul5U2UVF00kXzSs1ZwgiSRYrOgP1S9H+srt+W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496870"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496870"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615904"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615904"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:58 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 13/19] selftests/resctrl: Remove unnecessary startptr global from fill_buf
Date:   Thu, 13 Jul 2023 16:19:26 +0300
Message-Id: <20230713131932.133258-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

fill_buf stores buffer pointer into global variable startptr that is
only used in fill_cache().

Remove startptr as global variable, the local variable in fill_cache()
is enough to keep the pointer.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index d8f5505eb9e6..a5ec9c82a960 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -22,8 +22,6 @@
 #define PAGE_SIZE		(4 * 1024)
 #define MB			(1024 * 1024)
 
-static unsigned char *startptr;
-
 static void sb(void)
 {
 #if defined(__i386) || defined(__x86_64)
@@ -147,7 +145,6 @@ static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 	if (!start_ptr)
 		return -1;
 
-	startptr = start_ptr;
 	end_ptr = start_ptr + buf_size;
 
 	/* Flush the memory before using to avoid "cache hot pages" effect */
@@ -159,7 +156,7 @@ static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 	else
 		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
 
-	free(startptr);
+	free(start_ptr);
 
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
-- 
2.30.2

