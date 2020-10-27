Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46029A9B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898371AbgJ0KdQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 06:33:16 -0400
Received: from foss.arm.com ([217.140.110.172]:37738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898368AbgJ0KdK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 06:33:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3404930E;
        Tue, 27 Oct 2020 03:33:10 -0700 (PDT)
Received: from [10.57.11.195] (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435033F66E;
        Tue, 27 Oct 2020 03:33:06 -0700 (PDT)
Subject: Re: [PATCH 5/6] kselftest/arm64: Fix check_ksm_options test
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
 <20201026121248.2340-6-vincenzo.frascino@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <3610bc25-1c4f-8fac-9217-837679708b60@arm.com>
Date:   Tue, 27 Oct 2020 16:03:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201026121248.2340-6-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/26/20 5:42 PM, Vincenzo Frascino wrote:
> The check_ksm_options test reports the error below because the test
> plan is not declared correctly:
> 
>    # Planned tests != run tests (0 != 4)
> 
> Fix the test adding the correct test plan declaration.
This change makes sense and got missed earlier.
Acked by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> 
> Fixes: f981d8fa2646 ("kselftest/arm64: Verify KSM page merge for MTE pages")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Gabor Kertesz <gabor.kertesz@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/arm64/mte/check_ksm_options.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_ksm_options.c b/tools/testing/selftests/arm64/mte/check_ksm_options.c
> index bc41ae630c86..3b23c4d61d38 100644
> --- a/tools/testing/selftests/arm64/mte/check_ksm_options.c
> +++ b/tools/testing/selftests/arm64/mte/check_ksm_options.c
> @@ -140,6 +140,10 @@ int main(int argc, char *argv[])
>   	/* Register signal handlers */
>   	mte_register_signal(SIGBUS, mte_default_handler);
>   	mte_register_signal(SIGSEGV, mte_default_handler);
> +
> +	/* Set test plan */
> +	ksft_set_plan(4);
> +
>   	/* Enable KSM */
>   	mte_ksm_setup();
>   
> 
