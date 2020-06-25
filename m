Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A7520A08F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405082AbgFYOEj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 10:04:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:9128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405181AbgFYOEi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 10:04:38 -0400
IronPort-SDR: bMtSNLMSXlNAQl0YVXzGSqC8NvBFXbeR7u831RO/nRcWjHLbB0atq9iFC/e94TMDLp+qYVi/W2
 fnABpnLbTf5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146386844"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="146386844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 06:58:36 -0700
IronPort-SDR: qAWQgK2JV8WnY+PSLDzvjHI0TQJwiYpSVk1IyimzD3xS5mYJj+OtvkSwuixDmgR4kJpS8xumfF
 s2v7mKOJSOEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="354465173"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Jun 2020 06:58:33 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joSOe-0001dj-HB; Thu, 25 Jun 2020 13:58:32 +0000
Date:   Thu, 25 Jun 2020 21:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     kbuild-all@lists.01.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        keescook@chromium.org, linux@rasmusvillemoes.dk,
        davidgow@google.com
Subject: Re: [RESEND, PATCH v2] lib: overflow-test: add KUnit test of
 check_*_overflow functions
Message-ID: <202006252130.iJ0yp2Yn%lkp@intel.com>
References: <20200618140814.135948-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618140814.135948-1-vitor@massaru.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vitor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.8-rc2]
[cannot apply to next-20200625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vitor-Massaru-Iha/lib-overflow-test-add-KUnit-test-of-check_-_overflow-functions/20200618-221026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1b5044021070efa3259f3e9548dc35d1eb6aa844
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> lib/overflow-test.c:334:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
           ^
   lib/overflow-test.c:335:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
           ^
   lib/overflow-test.c:336:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
           ^
   lib/overflow-test.c:337:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
           ^
   lib/overflow-test.c:351:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
           ^
   lib/overflow-test.c:365:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
           ^
   lib/overflow-test.c:383:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
           ^
   lib/overflow-test.c:415:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
           ^
   lib/overflow-test.c:426:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
           ^
   lib/overflow-test.c:438:9: warning: Checking if unsigned variable '(unsigned int)-1' is less than zero. [unsignedLessThanZero]
    err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
           ^

vim +334 lib/overflow-test.c

d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  318  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  319  	/* Sane shifts. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  320  	err |= TEST_ONE_SHIFT(1, 0, u8, 1 << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  321  	err |= TEST_ONE_SHIFT(1, 4, u8, 1 << 4, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  322  	err |= TEST_ONE_SHIFT(1, 7, u8, 1 << 7, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  323  	err |= TEST_ONE_SHIFT(0xF, 4, u8, 0xF << 4, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  324  	err |= TEST_ONE_SHIFT(1, 0, u16, 1 << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  325  	err |= TEST_ONE_SHIFT(1, 10, u16, 1 << 10, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  326  	err |= TEST_ONE_SHIFT(1, 15, u16, 1 << 15, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  327  	err |= TEST_ONE_SHIFT(0xFF, 8, u16, 0xFF << 8, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  328  	err |= TEST_ONE_SHIFT(1, 0, int, 1 << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  329  	err |= TEST_ONE_SHIFT(1, 16, int, 1 << 16, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  330  	err |= TEST_ONE_SHIFT(1, 30, int, 1 << 30, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  331  	err |= TEST_ONE_SHIFT(1, 0, s32, 1 << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  332  	err |= TEST_ONE_SHIFT(1, 16, s32, 1 << 16, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  333  	err |= TEST_ONE_SHIFT(1, 30, s32, 1 << 30, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01 @334  	err |= TEST_ONE_SHIFT(1, 0, unsigned int, 1U << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  335  	err |= TEST_ONE_SHIFT(1, 20, unsigned int, 1U << 20, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  336  	err |= TEST_ONE_SHIFT(1, 31, unsigned int, 1U << 31, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  337  	err |= TEST_ONE_SHIFT(0xFFFFU, 16, unsigned int, 0xFFFFU << 16, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  338  	err |= TEST_ONE_SHIFT(1, 0, u32, 1U << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  339  	err |= TEST_ONE_SHIFT(1, 20, u32, 1U << 20, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  340  	err |= TEST_ONE_SHIFT(1, 31, u32, 1U << 31, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  341  	err |= TEST_ONE_SHIFT(0xFFFFU, 16, u32, 0xFFFFU << 16, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  342  	err |= TEST_ONE_SHIFT(1, 0, u64, 1ULL << 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  343  	err |= TEST_ONE_SHIFT(1, 40, u64, 1ULL << 40, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  344  	err |= TEST_ONE_SHIFT(1, 63, u64, 1ULL << 63, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  345  	err |= TEST_ONE_SHIFT(0xFFFFFFFFULL, 32, u64,
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  346  			      0xFFFFFFFFULL << 32, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  347  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  348  	/* Sane shift: start and end with 0, without a too-wide shift. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  349  	err |= TEST_ONE_SHIFT(0, 7, u8, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  350  	err |= TEST_ONE_SHIFT(0, 15, u16, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  351  	err |= TEST_ONE_SHIFT(0, 31, unsigned int, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  352  	err |= TEST_ONE_SHIFT(0, 31, u32, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  353  	err |= TEST_ONE_SHIFT(0, 63, u64, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  354  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  355  	/* Sane shift: start and end with 0, without reaching signed bit. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  356  	err |= TEST_ONE_SHIFT(0, 6, s8, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  357  	err |= TEST_ONE_SHIFT(0, 14, s16, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  358  	err |= TEST_ONE_SHIFT(0, 30, int, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  359  	err |= TEST_ONE_SHIFT(0, 30, s32, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  360  	err |= TEST_ONE_SHIFT(0, 62, s64, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  361  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  362  	/* Overflow: shifted the bit off the end. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  363  	err |= TEST_ONE_SHIFT(1, 8, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  364  	err |= TEST_ONE_SHIFT(1, 16, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  365  	err |= TEST_ONE_SHIFT(1, 32, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  366  	err |= TEST_ONE_SHIFT(1, 32, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  367  	err |= TEST_ONE_SHIFT(1, 64, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  368  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  369  	/* Overflow: shifted into the signed bit. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  370  	err |= TEST_ONE_SHIFT(1, 7, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  371  	err |= TEST_ONE_SHIFT(1, 15, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  372  	err |= TEST_ONE_SHIFT(1, 31, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  373  	err |= TEST_ONE_SHIFT(1, 31, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  374  	err |= TEST_ONE_SHIFT(1, 63, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  375  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  376  	/* Overflow: high bit falls off unsigned types. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  377  	/* 10010110 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  378  	err |= TEST_ONE_SHIFT(150, 1, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  379  	/* 1000100010010110 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  380  	err |= TEST_ONE_SHIFT(34966, 1, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  381  	/* 10000100000010001000100010010110 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  382  	err |= TEST_ONE_SHIFT(2215151766U, 1, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  383  	err |= TEST_ONE_SHIFT(2215151766U, 1, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  384  	/* 1000001000010000010000000100000010000100000010001000100010010110 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  385  	err |= TEST_ONE_SHIFT(9372061470395238550ULL, 1, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  386  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  387  	/* Overflow: bit shifted into signed bit on signed types. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  388  	/* 01001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  389  	err |= TEST_ONE_SHIFT(75, 1, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  390  	/* 0100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  391  	err |= TEST_ONE_SHIFT(17483, 1, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  392  	/* 01000010000001000100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  393  	err |= TEST_ONE_SHIFT(1107575883, 1, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  394  	err |= TEST_ONE_SHIFT(1107575883, 1, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  395  	/* 0100000100001000001000000010000001000010000001000100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  396  	err |= TEST_ONE_SHIFT(4686030735197619275LL, 1, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  397  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  398  	/* Overflow: bit shifted past signed bit on signed types. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  399  	/* 01001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  400  	err |= TEST_ONE_SHIFT(75, 2, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  401  	/* 0100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  402  	err |= TEST_ONE_SHIFT(17483, 2, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  403  	/* 01000010000001000100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  404  	err |= TEST_ONE_SHIFT(1107575883, 2, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  405  	err |= TEST_ONE_SHIFT(1107575883, 2, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  406  	/* 0100000100001000001000000010000001000010000001000100010001001011 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  407  	err |= TEST_ONE_SHIFT(4686030735197619275LL, 2, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  408  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  409  	/* Overflow: values larger than destination type. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  410  	err |= TEST_ONE_SHIFT(0x100, 0, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  411  	err |= TEST_ONE_SHIFT(0xFF, 0, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  412  	err |= TEST_ONE_SHIFT(0x10000U, 0, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  413  	err |= TEST_ONE_SHIFT(0xFFFFU, 0, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  414  	err |= TEST_ONE_SHIFT(0x100000000ULL, 0, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  415  	err |= TEST_ONE_SHIFT(0x100000000ULL, 0, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  416  	err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  417  	err |= TEST_ONE_SHIFT(0xFFFFFFFFUL, 0, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  418  	err |= TEST_ONE_SHIFT(0xFFFFFFFFFFFFFFFFULL, 0, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  419  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  420  	/* Nonsense: negative initial value. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  421  	err |= TEST_ONE_SHIFT(-1, 0, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  422  	err |= TEST_ONE_SHIFT(-1, 0, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  423  	err |= TEST_ONE_SHIFT(-5, 0, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  424  	err |= TEST_ONE_SHIFT(-5, 0, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  425  	err |= TEST_ONE_SHIFT(-10, 0, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  426  	err |= TEST_ONE_SHIFT(-10, 0, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  427  	err |= TEST_ONE_SHIFT(-100, 0, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  428  	err |= TEST_ONE_SHIFT(-100, 0, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  429  	err |= TEST_ONE_SHIFT(-10000, 0, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  430  	err |= TEST_ONE_SHIFT(-10000, 0, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  431  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  432  	/* Nonsense: negative shift values. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  433  	err |= TEST_ONE_SHIFT(0, -5, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  434  	err |= TEST_ONE_SHIFT(0, -5, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  435  	err |= TEST_ONE_SHIFT(0, -10, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  436  	err |= TEST_ONE_SHIFT(0, -10, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  437  	err |= TEST_ONE_SHIFT(0, -15, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  438  	err |= TEST_ONE_SHIFT(0, -15, unsigned int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  439  	err |= TEST_ONE_SHIFT(0, -20, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  440  	err |= TEST_ONE_SHIFT(0, -20, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  441  	err |= TEST_ONE_SHIFT(0, -30, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  442  	err |= TEST_ONE_SHIFT(0, -30, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  443  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  444  	/* Overflow: shifted at or beyond entire type's bit width. */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  445  	err |= TEST_ONE_SHIFT(0, 8, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  446  	err |= TEST_ONE_SHIFT(0, 9, u8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  447  	err |= TEST_ONE_SHIFT(0, 8, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  448  	err |= TEST_ONE_SHIFT(0, 9, s8, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  449  	err |= TEST_ONE_SHIFT(0, 16, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  450  	err |= TEST_ONE_SHIFT(0, 17, u16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  451  	err |= TEST_ONE_SHIFT(0, 16, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  452  	err |= TEST_ONE_SHIFT(0, 17, s16, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  453  	err |= TEST_ONE_SHIFT(0, 32, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  454  	err |= TEST_ONE_SHIFT(0, 33, u32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  455  	err |= TEST_ONE_SHIFT(0, 32, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  456  	err |= TEST_ONE_SHIFT(0, 33, int, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  457  	err |= TEST_ONE_SHIFT(0, 32, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  458  	err |= TEST_ONE_SHIFT(0, 33, s32, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  459  	err |= TEST_ONE_SHIFT(0, 64, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  460  	err |= TEST_ONE_SHIFT(0, 65, u64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  461  	err |= TEST_ONE_SHIFT(0, 64, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  462  	err |= TEST_ONE_SHIFT(0, 65, s64, 0, true);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  463  
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  464  	/*
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  465  	 * Corner case: for unsigned types, we fail when we've shifted
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  466  	 * through the entire width of bits. For signed types, we might
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  467  	 * want to match this behavior, but that would mean noticing if
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  468  	 * we shift through all but the signed bit, and this is not
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  469  	 * currently detected (but we'll notice an overflow into the
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  470  	 * signed bit). So, for now, we will test this condition but
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  471  	 * mark it as not expected to overflow.
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  472  	 */
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  473  	err |= TEST_ONE_SHIFT(0, 7, s8, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  474  	err |= TEST_ONE_SHIFT(0, 15, s16, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  475  	err |= TEST_ONE_SHIFT(0, 31, int, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  476  	err |= TEST_ONE_SHIFT(0, 31, s32, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  477  	err |= TEST_ONE_SHIFT(0, 63, s64, 0, false);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  478  
f1362e9519c80f lib/overflow-test.c Vitor Massaru Iha 2020-06-18  479  	KUNIT_EXPECT_FALSE(test, err);
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  480  }
d36b6ad27c7b95 lib/test_overflow.c Kees Cook         2018-08-01  481  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
