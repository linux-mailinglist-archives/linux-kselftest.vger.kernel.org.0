Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73CAB3D395
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbfFKRKD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 13:10:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46339 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfFKRJ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 13:09:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so5596218pgr.13
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2019 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4tN45q0D9pHywLWcDSI0MGipDR9BHLbNW3AKgfWrPoY=;
        b=RKRjOQ/CcWw8O0pNRp5OfIZbx3+kMO5Xos7WsX4RmawieoUisEZltkTlmO51etoV48
         IKQaXtgrrrpEX7AXiIp879yyFgZd7pb7jIil+r9xZmqJGjAnG6Bb//EZXFWhJHvT4gsi
         3h4TFpp7Q+OTbLfc69buJi7XbrHFI0uxOrBYItoZ06uu2zgpfg1jM9bCrvRMKW/Wt6z3
         o1WtPvtYPsD19PmHm9OLVZzgEUqysbbsmOYlRhPAXPpzcGCQn1e2t5tHXL5o4WnkjQur
         EZbXvxSdfxQ7VdBDDkMlYbEl4LmlEwuUK1oo/7WMSanbfmlIn6yCHNnKZLq2vpaNkIyW
         tDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tN45q0D9pHywLWcDSI0MGipDR9BHLbNW3AKgfWrPoY=;
        b=K0QzYYnFEvEoCjOPn/z9xnWTrBAl9FXJaKf7vE7367XfpUCiKeRhvp4SWhXlUYzTqU
         HwJZwsfFr7qo3WgD6ezTK0SvvBRV8pEZpTHRMqT74ELFeIe7LBLk/Sg0mnNCOFtELt6H
         xvCnAzaK/i4z5p/nlYuC/e2IZ9pyIIfuKoElIJuTavOpWtQkeqsi1bTCdeqrHalAyu+d
         0Zqv/tgM96txXGPOQuIjfXHOVlcSrWpQ8vN/O8zdCTauewqONG36qpDPL0XxONlP1bds
         8cu73N0nVc5BX0iPfG+r/63XR0QzMNg+poWn8NJmJwz1j/TrhRM54w5XuAins+6jjYwY
         FC+w==
X-Gm-Message-State: APjAAAUatSwf0+hMTS77kZqQ+UH9riECeS+D+OchM7wxvLCQb7RM4FXq
        vP0U2mpw1BOBVWbnvyThDruPqcl9BhqWsNA+84EYcQ==
X-Google-Smtp-Source: APXvYqxPNPG6zLFHjtM4dyk5+IsHprzo7Fpe7E2iITNY3Nfswb5d8bihSgIplM2GAJmG6XzIvzsXZh61I4tZiVJEP80=
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr6845324pje.129.1560272997822;
 Tue, 11 Jun 2019 10:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com> <20190611145720.GA63588@arrakis.emea.arm.com>
In-Reply-To: <20190611145720.GA63588@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 11 Jun 2019 19:09:46 +0200
Message-ID: <CAAeHK+z5nSOOaGfehETzznNcMq5E5U+Eb1rZE16UVsT8FWT0Vg@mail.gmail.com>
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 4:57 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> > On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index e5d5f31c6d36..9164ecb5feca 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> > >     return ret;
> > >  }
> > >
> > > -#define access_ok(addr, size)      __range_ok(addr, size)
> > > +#define access_ok(addr, size)      __range_ok(untagged_addr(addr), size)
> >
> > I'm going to propose an opt-in method here (RFC for now). We can't have
> > a check in untagged_addr() since this is already used throughout the
> > kernel for both user and kernel addresses (khwasan) but we can add one
> > in __range_ok(). The same prctl() option will be used for controlling
> > the precise/imprecise mode of MTE later on. We can use a TIF_ flag here
> > assuming that this will be called early on and any cloned thread will
> > inherit this.
>
> Updated patch, inlining it below. Once we agreed on the approach, I
> think Andrey can insert in in this series, probably after patch 2. The
> differences from the one I posted yesterday:
>
> - renamed PR_* macros together with get/set variants and the possibility
>   to disable the relaxed ABI
>
> - sysctl option - /proc/sys/abi/tagged_addr to disable the ABI globally
>   (just the prctl() opt-in, tasks already using it won't be affected)
>
> And, of course, it needs more testing.

Sure, I'll add it to the series.

Should I drop access_ok() change from my patch, since yours just reverts it?

Thanks!

>
> ---------8<----------------
> From 7c624777a4e545522dec1b34e60f0229cb2bd59f Mon Sep 17 00:00:00 2001
> From: Catalin Marinas <catalin.marinas@arm.com>
> Date: Tue, 11 Jun 2019 13:03:38 +0100
> Subject: [PATCH] arm64: Introduce prctl() options to control the tagged user
>  addresses ABI
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
>  arch/arm64/include/asm/uaccess.h     |  5 ++-
>  arch/arm64/kernel/process.c          | 67 ++++++++++++++++++++++++++++
>  include/uapi/linux/prctl.h           |  5 +++
>  kernel/sys.c                         | 16 +++++++
>  6 files changed, 99 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fcd0e691b1ea..fee457456aa8 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -307,6 +307,12 @@ extern void __init minsigstksz_setup(void);
>  /* PR_PAC_RESET_KEYS prctl */
>  #define PAC_RESET_KEYS(tsk, arg)       ptrauth_prctl_reset_keys(tsk, arg)
>
> +/* PR_TAGGED_ADDR prctl */
> +long set_tagged_addr_ctrl(unsigned long arg);
> +long get_tagged_addr_ctrl(void);
> +#define SET_TAGGED_ADDR_CTRL(arg)      set_tagged_addr_ctrl(arg)
> +#define GET_TAGGED_ADDR_CTRL()         get_tagged_addr_ctrl()
> +
>  /*
>   * For CONFIG_GCC_PLUGIN_STACKLEAK
>   *
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index c285d1ce7186..7263d4c973ce 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -101,6 +101,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_SVE                        23      /* Scalable Vector Extension in use */
>  #define TIF_SVE_VL_INHERIT     24      /* Inherit sve_vl_onexec across exec */
>  #define TIF_SSBD               25      /* Wants SSB mitigation */
> +#define TIF_TAGGED_ADDR                26
>
>  #define _TIF_SIGPENDING                (1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 9164ecb5feca..995b9ea11a89 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -73,6 +73,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>         unsigned long ret, limit = current_thread_info()->addr_limit;
>
> +       if (test_thread_flag(TIF_TAGGED_ADDR))
> +               addr = untagged_addr(addr);
> +
>         __chk_user_ptr(addr);
>         asm volatile(
>         // A + B <= C + 1 for all A,B,C, in four easy steps:
> @@ -94,7 +97,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>         return ret;
>  }
>
> -#define access_ok(addr, size)  __range_ok(untagged_addr(addr), size)
> +#define access_ok(addr, size)  __range_ok(addr, size)
>  #define user_addr_max                  get_fs
>
>  #define _ASM_EXTABLE(from, to)                                         \
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
>         fpsimd_flush_thread();
>         tls_thread_flush();
>         flush_ptrace_hw_breakpoint(current);
> +       clear_thread_flag(TIF_TAGGED_ADDR);
>  }
>
>  void release_thread(struct task_struct *dead_task)
> @@ -552,3 +554,68 @@ void arch_setup_new_exec(void)
>
>         ptrauth_thread_init_user(current);
>  }
> +
> +/*
> + * Control the relaxed ABI allowing tagged user addresses into the kernel.
> + */
> +static unsigned int tagged_addr_prctl_allowed = 1;
> +
> +long set_tagged_addr_ctrl(unsigned long arg)
> +{
> +       if (!tagged_addr_prctl_allowed)
> +               return -EINVAL;
> +       if (is_compat_task())
> +               return -EINVAL;
> +       if (arg & ~PR_TAGGED_ADDR_ENABLE)
> +               return -EINVAL;
> +
> +       if (arg & PR_TAGGED_ADDR_ENABLE)
> +               set_thread_flag(TIF_TAGGED_ADDR);
> +       else
> +               clear_thread_flag(TIF_TAGGED_ADDR);
> +
> +       return 0;
> +}
> +
> +long get_tagged_addr_ctrl(void)
> +{
> +       if (!tagged_addr_prctl_allowed)
> +               return -EINVAL;
> +       if (is_compat_task())
> +               return -EINVAL;
> +
> +       if (test_thread_flag(TIF_TAGGED_ADDR))
> +               return PR_TAGGED_ADDR_ENABLE;
> +
> +       return 0;
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
> +       {
> +               .procname       = "tagged_addr",
> +               .mode           = 0644,
> +               .data           = &tagged_addr_prctl_allowed,
> +               .maxlen         = sizeof(int),
> +               .proc_handler   = proc_dointvec_minmax,
> +               .extra1         = &zero,
> +               .extra2         = &one,
> +       },
> +       { }
> +};
> +
> +static int __init tagged_addr_init(void)
> +{
> +       if (!register_sysctl("abi", tagged_addr_sysctl_table))
> +               return -EINVAL;
> +       return 0;
> +}
> +
> +core_initcall(tagged_addr_init);
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 094bb03b9cc2..2e927b3e9d6c 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -229,4 +229,9 @@ struct prctl_mm_map {
>  # define PR_PAC_APDBKEY                        (1UL << 3)
>  # define PR_PAC_APGAKEY                        (1UL << 4)
>
> +/* Tagged user address controls for arm64 */
> +#define PR_SET_TAGGED_ADDR_CTRL                55
> +#define PR_GET_TAGGED_ADDR_CTRL                56
> +# define PR_TAGGED_ADDR_ENABLE         (1UL << 0)
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 2969304c29fe..ec48396b4943 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -124,6 +124,12 @@
>  #ifndef PAC_RESET_KEYS
>  # define PAC_RESET_KEYS(a, b)  (-EINVAL)
>  #endif
> +#ifndef SET_TAGGED_ADDR_CTRL
> +# define SET_TAGGED_ADDR_CTRL(a)       (-EINVAL)
> +#endif
> +#ifndef GET_TAGGED_ADDR_CTRL
> +# define GET_TAGGED_ADDR_CTRL()                (-EINVAL)
> +#endif
>
>  /*
>   * this is where the system-wide overflow UID and GID are defined, for
> @@ -2492,6 +2498,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                         return -EINVAL;
>                 error = PAC_RESET_KEYS(me, arg2);
>                 break;
> +       case PR_SET_TAGGED_ADDR_CTRL:
> +               if (arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error = SET_TAGGED_ADDR_CTRL(arg2);
> +               break;
> +       case PR_GET_TAGGED_ADDR_CTRL:
> +               if (arg2 || arg3 || arg4 || arg5)
> +                       return -EINVAL;
> +               error = GET_TAGGED_ADDR_CTRL();
> +               break;
>         default:
>                 error = -EINVAL;
>                 break;
