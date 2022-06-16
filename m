Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27F54EDDD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jun 2022 01:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379340AbiFPXY3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 19:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347180AbiFPXY0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 19:24:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B838BC1
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 16:24:22 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id r5so2996309iod.5
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 16:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u96BVz1Qua6XT1OJDIQTuU1phclFGfQLvNlbRU9Ucew=;
        b=KgLkLfGPPGdlMWK4pn22+nMzfZnwsIcLCRw+f/0sNBmk9QQL/Qxto9VWJqFVFY2yNH
         KyNqWrBmZTHRP57w3AXgxoqwEFI7E+Ff7Gq9b2xHVbubjUXJroRkU/8WM6/TyAv8Ytcc
         GYwPGtWZrDi/h0g5iqyLNExPedMZSicws7pO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u96BVz1Qua6XT1OJDIQTuU1phclFGfQLvNlbRU9Ucew=;
        b=Wj1VKgmqTnM3XT8c6cj3AX/zuqmR5hGi0CCOo3Pn3Llqel0y90TeXBYujzPa03CxBm
         xfVRihrlMvIr4o3YoX0rHSlOFAp8i9c6qop/5nLZ9imASR8INgHc9oflpKthXCRuVwA4
         Voga0RACBcrZyDVODSH/4ZHtnHFCMH2TddB+r80N2gwT31YzcavjDQsbJ3XpwkMAWs3v
         bD29Y/qq/ZA6odNegfqSqqUhxfEdaE7X88DdF8t50oMBBLmxTySDDU1K4s8AvebU2TeG
         YH1CO6dq+/yczX5LQ4CKGQDmprbA+0Ja4G15iT1QD158j7PN53GoKnG4j0Ynh4dz1Y5I
         TfRQ==
X-Gm-Message-State: AJIora+Fz5KhNKwCH/VIlWFs+KGUto3YPfZOm5milHSpd2we1QKPQdh8
        JSRYIq1b0QHOhVlF6LHX9HpIqQ==
X-Google-Smtp-Source: AGRyM1tFB91CUBcsjgqyr8dekyVExoN4n981kEWAV3tDRiIo/RAsr5C9W3MMWueFXJY8ksWSfWDsqw==
X-Received: by 2002:a02:a48b:0:b0:335:e30a:edb0 with SMTP id d11-20020a02a48b000000b00335e30aedb0mr1209237jam.190.1655421861833;
        Thu, 16 Jun 2022 16:24:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x9-20020a056638010900b00330a4ed20d6sm1451180jao.115.2022.06.16.16.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:24:21 -0700 (PDT)
Subject: Re: [PATCH v9 1/2] selftests/x86/xstate: Add xstate signal handling
 test for XSAVE feature
To:     Pengfei Xu <pengfei.xu@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Heng Su <heng.su@intel.com>, Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1655218544.git.pengfei.xu@intel.com>
 <f750fb183cf13e83cb2a10befacd3707879851ec.1655218544.git.pengfei.xu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <86f9d913-1041-b52d-0221-3585473239d2@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 17:24:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f750fb183cf13e83cb2a10befacd3707879851ec.1655218544.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/22 9:11 AM, Pengfei Xu wrote:
> The XSAVE feature set supports the saving and restoring of xstate components.
> 
> In order to ensure that XSAVE works correctly, add XSAVE most basic signal
> handling test for XSAVE architecture functionality, this patch tests "FP,
> SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/AVX512_Hi16_ZMM and PKRU"
> xstates with the following:
> The contents of these xstates in the process should not change after the
> signal handling.
> 
>    [ Dave Hansen; Chang S. Bae: bunches of cleanups ]
> 
> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>   tools/testing/selftests/x86/.gitignore       |   1 +
>   tools/testing/selftests/x86/Makefile         |  11 +-
>   tools/testing/selftests/x86/xstate.c         | 215 +++++++++++++++
>   tools/testing/selftests/x86/xstate.h         | 266 +++++++++++++++++++
>   tools/testing/selftests/x86/xstate_helpers.c | 160 +++++++++++
>   tools/testing/selftests/x86/xstate_helpers.h |   8 +
>   6 files changed, 659 insertions(+), 2 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/xstate.c
>   create mode 100644 tools/testing/selftests/x86/xstate.h
>   create mode 100644 tools/testing/selftests/x86/xstate_helpers.c
>   create mode 100644 tools/testing/selftests/x86/xstate_helpers.h
> 
> diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
> index 1aaef5bf119a..68951ceefe30 100644
> --- a/tools/testing/selftests/x86/.gitignore
> +++ b/tools/testing/selftests/x86/.gitignore
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   *_32
>   *_64
> +*.o
>   single_step_syscall
>   sysret_ss_attrs
>   syscall_nt
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 0388c4d60af0..49a6d78e0831 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>   			test_FCMOV test_FCOMI test_FISTTP \
>   			vdso_restorer
>   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx xstate
>   # Some selftests require 32bit support enabled also on 64bit systems
>   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>   
> @@ -69,7 +69,7 @@ all_32: $(BINARIES_32)
>   
>   all_64: $(BINARIES_64)
>   
> -EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
> +EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64) *.o
>   
>   $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
>   	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
> @@ -109,3 +109,10 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
>   # state.
>   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
>   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
> +
> +# xstate_64 is special: it needs xstate_helpers.o to prevent GCC from
> +# generating any FP code by mistake and stdlib.h can't be used due to
> +# "-mno-sse" parameter, so compile xstate_64 with the code file xstate.c
> +# which can use stdlib.h and xstate_helpers.o which cannot use stdlib.h
> +xstate_helpers.o: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> +$(OUTPUT)/xstate_64: xstate_helpers.o
> diff --git a/tools/testing/selftests/x86/xstate.c b/tools/testing/selftests/x86/xstate.c
> new file mode 100644
> index 000000000000..05dabb4733a0
> --- /dev/null
> +++ b/tools/testing/selftests/x86/xstate.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * xstate.c - tests XSAVE feature with fork and signal handling.
> + *
> + * The XSAVE feature set supports the saving and restoring of state components.
> + * It tests "FP, SSE(XMM), AVX2(YMM), AVX512_OPMASK/AVX512_ZMM_Hi256/
> + * AVX512_Hi16_ZMM and PKRU parts" xstates with following cases:
> + * 1. The contents of these xstates in the process should not change after the
> + *    signal handling.
> + * 2. The contents of these xstates in the child process should be the same as
> + *    the contents of the xstate in the parent process after the fork syscall.
> + * 3. The contents of xstates in the parent process should not change after
> + *    the context switch.
> + *
> + * The regions and reserved bytes of the components tested for XSAVE feature
> + * are as follows:
> + * x87(FP)/SSE    (0 - 159 bytes)
> + * SSE(XMM part)  (160-415 bytes)
> + * Reserved       (416-511 bytes)
> + * Header_used    (512-527 bytes; XSTATE BV(bitmap vector) mask:512-519 bytes)
> + * Header_reserved(528-575 bytes must be 00)
> + * YMM            (Offset:CPUID.(EAX=0D,ECX=2).EBX Size:CPUID(EAX=0D,ECX=2).EAX)
> + * AVX512_OPMASK  (Offset:CPUID.(EAX=0D,ECX=5).EBX Size:CPUID(EAX=0D,ECX=5).EAX)
> + * ZMM_Hi256      (Offset:CPUID.(EAX=0D,ECX=6).EBX Size:CPUID(EAX=0D,ECX=6).EAX)
> + * Hi16_ZMM       (Offset:CPUID.(EAX=0D,ECX=7).EBX Size:CPUID(EAX=0D,ECX=7).EAX)
> + * PKRU           (Offset:CPUID.(EAX=0D,ECX=9).EBX Size:CPUID(EAX=0D,ECX=9).EAX)
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <stdbool.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <cpuid.h>
> +#include <malloc.h>
> +#include <stdlib.h>
> +
> +#include "xstate.h"
> +#include "xstate_helpers.h"
> +#include "../kselftest.h"
> +
> +#define NUM_TESTS 1
> +#define xstate_test_array_init(idx, init_opt, fill_opt)	\
> +	do {						\
> +		xstate_tests[idx].init = init_opt;	\
> +		xstate_tests[idx].fill_xbuf = fill_opt;	\
> +	} while (0)
> +
> +static struct xsave_buffer *valid_xbuf, *compared_xbuf;
> +static struct xstate_test xstate_tests[XFEATURE_MAX];
> +static uint32_t xstate_size;
> +
> +static bool xstate_in_test(int xfeature_num)
> +{
> +	return !!(xstate_info.mask & (1 << xfeature_num));

This is used just one. Why do you need a function for this?
Also please don't use !! - it is just very hard to read.

> +}
> +
> +static struct xsave_buffer *alloc_xbuf(uint32_t buf_size)
> +{
> +	struct xsave_buffer *xbuf;
> +
> +	/* XSAVE buffer should be 64B-aligned. */
> +	xbuf = aligned_alloc(64, buf_size);
> +	if (!xbuf)
> +		ksft_exit_fail_msg("aligned_alloc() failed.\n");
> +
> +	return xbuf;
> +}
> +
> +static void free_xbuf(void)
> +{
> +	free(valid_xbuf);
> +	free(compared_xbuf);
> +}
> +

Again this is called just one. WHy do you need a speacial function
for this. Please don't fragment code without a good reason.

> +static void allocate_xbuf(void)
> +{
> +	valid_xbuf = alloc_xbuf(xstate_size);
> +	compared_xbuf = alloc_xbuf(xstate_size);
> +}
> +

Probably another case of unnecessary function?

> +static void show_test_xfeatures(void)
> +{
> +	uint32_t i;
> +	const char *feature_name;
> +
> +	ksft_print_msg("[NOTE] Test following xstates with mask:%lx.\n",
> +		       xstate_info.mask);
> +	for (i = 0; i < XFEATURE_MAX; i++) {
> +		if (!xstate_in_test(i))
> +			continue;
> +		feature_name = xfeature_names[i];
> +		ksft_print_msg("[NOTE] XSAVE feature num %02d: '%s'.\n", i,
> +			       feature_name);
> +	}
> +}
> +
> +static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
> +{
> +	/* XSTATE_BV is at the beginning of xstate header. */
> +	*(uint64_t *)(&buffer->header) = bv;
> +}
> +

Okay - if you have a function - I want to see it called at least 2 times.
Having so many little function breaks up the code for no good reason.

Let's fix these first and in both patches.

thanks,
-- Shuah
