Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29696D139D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 01:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjC3XsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 19:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjC3Xrw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 19:47:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D212858;
        Thu, 30 Mar 2023 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680220038; x=1711756038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=q+JNlSC1uCqvuWCBy2qAYpAlDZtiUcm4wmk9OxwbY/4=;
  b=IwJYyML8iXPKBMVylEEDOGgx8KayXV1Z0lJZZWbDmwQL+xRCrYrokdve
   VySUiHg4o/Nqsh7pRd6W0Xhqy7lFOBgXX6quHjkWJ7Cg1RezQe4Bnphc2
   A61Gfu4TCACSXKEe7E6zGVgHbRB9ejuSvQtfKdcOQSDZOOLAaIj6mJjek
   zeT/RlLbpNi7TmDrD03/OLoo6FetZ9/gqxODXtvXjXFrUStpH4Y8wE981
   xAPUkkzmJAS1JTu/gQzMWYNB/0QC2Z8Hp9Gg1tbbCJysGPdLyPPIdeNth
   uom3FreHj5xkFogXDWGx2jNZRxejJRZ2NBHI8XC8/1//3atiwvn+QaT8Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427587819"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="427587819"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="930926046"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="930926046"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 16:47:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, chang.seok.bae@intel.com
Subject: [PATCH v3 0/3] selftests/x86: AMX-related test improvements
Date:   Thu, 30 Mar 2023 16:35:17 -0700
Message-Id: <20230330233520.21937-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711170330.27138-1-chang.seok.bae@intel.com>
References: <20220711170330.27138-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear maintainers,

Let me follow up on the last posting [5] with these two small changes:
* Clean up unused code in the AMX test.
* Fix the subsystem name in the patch1 subject.

Here is a summary of the included test code changes:

* With the STRICT_SIGALTSTACK_SIZE option [1,2], the kernel's altstack
  check becomes stringent. The x86 sigaltstack test is ignorant about
  this. Adjust the test. This check was established [3] to ensure
  every AMX task's altstack is sufficient (regardless of that option)
  [4].

* The AMX test wrongly fails on non-AMX machines. Fix the code to skip
  the test instead.

* It also has some unused code. Remove them where at this.

The series is available in this repository:
  git://github.com/intel/amx-linux.git selftest

Thanks,
Chang

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/Kconfig#n2467
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt#n6038
[3] 3aac3ebea08f ("x86/signal: Implement sigaltstack size validation")
[4] 4b7ca609a33d ("x86/signal: Use fpu::__state_user_size for sigalt stack validation")
[5] https://lore.kernel.org/lkml/20220711170330.27138-1-chang.seok.bae@intel.com/


Chang S. Bae (3):
  selftests/x86/sigaltstack: Adjust the test to the kernel's altstack
    check
  selftests/x86/amx: Fix the test to avoid failure when AMX is
    unavailable
  selftests/x86/amx: Remove unneeded code

 tools/testing/selftests/x86/amx.c         | 51 +++++------------------
 tools/testing/selftests/x86/sigaltstack.c | 12 +++++-
 2 files changed, 21 insertions(+), 42 deletions(-)


base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
-- 
2.17.1

