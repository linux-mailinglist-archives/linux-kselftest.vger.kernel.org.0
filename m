Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F9968EB6E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 10:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjBHJba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 04:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjBHJbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 04:31:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F07545F67;
        Wed,  8 Feb 2023 01:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675848631; x=1707384631;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=TRBoRdV3a9jOZVWAFY2ULLzhstU2pVvPebTVTTjpfxE=;
  b=DHqyuRlJAnYH5HKe+KtEj56wxt7U5KVrJ5vmA+Ql7NzY3lfNhCX7XTzd
   /fMaFvGJFDT7UOw+PxycNgBANO40CQBe2h2Qk2ELvLm5SjPGwA/l+8/kR
   U1WZFz5Rqqz68Fupr2t7rFXzZ9Ns/HD9TbCdubSdlUIP97VkkVC/xOuMT
   T+9KWiPmtCj8hWgObk1Ig2x1jQqxGvgBfAITdXmDJhgviKDL8cr2lSlmr
   h/3Rc+BdDwS9RQ4gV/WssYR0ImMUKcG6tX281F2X5tnZ4YxZ6lDYePvHX
   vleYCBiZtGcUdrOycn/O1mgp9Sp8g+D2fnn6i/x2LpCgGZMWBADbq0nfA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="415974499"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="415974499"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="697613865"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="697613865"
Received: from jstelter-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.38.39])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 01:30:27 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH 1/4] selftests/resctrl: Return error if memory is not allocated
Date:   Wed,  8 Feb 2023 11:30:13 +0200
Message-Id: <20230208093016.20670-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
References: <20230208093016.20670-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

malloc_and_init_memory() in fill_buf isn't checking if memalign()
successfully allocated memory or not before accessing the memory.

Check the return value of memalign() and return NULL if allocating
aligned memory fails.

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 56ccbeae0638..f4880c962ec4 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -68,6 +68,8 @@ static void *malloc_and_init_memory(size_t s)
 	size_t s64;
 
 	void *p = memalign(PAGE_SIZE, s);
+	if (!p)
+		return p;
 
 	p64 = (uint64_t *)p;
 	s64 = s / sizeof(uint64_t);
-- 
2.30.2

