Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE70F722E3B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjFESEH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjFESDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:03:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDECAE75;
        Mon,  5 Jun 2023 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988205; x=1717524205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReRBurQsGT7Fx6kcQMK28MT5AqfN9HI/hJmNwwtabwY=;
  b=B5rkXrBOtbX4+W8RCw/5xZ9C4h1NbXjTDVxCTJd36qdjLtYNmDRhW08J
   j4TjGm+j9UhtuHAZ//RUMvuQNiSZ2hriljPISRVdnf1MmJ5Le5tI9EJeC
   pTAnzHiTE+k65Fuaw46ZL2yFi2RwxNXtwKcW8Ya6I49p+LhzlrogIAPNz
   BnYo8/4/mJ4y7Lo43OAiA3G/qXw+MTJs43530lAzyq4Bx38KK0hjna5UJ
   mGzro+JtVWeX4hsJtgNNymSovQwU5tC37DIffagvdkzekC01gsd92V/EH
   WXI13kD0Wa99XzvwwFpK2GjnzF2axGszMUCif3+LYSijiF35iBMALreUP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442815300"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442815300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274223"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274223"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:03:08 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 13/19] selftests/resctrl: Remove unnecessary startptr global from fill_buf
Date:   Mon,  5 Jun 2023 21:01:39 +0300
Message-Id: <20230605180145.112924-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
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

