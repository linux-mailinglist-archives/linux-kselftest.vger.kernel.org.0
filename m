Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D847AAD60
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjIVJGM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVJGL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 05:06:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8ACA;
        Fri, 22 Sep 2023 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695373565; x=1726909565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T3FdWmDNR/lv5xeJT/UeFBdFzsKp+DdlUH94ECBPozw=;
  b=AxGN06kqap5AM27jTn928pGb/SSB4txQfro3LDvMXQszZ6T1DXR2Denp
   lCben4rH6x4c4hXuaPvK5qs7iSYKVxpB0+WN6sva/NM1unZdV4qoDCoB4
   qKuHd49K8SSrIuQ6XJtJC1pYPCt2NNNLPrOZTS3eKRFDkL01UB33D5caa
   QZjVnJ3OWit8nafBl+a+ZXwFu6KGwWEIsKftK/NPQ+J70eUoWzAW+w0xC
   nO15M9piBRWZqvmEUecjb8bdNmgypqBOYsxC491/y9e9DeBw43qkFRoYq
   YdrnkM0/z0ofI0U6Xj9fzG7iL2uDhqRd1qLcuU1vKLzTRjXM6H8qXCw8F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383528342"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="383528342"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:06:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="741026653"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741026653"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.8.2])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:05:58 -0700
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
Subject: [PATCH v3 0/8] Add printf attribute to kselftest functions
Date:   Fri, 22 Sep 2023 11:05:50 +0200
Message-ID: <cover.1695373131.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Changelog v3:
- Change git signature from Wieczor-Retman Maciej to Maciej
  Wieczor-Retman.
- Add one review tag.
- Rebase onto updated kselftests next branch and change base commit.

Changelog v2:
- Add review and fixes tags to patches.
- Add two patches with mismatch fixes.
- Fix missed attribute in selftests/kvm. (Andrew)
- Fix previously missed issues in selftests/mm (Ilpo)

[v2] https://lore.kernel.org/all/cover.1693829810.git.maciej.wieczor-retman@intel.com/
[v1] https://lore.kernel.org/all/cover.1693216959.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (8):
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


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.42.0

