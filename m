Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035807C847C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjJMLg3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjJMLg2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:36:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBBB7;
        Fri, 13 Oct 2023 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196987; x=1728732987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kHNtyQVnjAw9mhsimssz82xFGGV/T8R0wPGXi0ez5k=;
  b=NjBiBEMjrjd9NqR/lCsxi6uvfS1Ow24iEwNCPXEYcqHAUIkQx65P1el8
   Yjhrb+ziNL8TuY4gTIZMtztbD2UHeuf4F1Y8giic4pLWYnyul9PZIBpQ2
   XzLor/tkzlxHWaEwqoDulElMRj9UPqoyONH0sF5DV5qWxjq8gFL1c6nPB
   56noZfTuyR07pvX3jOiGx+/4eTu1xLw9tM01XAJYF+u3rPQystJENdtC9
   NETmV8FgV9t8gqVTUp2fsZPxBbFDnKd6IL8qr+pBS0efR9IlSTDTodPhP
   Dqd72Q5ncfO8bed88pOptbmBQHfd/jP8/Jt4yA/Y3Zj8YX5an1Is9omER
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382391386"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="382391386"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1001916985"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1001916985"
Received: from bsankiew-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.114])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:36:18 -0700
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
Subject: [PATCH v6 0/8] Add printf attribute to kselftest functions
Date:   Fri, 13 Oct 2023 13:36:04 +0200
Message-ID: <cover.1697196663.git.maciej.wieczor-retman@intel.com>
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

kselftest.h declares many variadic functions that can print some
formatted message while also executing selftest logic. These
declarations don't have any compiler mechanism to verify if passed
arguments are valid in comparison with format specifiers used in
printf() calls.

Attribute addition can make debugging easier, the code more consistent
and prevent mismatched or missing variables.

The first patch adds __printf() macro and applies it to all functions
in kselftest.h that use printf format specifiers. After compiling all
selftests using:
	make -C tools/testing/selftests
many instances of format specifier mismatching are exposed in the form
of -Wformat warnings.

Fix the mismatched format specifiers caught by __printf() attribute in
multiple tests.

Series is based on kselftests next branch.

Changelog v6:
- Add methodology notes to all patches.
- No functional changes in the patches.

Changelog v5:
- Mention in the cover letter what methodology was used to find the
  mismatched format specifiers.
- No functional changes in the patches.

Changelog v4:
- Fix patch 1/8 subject typo.
- Add Reinette's reviewed-by tags.
- Rebase onto new kselftest/next patches.

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

[v5] https://lore.kernel.org/all/cover.1697012398.git.maciej.wieczor-retman@intel.com/
[v4] https://lore.kernel.org/all/cover.1696846568.git.maciej.wieczor-retman@intel.com/
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


base-commit: 2531f374f922e77ba51f24d1aa6fa11c7f4c36b8
-- 
2.42.0

