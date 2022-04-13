Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D65000CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiDMVN3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiDMVNN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD83BBD4;
        Wed, 13 Apr 2022 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884251; x=1681420251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuTlewmQK70KDihztEJudq9AVH8Fb8wzxHOAdBGQCNU=;
  b=JPDkBIF8juKUqiujJ8x3qjju488DCD9NWfNMcS/cUv/a6t0ZPKdEYtgD
   LCG+B2wQTt6xC5C4s539VmdYLAoam/PsbezkSY4WaOfvcJLkk2CQUgRis
   HIWO4CzaxtOGJrHZn8RcXvO3xWntA/w0t+gyHIYsr6fe9NbjiNwDinzN3
   EiozWq6j2XvIbUkDi5pcG9JLdvUe5iX2FgDGjMbgMbI2sCLykqi7XdJJK
   kYg0YCC6eAlPptzmS0AW1GzevtNn2t8foPcPV/ws39UP4v0tpjjfvuns0
   4AClwW7RAxMebDQRTkYnsH6HSedMvKX+4uSyclsycu90wUmaRgIInvi9v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219065"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219065"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054318"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:46 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 25/31] selftests/sgx: Introduce dynamic entry point
Date:   Wed, 13 Apr 2022 14:10:25 -0700
Message-Id: <9916be3aecbd1ec6fd78f4804ee3b84bcee3adb5.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test enclave (test_encl.elf) is built with two initialized
Thread Control Structures (TCS) included in the binary. Both TCS are
initialized with the same entry point, encl_entry, that correctly
computes the absolute address of the stack based on the stack of each
TCS that is also built into the binary.

A new TCS can be added dynamically to the enclave and requires to be
initialized with an entry point used to enter the enclave. Since the
existing entry point, encl_entry, assumes that the TCS and its stack
exists at particular offsets within the binary it is not able to handle
a dynamically added TCS and its stack.

Introduce a new entry point, encl_dyn_entry, that initializes the
absolute address of that thread's stack to the address immediately
preceding the TCS itself. It is now possible to dynamically add a
contiguous memory region to the enclave with the new stack preceding
the new TCS. With the new TCS initialized with encl_dyn_entry as entry
point the absolute address of the stack is computed correctly on entry.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.

 tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..03ae0f57e29d 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -45,6 +45,12 @@ encl_entry:
 	# TCS #2. By adding the value of encl_stack to it, we get
 	# the absolute address for the stack.
 	lea	(encl_stack)(%rbx), %rax
+	jmp encl_entry_core
+encl_dyn_entry:
+	# Entry point for dynamically created TCS page expected to follow
+	# its stack directly.
+	lea -1(%rbx), %rax
+encl_entry_core:
 	xchg	%rsp, %rax
 	push	%rax
 
-- 
2.25.1

