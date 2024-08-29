Return-Path: <linux-kselftest+bounces-16706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6382964D83
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1BB22714
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3001B78FF;
	Thu, 29 Aug 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eB6hBRha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316D1B5EC8
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955241; cv=none; b=dvN17pe3o5Rrm7nJXGM/ZMmGmD6S4TMIsRM8m2LqkVHttac0TI123METG3E56P7MrssOn9Jdznn9ryKEsDbwVI1TCDssJOjFSCqUIC9NAnGRWEu4Je38wgMqDwZBR0Ton8LtyxGFfB9qz13bUE1yLOtt9+S5kJ0cW00jwgBRQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955241; c=relaxed/simple;
	bh=q8B9yN5o6Or8Ml2GObOcjYWgPgKhKWzFLGKMwV5/K0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Umq0KCHb5/tW6mJJgPRfIVooj5wOj8SI8N/VD4KjswA71qmUA0pnyADmd+t9iVVD0QXel8lHTXWZ4g0uzcwuffHP0xBIBxSsHMjtYU1Rl9/i5cY4g5wQXYfM9kGIWizIdG9E6KTt1eMnBchsvhJqiJNpnf40Ir8eV+OM12LOzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eB6hBRha; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955239; x=1756491239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q8B9yN5o6Or8Ml2GObOcjYWgPgKhKWzFLGKMwV5/K0A=;
  b=eB6hBRhacwC+shjRzFQcB66Ps/V4p57+ffJzYZVM6m/3+Mt9qdzWOHeN
   Hf6/OB+UBO01zt0bTeFVdaaZLyDXc70y7Eu082x/xQtbDH2XpN9Nlv4ip
   iP1bfwz8YFSUY3Mw2o0DCHniVEXRJZ57h2KAbR2rRGeEku5gFSvWBBhXL
   T+9Jl2LzrDJJMAa8y2nv1+5JhAIV7VzunQYW3o0mj1xea8ghHz5jMxdOk
   aDcxU/wmIgV3UbCYdKq43QuMMts5fhQZwcxT/kvW233AH39Kf/lFbDtwW
   X8wpWyMq2WKFO2m3vQDZ7fBWrT+UJQ3tFQtYP9seNa1KeOCSq9gElBNdY
   g==;
X-CSE-ConnectionGUID: R/S2KB0PTUO6jWepMtKejA==
X-CSE-MsgGUID: 39ld4HRiTwO/zVT3+CYBIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34238429"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34238429"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:13:59 -0700
X-CSE-ConnectionGUID: R2ya2+RQQeuKFmcr7+p0ig==
X-CSE-MsgGUID: 1PtS3lByQFi+WKCtcOaBxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63353198"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:13:56 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 0/6] kunit: Add macros to help write more complex tests
Date: Thu, 29 Aug 2024 20:13:42 +0200
Message-Id: <20240829181348.1572-1-michal.wajdeczko@intel.com>
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
v3: include example for DECLARE_IF_KUNIT (Lucas)
    rename s/ONLY_IF_KUNIT/VALUE_IF_KUNIT (Michal)
    and add simple usage example for it (Rae)
    fix s/fixed/global in comments (Lucas)
    improve stub sanitize flow (Lucas, Michal)
    reformat kernel-doc for better output (Michal)

Test outputs:

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
 include/kunit/visibility.h     |  40 ++++++
 lib/kunit/kunit-example-test.c |  67 +++++++++
 lib/kunit/kunit-test.c         | 254 ++++++++++++++++++++++++++++++++-
 lib/kunit/static_stub.c        |  50 +++++++
 6 files changed, 578 insertions(+), 3 deletions(-)

-- 
2.43.0


