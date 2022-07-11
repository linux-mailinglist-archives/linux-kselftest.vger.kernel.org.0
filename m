Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217775708AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiGKRMv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKRMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 13:12:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5297A33A29;
        Mon, 11 Jul 2022 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657559569; x=1689095569;
  h=from:to:cc:subject:date:message-id;
  bh=Dva4WD3WS7cRqxq4sX7WSyArXpzF6zN4DWCsUqcI9bY=;
  b=hzwuE+fhPnnIQy2ZeA9OwnXWztRCQd9huvdJkh0fddHr96pdF1/GKOXC
   w8mY+fX14Vl2hleLC53ddYMqi87ovAUG2H9vj9CxK5mg+n9Snn/GucK1A
   9wec7qMEpeNYD738x6aTGihrgOQz5xfrhAcKkHOfL1QBX4Xl5RFTjDmqj
   51xDh6ZQaswVAgcggwTKvj7VNFycbYFNZcjGZupA4yHefPZfftTShvrMt
   +EX9iiAlKz4fhwlX2f1WiulzPmP5oCCYrMEOqMvjYdgaFgwWBrdi0IRkg
   oesG+aGrgo4sz7aj7061CCmjXxYC9jiu4i0Pf36xCaZNFCsfZPtLItciz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348697916"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348697916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="652544221"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2022 10:12:48 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        chang.seok.bae@intel.com
Subject: [PATCH v2 0/2] selftests/x86: AMX-related test improvements
Date:   Mon, 11 Jul 2022 10:03:28 -0700
Message-Id: <20220711170330.27138-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the delay in this update.

Changes from v1:
* Improve the skip message along with the changelog massage (Suah Khan).
* Simplify the feature support check (Suah Khan).

=== Cover Letter ===

A couple of test updates are included:

* With the STRICT_SIGALTSTACK_SIZE option [1,2], the kernel's altstack
  check becomes stringent. The x86 sigaltstack test is ignorant about this.
  Adjust the test now. This check was established [3] to ensure every AMX
  task's altstack is sufficient (regardless of that option) [4].

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

 tools/testing/selftests/x86/amx.c         | 31 ++++++++---------------
 tools/testing/selftests/x86/sigaltstack.c | 14 +++++++++-
 2 files changed, 23 insertions(+), 22 deletions(-)


base-commit: 32346491ddf24599decca06190ebca03ff9de7f8
-- 
2.17.1

