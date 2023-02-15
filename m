Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F3697CB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjBONGZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjBONGX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F238B43;
        Wed, 15 Feb 2023 05:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466383; x=1708002383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRld6On45bu0R7Xy8hDi8ba43WkFZqsxPMer/O6B9x8=;
  b=NiSIyHx7AXzh9Z5feKZRPvHpIICO+NoaIdapaYI8XQxoBDwPI2JOQ3/X
   JZg7ACyh8nXHiF2jMyDTTl5vHuJ0wyqp7ZLqPo7gFm2UEt8ivY4zpyaIX
   i/BpyfuX4jfPCcDmBBTT5yJKbDBx3GUoQ98m//WVAju+TYKXBZPtO+vvS
   Ii0Tai++geX8dtYSVohk1o73TQm1rlmZESimPHkmosqgpPKpU0QsBr0Tt
   I8YbLHlFLEh1HXjtLUFrpAciHf6IM2KPJfO8uAk6RzMtnPlOYDK91PfFP
   cNeeDv8fb5wRQdDu3vvk3nO10PnO3JhKTfyQ1DyQXJ5s540D13j+edJHD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456237"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436017"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436017"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:20 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/9] selftests/resctrl: Return NULL if malloc_and_init_memory() did not alloc mem
Date:   Wed, 15 Feb 2023 15:05:57 +0200
Message-Id: <20230215130605.31583-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

malloc_and_init_memory() in fill_buf isn't checking if memalign()
successfully allocated memory or not before accessing the memory.

Check the return value of memalign() and return NULL if allocating
aligned memory fails.

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638..c20d0a7ecbe6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
 	size_t s64;
 
 	void *p = memalign(PAGE_SIZE, s);
+	if (!p)
+		return NULL;
 
 	p64 = (uint64_t *)p;
 	s64 = s / sizeof(uint64_t);
-- 
2.30.2

