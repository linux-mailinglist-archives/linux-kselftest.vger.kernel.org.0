Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2434DA04D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 17:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350162AbiCOQqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 12:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbiCOQqA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 12:46:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55256C21;
        Tue, 15 Mar 2022 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362688; x=1678898688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8KaVKH4qUgKYR/3ymaU2krf35oF098yonqwR5NUOhxE=;
  b=ZiqohRRm14xYK9X1zjRg1Z44rJDy/rSmaXYPnPVYIEzG3R8oLsLeKkRf
   vgXI22ntwypIg03CPhi0EHqGKgWPRZI9VrrdRdQT5pGLwAv4+H6wxxtNa
   QDph8kh9TKTDhVJFJeT4ALMchGnUuEo0nzqYn6aeTvgWZRnuTevA/PRv+
   IDO7iWbNsr2Ji05cacY+QuGB4pKQ4xCZaS/LfT6LKYTFfVLCRdekAR9cz
   daR8tCHE5OJvW4lW100LqhMWWaMohm1em2H/RfDTo7jnnc9adMNAJGoc+
   0qE73a47hWsLIC8S5vtKKEu5QQwtcgMpehiWGkOACboeMjKI/NhpfMBkw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342782287"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342782287"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="714236346"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org
Subject: [PATCH V2 0/4] selftests: Remove duplicate CPUID wrappers
Date:   Tue, 15 Mar 2022 09:44:24 -0700
Message-Id: <cover.1647360971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since V1:
- V1: https://lore.kernel.org/lkml/cover.1644000145.git.reinette.chatre@intel.com/
- Change solution to not use __cpuid_count() from compiler's
  cpuid.h but instead use a local define of __cpuid_count()
  provided in kselftest.h to ensure tests continue working
  in all supported environments. (Shuah)
- Rewrite cover letter and changelogs to reflect new solution.

A few tests that require running CPUID do so with a private
implementation of a wrapper for CPUID. This duplication of
the CPUID wrapper should be avoided.

Both gcc and clang/LLVM provide wrappers for CPUID but
the wrappers are not available in the minimal required
version of gcc, v3.2, that the selftests need to be used
in. __cpuid_count() was added to gcc in v4.4, which is ok for
kernels after v4.19 when the gcc minimal required version
was changed to v4.6.

Add a local define of __cpuid_count() to kselftest.h to
ensure that selftests can still work in environments with
older stable kernels (v4.9 and v4.14 that have the minimal
required version of gcc of v3.2). Update tests with private
CPUID wrappers to use the new macro.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: linux-mm@kvack.org
Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>

Reinette Chatre (4):
  selftests: Provide local define of __cpuid_count()
  selftests/vm/pkeys: Use provided __cpuid_count() macro
  selftests/x86/amx: Use provided __cpuid_count() macro
  selftests/x86/corrupt_xstate_header: Use provided __cpuid_count()
    macro

 tools/testing/selftests/kselftest.h           | 15 ++++++++++++
 tools/testing/selftests/vm/pkey-x86.h         | 21 ++--------------
 tools/testing/selftests/x86/amx.c             | 24 ++++++-------------
 .../selftests/x86/corrupt_xstate_header.c     | 16 ++-----------
 4 files changed, 26 insertions(+), 50 deletions(-)


base-commit: 09688c0166e76ce2fb85e86b9d99be8b0084cdf9
-- 
2.25.1

