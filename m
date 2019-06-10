Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72C523BBA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2019 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbfFJSHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jun 2019 14:07:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42393 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388052AbfFJSHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jun 2019 14:07:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so2844646pgh.9
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2019 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qk1teTE+M+IujpCJ4fnOYjeYPWGwjvW8JXrxo/yH0Jc=;
        b=bS38Kka2lRnznRWhG8/qOGDxKjllgWQ6UMeG3F2amaGnqe8pK0xiGk3vZdBB3YxIb3
         SWpAwEtE9q/WxIcVXvPngtzttAwOIVkoldUG9+Ng+5o+FvKdQZW1HjakB3VBQBFOd4GH
         8QDt5M3wpL9e9LGdgrn8sofUH/zfBbAJ6Uge8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qk1teTE+M+IujpCJ4fnOYjeYPWGwjvW8JXrxo/yH0Jc=;
        b=RARTqDGGu+5KfqtIwdd+9h7hEOHxk2YPWM7FSD4N456vzORyjcrum/srhFjdTuV5ei
         PwRmTkEKlpcH5ETY20TIr35rUCcHWXpxmV7dU7Q6JGomUFIJYcsJdWpczhs3yuZk4XK9
         jt2uo9CFNBWhwUO+9a+W5LiJ8GeamxU+vDGr5ygclfjYLxewWt+KSflF9qUYLuuMb7iG
         fhI5Lxk2mrZxqaqINw7xK+7qjoCVHsi3Hz9k8v8enGyMP0o7S9ak5TZ38k33uyEPnue7
         1QdVbci9BNa3gAiOpucRbWjisMUrk6JpFzJaC8JdaSx7vUkwOu3uFgHsn9nWtUppuX8I
         p7IA==
X-Gm-Message-State: APjAAAXL1PFYdqA2t+tFspYNZqKVMPNJHnCGv//lNcGFOX2rXHmHX3M7
        8ancH8aVxpSXdj+cfnrY4+nYaQ==
X-Google-Smtp-Source: APXvYqwpdKpmgyrcHoPqfm2kAKseftWNyRK4QJdbz1OaJAD6dgVCG3NHvWUoe0J25QMfVAkrE6hAGQ==
X-Received: by 2002:a65:6104:: with SMTP id z4mr16749806pgu.319.1560190025622;
        Mon, 10 Jun 2019 11:07:05 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x7sm11154611pfm.82.2019.06.10.11.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 11:07:04 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:07:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v16 02/16] arm64: untag user pointers in access_ok and
 __uaccess_mask_ptr
Message-ID: <201906101106.3CA50745E3@keescook>
References: <cover.1559580831.git.andreyknvl@google.com>
 <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
 <20190610175326.GC25803@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610175326.GC25803@arrakis.emea.arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 10, 2019 at 06:53:27PM +0100, Catalin Marinas wrote:
> On Mon, Jun 03, 2019 at 06:55:04PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index e5d5f31c6d36..9164ecb5feca 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
> >  	return ret;
> >  }
> >  
> > -#define access_ok(addr, size)	__range_ok(addr, size)
> > +#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
> 
> I'm going to propose an opt-in method here (RFC for now). We can't have
> a check in untagged_addr() since this is already used throughout the
> kernel for both user and kernel addresses (khwasan) but we can add one
> in __range_ok(). The same prctl() option will be used for controlling
> the precise/imprecise mode of MTE later on. We can use a TIF_ flag here
> assuming that this will be called early on and any cloned thread will
> inherit this.
> 
> Anyway, it's easier to paste some diff than explain but Vincenzo can
> fold them into his ABI patches that should really go together with
> these. I added a couple of MTE definitions for prctl() as an example,
> not used currently:
> 
> ------------------8<---------------------------------------------
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index fcd0e691b1ea..2d4cb7e4edab 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -307,6 +307,10 @@ extern void __init minsigstksz_setup(void);
>  /* PR_PAC_RESET_KEYS prctl */
>  #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
>  
> +/* PR_UNTAGGED_UADDR prctl */
> +int untagged_uaddr_set_mode(unsigned long arg);
> +#define SET_UNTAGGED_UADDR_MODE(arg)	untagged_uaddr_set_mode(arg)
> +
>  /*
>   * For CONFIG_GCC_PLUGIN_STACKLEAK
>   *
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index c285d1ce7186..89ce77773c49 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -101,6 +101,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_SVE			23	/* Scalable Vector Extension in use */
>  #define TIF_SVE_VL_INHERIT	24	/* Inherit sve_vl_onexec across exec */
>  #define TIF_SSBD		25	/* Wants SSB mitigation */
> +#define TIF_UNTAGGED_UADDR	26
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> @@ -116,6 +117,7 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  #define _TIF_SVE		(1 << TIF_SVE)
> +#define _TIF_UNTAGGED_UADDR	(1 << TIF_UNTAGGED_UADDR)
>  
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 9164ecb5feca..54f5bbaebbc4 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -73,6 +73,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  {
>  	unsigned long ret, limit = current_thread_info()->addr_limit;
>  
> +	if (test_thread_flag(TIF_UNTAGGED_UADDR))
> +		addr = untagged_addr(addr);
> +
>  	__chk_user_ptr(addr);
>  	asm volatile(
>  	// A + B <= C + 1 for all A,B,C, in four easy steps:
> @@ -94,7 +97,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  	return ret;
>  }
>  
> -#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
> +#define access_ok(addr, size)	__range_ok(addr, size)
>  #define user_addr_max			get_fs
>  
>  #define _ASM_EXTABLE(from, to)						\
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 3767fb21a5b8..fd191c5b92aa 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -552,3 +552,18 @@ void arch_setup_new_exec(void)
>  
>  	ptrauth_thread_init_user(current);
>  }
> +
> +/*
> + * Enable the relaxed ABI allowing tagged user addresses into the kernel.
> + */
> +int untagged_uaddr_set_mode(unsigned long arg)
> +{
> +	if (is_compat_task())
> +		return -ENOTSUPP;
> +	if (arg)
> +		return -EINVAL;
> +
> +	set_thread_flag(TIF_UNTAGGED_UADDR);
> +
> +	return 0;
> +}

I think this should be paired with a flag clearing in copy_thread(),
yes? (i.e. each binary needs to opt in)

-- 
Kees Cook
