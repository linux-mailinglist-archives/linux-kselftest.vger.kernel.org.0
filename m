Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD57BD88F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345716AbjJIKaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345781AbjJIKa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 06:30:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D4AC5;
        Mon,  9 Oct 2023 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696847427; x=1728383427;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OMhrMk6H+hsf9008O1J15mQR51/WYPVUjbeah3bIryg=;
  b=Lti+4mbhqUmyRbF20HkcptRcwwNQRgYHG9pnvBtcUEaAYnQPMnckuaU1
   qxfKVNp2OOjYwFdMrbzJ5iRHSylKSX/9ceUdoF72xKhMKGk3RGkfszCa+
   Eek7YutFR3+kiqZjrgd6R272Tdl8/QAreovUXUKI0dpIJwlaHcebX5zkU
   Ztygz90HiHE5bbI60rHPsFzMil7UfQ+/l4cJaYdyROFr0PSTC9BL2uVIn
   5uwoJ82yY2ZHKV8gltYMV5RC9Dnv4vAu4EErTVnq91/IfKeyKQcL5N0sP
   NZ/u+Q6R7+X7gvMgtlHScFQjc+Ha0GrYKGfkQvx7530tsRZqeHxlASxbE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="2711575"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="2711575"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="876753798"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876753798"
Received: from kkensic-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.30.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 03:30:20 -0700
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     akpm@linux-foundation.org, christian@kellner.me,
        fenghua.yu@intel.com, keescook@chromium.org,
        ndesaulniers@google.com, coltonlewis@google.com,
        dmatlack@google.com, vipinsh@google.com, seanjc@google.com,
        brauner@kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        hannes@cmpxchg.org, nphamcs@gmail.com, reinette.chatre@intel.com
Cc:     ilpo.jarvinen@linux.intel.com, linux-kselftest@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 0/8] Add printf attribute to kselftest functions
Date:   Mon,  9 Oct 2023 12:28:28 +0200
Message-ID: <cover.1696846568.git.maciej.wieczor-retman@intel.com>
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

Series is based on kselftests next branch.

Changelog v4:
- Fix patch 1/8 subject typo.
- Add Reinette's reviewed-by tags.
- Rebased onto updated kselftests next branch.

Changelog v3:
- Changed git signature from Wieczor-Retman Maciej to Maciej
  Wieczor-Retman.
- Added one review tag.
- Rebased onto updated kselftests next branch.

Changelog v2:
- Add review and fixes tags to patches.
- Add two patches with mismatch fixes.
- Fix missed attribute in selftests/kvm. (Andrew)
- Fix previously missed issues in selftests/mm (Ilpo)

[v3] https://lore.kernel.org/all/cover.1695373131.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1693829810.git.maciej.wieczor-retman@intel.com/
[v1] https://lore.kernel.org/all/cover.1693216959.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (8):
  selftests: Add printf attribute to kselftest prints
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


base-commit: f1020c687153609f246f3314db5b74821025c185
-- 
2.42.0

