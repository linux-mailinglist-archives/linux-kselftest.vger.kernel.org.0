Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DC7C4CFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Oct 2023 10:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjJKIYF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Oct 2023 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjJKIYF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Oct 2023 04:24:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B2F98;
        Wed, 11 Oct 2023 01:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697012644; x=1728548644;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3x9GAp5cDvGnLg+Fycea/9UNsfwyKD8QpuehWluv3WI=;
  b=H1rpGgWookqps3M7iaHPqiIPC0yAgbl4mzfR62AXxTUp9xkc3Vx2eguM
   EI9XsK9K0pz7FvOjxSGVslpGAPlYZr4/t7Cq6Di1sSbUdquHXfurRMWWI
   gbxCjkjSk3KZpf6HP7rjAL3qBI+bdVFtELMx4Ww/yuCTsMILNXClWtC1K
   kcRLccWRY8znXmlhGlOucSJrbanjEmZUWyQggW6PzkTKdp8Au9WuJKYhu
   Oeo1Rfa1SXAQSHEPQ3BasdoqGZLZwxP8zQFygIhNISzcUB1Vn1ZvRu22y
   7WEb6/gKQTA3XxEapGPOfBbgGTtAkmG8/gUlafbd8+AY4rv+2xmaITmQM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387450904"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387450904"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819606024"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="819606024"
Received: from bmatwiej-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.17.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 01:23:56 -0700
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
Subject: [PATCH v5 0/8] Add printf attribute to kselftest functions
Date:   Wed, 11 Oct 2023 10:23:42 +0200
Message-ID: <cover.1697012398.git.maciej.wieczor-retman@intel.com>
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

