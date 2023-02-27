Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80596A4CF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB0VQp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 16:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjB0VQp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 16:16:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1853274BA;
        Mon, 27 Feb 2023 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677532602; x=1709068602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6gsyWpdMmpV/kHoDflhj1iFUs6nUQtkpERK0c6Cpd4o=;
  b=l5VQLXZnI9HBm3sow10z1sC4Nrppqu07BDXipKkoaFDbL1YKDp1MX8x2
   R1j6oBSNWsblYwEMCUiXf3Zn84Gj3Cd+Om5WzMktDdVgWbMcV9MSiUkZ0
   XU1hK5fA9//MTBBMARpVpWusjOQtKEoaGPnVZ2h8ilCZQAnr1OmGDHb15
   OIC5KYVCCH+7SobkLlUptsllXyrAscJCSsgKEb3dg1z8YpG1ZEsA8jefz
   DKsUQT2Pn9mC8NV1Y3Bxzb2LB0q6Xbo+SMFG3qMuVc/pal4lGhBo+Xa6S
   b7EX8qxvKhgUUDCho07qGYQvPvwL9jGq7CN/fNx/S+riyfPtpHCTEkLRr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="322216363"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="322216363"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 13:16:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="651372901"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="651372901"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2023 13:16:41 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, dave.hansen@intel.com, hpa@zytor.com,
        linux-kselftest@vger.kernel.org, mizhang@google.com,
        chang.seok.bae@intel.com
Subject: [PATCH 0/2] x86/fpu/xstate: Follow up on the init_fpstate fallout again
Date:   Mon, 27 Feb 2023 13:05:02 -0800
Message-Id: <20230227210504.18520-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018221349.4196-1-chang.seok.bae@intel.com>
References: <20221018221349.4196-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear maintainers,

This series is following up on the last fix [2]. I thought I could
forget about it with that. But, I was wrong because now this was
realized as an incomplete solution -- my bad. Here is some context for
this series:

The last fix [3] has resolved the case when copying the initialized
dynamic state from init_fpstate to the user buffer in
__copy_xstate_to_uabi_buf(). (This was intended to resolve the fallout
of the init_fpstate fix [1].)

But, when copying the *non-initialized* dynamic state from the task
xstate, the code [4] unconditionally retrieves the address in
init_fpstate which is needless. Consequently, this triggers a
false-positive warning as shown in [5] which meaninglessly confuses
users.

With these repetitive surgeries, a more solid and comprehensive
solution is more helpful I thought. Considerably removing init_fpstate
from this loop is not impossible here because dynamic states have an
all-zeros init state. Then, zeroing the user buffer instead of
retrieving init_fpstate resolves the issue and simplifies the code.

These issues were discovered from the KVM execution with launching a
guest and running the KVM self-test as __copy_xstate_to_uabi_buf() was
called. But, the negligibly missing ptrace test could have disclosed
them too. So that case is included here.

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20220824191223.1248-1-chang.seok.bae@intel.com/
[2] https://lore.kernel.org/lkml/20221018221349.4196-1-chang.seok.bae@intel.com/
[3] https://lore.kernel.org/lkml/20221021185844.13472-1-chang.seok.bae@intel.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n1156
[5] https://lore.kernel.org/kvm/20230221163655.920289-2-mizhang@google.com/

Chang S. Bae (2):
  x86/fpu/xstate: Prevent false-positive warning in
    __copy_xstate_uabi_buf()
  selftests/x86/amx: Add a ptrace test

 arch/x86/kernel/fpu/xstate.c      |  30 ++++-----
 tools/testing/selftests/x86/amx.c | 108 +++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 19 deletions(-)


base-commit: 7fa08de735e41001a70c8ca869b2b159d74c2339
-- 
2.17.1

