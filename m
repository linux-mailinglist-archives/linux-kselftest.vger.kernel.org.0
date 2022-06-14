Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C69B54B43C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiFNPLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiFNPLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 11:11:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFC72FE57;
        Tue, 14 Jun 2022 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655219508; x=1686755508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ThbrdSl7ac2Xg3NVTJbJs4XQZ17kBipcdz3o+Cig7TI=;
  b=IL9AhoEytErn/UBeyvLXy50qWAXoIE09n2/fjUtQcufZS+nwLb+wz2pq
   sfdZqFu8RTEDlztUdFnpAVegvdwkECF1UsV/lxEDTrLOZV24q3VHTvQfP
   abPtTMWbpdQ1pGZNX1rE3PueifaVI0HpvjA02/KMnZJWPJuSaNgM4rJ1P
   7XUTdc7DkozAUUzulqVYhG2WE4wRXgvLwtJAGhn98uIHzUa83lcH2i4gB
   jR05G7rNjSQ7ZfFVT5c5m47kdCKg6XUgRqLwVTuaHNirs5Dml5Luch5xi
   Th8/OayAyEwhRQUR7wnFQg5p5OeD2J17i6xkNzLZx4zt5rOcD0CRFo3ND
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="261673574"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="261673574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="673941747"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 08:11:44 -0700
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>
Subject: [PATCH v9 0/2] Introduce XSAVE feature self-test
Date:   Tue, 14 Jun 2022 23:11:04 +0800
Message-Id: <cover.1655218544.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The XSAVE feature set supports the saving and restoring of xstate components.
XSAVE feature has been used for process context switching. XSAVE components
include x87 state for FP execution environment, SSE state, AVX state and so on.

In order to ensure that XSAVE works correctly, add XSAVE most basic test for
XSAVE architecture functionality.

This patch tests "FP, SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/
AVX512_Hi16_ZMM and PKRU parts" xstates with following cases:
1. The contents of these xstates in the process should not change after the
   signal handling.
2. The contents of these xstates in the child process should be the same as
   the contents of the xstate in the parent process after the fork syscall.
3. The contents of xstates in the parent process should not change after
   the context switch.

Because xstate like XMM will not be preserved across function calls, fork() and
raise() are implemented and inlined.
To prevent GCC from generating any FP/SSE(XMM)/AVX/PKRU code, add
"-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler arguments. stdlib.h
can not be used because of the "-mno-sse" option.
Thanks Dave, Hansen for the above suggestion!
Thanks Chen Yu; Shuah Khan; Chatre Reinette and Tony Luck's comments!
Thanks to Bae, Chang Seok for a bunch of comments!

========
- Change from v8 to v9
  - Use function pointers to make it more structured. (Hansen, Dave)
  - Improve the function name: xstate_tested -> xstate_in_test. (Chang S. Bae)
  - Break this test up into two pieces: keep the xstate key test steps with
    "-mno-sse" and no stdlib.h, keep others in xstate.c file. (Hansen, Dave)
  - Use kselftest infrastructure for xstate.c file. (Hansen, Dave)
  - Use instruction back to populate fp xstate buffer. (Hansen, Dave)
  - Will skip the test if cpu could not support xsave. (Chang S. Bae)
  - Use __cpuid_count() helper in kselftest.h. (Reinette, Chatre)

- Change from v7 to v8
  Many thanks to Bae, Chang Seok for a bunch of comments as follow:
  - Use the filling buffer way to prepare the xstate buffer, and use xrstor
    instruction way to load the tested xstates.
  - Remove useless dump_buffer, compare_buffer functions.
  - Improve the struct of xstate_info.
  - Added AVX512_ZMM_Hi256 and AVX512_Hi16_ZMM components in xstate test.
  - Remove redundant xstate_info.xstate_mask, xstate_flag[], and
    xfeature_test_mask, use xstate_info.mask instead.
  - Check if xfeature is supported outside of fill_xstate_buf() , this change
    is easier to read and understand.
  - Remove useless wrpkru, only use filling all tested xstate buffer in
    fill_xstates_buf().
  - Improve a bunch of function names and variable names.
  - Improve test steps flow for readability.

- Change from v6 to v7:
  - Added the error number and error description of the reason for the
    failure, thanks Shuah Khan's suggestion.
  - Added a description of what these tests are doing in the head comments.
  - Added changes update in the head comments.
  - Added description of the purpose of the function. thanks Shuah Khan.

- Change from v5 to v6:
  - In order to prevent GCC from generating any FP code by mistake,
    "-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler parameter was
    added, it's referred to the parameters for compiling the x86 kernel. Thanks
    Dave Hansen's suggestion.
  - Removed the use of "kselftest.h", because kselftest.h included <stdlib.h>,
    and "stdlib.h" would use sse instructions in it's libc, and this *XSAVE*
    test needed to be compiled without libc sse instructions(-mno-sse).
  - Improved the description in commit header, thanks Chen Yu's suggestion.
  - Becasue test code could not use buildin xsave64 in libc without sse, added
    xsave function by instruction way.
  - Every key test action would not use libc(like printf) except syscall until
    it's failed or done. If it's failed, then it would print the failed reason.
  - Used __cpuid_count() instead of native_cpuid(), becasue __cpuid_count()
    was a macro definition function with one instruction in libc and did not
    change xstate. Thanks Chatre Reinette, Shuah Khan.
    https://lore.kernel.org/linux-sgx/8b7c98f4-f050-bc1c-5699-fa598ecc66a2@linuxfoundation.org/

- Change from v4 to v5:
  - Moved code files into tools/testing/selftests/x86.
  - Delete xsave instruction test, becaue it's not related to kernel.
  - Improved case description.
  - Added AVX512 opmask change and related XSAVE content verification.
  - Added PKRU part xstate test into instruction and signal handling test.
  - Added XSAVE process swich test for FPU, AVX2, AVX512 opmask and PKRU part.

- Change from v3 to v4:
  - Improve the comment in patch 1.

- Change from v2 to v3:
  - Improve the description of patch 2 git log.

- Change from v1 to v2:
  - Improve the cover-letter. Thanks Dave Hansen's suggestion.

Pengfei Xu (2):
  selftests/x86/xstate: Add xstate signal handling test for XSAVE
    feature
  selftests/x86/xstate: Add xstate fork test for XSAVE feature

 tools/testing/selftests/x86/.gitignore       |   1 +
 tools/testing/selftests/x86/Makefile         |  11 +-
 tools/testing/selftests/x86/xstate.c         | 235 ++++++++++++++++
 tools/testing/selftests/x86/xstate.h         | 267 +++++++++++++++++++
 tools/testing/selftests/x86/xstate_helpers.c | 211 +++++++++++++++
 tools/testing/selftests/x86/xstate_helpers.h |  10 +
 6 files changed, 733 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/x86/xstate.c
 create mode 100644 tools/testing/selftests/x86/xstate.h
 create mode 100644 tools/testing/selftests/x86/xstate_helpers.c
 create mode 100644 tools/testing/selftests/x86/xstate_helpers.h

-- 
2.31.1

