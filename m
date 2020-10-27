Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AFE29A98E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898033AbgJ0KZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 06:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:37574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898032AbgJ0KZp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 06:25:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FA5D30E;
        Tue, 27 Oct 2020 03:25:45 -0700 (PDT)
Received: from [10.57.11.195] (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35BF43F66E;
        Tue, 27 Oct 2020 03:25:41 -0700 (PDT)
Subject: Re: [PATCH 1/6] kselftest/arm64: Fix check_buffer_fill test
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
 <20201026121248.2340-2-vincenzo.frascino@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <b04b862b-39c7-7cd6-7760-2b3a2b78e69e@arm.com>
Date:   Tue, 27 Oct 2020 15:55:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201026121248.2340-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/26/20 5:42 PM, Vincenzo Frascino wrote:
> The check_buffer_fill test reports the error below because the test
> plan is not declared correctly:
> 
>    # Planned tests != run tests (0 != 20)
> 
> Fix the test adding the correct test plan declaration.

This change is required and got missed earlier.
Acked by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> 
> Fixes: e9b60476bea0 ("kselftest/arm64: Add utilities and a test to validate mte memory")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Gabor Kertesz <gabor.kertesz@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/arm64/mte/check_buffer_fill.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_buffer_fill.c b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
> index 242635d79035..c9fa141ebdcc 100644
> --- a/tools/testing/selftests/arm64/mte/check_buffer_fill.c
> +++ b/tools/testing/selftests/arm64/mte/check_buffer_fill.c
> @@ -417,6 +417,9 @@ int main(int argc, char *argv[])
>   	/* Register SIGSEGV handler */
>   	mte_register_signal(SIGSEGV, mte_default_handler);
>   
> +	/* Set test plan */
> +	ksft_set_plan(20);
> +
>   	/* Buffer by byte tests */
>   	evaluate_test(check_buffer_by_byte(USE_MMAP, MTE_SYNC_ERR),
>   	"Check buffer correctness by byte with sync err mode and mmap memory\n");
> 
