Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B0979B567
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345047AbjIKVTP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242978AbjIKQiy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 12:38:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C0E0;
        Mon, 11 Sep 2023 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694450328; x=1725986328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyXiEIA0NDK841I9Ihuf4Iuy+Pl5nH6gQ03aphA8PVQ=;
  b=a7+DH6HG4f+85MZTZ+qRWAVvLKUUfHqVxd8W3S7D60z92qzYdTRH57pE
   hkZXcl1uEZ04M6XOU8PErUOdr3zRUsN57hCqI6DCX3S4Y14JyaofHjB9G
   KBKF3cP2uokE3Md7acpex+vxqPjrg8wrERm9nzWzEpD/VJiiU8O6o2rR9
   08O6hhjUn0wu7Zkx+y93oyDLIeIgjrhht+mrHbthNNna5/WjxM47MJMQk
   uOU4y5ASuOZVNVlQz6CKwhpXFkaZDVzqowacHcuJkpoppbLa+nE8j4rLb
   Vo8z4UCrT9n9m/6h5QzqLd/Mja+nTlgOka9Zrv+eIQYqgP60oHdu+RzKM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442137748"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="442137748"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693141455"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="693141455"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2023 09:10:26 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Shuah Khan <shuah@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/user_events: fix long size check in the ABI selftest
Date:   Mon, 11 Sep 2023 18:09:35 +0200
Message-ID: <20230911160935.10720-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current check for 64-bit architecture is double-bugged.
First of all, %BITS_PER_LONG is not available in the userspace,
the underscored version from <asm/bitsperlong.h> must be used.
The following check:

 #if BITS_PER_LONG == 0
 #error
 #endif

triggers the error in this source file -- the macro is undefined and
thus is implicitly evaluated to 0.
Next, %BITS_PER_LONG means "bits", not "bytes". In the Linux kernel,
it can be 32 or 64, never 8. Given that the tests guarded by that check
are meant to be run on a 64-bit system, the correct value would be 64.

Prefix the macro name and fix the value it's compared to.

Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
Cc: stable@vger.kernel.org # 6.4+
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 tools/testing/selftests/user_events/abi_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 5125c42efe65..4b30461fc741 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -129,7 +129,7 @@ TEST_F(user, bit_sizes) {
 	ASSERT_EQ(0, reg_disable(&self->check, 0));
 	ASSERT_EQ(0, reg_disable(&self->check, 31));
 
-#if BITS_PER_LONG == 8
+#if __BITS_PER_LONG == 64
 	/* Allow 0-64 bits for 64-bit */
 	ASSERT_EQ(0, reg_enable(&self->check, sizeof(long), 63));
 	ASSERT_NE(0, reg_enable(&self->check, sizeof(long), 64));
-- 
2.41.0

