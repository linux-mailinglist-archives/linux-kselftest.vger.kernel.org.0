Return-Path: <linux-kselftest+bounces-16341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B603295FCA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84931C20D75
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310619CD12;
	Mon, 26 Aug 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBKQRPrc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C028811E2
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710835; cv=none; b=uaaRlWPEQ7cuuljLBXI/RohQkhLIxz0AiKmm9vrPaUmXipz9CY5HdR9RgMLmbwe5QtFk9Y3Y/IXk06/OX40b3AMcKuvOL7gJOcw0OzYjOc+npuxfe8wuPmAP2d8insJgM4Sy/LFqmHq7wlazJIs8ktvfnyCSOsMrvA+QbgIeOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710835; c=relaxed/simple;
	bh=egQH7ylqMlk9A1F1S8NDzrG7Jkqc1zBi735neRHD7q8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZHVdra/Zv4+kl3Cjl1opx5DgbVVhNjk2+24ncI2zSKAz8u6et2fmkjbaD4ie88AgdVHzUtV2RVNWTz4NohPRSeUExTIfzALT8IGPg/BfpCOSl1jgOYR3ebIUOi/7/3RMmTdVhREpF8x18/qh+qLFhQ/lW6BBBaA4xrZACXj6Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBKQRPrc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710834; x=1756246834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=egQH7ylqMlk9A1F1S8NDzrG7Jkqc1zBi735neRHD7q8=;
  b=EBKQRPrc0nskhpkQeu+te6EVPHbA6665bE8RvLb0qBNeeKvQiFnoo2H9
   janOO6cNZnFpVcmhsYWOb4P9z4nvQWV3rxVf39qtmb9MoCAFEUIa/H8ph
   hyPBSBCqLtWWtNC2DQvAIJArTzZFtjp9ICzH2LJx7ueYn1rqaTtwoKZww
   LeItA+QdZXgVaXmHPDmetINKBFqwc3Wy6EkxnZqylNRk625FufYHJbgR5
   fS1jy+9r4Ir18mEClOfaZW/5YysU1vzuHB3BZGUcHJ3NTsBip2UJfcUeM
   1re1H6IJZgaSGZEgkAvK3qLWzKM22lmrOmToUgPChlUiG5HIV6wopaEsa
   w==;
X-CSE-ConnectionGUID: 6odGplOJThmnngdEqGKDUQ==
X-CSE-MsgGUID: o95AzkFFQYua0KD08CcxdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537380"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537380"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:33 -0700
X-CSE-ConnectionGUID: kRfup2qNQdatr4Cy19TMWg==
X-CSE-MsgGUID: r2pSV4OkQuWQYc1rEWTjrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992175"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:31 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 0/6] kunit: Add macros to help write more complex tests
Date: Tue, 27 Aug 2024 00:20:09 +0200
Message-Id: <20240826222015.1484-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://groups.google.com/g/kunit-dev/c/f4LIMLyofj8
v2: make it more complex and attempt to be thread safe
    s/FIXED_STUB/GLOBAL_STUB (David, Lucas)
    make it little more thread safe (Rae, David)
    wait until stub call finishes before test end (David)
    wait until stub call finishes before changing stub (David)
    allow stub deactivation (Rae)
    prefer kunit log (David)
    add simple selftest (Michal)
    also introduce ONLY_IF_KUNIT macro (Michal)

Sample output from the tests:

    $ tools/testing/kunit/kunit.py run *example*.*global* \
        --kunitconfig lib/kunit/.kunitconfig --raw_output

    KTAP version 1
    1..1
    # example: initializing suite
    KTAP version 1
    # Subtest: example
    # module: kunit_example_test
    1..1
    # example_global_stub_test: initializing
    # example_global_stub_test: add_two: redirecting to subtract_one
    # example_global_stub_test: add_two: redirecting to subtract_one
    # example_global_stub_test: cleaning up
    ok 1 example_global_stub_test
    # example: exiting suite
    ok 1 example

    $ tools/testing/kunit/kunit.py run *global*.*global* \
        --kunitconfig lib/kunit/.kunitconfig --raw_output

    KTAP version 1
    1..1
        KTAP version 1
        # Subtest: kunit_global_stub
        # module: kunit_test
        1..4
        # kunit_global_stub_test_activate: real_void_func: redirecting to replacement_void_func
        # kunit_global_stub_test_activate: real_func: redirecting to replacement_func
        # kunit_global_stub_test_activate: real_func: redirecting to replacement_func
        # kunit_global_stub_test_activate: real_func: redirecting to other_replacement_func
        # kunit_global_stub_test_activate: real_func: redirecting to other_replacement_func
        # kunit_global_stub_test_activate: real_func: redirecting to super_replacement_func
        # kunit_global_stub_test_activate: real_func: redirecting to super_replacement_func
        ok 1 kunit_global_stub_test_activate
        ok 2 kunit_global_stub_test_deactivate
        # kunit_global_stub_test_slow_deactivate: real_func: redirecting to slow_replacement_func
        # kunit_global_stub_test_slow_deactivate: real_func: redirecting to slow_replacement_func
        # kunit_global_stub_test_slow_deactivate: waiting for slow_replacement_func
        # kunit_global_stub_test_slow_deactivate.speed: slow
        ok 3 kunit_global_stub_test_slow_deactivate
        # kunit_global_stub_test_slow_replace: real_func: redirecting to slow_replacement_func
        # kunit_global_stub_test_slow_replace: real_func: redirecting to slow_replacement_func
        # kunit_global_stub_test_slow_replace: waiting for slow_replacement_func
        # kunit_global_stub_test_slow_replace: real_func: redirecting to other_replacement_func
        # kunit_global_stub_test_slow_replace.speed: slow
        ok 4 kunit_global_stub_test_slow_replace
    # kunit_global_stub: pass:4 fail:0 skip:0 total:4
    # Totals: pass:4 fail:0 skip:0 total:4
    ok 1 kunit_global_stub

Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>

Michal Wajdeczko (6):
  kunit: Introduce kunit_is_running()
  kunit: Add macro to conditionally expose declarations to tests
  kunit: Add macro to conditionally expose expressions to tests
  kunit: Allow function redirection outside of the KUnit thread
  kunit: Add example with alternate function redirection method
  kunit: Add some selftests for global stub redirection macros

 include/kunit/static_stub.h    | 158 ++++++++++++++++++++
 include/kunit/test-bug.h       |  12 +-
 include/kunit/visibility.h     |  16 +++
 lib/kunit/kunit-example-test.c |  67 +++++++++
 lib/kunit/kunit-test.c         | 254 ++++++++++++++++++++++++++++++++-
 lib/kunit/static_stub.c        |  49 +++++++
 6 files changed, 553 insertions(+), 3 deletions(-)

-- 
2.43.0


