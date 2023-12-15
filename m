Return-Path: <linux-kselftest+bounces-2071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E070814B7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2C8284363
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB93C6A4;
	Fri, 15 Dec 2023 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZgAHEf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835733C49E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702653227; x=1734189227;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xXzAs03rS7Wh150F/MXgoEdBkwMgUJfCLapM46KW2Cs=;
  b=hZgAHEf49yOg18Rm5pLcqpUv8ydGc33TiSONXx4+PKcmXMjAle+Pthyn
   uOWj81WoEnpqiKVL5NaKZmrHzwazLL1/IblNK/9XPI5xSn2tvCOYeamQV
   0qgOACtf57OOkix4ozDdd5OQqDtq5YyZsPs6Nlgerwe5uGg97O8vwqpQA
   YrRcujAc1zna05yFnDB45LpELPIiK+Q72SKVnS834jNl/SYtmr3xUMVxY
   SQg44IR732EQG0NGjC3uqRgBD3xYA16xO3zMINE5y0bsPshwkLXerjBmA
   fr1FheDhJYUdaimpGGN5EjoekjX5lC5Gr8FgPYYBQNMvfOoVjKN/dmBG5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8645424"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8645424"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840692235"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840692235"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.144.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:13:44 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 2/2] kunit: Reset test->priv after each param iteration
Date: Fri, 15 Dec 2023 16:13:27 +0100
Message-Id: <20231215151327.1835-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231215151327.1835-1-michal.wajdeczko@intel.com>
References: <20231215151327.1835-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we run parameterized test that uses test->priv to prepare some
custom data, then value of test->priv will leak to the next param
iteration and may be unexpected.  This could be easily seen if
we promote example_priv_test to parameterized test as then only
first test iteration will be successful:

$ ./tools/testing/kunit/kunit.py run \
	--kunitconfig ./lib/kunit/.kunitconfig *.example_priv*

[ ] Starting KUnit Kernel (1/1)...
[ ] ============================================================
[ ] =================== example (1 subtest) ====================
[ ] ==================== example_priv_test  ====================
[ ] [PASSED] example value 3
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 2
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 1
[ ] # example_priv_test: initializing
[ ] # example_priv_test: ASSERTION FAILED at lib/kunit/kunit-example-test.c:230
[ ] Expected test->priv == ((void *)0), but
[ ]     test->priv == 0000000060dfe290
[ ]     ((void *)0) == 0000000000000000
[ ] # example_priv_test: cleaning up
[ ] [FAILED] example value 0
[ ] # example_priv_test: initializing
[ ] # example_priv_test: cleaning up
[ ] # example_priv_test: pass:1 fail:3 skip:0 total:4
[ ] ================ [FAILED] example_priv_test ================
[ ]     # example: initializing suite
[ ]     # module: kunit_example_test
[ ]     # example: exiting suite
[ ] # Totals: pass:1 fail:3 skip:0 total:4
[ ] ===================== [FAILED] example =====================

Fix that by resetting test->priv after each param iteration, in
similar way what we did for the test->status.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 0308865194bb..7255ca297399 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -622,6 +622,7 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.param_index++;
 				test.status = KUNIT_SUCCESS;
 				test.status_comment[0] = '\0';
+				test.priv = NULL;
 			}
 		}
 
-- 
2.25.1


