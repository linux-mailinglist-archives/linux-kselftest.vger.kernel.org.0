Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6924943B90
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfFMPaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:06 -0400
Received: from foss.arm.com ([217.140.110.172]:38318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbfFMLRH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:17:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C33367;
        Thu, 13 Jun 2019 04:17:06 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EDF3F694;
        Thu, 13 Jun 2019 04:18:44 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:16:59 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control
 the tagged user addresses ABI
Message-ID: <20190613111659.GX28398@e103592.cambridge.arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
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

(A couple of comments I missed in my last reply:)

Name mismatch?

> +long set_tagged_addr_ctrl(unsigned long arg);
> +long get_tagged_addr_ctrl(void);
> +#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(arg)
> +#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl()
> +

[...]

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

So, tagging can actually be locked on by having a process enable it and
then some possibly unrelated process clearing tagged_addr_prctl_allowed.
That feels a bit weird.

Do we want to allow a process that has tagging on to be able to turn
it off at all?  Possibly things like CRIU might want to do that.

> +	if (is_compat_task())
> +		return -EINVAL;
> +	if (arg & ~PR_TAGGED_ADDR_ENABLE)
> +		return -EINVAL;

How do we expect this argument to be extended in the future?

I'm wondering whether this is really a bitmask or an enum, or a mixture
of the two.  Maybe it doesn't matter.

> +
> +	if (arg & PR_TAGGED_ADDR_ENABLE)
> +		set_thread_flag(TIF_TAGGED_ADDR);
> +	else
> +		clear_thread_flag(TIF_TAGGED_ADDR);

I think update_thread_flag() could be used here.

[...]

Cheers
---Dave
