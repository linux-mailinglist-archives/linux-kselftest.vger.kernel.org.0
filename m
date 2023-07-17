Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D875684B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 17:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGQPto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGQPtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 11:49:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24FA0E51;
        Mon, 17 Jul 2023 08:49:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448EAC15;
        Mon, 17 Jul 2023 08:50:25 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032743F738;
        Mon, 17 Jul 2023 08:49:40 -0700 (PDT)
Message-ID: <5ef9d217-29a1-7935-d2fb-319e2a21ffbd@arm.com>
Date:   Mon, 17 Jul 2023 16:49:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests: vDSO: fix Makefile so that it uses lib.mk
 correctly
Content-Language: en-US
To:     Aditya Deshpande <aditya.deshpande@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230717150942.37448-1-aditya.deshpande@arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20230717150942.37448-1-aditya.deshpande@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/07/2023 16:09, Aditya Deshpande wrote:
> kselftest.rst states that flags must be specified before including lib.mk,
> but the vDSO selftest Makefile does not follow this order. As a result,
> changes made by lib.mk to flags and other variables are overwritten by the
> Makefile. For example, it is impossible to pass CFLAGS to the compiler via
> make.
> 
> Rectify this by including lib.mk after assigning flag values.
> 
> Also change the paths of the generated programs from absolute to relative
> paths as lib.mk will now correctly prepend the output directory path to
> the program name as intended.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Signed-off-by: Aditya Deshpande <aditya.deshpande@arm.com>
> ---
>   tools/testing/selftests/vDSO/Makefile | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index d53a4d8008f9..19145210d044 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,16 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0
> -include ../lib.mk
> -
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
> +TEST_GEN_PROGS := vdso_test_gettimeofday
> +TEST_GEN_PROGS += vdso_test_getcpu
> +TEST_GEN_PROGS += vdso_test_abi
> +TEST_GEN_PROGS += vdso_test_clock_getres
>   ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
> +TEST_GEN_PROGS += vdso_standalone_test_x86
>   endif
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
> +TEST_GEN_PROGS += vdso_test_correctness
>   
>   CFLAGS := -std=gnu99
>   CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> @@ -19,7 +18,8 @@ ifeq ($(CONFIG_X86_32),y)
>   LDLIBS += -lgcc_s
>   endif
>   
> -all: $(TEST_GEN_PROGS)
> +include ../lib.mk
> +
>   $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>   $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>   $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c

-- 
Regards,
Vincenzo
