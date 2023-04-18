Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19A36E5E54
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 12:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDRKLN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 06:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDRKLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D9593AA0;
        Tue, 18 Apr 2023 03:10:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25119168F;
        Tue, 18 Apr 2023 03:11:32 -0700 (PDT)
Received: from [192.168.4.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43FFF3F587;
        Tue, 18 Apr 2023 03:10:47 -0700 (PDT)
Message-ID: <20487c94-7f81-cbf5-7136-c7f266eaf60d@arm.com>
Date:   Tue, 18 Apr 2023 11:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] kselftest: vDSO: Fix accumulation of uninitialized ret
 when CLOCK_REALTIME is undefined
To:     Colin Ian King <colin.i.king@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417104743.30018-1-colin.i.king@gmail.com>
Content-Language: en-US
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20230417104743.30018-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Colin,

On 4/17/23 11:47, Colin Ian King wrote:
> In the unlikely case that CLOCK_REALTIME is not defined, variable ret is
> not initialized and further accumulation of return values to ret can leave
> ret in an undefined state. Fix this by initialized ret to zero and changing
> the assignment of ret to an accumulation for the CLOCK_REALTIME case.
> 

I was wondering how did you find this.

Apart that:

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Fixes: 03f55c7952c9 ("kselftest: Extend vDSO selftest to clock_getres")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> index 15dcee16ff72..38d46a8bf7cb 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> @@ -84,12 +84,12 @@ static inline int vdso_test_clock(unsigned int clock_id)
>  
>  int main(int argc, char **argv)
>  {
> -	int ret;
> +	int ret = 0;
>  
>  #if _POSIX_TIMERS > 0
>  
>  #ifdef CLOCK_REALTIME
> -	ret = vdso_test_clock(CLOCK_REALTIME);
> +	ret += vdso_test_clock(CLOCK_REALTIME);
>  #endif
>  
>  #ifdef CLOCK_BOOTTIME

-- 
Regards,
Vincenzo
