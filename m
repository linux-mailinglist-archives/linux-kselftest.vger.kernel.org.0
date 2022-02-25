Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3928A4C4E0A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiBYSuP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 13:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiBYSuO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 13:50:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC7182D8A;
        Fri, 25 Feb 2022 10:49:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id DED551F4664E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645814980;
        bh=W1siran0TDWu7KT1NGueE/mVjJkk8nSZK4wyUM635do=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=WijUW/t4Phhx9H51BK2pBFSQkcaSPVGY+5nyahB6tSqLcsRuGthEKnKM6MTXySYOk
         dtkboROcim2ASyTrJwugmHjLAIO/htDGkxMCbopG8TIZ6OJiRLjt9t3fuWqc38PLse
         NkWA8WLGiyPonH80gGYow+LYwyiIeHsBdeh2neu66f0ZI0ksCFGWen6HOHw0X5wA8K
         wXs+5lXyErJs6pG9+2mS6EAtOJXj09wOI/TFTaWExYF24I4/1bK8svQ1X6jARLdPVg
         HGbQjB2pKOw15iNAkIimvqxIrHO2zFUVjbX3Q3nt1zVEn9OOqODCNwQGYHWhEb3ypZ
         B6Hk93T9vDfZQ==
Message-ID: <8e88488b-1666-ce1b-6d79-7c6758672ac0@collabora.com>
Date:   Fri, 25 Feb 2022 18:49:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] selftests, x86: fix how check_cc.sh is being invoked
Content-Language: en-US
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel@collabora.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
In-Reply-To: <9320d88a3a65350d9bfdc5e258742cd0b162f017.1645794882.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/02/2022 13:15, Guillaume Tucker wrote:
> Add quotes around $(CC) when calling check_cc.sh from a Makefile to
> pass the value as a single argument to the script even if it has
> several words such as "ccache gcc".  Conversely, remove quotes in
> check_cc.sh when calling $CC to make it a command with potentially
> several arguments again.
> 
> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture detection")
> Tested-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>  tools/testing/selftests/vm/Makefile     | 6 +++---
>  tools/testing/selftests/x86/Makefile    | 6 +++---
>  tools/testing/selftests/x86/check_cc.sh | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 1607322a112c..d934f026ebb5 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -49,9 +49,9 @@ TEST_GEN_FILES += split_huge_page_test
>  TEST_GEN_FILES += ksm_tests
>  
>  ifeq ($(MACHINE),x86_64)
> -CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_32bit_program.c -m32)
> -CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_64bit_program.c)
> -CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh $(CC) ../x86/trivial_program.c -no-pie)
> +CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
> +CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
> +CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
>  
>  TARGETS := protection_keys
>  BINARIES_32 := $(TARGETS:%=%_32)
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 8a1f62ab3c8e..53df7d3893d3 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -6,9 +6,9 @@ include ../lib.mk
>  .PHONY: all all_32 all_64 warn_32bit_failure clean
>  
>  UNAME_M := $(shell uname -m)
> -CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
> -CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
> -CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
> +CAN_BUILD_I386 := $(shell ./check_cc.sh "$(CC)" trivial_32bit_program.c -m32)
> +CAN_BUILD_X86_64 := $(shell ./check_cc.sh "$(CC)" trivial_64bit_program.c)
> +CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh "$(CC)" trivial_program.c -no-pie)
>  
>  TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
>  			check_initial_reg_state sigreturn iopl ioperm \
> diff --git a/tools/testing/selftests/x86/check_cc.sh b/tools/testing/selftests/x86/check_cc.sh
> index 3e2089c8cf54..aff2c15018b5 100755
> --- a/tools/testing/selftests/x86/check_cc.sh
> +++ b/tools/testing/selftests/x86/check_cc.sh
> @@ -7,7 +7,7 @@ CC="$1"
>  TESTPROG="$2"
>  shift 2
>  
> -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>      echo 1
>  else
>      echo 0

I see the change in check_cc.sh is already covered by Usama's patch:

  selftests/x86: Add validity check and allow field splitting

-if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
+if [ -n "$CC" ] && $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then


However, the rest of this patch in the Makefiles still needs to
be applied.  Let me know if I should rebase it on top of Usama's.

Thanks,
Guillaume

