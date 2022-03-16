Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB864DAFE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 13:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355850AbiCPMnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355821AbiCPMm7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 08:42:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD065D27;
        Wed, 16 Mar 2022 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647434505; x=1678970505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jG6WJEvJi1w8lkMOJ54bp1lSTssrIdv4mh4Lm+BFCH4=;
  b=N6HhUzolSTAMJOXZUL+RKKEg0ZqhYC81pT2JiFez6ZhMyTd7fPkKfByo
   x0K4g595e2ktxmm1dEjrABx70W2qyWOVn+Mzd66Z4JVeCMn0AdIhAjp4P
   3t1knHy42+CzpPQw0W//eYQ0Z8Q1g29BoITBNYcGmpSqxiF1kTnpaB+Sg
   IbhEMylHWbl7wwUWR5gPsVGP9z2Re3Wn4ig4YdP9WifaFrNLkjCdv5GQf
   x0mYPqQMx1/3K6lUBnmVXtcLWYbkAeqstiSwqaJqVY4drtL7Bouw+aijQ
   L3GHagbbTinexIxGfuJyzcQ6wTvtd4PapgTBNBd8i6iE3kvflItP6A5u1
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="343002119"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="343002119"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 05:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646631233"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 05:41:41 -0700
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
Subject: [PATCH v8 0/1] Introduce XSAVE feature self-test
Date:   Wed, 16 Mar 2022 20:40:00 +0800
Message-Id: <cover.1646999762.git.pengfei.xu@intel.com>
X-Mailer: git-send-email 2.31.1
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

The XSAVE feature set supports the saving and restoring of xstate components.
XSAVE feature has been used for process context switching. XSAVE components
include x87 state for FP execution environment, SSE state, AVX state and so on.

In order to ensure that XSAVE works correctly, add XSAVE most basic test for
XSAVE architecture functionality.

This patch tests "FP, SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/
AVX512_Hi16_ZMM and PKRU parts" xstates with following cases:
1. The content of these xstates in the process should not change after the
   signal handling.
2. The content of these xstates in the child process should be the same as
   the content of the parent process after the fork syscall.

Because xstate like XMM will not be preserved across function calls, fork() and
raise() are implemented and inlined.
To prevent GCC from generating any FP/SSE(XMM)/AVX/PKRU code, add
"-mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku" compiler arguments. stdlib.h
can not be used because of the "-mno-sse" option.
Thanks Dave, Hansen for the above suggestion!
Thanks Chen Yu; Shuah Khan; Chatre Reinette and Tony Luck's comments!
Thanks to Bae, Chang Seok for a bunch of comments!

========
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

Pengfei Xu (1):
  selftests/x86/xstate: Add xstate test cases for XSAVE feature

 tools/testing/selftests/x86/Makefile |   3 +-
 tools/testing/selftests/x86/xstate.c | 574 +++++++++++++++++++++++++++
 2 files changed, 576 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xstate.c

-- 
2.31.1

