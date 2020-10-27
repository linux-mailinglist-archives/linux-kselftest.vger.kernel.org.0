Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8034129A9AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898307AbgJ0KcZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 06:32:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898300AbgJ0KbW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 06:31:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D5B230E;
        Tue, 27 Oct 2020 03:31:22 -0700 (PDT)
Received: from [10.57.11.195] (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27AB73F66E;
        Tue, 27 Oct 2020 03:31:18 -0700 (PDT)
Subject: Re: [PATCH 4/6] kselftest/arm64: Fix check_mmap_options test
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
 <20201026121248.2340-5-vincenzo.frascino@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <7a719ad9-0eef-5f7a-be5a-f2194d774d74@arm.com>
Date:   Tue, 27 Oct 2020 16:01:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201026121248.2340-5-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/26/20 5:42 PM, Vincenzo Frascino wrote:
> The check_mmap_options test reports the error below because the test
> plan is not declared correctly:
> 
>    # Planned tests != run tests (0 != 22)
> 
> Fix the test adding the correct test plan declaration.

This change is required and got missed earlier.
Acked by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> 
> Fixes: 53ec81d23213 ("kselftest/arm64: Verify all different mmap MTE options")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Gabor Kertesz <gabor.kertesz@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/arm64/mte/check_mmap_options.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_mmap_options.c b/tools/testing/selftests/arm64/mte/check_mmap_options.c
> index 33b13b86199b..a04b12c21ac9 100644
> --- a/tools/testing/selftests/arm64/mte/check_mmap_options.c
> +++ b/tools/testing/selftests/arm64/mte/check_mmap_options.c
> @@ -205,7 +205,11 @@ int main(int argc, char *argv[])
>   	mte_register_signal(SIGBUS, mte_default_handler);
>   	mte_register_signal(SIGSEGV, mte_default_handler);
>   
> +	/* Set test plan */
> +	ksft_set_plan(22);
> +
>   	mte_enable_pstate_tco();
> +
>   	evaluate_test(check_anonymous_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
>   	"Check anonymous memory with private mapping, sync error mode, mmap memory and tag check off\n");
>   	evaluate_test(check_file_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE, TAG_CHECK_OFF),
> 
