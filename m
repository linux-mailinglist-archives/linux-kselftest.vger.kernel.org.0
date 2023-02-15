Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A806697CC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjBONGy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 08:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbjBONGn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:43 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1F38E81;
        Wed, 15 Feb 2023 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676466396; x=1708002396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATWdTIj6nlHosfxRj2cQEQ4dZAgek4AbNN/n59hIx9E=;
  b=TbpsbkpIrsubjjxbWHiTBvoESEjnbU4eSJ1VO4a7FwvPx9sQMkzsyJgn
   KOfl3aCvk1wtQX2lzcD0ERrQR3FhvHN+oc3U090cqCRDmxW9CMyWndz2U
   dhF6NAgjdxiFju1ftEj1GSSmKMWLwtuQsIg7kJYuAusNL+YNgbCm1GHcA
   AzvA1X/XTDUPa3aocRkXHRTx+LWE7OPSKoacyzUclPfv542ReQoXhb+ul
   jraNiX886Fwb36ItGkDjHQ0yGBbBlTZlZyzi96C8nUdsyfDVV2IEGaeUG
   YzRaoaVxDM9WN/q3wGth++vHWheSnoZI+mFOxMw4kzHZNhc6Wz10cstmo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="319456280"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="319456280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812436072"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812436072"
Received: from hshannan-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.49.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:06:33 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/9] selftests/resctrl: Replace obsolete memalign() with posix_memalign()
Date:   Wed, 15 Feb 2023 15:06:01 +0200
Message-Id: <20230215130605.31583-6-ilpo.jarvinen@linux.intel.com>
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

memalign() is obsolete according to its manpage.

Replace memalign() with posix_memalign() and remove malloc.h include
that was there for memalign().

As a pointer is passed into posix_memalign(), initialize *p to NULL
to silence a warning about the function's return value being used as
uninitialized (which is not valid anyway because the error is properly
checked before p is returned).

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index c20d0a7ecbe6..3cd0b337eae5 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -14,7 +14,6 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <inttypes.h>
-#include <malloc.h>
 #include <string.h>
 
 #include "resctrl.h"
@@ -64,11 +63,13 @@ static void mem_flush(void *p, size_t s)
 
 static void *malloc_and_init_memory(size_t s)
 {
+	void *p = NULL;
 	uint64_t *p64;
 	size_t s64;
+	int ret;
 
-	void *p = memalign(PAGE_SIZE, s);
-	if (!p)
+	ret = posix_memalign(&p, PAGE_SIZE, s);
+	if (ret < 0)
 		return NULL;
 
 	p64 = (uint64_t *)p;
-- 
2.30.2

