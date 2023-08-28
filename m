Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D778AE17
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjH1K4c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjH1K4U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:56:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81C19A;
        Mon, 28 Aug 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693220121; x=1724756121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxKUOhuwkcSCEpW7Xpnp4lHioctyE1x03cSt4igskt4=;
  b=b0W5P6iFza4XakXzQXI+bRa5Pv0g+qLDgR7WUDi0YuZZm7TC482liD0P
   80YBBd5jsAUXk+SrHchSxVzyWp8rolKJS731+CNXtKajdiNd2sV3QwJEK
   0Nz47lXN4PqATSI6wlvG81MM225XZXX8+oEBbF8PnLsV3xndWsW5CbDxd
   pXs4tYEhsCEQU7kYaLo2uNpCObZ1DhghFFjI6+L+ajmvXQ+rIeeAqMYaj
   nzsZm/Ro6v1NdTcL66fXmRgpSgH7bHxCqZPmKqT+vP2/EOqQhrWQapJ9M
   0dD9dZl2Ira1Joetusld17nk3rElki443eLMKoqVaTav4arCEN7rAJWuP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="355399043"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="355399043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803658371"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803658371"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:51:24 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, reinette.chatre@intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] selftests/kvm: Replace attribute with macro
Date:   Mon, 28 Aug 2023 12:49:10 +0200
Message-ID: <82ed62dd7070203701b4ca326e62862404dd5f72.1693216959.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The __printf() macro is used in many tools in the linux kernel to
validate the format specifiers in functions that use printf. Some
selftests use it without putting it in a macro definition and some tests
import the kselftests.h header.

Use __printf() attribute instead of the full attribute since the macro
is inside kselftests.h and the header is already imported.

Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6e9f215ce70..710a8a78e8ce 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -33,7 +33,7 @@ static inline int _no_printf(const char *format, ...) { return 0; }
 #define pr_info(...) _no_printf(__VA_ARGS__)
 #endif
 
-void print_skip(const char *fmt, ...) __attribute__((format(printf, 1, 2)));
+void __printf(1, 2) print_skip(const char *fmt, ...);
 #define __TEST_REQUIRE(f, fmt, ...)				\
 do {								\
 	if (!(f))						\
-- 
2.42.0

