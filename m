Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABD3F2753
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhHTHKX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 03:10:23 -0400
Received: from foss.arm.com ([217.140.110.172]:54972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhHTHKX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 03:10:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 968F51042;
        Fri, 20 Aug 2021 00:09:45 -0700 (PDT)
Received: from [10.163.69.164] (unknown [10.163.69.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20FBD3F66F;
        Fri, 20 Aug 2021 00:09:42 -0700 (PDT)
Subject: Re: [PATCH] kselftest/arm64: pac: Fix skipping of tests on systems
 without PAC
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20210819165723.43903-1-broonie@kernel.org>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <a988b3e2-5f88-fbd5-99da-2066a65a17b2@arm.com>
Date:   Fri, 20 Aug 2021 12:39:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210819165723.43903-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/19/21 10:27 PM, Mark Brown wrote:
> The PAC tests check to see if the system supports the relevant PAC features
> but instead of skipping the tests if they can't be executed they fail the
> tests which makes things look like they're not working when they are.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/arm64/pauth/pac.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> index 592fe538506e..b743daa772f5 100644
> --- a/tools/testing/selftests/arm64/pauth/pac.c
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -25,13 +25,15 @@
>   do { \
>   	unsigned long hwcaps = getauxval(AT_HWCAP); \
>   	/* data key instructions are not in NOP space. This prevents a SIGILL */ \
> -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
> +	if (!(hwcaps & HWCAP_PACA))					\
> +		SKIP(return, "PAUTH not enabled"); \
>   } while (0)
>   #define ASSERT_GENERIC_PAUTH_ENABLED() \

May be ASSERT_GENERIC_PAUTH_ENABLED can be replaced with
something like VERIFY_GENERIC_PAUTH_ENABLED

or can be modified like below and instead of failing it skips with a
message

   -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
   +	ASSERT_NE(0, hwcaps & HWCAP_PACA) SKIP(return, "PAUTH not 
enabled"); \					


>   do { \
>   	unsigned long hwcaps = getauxval(AT_HWCAP); \
>   	/* generic key instructions are not in NOP space. This prevents a SIGILL */ \
> -	ASSERT_NE(0, hwcaps & HWCAP_PACG) TH_LOG("Generic PAUTH not enabled"); \
> +	if (!(hwcaps & HWCAP_PACG)) \
> +		SKIP(return, "Generic PAUTH not enabled");	\
>   } while (0)
>   
>   void sign_specific(struct signatures *sign, size_t val)
> @@ -256,7 +258,7 @@ TEST(single_thread_different_keys)
>   	unsigned long hwcaps = getauxval(AT_HWCAP);
>   
>   	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
> -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
> +	ASSERT_PAUTH_ENABLED();
>   	if (!(hwcaps & HWCAP_PACG)) {
>   		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
>   		nkeys = NKEYS - 1;
> @@ -299,7 +301,7 @@ TEST(exec_changed_keys)
>   	unsigned long hwcaps = getauxval(AT_HWCAP);
>   
>   	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
> -	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
> +	ASSERT_PAUTH_ENABLED();
>   	if (!(hwcaps & HWCAP_PACG)) {
>   		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
>   		nkeys = NKEYS - 1;
> 
