Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF31178DACC
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbjH3ShL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242298AbjH3Hza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 03:55:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1807C193;
        Wed, 30 Aug 2023 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693382127; x=1724918127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gy42heFFBmku26L7zRC32gHV7wb/DscL5QqcL5RLE0Y=;
  b=GeEnD3P2iiZJqRJjlE/XcTOfB7AqeZc/F7/rbQC4Rsyaj6A0byGzgQej
   vrs7ubAfDzPSfiAgLF11P8Xp3Qx3g61ARLYNG3dcVpE1Zh9G+7C0AJrKB
   LwmQ3B1VWylHdyLBGntTCEkxZVJtO9+dDjpLZSE+Bt9t7vby0KfCIzcBd
   rhNhmVOd8H6EkyPXsRzB9c2iqGCo9IlS8mq3IWbdwcu6Bc3lJaL5QLG/i
   B4WXOZ7lfybd1bVldYCfw+TjKC/hZoHbtIaqbUUCIwZIirfnM1UnygDmi
   RKSegDSrlynParS9gc5aPBCFE4Wehef+FdH0NfX7KOsyHtJyKw3BQK7zA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="375533341"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="375533341"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829138446"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; 
   d="scan'208";a="829138446"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.24.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 00:55:20 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        drm-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] kunit: Fix test log size limit too low for some tests
Date:   Wed, 30 Aug 2023 09:54:20 +0200
Message-ID: <20230830075419.26484-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now we have memory space available to a kunit test case log exposed via
debugfs limited to 2048 bytes, while some parametrized test cases, e.g.,
drm_framebuffer.drm_test_framebuffer_create, need more.  For this reason,
debugfs results from affected test cases get truncated silently, and
external tools that rely on parsing of debugfs results can fail.

Increase kunit test case log size limit to 4096 bytes.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index d33114097d0d0..d20eb1884edfa 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
 struct kunit;
 
 /* Size of log associated with test. */
-#define KUNIT_LOG_SIZE 2048
+#define KUNIT_LOG_SIZE 4096
 
 /* Maximum size of parameter description string. */
 #define KUNIT_PARAM_DESC_SIZE 128
-- 
2.41.0

