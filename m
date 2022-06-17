Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9654F3A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 10:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381345AbiFQIws (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jun 2022 04:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381339AbiFQIwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jun 2022 04:52:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A82101D7;
        Fri, 17 Jun 2022 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655455966; x=1686991966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W3Kn73ADXqjDGIJOC78KxytBzQgghyOle85IAQ4iTMI=;
  b=UButNWX6CyzTlQE8hLl0y7h4PAPU09GZJkNzb+iAWwzcAePf09bm0+FH
   6XxICOk1C5SdTvus56ZUaqhli3GPl+abu32Jzg++eFsBAYLUCoCXtOvKz
   w9q8wwFZkccRBtGxAvyuKtZkEVWC8QFYQQ8sQ2n0E0fzjdrv5i72/ea2J
   sMgt7MEgT54/mQfw2gNR2PZKle4nIjOOeVSyugWLaksskvU5FnKyYGCN2
   fbt4wtRiTRd5LjY33b0dtkvNCDX1NOsmkBWyJiP1EuP9iyCmE85fpskjg
   DrsDUNmClji0NdImRbuuCggSqFnUXV7fxPNxYogVXal8hVBlzLgwBBulb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259308368"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259308368"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 01:52:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="831958591"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jun 2022 01:52:43 -0700
Date:   Fri, 17 Jun 2022 16:52:07 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>
Subject: Re: [PATCH v9 1/2] selftests/x86/xstate: Add xstate signal handling
 test for XSAVE feature
Message-ID: <YqxAt9flTQH5TYQh@xpf.sh.intel.com>
References: <cover.1655218544.git.pengfei.xu@intel.com>
 <f750fb183cf13e83cb2a10befacd3707879851ec.1655218544.git.pengfei.xu@intel.com>
 <86f9d913-1041-b52d-0221-3585473239d2@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f9d913-1041-b52d-0221-3585473239d2@linuxfoundation.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 2022-06-16 at 17:24:20 -0600, Shuah Khan wrote:
> On 6/14/22 9:11 AM, Pengfei Xu wrote:
> > The XSAVE feature set supports the saving and restoring of xstate components.
> > 
> > In order to ensure that XSAVE works correctly, add XSAVE most basic signal
> > handling test for XSAVE architecture functionality, this patch tests "FP,
> > SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/AVX512_Hi16_ZMM and PKRU"
> > xstates with the following:
> > The contents of these xstates in the process should not change after the
> > signal handling.
> > 
> >    [ Dave Hansen; Chang S. Bae: bunches of cleanups ]
> > 
> > Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > ---
> >   tools/testing/selftests/x86/.gitignore       |   1 +
> >   tools/testing/selftests/x86/Makefile         |  11 +-
> >   tools/testing/selftests/x86/xstate.c         | 215 +++++++++++++++
> >   tools/testing/selftests/x86/xstate.h         | 266 +++++++++++++++++++
> >   tools/testing/selftests/x86/xstate_helpers.c | 160 +++++++++++
> >   tools/testing/selftests/x86/xstate_helpers.h |   8 +
> >   6 files changed, 659 insertions(+), 2 deletions(-)
> >   create mode 100644 tools/testing/selftests/x86/xstate.c
> >   create mode 100644 tools/testing/selftests/x86/xstate.h
> >   create mode 100644 tools/testing/selftests/x86/xstate_helpers.c
> >   create mode 100644 tools/testing/selftests/x86/xstate_helpers.h
> > 
> > diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
> > index 1aaef5bf119a..68951ceefe30 100644
> > --- a/tools/testing/selftests/x86/.gitignore
> > +++ b/tools/testing/selftests/x86/.gitignore
> > @@ -1,6 +1,7 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   *_32
> >   *_64
> > +*.o
> >   single_step_syscall
> >   sysret_ss_attrs
> >   syscall_nt
> > diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> > index 0388c4d60af0..49a6d78e0831 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
> >   			test_FCMOV test_FCOMI test_FISTTP \
> >   			vdso_restorer
> >   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> > -			corrupt_xstate_header amx
> > +			corrupt_xstate_header amx xstate
> >   # Some selftests require 32bit support enabled also on 64bit systems
> >   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
> > @@ -69,7 +69,7 @@ all_32: $(BINARIES_32)
> >   all_64: $(BINARIES_64)
> > -EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
> > +EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) *.o
> >   $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
> >   	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
> > @@ -109,3 +109,10 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
> >   # state.
> >   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
> >   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
> > +
> > +# xstate_64 is special: it needs xstate_helpers.o to prevent GCC from
> > +# generating any FP code by mistake and stdlib.h can't be used due to
> > +# "-mno-sse" parameter, so compile xstate_64 with the code file xstate.c
> > +# which can use stdlib.h and xstate_helpers.o which cannot use stdlib.h
> > +xstate_helpers.o: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> > +$(OUTPUT)/xstate_64: xstate_helpers.o
> > diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
> > new file mode 100644
> > index 000000000000..05dabb4733a0
> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/xstate.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * xstate.c - tests XSAVE feature with fork and signal handling.
> > + *
> > + * The XSAVE feature set supports the saving and restoring of state components.
> > + * It tests "FP, SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/
> > + * AVX512_Hi16_ZMM and PKRU parts" xstates with following cases:
> > + * 1. The contents of these xstates in the process should not change after the
> > + *    signal handling.
> > + * 2. The contents of these xstates in the child process should be the same as
> > + *    the contents of the xstate in the parent process after the fork syscall.
> > + * 3. The contents of xstates in the parent process should not change after
> > + *    the context switch.
> > + *
> > + * The regions and reserved bytes of the components tested for XSAVE feature
> > + * are as follows:
> > + * x87(FP)/SSE    (0 - 159 bytes)
> > + * SSE(XMM part)  (160-415 bytes)
> > + * Reserved       (416-511 bytes)
> > + * Header_used    (512-527 bytes; XSTATE BV(bitmap vector) mask:512-519 bytes)
> > + * Header_reserved(528-575 bytes must be 00)
> > + * YMM            (Offset:CPUID.(EAX=0D,ECX=2).EBX Size:CPUID(EAX=0D,ECX=2).EAX)
> > + * AVX512_OPMASK  (Offset:CPUID.(EAX=0D,ECX=5).EBX Size:CPUID(EAX=0D,ECX=5).EAX)
> > + * ZMM_Hi256      (Offset:CPUID.(EAX=0D,ECX=6).EBX Size:CPUID(EAX=0D,ECX=6).EAX)
> > + * Hi16_ZMM       (Offset:CPUID.(EAX=0D,ECX=7).EBX Size:CPUID(EAX=0D,ECX=7).EAX)
> > + * PKRU           (Offset:CPUID.(EAX=0D,ECX=9).EBX Size:CPUID(EAX=0D,ECX=9).EAX)
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <err.h>
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <signal.h>
> > +#include <unistd.h>
> > +#include <sched.h>
> > +#include <stdbool.h>
> > +#include <sys/wait.h>
> > +#include <sys/syscall.h>
> > +#include <cpuid.h>
> > +#include <malloc.h>
> > +#include <stdlib.h>
> > +
> > +#include "xstate.h"
> > +#include "xstate_helpers.h"
> > +#include "../kselftest.h"
> > +
> > +#define NUM_TESTS 1
> > +#define xstate_test_array_init(idx, init_opt, fill_opt)	\
> > +	do {						\
> > +		xstate_tests[idx].init = init_opt;	\
> > +		xstate_tests[idx].fill_xbuf = fill_opt;	\
> > +	} while (0)
> > +
> > +static struct xsave_buffer *valid_xbuf, *compared_xbuf;
> > +static struct xstate_test xstate_tests[XFEATURE_MAX];
> > +static uint32_t xstate_size;
> > +
> > +static bool xstate_in_test(int xfeature_num)
> > +{
> > +	return !!(xstate_info.mask & (1 << xfeature_num));
> 
> This is used just one. Why do you need a function for this?
> Also please don't use !! - it is just very hard to read.
> 
 Ok, this function is only used once, will remove it. Thanks!

> > +}
> > +
> > +static struct xsave_buffer *alloc_xbuf(uint32_t buf_size)
> > +{
> > +	struct xsave_buffer *xbuf;
> > +
> > +	/* XSAVE buffer should be 64B-aligned. */
> > +	xbuf = aligned_alloc(64, buf_size);
> > +	if (!xbuf)
> > +		ksft_exit_fail_msg("aligned_alloc() failed.\n");
> > +
> > +	return xbuf;
> > +}
> > +
> > +static void free_xbuf(void)
> > +{
> > +	free(valid_xbuf);
> > +	free(compared_xbuf);
> > +}
> > +
> 
> Again this is called just one. WHy do you need a speacial function
> for this. Please don't fragment code without a good reason.
> 
 Will fix it, thanks!

> > +static void allocate_xbuf(void)
> > +{
> > +	valid_xbuf = alloc_xbuf(xstate_size);
> > +	compared_xbuf = alloc_xbuf(xstate_size);
> > +}
> > +
> 
> Probably another case of unnecessary function?
> 
Will fix it, thanks!

> > +static void show_test_xfeatures(void)
> > +{
> > +	uint32_t i;
> > +	const char *feature_name;
> > +
> > +	ksft_print_msg("[NOTE] Test following xstates with mask:%lx.\n",
> > +		       xstate_info.mask);
> > +	for (i = 0; i < XFEATURE_MAX; i++) {
> > +		if (!xstate_in_test(i))
> > +			continue;
> > +		feature_name = xfeature_names[i];
> > +		ksft_print_msg("[NOTE] XSAVE feature num %02d: '%s'.\n", i,
> > +			       feature_name);
> > +	}
> > +}
> > +
> > +static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
> > +{
> > +	/* XSTATE_BV is at the beginning of xstate header. */
> > +	*(uint64_t *)(&buffer->header) = bv;
> > +}
> > +
> 
> Okay - if you have a function - I want to see it called at least 2 times.
> Having so many little function breaks up the code for no good reason.
> 
> Let's fix these first and in both patches.
Sure, I will collect all the comments and fix them in next version.

Thanks!
-- Pengfei

> 
> thanks,
> -- Shuah
