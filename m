Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9394AE411
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386938AbiBHWZv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387026AbiBHVsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:48:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2191C0612B8;
        Tue,  8 Feb 2022 13:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356929; x=1675892929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GGSyh+03q9qU11wHQlvx8iReUEq1xb52fNxWSqLbH+4=;
  b=GJz07wFvA+IoPPsN9IpyuJWWA/A2v0qbbQGPLgU/LoNFALHXmV9Ue2nN
   2K0Occf/hrS1cXd7PrKi72PB7wLpvkEJuyYW7WL0k5vW3BJNGsGySe11W
   nvNG5VwXnKmodjasmjYrgcSf/yC1gsetZq/dtOUdFOUybOZfOmSB0dO7B
   YPZDQj1vbUF/h56K9QtfqRgOBwfARR/shTyMH41P9UYUUTs2DeN44/s+z
   8a3WrHZBXcgPg5PsFd6jyGVD9Sv4YMeXHH/hSUEt7d/ZrdaMOG82MPQnz
   uXgjWOcitxNnrkUccR2scjkK322pK0oyJetO2gSlwjnFebTfpgHBe7Sal
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309805365"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309805365"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632992863"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/4] selftests/sgx: Early enclave loading error path fixes
Date:   Tue,  8 Feb 2022 13:48:38 -0800
Message-Id: <cover.1644355600.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since V2:
- V2: https://lore.kernel.org/linux-sgx/cover.1643754040.git.reinette.chatre@intel.com/
- Added Acked-by from Shuah to all patches in series.
- Shuah is ok with these entering the kernel via tip.git:
  https://lore.kernel.org/linux-sgx/e188c62e-f75e-2bec-b544-76063098611d@linuxfoundation.org/
- Include x86@kernel.org and more x86 maintainers since goal is for
  inclusion into tip.git.

Changes since V1:
- V1: https://lore.kernel.org/linux-sgx/cover.1643393473.git.reinette.chatre@intel.com/
- All changes impact the commit messages only, no changes to code.
- Rewrite commit message of 1/4 (Dave).
- Detail in 2/4 commit log what callers will see with this change (Dave).
- Add Acked-by from Dave to 2/4 and 4/4.

Hi Everybody,

Please find included a few fixes that address problems encountered after
venturing into the enclave loading error handling code of the SGX
selftests.

Reinette

Reinette Chatre (4):
  selftests/sgx: Fix NULL-pointer-dereference upon early test failure
  selftests/sgx: Do not attempt enclave build without valid enclave
  selftests/sgx: Ensure enclave data available during debug print
  selftests/sgx: Remove extra newlines in test output

 tools/testing/selftests/sgx/load.c | 9 +++++----
 tools/testing/selftests/sgx/main.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.25.1

