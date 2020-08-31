Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4782A25751E
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHaIOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 04:14:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHaIOB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 04:14:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 814D531B;
        Mon, 31 Aug 2020 01:14:00 -0700 (PDT)
Received: from [10.57.6.112] (unknown [10.57.6.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E224F3F68F;
        Mon, 31 Aug 2020 01:13:57 -0700 (PDT)
Subject: Re: [PATCH 3/4] kselftests/arm64: add PAuth test for whether exec()
 changes keys
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-4-boyan.karatotev@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <e4169cc5-643b-67f1-5b19-c3265a341a8f@arm.com>
Date:   Mon, 31 Aug 2020 13:43:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200828131606.7946-4-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/28/20 6:46 PM, Boyan Karatotev wrote:
> Kernel documentation states that it will change PAuth keys on exec() calls.
> 
> Verify that all keys are correctly switched to new ones.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>

The changes look fine so,
Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

> ---
>   tools/testing/selftests/arm64/pauth/Makefile  |   4 +
>   .../selftests/arm64/pauth/exec_target.c       |  35 +++++
>   tools/testing/selftests/arm64/pauth/helper.h  |  10 ++
>   tools/testing/selftests/arm64/pauth/pac.c     | 148 ++++++++++++++++++
>   4 files changed, 197 insertions(+)
>   create mode 100644 tools/testing/selftests/arm64/pauth/exec_target.c
> 
> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
> index a017d1c8dd58..2e237b21ccf6 100644
> --- a/tools/testing/selftests/arm64/pauth/Makefile
> +++ b/tools/testing/selftests/arm64/pauth/Makefile
> @@ -5,6 +5,7 @@ CFLAGS += -mbranch-protection=pac-ret
>   
