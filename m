Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361354702C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jun 2022 01:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbiFJXgP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jun 2022 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349341AbiFJXgC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7C289F0F;
        Fri, 10 Jun 2022 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654904138; x=1686440138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dcKqMrWYeQV/7jbUzKkDrJIenL/1HTp7HjU/MpsQUU0=;
  b=QmD0ToXlDwFMLHFZf6E7Hwqa3z64LU/YWkMNIQWv7M1jvtDS3l9tOqzx
   i0cAM33VTJ8fSwsuH7Z/NOrchfGcVNssKIwyOlS5lvDvIOobbdHCqDcfG
   7UebsU1TkMIrRTnHY9YTYRHvkM7GHPoZMLh6n+RF91cjGNHO4xyDr2tnf
   6SvEXCykWwJ5V0bCjn6J1W/P+/wLa/enqLkjJp3Z1EJx97pFdbQeSkA8o
   iONvtUveJnAsyZ511wnQl+SyVMiCXv/IiyRX076QYBDot6BMIjGt390w7
   mR8dYYte1Wy2qaF4z2AfJapx/pg8X1q5iat0TAtHWejS5ypjj6JT+BW1N
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266547096"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="266547096"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="586450901"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:35:37 -0700
From:   ira.weiny@intel.com
To:     linux-api@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/6] testing/pkeys: Don't use uninitialized variable
Date:   Fri, 10 Jun 2022 16:35:29 -0700
Message-Id: <20220610233533.3649584-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610233533.3649584-1-ira.weiny@intel.com>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

err was being used in test_pkey_alloc_exhaust() prior to being assigned.
errno is useful to know after a failed alloc_pkey() call.

Change err to errno in the debug print.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/selftests/vm/protection_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index d0183c381859..43e47de19c0d 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1225,9 +1225,9 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 		int new_pkey;
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
-		dprintf4("%s()::%d, err: %d pkey_reg: 0x%016llx"
+		dprintf4("%s()::%d, errno: %d pkey_reg: 0x%016llx"
 				" shadow: 0x%016llx\n",
-				__func__, __LINE__, err, __read_pkey_reg(),
+				__func__, __LINE__, errno, __read_pkey_reg(),
 				shadow_pkey_reg);
 		read_pkey_reg(); /* for shadow checking */
 		dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);
-- 
2.35.1

