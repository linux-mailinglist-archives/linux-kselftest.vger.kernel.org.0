Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB135C496
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Apr 2021 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbhDLLCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Apr 2021 07:02:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11012 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238741AbhDLLCR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Apr 2021 07:02:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FJm5X3TZzz9tyQf;
        Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id uqxnhjxGkXvi; Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FJm5X2L2kz9tyQd;
        Mon, 12 Apr 2021 13:01:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 44C598B78F;
        Mon, 12 Apr 2021 13:01:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zdhaUy4GMB_D; Mon, 12 Apr 2021 13:01:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 41C188B78D;
        Mon, 12 Apr 2021 13:01:56 +0200 (CEST)
Subject: Re: [PATCH] powerpc: alignment: Remove unneeded variables
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
References: <20210412095923.3916-1-wanjiabing@vivo.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8cca3679-f932-fbd7-fb6f-f5c2e641aec0@csgroup.eu>
Date:   Mon, 12 Apr 2021 13:01:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412095923.3916-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Le 12/04/2021 à 11:59, Wan Jiabing a écrit :
> Fix coccicheck warning:

Can you mention in the commit subject that it is selftests and not the core part of powerpc which is 
addressed here ?

> 
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:539:5-7:
> Unneeded variable: "rc". Return "0" on line 562
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:567:5-7:
> Unneeded variable: "rc". Return "0" on line 580
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:585:5-7:
> Unneeded variable: "rc". Return "0" on line 594
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:600:5-7:
> Unneeded variable: "rc". Return "0" on line 611
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:416:5-7:
> Unneeded variable: "rc". Return "0" on line 470
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:475:5-7:
> Unneeded variable: "rc". Return "0" on line 485
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:490:5-7:
> Unneeded variable: "rc". Return "0" on line 506
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:511:5-7:
> Unneeded variable: "rc". Return "0" on line 534
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:331:5-7:
> Unneeded variable: "rc". Return "0" on line 344
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:349:5-7:
> Unneeded variable: "rc". Return "0" on line 360
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:365:5-7:
> Unneeded variable: "rc". Return "0" on line 392
> ./tools/testing/selftests/powerpc/alignment/alignment_handler.c:397:5-7:
> Unneeded variable: "rc". Return "0" on line 411
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>   .../powerpc/alignment/alignment_handler.c     | 48 +++++--------------
>   1 file changed, 12 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/alignment/alignment_handler.c b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> index c25cf7cd45e9..48bfb7b36d84 100644
> --- a/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> +++ b/tools/testing/selftests/powerpc/alignment/alignment_handler.c
> @@ -328,8 +328,6 @@ static bool can_open_cifile(void)
>   
>   int test_alignment_handler_vsx_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -341,13 +339,11 @@ int test_alignment_handler_vsx_206(void)
>   	STORE_VSX_XFORM_TEST(stxvd2x);
>   	STORE_VSX_XFORM_TEST(stxvw4x);
>   	STORE_VSX_XFORM_TEST(stxsdx);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_207(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_2_07));
>   
> @@ -357,13 +353,11 @@ int test_alignment_handler_vsx_207(void)
>   	LOAD_VSX_XFORM_TEST(lxsiwzx);
>   	STORE_VSX_XFORM_TEST(stxsspx);
>   	STORE_VSX_XFORM_TEST(stxsiwx);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_300(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_00));
> @@ -389,13 +383,11 @@ int test_alignment_handler_vsx_300(void)
>   	STORE_VSX_XFORM_TEST(stxvx);
>   	STORE_VSX_XFORM_TEST(stxvl);
>   	STORE_VSX_XFORM_TEST(stxvll);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vsx_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -408,13 +400,11 @@ int test_alignment_handler_vsx_prefix(void)
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXSSP, 0);
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXV0, 0);
>   	STORE_VSX_8LS_PREFIX_TEST(PSTXV1, 1);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	printf("Integer\n");
> @@ -467,13 +457,11 @@ int test_alignment_handler_integer(void)
>   	STORE_DFORM_TEST(stmw);
>   #endif
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -482,13 +470,11 @@ int test_alignment_handler_integer_206(void)
>   	LOAD_XFORM_TEST(ldbrx);
>   	STORE_XFORM_TEST(stdbrx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_integer_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -503,13 +489,11 @@ int test_alignment_handler_integer_prefix(void)
>   	STORE_MLS_PREFIX_TEST(PSTH);
>   	STORE_MLS_PREFIX_TEST(PSTW);
>   	STORE_8LS_PREFIX_TEST(PSTD);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_vmx(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_HAS_ALTIVEC));
>   
> @@ -531,13 +515,11 @@ int test_alignment_handler_vmx(void)
>   	STORE_VMX_XFORM_TEST(stvehx);
>   	STORE_VMX_XFORM_TEST(stvewx);
>   	STORE_VMX_XFORM_TEST(stvxl);
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   
>   	printf("Floating point\n");
> @@ -559,13 +541,11 @@ int test_alignment_handler_fp(void)
>   	STORE_FLOAT_XFORM_TEST(stfsux);
>   	STORE_FLOAT_XFORM_TEST(stfiwx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp_205(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_05));
>   
> @@ -577,13 +557,11 @@ int test_alignment_handler_fp_205(void)
>   	STORE_FLOAT_DFORM_TEST(stfdp);
>   	STORE_FLOAT_XFORM_TEST(stfdpx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   int test_alignment_handler_fp_206(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap(PPC_FEATURE_ARCH_2_06));
>   
> @@ -591,14 +569,12 @@ int test_alignment_handler_fp_206(void)
>   
>   	LOAD_FLOAT_XFORM_TEST(lfiwzx);
>   
> -	return rc;
> +	return 0;
>   }
>   
>   
>   int test_alignment_handler_fp_prefix(void)
>   {
> -	int rc = 0;
> -
>   	SKIP_IF(!can_open_cifile());
>   	SKIP_IF(!have_hwcap2(PPC_FEATURE2_ARCH_3_1));
>   
> @@ -608,7 +584,7 @@ int test_alignment_handler_fp_prefix(void)
>   	LOAD_FLOAT_MLS_PREFIX_TEST(PLFD);
>   	STORE_FLOAT_MLS_PREFIX_TEST(PSTFS);
>   	STORE_FLOAT_MLS_PREFIX_TEST(PSTFD);
> -	return rc;
> +	return 0;
>   }
>   
>   void usage(char *prog)
> 
