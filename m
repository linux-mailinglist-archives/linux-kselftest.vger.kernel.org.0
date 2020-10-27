Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150DF29A997
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898098AbgJ0K1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 06:27:12 -0400
Received: from foss.arm.com ([217.140.110.172]:37612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898092AbgJ0K1M (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 06:27:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F84530E;
        Tue, 27 Oct 2020 03:27:12 -0700 (PDT)
Received: from [10.57.11.195] (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED633F66E;
        Tue, 27 Oct 2020 03:27:08 -0700 (PDT)
Subject: Re: [PATCH 2/6] kselftest/arm64: Fix check_tags_inclusion test
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
 <20201026121248.2340-3-vincenzo.frascino@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <4783a06c-f9a1-73fa-9cf3-73f8e258989d@arm.com>
Date:   Tue, 27 Oct 2020 15:57:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201026121248.2340-3-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/26/20 5:42 PM, Vincenzo Frascino wrote:
> The check_tags_inclusion test reports the error below because the test
> plan is not declared correctly:
> 
>    # Planned tests != run tests (0 != 4)
> 
> Fix the test adding the correct test plan declaration.

This change is required and got missed earlier.
Acked by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> 
> Fixes: f3b2a26ca78d ("kselftest/arm64: Verify mte tag inclusion via prctl")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Gabor Kertesz <gabor.kertesz@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/arm64/mte/check_tags_inclusion.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> index 94d245a0ed56..deaef1f61076 100644
> --- a/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> +++ b/tools/testing/selftests/arm64/mte/check_tags_inclusion.c
> @@ -170,6 +170,9 @@ int main(int argc, char *argv[])
>   	/* Register SIGSEGV handler */
>   	mte_register_signal(SIGSEGV, mte_default_handler);
>   
> +	/* Set test plan */
> +	ksft_set_plan(4);
> +
>   	evaluate_test(check_single_included_tags(USE_MMAP, MTE_SYNC_ERR),
>   		      "Check an included tag value with sync mode\n");
>   	evaluate_test(check_multiple_included_tags(USE_MMAP, MTE_SYNC_ERR),
> 
