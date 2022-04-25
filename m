Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7231B50EAEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbiDYVEZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiDYVEY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:04:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A718366
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650920479; x=1682456479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SFrZIOQtKpUy81uaSvHixmsB2hBWhZKBOMyLkzWOzZY=;
  b=CQLzYRpO2U7cjTLDnntHLV0k5qSnUlwxqHbina2zj8264dQP5xoGN1PS
   z1EKEe6J6O+0a+tng218fMYb9fKotZuqV7wVhd6d/nd+SYmMy3mEcdij8
   Bhjfp77R60cJMreu5zvZuZUaHOWLk+UCwUZ9PDYdHNfhr2Kd7PdAQKhHA
   04uhho0UDJ42VOEsqkNOJMFp8p/ClKSYY0FTmBj/CzGlS5DkFXaRu2nNZ
   3fu5UJ//9eQE5xYonHLFH9J4SvmrSKbnBtidcU5xa73cjCh2dEzgtRu89
   OaxmKcE/AtU/MD2fWqZnXOHLkzdu/nWmvbIEdtdGHWtm4+Us6g7zOMzd3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290502301"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290502301"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="579499489"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, sandipan@linux.ibm.com,
        fweimer@redhat.com, desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org
Subject: [PATCH V3 0/4] selftests: Remove duplicate CPUID wrappers
Date:   Mon, 25 Apr 2022 14:01:10 -0700
Message-Id: <cover.1650918160.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes since V2:
- V2: https://lore.kernel.org/lkml/cover.1647360971.git.reinette.chatre@intel.com/
- Rebased against v5.18-rc4, no functional changes.
- Add text in cover letter and first patch to highlight that
  the __cpuid_count() macro provided is not a new implementation but
  copied from gcc.

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

Copy gcc's __cpuid_count() to provide a local define of
__cpuid_count() to kselftest.h to ensure that selftests can
still work in environments with older stable kernels (v4.9
and v4.14 that have the minimal required version of gcc of
v3.2). Update tests with private CPUID wrappers to use the
new macro.

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


base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.25.1

