Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18416E6057
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDRLsg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjDRLsd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:48:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF283C0;
        Tue, 18 Apr 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818485; x=1713354485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4xwHdOVMGdLd6NXJ0J9sSmWMj5I0QfO/TqlAoKy0Ng=;
  b=bLqJKe+Rw7RWmE2yvcbABIsf23dQmD5YpmB20Qzo3uULU8/f6yLv4u83
   oHE5PVmyG3NPIXd2b6kgLYJIi/RMaFa5tj1e5TLItSjUB8e1R0PzoULiD
   mDbE2z+sVYQe26l3Q7sJAylt/weNPgoFgFtf7bx9SFkh4mjqb/2qlak7x
   66XYQ7paAiZ6L8wF+ICrktNM/gjXdxs4snS5lCvDzEsqXWu9rOCll0JDK
   9+T3e35643Vq5f9Iynes/jkKSmOQgo5/VlvZBekIIsQjodafQJzCdo8ig
   bcMPguswyuqEJtdPwqIDx3qzGhwIUinzUHrotbMoIwbwaZmwVx7deXDtk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994490"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994490"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601868"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601868"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:28 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 21/24] selftests/resctrl: Read in less obvious order to defeat prefetch optimizations
Date:   Tue, 18 Apr 2023 14:45:03 +0300
Message-Id: <20230418114506.46788-22-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When reading memory in order, HW prefetching optimizations will
interfere with measuring how caches and memory are being accessed. This
adds noise into the results.

Change the fill_buf reading loop to not use an obvious in-order
access using multiply by a prime and modulo.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 7e0d3a1ea555..049a520498a9 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -88,14 +88,17 @@ static void *malloc_and_init_memory(size_t s)
 
 static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
 {
-	unsigned char sum, *p;
-
+	unsigned int size = (end_ptr - start_ptr) / (CL_SIZE / 2);
+	unsigned int count = size;
+	unsigned char sum;
+
+	/*
+	 * Read the buffer in an order that is unexpected by HW prefetching
+	 * optimizations to prevent them interfering with the caching pattern.
+	 */
 	sum = 0;
-	p = start_ptr;
-	while (p < end_ptr) {
-		sum += *p;
-		p += (CL_SIZE / 2);
-	}
+	while (count--)
+		sum += start_ptr[((count * 59) % size) * CL_SIZE / 2];
 
 	return sum;
 }
-- 
2.30.2

