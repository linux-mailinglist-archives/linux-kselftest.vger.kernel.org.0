Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CC42939
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437890AbfFLOav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 10:30:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437584AbfFLOau (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 10:30:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7BE32B;
        Wed, 12 Jun 2019 07:30:49 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08D163F557;
        Wed, 12 Jun 2019 07:30:44 -0700 (PDT)
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <71ed41e2-47b8-3410-e759-21d972b7a33d@arm.com>
Date:   Wed, 12 Jun 2019 15:30:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/06/2019 12:43, Andrey Konovalov wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> It is not desirable to relax the ABI to allow tagged user addresses into
> the kernel indiscriminately. This patch introduces a prctl() interface
> for enabling or disabling the tagged ABI with a global sysctl control
> for preventing applications from enabling the relaxed ABI (meant for
> testing user-space prctl() return error checking without reconfiguring
> the kernel). The ABI properties are inherited by threads of the same
> application and fork()'ed children but cleared on execve().
> 
> The PR_SET_TAGGED_ADDR_CTRL will be expanded in the future to handle
> MTE-specific settings like imprecise vs precise exceptions.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/include/asm/processor.h   |  6 +++
>  arch/arm64/include/asm/thread_info.h |  1 +
>  arch/arm64/include/asm/uaccess.h     |  3 +-
>  arch/arm64/kernel/process.c          | 67 ++++++++++++++++++++++++++++
>  include/uapi/linux/prctl.h           |  5 +++
>  kernel/sys.c                         | 16 +++++++
>  6 files changed, 97 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fcd0e691b1ea..fee457456aa8 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -307,6 +307,12 @@ extern void __init minsigstksz_setup(void);
>  /* PR_PAC_RESET_KEYS prctl */
>  #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
>  
> +/* PR_TAGGED_ADDR prctl */
> +long set_tagged_addr_ctrl(unsigned long arg);
> +long get_tagged_addr_ctrl(void);
> +#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(arg)
> +#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl()
> +
>  /*
>   * For CONFIG_GCC_PLUGIN_STACKLEAK
>   *
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index f1d032be628a..354a31d2b737 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -99,6 +99,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_SVE			23	/* Scalable Vector Extension in use */
>  #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
>  #define TIF_SSBD		25	/* Wants SSB mitigation */
> +#define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index df729afca0ba..995b9ea11a89 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -73,7 +73,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>  	unsigned long ret, limit = current_thread_info()->addr_limit;
>  
> -	addr = untagged_addr(addr);
> +	if (test_thread_flag(TIF_TAGGED_ADDR))
> +		addr = untagged_addr(addr);
>  
>  	__chk_user_ptr(addr);
>  	asm volatile(
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 3767fb21a5b8..69d0be1fc708 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -30,6 +30,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/stddef.h>
> +#include <linux/sysctl.h>
>  #include <linux/unistd.h>
>  #include <linux/user.h>
>  #include <linux/delay.h>
> @@ -323,6 +324,7 @@ void flush_thread(void)
>  	fpsimd_flush_thread();
>  	tls_thread_flush();
>  	flush_ptrace_hw_breakpoint(current);
> +	clear_thread_flag(TIF_TAGGED_ADDR);
>  }
>  
>  void release_thread(struct task_struct *dead_task)
> @@ -552,3 +554,68 @@ void arch_setup_new_exec(void)
>  
>  	ptrauth_thread_init_user(current);
>  }
> +
> +/*
> + * Control the relaxed ABI allowing tagged user addresses into the kernel.
> + */
> +static unsigned int tagged_addr_prctl_allowed = 1;
> +
> +long set_tagged_addr_ctrl(unsigned long arg)
> +{
> +	if (!tagged_addr_prctl_allowed)
> +		return -EINVAL;
> +	if (is_compat_task())
> +		return -EINVAL;
> +	if (arg & ~PR_TAGGED_ADDR_ENABLE)
> +		return -EINVAL;
> +
> +	if (arg & PR_TAGGED_ADDR_ENABLE)
> +		set_thread_flag(TIF_TAGGED_ADDR);
> +	else
> +		clear_thread_flag(TIF_TAGGED_ADDR);
> +
> +	return 0;
> +}
> +
> +long get_tagged_addr_ctrl(void)
> +{
> +	if (!tagged_addr_prctl_allowed)
> +		return -EINVAL;
> +	if (is_compat_task())
> +		return -EINVAL;
> +
> +	if (test_thread_flag(TIF_TAGGED_ADDR))
> +		return PR_TAGGED_ADDR_ENABLE;
> +
> +	return 0;
> +}
> +
> +/*
> + * Global sysctl to disable the tagged user addresses support. This control
> + * only prevents the tagged address ABI enabling via prctl() and does not
> + * disable it for tasks that already opted in to the relaxed ABI.
> + */
> +static int zero;
> +static int one = 1;
> +
> +static struct ctl_table tagged_addr_sysctl_table[] = {
> +	{
> +		.procname	= "tagged_addr",
> +		.mode		= 0644,
> +		.data		= &tagged_addr_prctl_allowed,
> +		.maxlen		= sizeof(int),
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &zero,
> +		.extra2		= &one,
> +	},
> +	{ }
> +};
> +
> +static int __init tagged_addr_init(void)
> +{
> +	if (!register_sysctl("abi", tagged_addr_sysctl_table))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +core_initcall(tagged_addr_init);
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..2e927b3e9d6c 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,9 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY			(1UL << 3)
>  # define PR_PAC_APGAKEY			(1UL << 4)
>  
> +/* Tagged user address controls for arm64 */
> +#define PR_SET_TAGGED_ADDR_CTRL		55
> +#define PR_GET_TAGGED_ADDR_CTRL		56
> +# define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 2969304c29fe..ec48396b4943 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -124,6 +124,12 @@
>  #ifndef PAC_RESET_KEYS
>  # define PAC_RESET_KEYS(a, b)	(-EINVAL)
>  #endif
> +#ifndef SET_TAGGED_ADDR_CTRL
> +# define SET_TAGGED_ADDR_CTRL(a)	(-EINVAL)
> +#endif
> +#ifndef GET_TAGGED_ADDR_CTRL
> +# define GET_TAGGED_ADDR_CTRL()		(-EINVAL)
> +#endif
>  
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2492,6 +2498,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = PAC_RESET_KEYS(me, arg2);
>  		break;
> +	case PR_SET_TAGGED_ADDR_CTRL:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = SET_TAGGED_ADDR_CTRL(arg2);
> +		break;
> +	case PR_GET_TAGGED_ADDR_CTRL:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = GET_TAGGED_ADDR_CTRL();
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> 

-- 
Regards,
Vincenzo
