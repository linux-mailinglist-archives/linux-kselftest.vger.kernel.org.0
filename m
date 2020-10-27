Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872DE29A9B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898276AbgJ0Kal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 06:30:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898137AbgJ0K3j (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 06:29:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C1A830E;
        Tue, 27 Oct 2020 03:29:38 -0700 (PDT)
Received: from [10.57.11.195] (unknown [10.57.11.195])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AC6E3F66E;
        Tue, 27 Oct 2020 03:29:35 -0700 (PDT)
Subject: Re: [PATCH 3/6] kselftest/arm64: Fix check_child_memory test
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gabor Kertesz <gabor.kertesz@arm.com>
References: <20201026121248.2340-1-vincenzo.frascino@arm.com>
 <20201026121248.2340-4-vincenzo.frascino@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <415f8728-8379-2094-4186-de7cf338c1e3@arm.com>
Date:   Tue, 27 Oct 2020 15:59:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20201026121248.2340-4-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/26/20 5:42 PM, Vincenzo Frascino wrote:
> The check_child_memory test reports the error below because the test
> plan is not declared correctly:
> 
>    # Planned tests != run tests (0 != 12)
> 
> Fix the test adding the correct test plan declaration.

This change is required and got missed earlier.
Acked by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> 
> Fixes: dfe537cf4718 ("kselftest/arm64: Check forked child mte memory accessibility")
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Gabor Kertesz <gabor.kertesz@arm.com>
> Cc: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/arm64/mte/check_child_memory.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/mte/check_child_memory.c b/tools/testing/selftests/arm64/mte/check_child_memory.c
> index 97bebdecd29e..43bd94f853ba 100644
> --- a/tools/testing/selftests/arm64/mte/check_child_memory.c
> +++ b/tools/testing/selftests/arm64/mte/check_child_memory.c
> @@ -163,6 +163,9 @@ int main(int argc, char *argv[])
>   	mte_register_signal(SIGSEGV, mte_default_handler);
>   	mte_register_signal(SIGBUS, mte_default_handler);
>   
> +	/* Set test plan */
> +	ksft_set_plan(12);
> +
>   	evaluate_test(check_child_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE),
>   		"Check child anonymous memory with private mapping, precise mode and mmap memory\n");
>   	evaluate_test(check_child_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_SHARED),
> 
