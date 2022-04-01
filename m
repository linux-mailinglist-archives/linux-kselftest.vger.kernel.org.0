Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91854EFCB8
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353164AbiDAWUc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349992AbiDAWUa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 18:20:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC754C41F;
        Fri,  1 Apr 2022 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648851520; x=1680387520;
  h=from:to:cc:subject:date:message-id;
  bh=qT1iUcSDEtAU+xXuDjdqpSGzyO4mMVV0OZcTstB3bGQ=;
  b=mPv+ycXn5CMVZgHAXwkv9f0dkWxp4/F+l/vMPfzxDetILeuYow0o3LII
   s6X2wVe6OEpJqYmDRRI3RZcYscCYZRB5rDRphHqbA+cae4eJ1ZV+B7417
   vj7Hsa5fRrTd0Er4gp0hNHEWl8797wIiiQJfh0BaZv/X1AV8a8M3JDOm7
   apGIqAarvPAU4Ws6d/gPeWm2QVuow06bQ6KvGjI8jG3mgVcB8gZV9Ewvz
   zC5a0o5RxWGDkmn2xNlFPwlj8iRrOwLFrA7zkMY2bV0o1JFGDAf0+Cn28
   tI/tJAEkEXOgLeZ4PtBUMzqnNEzW6xrhtvN4gzutkWAsCe0uN3t/LqFOi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="257822122"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="257822122"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567860534"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2022 15:18:34 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        chang.seok.bae@intel.com
Subject: [PATCH 0/2] selftests/x86: AMX-related test improvements
Date:   Fri,  1 Apr 2022 15:10:12 -0700
Message-Id: <20220401221014.13556-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A couple of test updates are included:

* With this option [1,2], the kernel's altstack check becomes stringent.
  The x86 sigaltstack test is ignorant about this. Adjust the test now. 
  This check was established [3] to ensure every AMX task's altstack is 
  sufficient (regardless of that option) [4].

* The AMX test wrongly fails on non-AMX machines. Fix the code to skip the
  test instead.

The series is available in this repository:
  git://github.com/intel/amx-linux.git selftest

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/Kconfig#n2432
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n5676
[3] 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
[4] 4b7ca609a33d ("x86/signal: Use fpu::__state_user_size for sigalt stack validation")

Chang S. Bae (2):
  selftests/x86/signal: Adjust the test to the kernel's altstack check
  selftests/x86/amx: Fix the test to avoid failure when AMX is
    unavailable

 tools/testing/selftests/x86/amx.c         | 42 +++++++++++++++++------
 tools/testing/selftests/x86/sigaltstack.c | 12 ++++++-
 2 files changed, 42 insertions(+), 12 deletions(-)


base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.17.1

