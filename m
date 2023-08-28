Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04F678AD92
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjH1Kte (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjH1Kt1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F72E56;
        Mon, 28 Aug 2023 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219746; x=1724755746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=68kPnBw0DAbuilGsjX92zfZ1H4FfKYa2MVlR5dt9PmI=;
  b=d/JXKI4b5nsqEvW1K2VwB6UBQEnjpboHFW2yf0v3LwisBNq+e+8cV72D
   ReM7IMLCawXd+rzCHHs8XIIhil8q8hzr3QjrV6rvCIUzA6G5Deb3ZcLRH
   MSMjQ7fs93GImK8wjnw5/9/zasecN8KXmxhjXnRrhU7Wsq/jB+Dp0pnvu
   +HdagGbmQR74zID9ZPoGsdAw3MdP4PLu2WKjNXj/2Vc1qHmv1wbaZOWyM
   IGlkgsG+6nCa3tymFEVQXRpw9d8vI/wZFQwIkNIrpKcR7QdCUxtf7yoPe
   6L6Jh7VbOVAWXc+QsN8UVJg6hZEM9HgwNr7z9uhmVzMNASWqeS5n6sFfy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="378848305"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="378848305"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="984840263"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="984840263"
Received: from nwiklans-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.22.120])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:48:57 -0700
From:   "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
To:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, keescook@chromium.org, ndesaulniers@google.com,
        coltonlewis@google.com, dmatlack@google.com, vipinsh@google.com,
        seanjc@google.com, pbonzini@redhat.com, shuah@kernel.org,
        hannes@cmpxchg.org, nphamcs@gmail.com, reinette.chatre@intel.com,
        ilpo.jarvinen@linux.intel.com,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
Subject: [PATCH 0/6] Add printf attribute to kselftest functions
Date:   Mon, 28 Aug 2023 12:48:24 +0200
Message-ID: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
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
format string. The macro is similiarly used in other tools in the kernel.

Add __printf() attributes to function definitions inside kselftest.h that
use printing.

Adding the __printf() macro exposes some mismatches in format strings
across different selftests.

Fix the mismatched format specifiers in multiple tests.

Wieczor-Retman, Maciej (6):
  selftests: Add printf attribute to ksefltest prints
  selftests/cachestat: Fix print_cachestat format
  selftests/openat2: Fix wrong format specifier
  selftests/pidfd: Fix ksft print formats
  selftests/sigaltstack: Fix wrong format specifier
  selftests/kvm: Replace attribute with macro

 .../selftests/cachestat/test_cachestat.c       |  2 +-
 tools/testing/selftests/kselftest.h            | 18 ++++++++++--------
 .../testing/selftests/kvm/include/test_util.h  |  2 +-
 tools/testing/selftests/openat2/openat2_test.c |  2 +-
 .../selftests/pidfd/pidfd_fdinfo_test.c        |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c     | 12 ++++++------
 tools/testing/selftests/sigaltstack/sas.c      |  2 +-
 7 files changed, 21 insertions(+), 19 deletions(-)


base-commit: 13eb52f6293dbda02890698d92f3d9913d8d5aeb
-- 
2.42.0

