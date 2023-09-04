Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035C79175B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbjIDMog (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352920AbjIDMof (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 08:44:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86151CCC;
        Mon,  4 Sep 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831467; x=1725367467;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7OC8ieWLUaMKSqNXbWK6Ilf12UrX6NTH6dUWJKnSfd8=;
  b=RepF1Ou/L+jXxWYBuLl8nxm5Zv+juInH45iYr3aNwQJOHx7fz+kH5Zin
   f4l0XvLBt/pI3lQlLmWp9rZXc7s/LnOxu/9TiFJwYcaijcjTscEy44zTo
   nV0kB17b81stlRqWNNeL3aLtAQC4xw1UMA/txGEMhR88VF5I8lvQYFS4/
   sQ2h+fpIA38V66XBfMse4/aoNp2bAvwZB8i8LOnZRwUY439W2Rw6qEEzg
   D2vtomriH9xpo4NVz4Xs4ALTYHogMHnMelKqxkTNENuYfH1VT5MTU27oX
   UIRiVBNDS9OWB6aSsy0ZTNp4kGb/kiCH+b7QxwXBq8SkQN2+v09Z2yUTO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="462958523"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462958523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="810888530"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="810888530"
Received: from mfederki-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.15.69])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:44:22 -0700
From:   Wieczor-Retman Maciej <maciej.wieczor-retman@intel.com>
To:     akpm@linux-foundation.org, christian@kellner.me,
        fenghua.yu@intel.com, keescook@chromium.org,
        ndesaulniers@google.com, coltonlewis@google.com,
        dmatlack@google.com, vipinsh@google.com, seanjc@google.com,
        brauner@kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        hannes@cmpxchg.org, nphamcs@gmail.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/8] Add printf attribute to kselftest functions
Date:   Mon,  4 Sep 2023 14:43:14 +0200
Message-ID: <cover.1693829810.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Kselftest.h declares many variadic functions that can print some
formatted message while also executing selftest logic. These
declarations don't have any compiler mechanism to verify if passed
arguments are valid in comparison with format specifiers used in
printf() calls.

Attribute addition can make debugging easier, the code more consistent
and prevent mismatched or missing variables.

Add a __printf() macro that validates types of variables passed to the
format string. The macro is similarly used in other tools in the kernel.

Add __printf() attributes to function definitions inside kselftest.h that
use printing.

Adding the __printf() macro exposes some mismatches in format strings
across different selftests.

Fix the mismatched format specifiers in multiple tests.

Changelog v2:
- Add review and fixes tags to patches.
- Add two patches with mismatch fixes.
- Fix missed attribute in selftests/kvm. (Andrew)
- Fix previously missed issues in selftests/mm (Ilpo)

Wieczor-Retman Maciej (8):
  selftests: Add printf attribute to ksefltest prints
  selftests/cachestat: Fix print_cachestat format
  selftests/openat2: Fix wrong format specifier
  selftests/pidfd: Fix ksft print formats
  selftests/sigaltstack: Fix wrong format specifier
  selftests/kvm: Replace attribute with macro
  selftests/mm: Substitute attribute with a macro
  selftests/resctrl: Fix wrong format specifier

 .../selftests/cachestat/test_cachestat.c       |  2 +-
 tools/testing/selftests/kselftest.h            | 18 ++++++++++--------
 .../testing/selftests/kvm/include/test_util.h  |  8 ++++----
 tools/testing/selftests/mm/mremap_test.c       |  2 +-
 tools/testing/selftests/mm/pkey-helpers.h      |  2 +-
 tools/testing/selftests/openat2/openat2_test.c |  2 +-
 .../selftests/pidfd/pidfd_fdinfo_test.c        |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c     | 12 ++++++------
 tools/testing/selftests/resctrl/cache.c        |  2 +-
 tools/testing/selftests/sigaltstack/sas.c      |  2 +-
 10 files changed, 27 insertions(+), 25 deletions(-)


base-commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
-- 
2.42.0

