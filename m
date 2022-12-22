Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4524654453
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 16:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiLVP2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 10:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiLVP2F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 10:28:05 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B026166;
        Thu, 22 Dec 2022 07:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671722883;
        bh=rpA44R7emjI1qfvYw5PNQuISdxrQHVVRQfHfzR8tV+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XtKGHoWZPqL/uWvKgIGwBbfsliUlaqCaZKBwUAxvR4ETlyzVenEeU/R1uNZNpBii9
         qt0qqcVZsOeeaSdvOvPyz/sBdsp/7umSMIt0ngwu3st2G9kyg/Xm9LKSH8bZet40Pv
         /9GendsgWKLq86hoZTOuRbByW239ktBrf80ho4iYrxX3jf1PrgMd7lMdmpHrbjkLfx
         wP/sVDAqtdNvYXXCIUWwSH6hzO0FadaI4sia24RPwdy5dx2fF9m1rwF8lZqszlnI9l
         Xg3eiak7cAuhU2rwV/r0UCJlork92zX9rbBwLPyq4qkTsoOG1tkNI10+d6X0wY/vCM
         LcR+N0DOyvc3Q==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NdDhz57syzc1J;
        Thu, 22 Dec 2022 10:28:03 -0500 (EST)
Message-ID: <9fad5641-ebd4-d2e5-6f87-2c409c336072@efficios.com>
Date:   Thu, 22 Dec 2022 10:28:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/2] sched/membarrier, selftests: Introduce
 MEMBARRIER_CMD_GET_REGISTRATIONS
Content-Language: en-US
To:     Michal Clapinski <mclapinski@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20221207164338.1535591-1-mclapinski@google.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221207164338.1535591-1-mclapinski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-12-07 11:43, Michal Clapinski wrote:
> This change provides a method to query previously issued registrations.
> It's needed for CRIU (checkpoint/restore in userspace). Before this
> change we had to issue private membarrier commands during checkpoint -
> if they succeeded, they must have been registered. Unfortunately global
> membarrier succeeds even on unregistered processes, so there was no way to
> tell if MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED had been issued or not.
> 
> CRIU is run after the process has been frozen with ptrace, so we don't
> have to worry too much about the result of running this command in parallel
> with registration commands.

Peter, Paul, I'm OK with the proposed changes. Should we route this 
through sched/core from the tip tree ?

For both patches:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> Michal Clapinski (2):
>    sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS
>    selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS
> 
>   include/uapi/linux/membarrier.h               |  4 ++
>   kernel/sched/membarrier.c                     | 39 ++++++++++++++++++-
>   .../membarrier/membarrier_test_impl.h         | 33 ++++++++++++++++
>   .../membarrier/membarrier_test_multi_thread.c |  2 +-
>   .../membarrier_test_single_thread.c           |  6 ++-
>   5 files changed, 81 insertions(+), 3 deletions(-)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

