Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC4579FA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 15:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiGSN3K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 09:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238304AbiGSN2y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 09:28:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 623B785FA8
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 05:45:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB9D3153B;
        Tue, 19 Jul 2022 05:45:01 -0700 (PDT)
Received: from [10.163.76.194] (unknown [10.163.76.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D46E3F766;
        Tue, 19 Jul 2022 05:45:00 -0700 (PDT)
Message-ID: <956f35b0-3774-3b79-5413-903ce1d6728f@arm.com>
Date:   Tue, 19 Jul 2022 18:14:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] kselftest/arm64: Add utilities and a test to
 validate mte memory
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kselftest@vger.kernel.org
References: <YtVykH0CIFM9bw2E@kili>
From:   Amit Kachhap <amit.kachhap@arm.com>
In-Reply-To: <YtVykH0CIFM9bw2E@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 7/18/22 20:17, Dan Carpenter wrote:
> Hello Amit Daniel Kachhap,
> 
> The patch e9b60476bea0: "kselftest/arm64: Add utilities and a test to
> validate mte memory" from Oct 2, 2020, leads to the following Smatch
> static checker warning:
> 
> 	./tools/testing/selftests/arm64/mte/mte_common_util.c:336 mte_default_setup()
> 	warn: bitwise AND condition is false here
> 
> ./tools/testing/selftests/arm64/mte/mte_common_util.c
>      316 int mte_default_setup(void)
>      317 {
>      318         unsigned long hwcaps2 = getauxval(AT_HWCAP2);
>      319         unsigned long en = 0;
>      320         int ret;
>      321
>      322         if (!(hwcaps2 & HWCAP2_MTE)) {
>      323                 ksft_print_msg("SKIP: MTE features unavailable\n");
>      324                 return KSFT_SKIP;
>      325         }
>      326         /* Get current mte mode */
>      327         ret = prctl(PR_GET_TAGGED_ADDR_CTRL, en, 0, 0, 0);
>      328         if (ret < 0) {
>      329                 ksft_print_msg("FAIL:prctl PR_GET_TAGGED_ADDR_CTRL with error =%d\n", ret);
>      330                 return KSFT_FAIL;
>      331         }
>      332         if (ret & PR_MTE_TCF_SYNC)
>      333                 mte_cur_mode = MTE_SYNC_ERR;
>      334         else if (ret & PR_MTE_TCF_ASYNC)
>      335                 mte_cur_mode = MTE_ASYNC_ERR;
> --> 336         else if (ret & PR_MTE_TCF_NONE)
> 
> It looks like the intent was to make PR_MTE_TCF_NONE into an ifdef
> configurable thing but that never happened?

Thanks for pointing this out. I will send the proper fix with
the Reported bys .

Regards,
Amit
> 
>      337                 mte_cur_mode = MTE_NONE_ERR;
>      338
>      339         mte_cur_pstate_tco = mte_get_pstate_tco();
>      340         /* Disable PSTATE.TCO */
>      341         mte_disable_pstate_tco();
>      342         return 0;
>      343 }
> 
> regards,
> dan carpenter
