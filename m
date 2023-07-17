Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A9756416
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGQNPg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjGQNP2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:15:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF0910D;
        Mon, 17 Jul 2023 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599726; x=1721135726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6wy5EseuZzIYCIuEismdoJnu3cQnBT/NnF9R1DU9nA=;
  b=eicNJvCpHk+tmwz/h8RJ1fnFlnQO4HqAUsM60lLpNNHFR8R72qhAWvit
   6ljNWtPqmyp5bxEBEpSUFSDqZfKQm2L3aJ9wYTMTeZAkxgG+soTos2IPa
   F+rdOM//nQXhnDKflmyQ9C7kHHXm3qlRuEpsvVIMrlaLA9cgj8QcbNaqK
   yqOOVzdV0AOzZkepLsEf8z1fJQwS2ngq+aYNk9j3q0rtTI3NqFBQ94rC9
   PfzgHrQc5gVLDQOlef4kU/4muqQZknHDJ8PTqKJfVAQV83pEcmGphYUAs
   85CKLvCKsXV7r1VQ+9SXp5q0WvUgFOResKvXHefPwrNZdhsw70cwuAAC0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568830"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568830"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246707"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246707"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 02/19] selftests/resctrl: Don't leak buffer in fill_cache()
Date:   Mon, 17 Jul 2023 16:14:50 +0300
Message-Id: <20230717131507.32420-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The error path in fill_cache() does return before the allocated buffer
is freed leaking the buffer.

The leak was introduced when fill_cache_read() started to return errors
in commit c7b607fa9325 ("selftests/resctrl: Fix null pointer
dereference on open failed"), before that both fill functions always
returned 0.

Move free() earlier to prevent the mem leak.

Fixes: c7b607fa9325 ("selftests/resctrl: Fix null pointer dereference on open failed")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 341cc93ca84c..3b328c844896 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -177,12 +177,13 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	else
 		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
 
+	free(startptr);
+
 	if (ret) {
 		printf("\n Error in fill cache read/write...\n");
 		return -1;
 	}
 
-	free(startptr);
 
 	return 0;
 }
-- 
2.30.2

