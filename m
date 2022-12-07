Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110CB645F9A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 18:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiLGRHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 12:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGRHf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 12:07:35 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C930F654CC;
        Wed,  7 Dec 2022 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1670432847;
        bh=G0BsHsdboL62GAeZrE9/3v4SjnUS0OVkBTj5YWSHERI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z0Nnmg1qdSsWIw2lpWz58lE/xXLYDfy0d5fKUZ4Qi4aZz09IkQzK9616OTJ47uC8d
         Y3curH3gWXr3DrHwmByGPJm+7EA16BOAnBU1yfElHAr31g/APGAQCdJQ36xd6Lkbz4
         26SqIBnDHa29Ag7nhR/ErdXuT7HLIzqXBbAC4mUdrr+aPpfk9h30FGHNCoqgyGpIs9
         xBt+skfa6oMHQSG9yJdjIjFkWVmClfKtOj+/LXa4dIIbXgOh36bBKUp2oP7Wfv4rJx
         uQcrwnt9dwpCouZOw9Il8wI6H/uFd1ADSZZXzKSJWbsYYqfAyVAeRMXCY68UVEB/uB
         ZuRsoVQeOnSZQ==
Received: from [172.16.0.118] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NS3cb2w0kzZn1;
        Wed,  7 Dec 2022 12:07:27 -0500 (EST)
Message-ID: <843af7b5-8917-e9e3-de27-cb328f53fb70@efficios.com>
Date:   Wed, 7 Dec 2022 12:07:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] sched/membarrier: Introduce
 MEMBARRIER_CMD_GET_REGISTRATIONS
Content-Language: en-US
To:     Michal Clapinski <mclapinski@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20221207164338.1535591-1-mclapinski@google.com>
 <20221207164338.1535591-2-mclapinski@google.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20221207164338.1535591-2-mclapinski@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-12-07 11:43, Michal Clapinski wrote:
> Provide a method to query previously issued registrations.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>   include/uapi/linux/membarrier.h |  4 ++++
>   kernel/sched/membarrier.c       | 39 ++++++++++++++++++++++++++++++++-
>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
> index 737605897f36..5f3ad6d5be6f 100644
> --- a/include/uapi/linux/membarrier.h
> +++ b/include/uapi/linux/membarrier.h
> @@ -137,6 +137,9 @@
>    * @MEMBARRIER_CMD_SHARED:
>    *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
>    *                          header backward compatibility.
> + * @MEMBARRIER_CMD_GET_REGISTRATIONS:
> + *                          Returns a bitmask of previously issued
> + *                          registration commands.
>    *
>    * Command to be passed to the membarrier system call. The commands need to
>    * be a single bit each, except for MEMBARRIER_CMD_QUERY which is assigned to
> @@ -153,6 +156,7 @@ enum membarrier_cmd {
>   	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
>   	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
>   	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
> +	MEMBARRIER_CMD_GET_REGISTRATIONS			= (1 << 9),
>   
>   	/* Alias for header backward compatibility. */
>   	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 0c5be7ebb1dc..2ad881d07752 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -159,7 +159,8 @@
>   	| MEMBARRIER_CMD_PRIVATE_EXPEDITED				\
>   	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED			\
>   	| MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK		\
> -	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
> +	| MEMBARRIER_PRIVATE_EXPEDITED_RSEQ_BITMASK			\
> +	| MEMBARRIER_CMD_GET_REGISTRATIONS)
>   
>   static void ipi_mb(void *info)
>   {
> @@ -540,6 +541,40 @@ static int membarrier_register_private_expedited(int flags)
>   	return 0;
>   }
>   
> +static int membarrier_get_registrations(void)
> +{
> +	struct task_struct *p = current;
> +	struct mm_struct *mm = p->mm;
> +	int registrations_mask = 0, membarrier_state, i;
> +	static const int states[] = {
> +		MEMBARRIER_STATE_GLOBAL_EXPEDITED |
> +			MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,

What is the purpose of checking for the _READY state flag as well here ?

> +		MEMBARRIER_STATE_PRIVATE_EXPEDITED |
> +			MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
> +		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
> +			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
> +		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
> +			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
> +	};
> +	static const int registration_cmds[] = {
> +		MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
> +		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED,
> +		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
> +		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
> +	};
> +	BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
> +
> +	membarrier_state = atomic_read(&mm->membarrier_state);
> +	for (i = 0; i < ARRAY_SIZE(states); ++i) {
> +		if (membarrier_state & states[i]) {

The mask will match if either of the flags to match are set. Is that 
your intent ?

> +			registrations_mask |= registration_cmds[i];
> +			membarrier_state &= ~states[i];

So I understand that those _READY flags are there purely for making sure 
we clear the membarrier_state for validation that they have all been 
checked with the following WARN_ON_ONCE(). Am I on the right track ?

> +		}
> +	}
> +	WARN_ON_ONCE(membarrier_state != 0);

Thanks,

Mathieu

> +	return registrations_mask;
> +}
> +
>   /**
>    * sys_membarrier - issue memory barriers on a set of threads
>    * @cmd:    Takes command values defined in enum membarrier_cmd.
> @@ -623,6 +658,8 @@ SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
>   		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
>   	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
>   		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
> +	case MEMBARRIER_CMD_GET_REGISTRATIONS:
> +		return membarrier_get_registrations();
>   	default:
>   		return -EINVAL;
>   	}

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

