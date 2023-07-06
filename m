Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E225474A7EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 01:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGFX43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 19:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGFX42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 19:56:28 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD401BF0
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Jul 2023 16:56:26 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b06da65bdbso1234205fac.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jul 2023 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688687785; x=1691279785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PnXWtVOLq2cNUHw/WdqqgS2x7oe3d4wm7IeGzzcAThk=;
        b=ZD4lEGguRKey0FAO8caWLXptBsECybkX558kZshhYkCA38woYPQvWkd0WBAaUlMNCN
         zBkCzOD0lGaT85jx4VSyvXT41JpErfeo5NcZRZ+d/bfY78sWpYuO/3Y0HZsgSHj7K6Fu
         fBcI2/E0xUPwC6IR0AtH6ysQ0ORrXBIkky05oyOylCVgirYvVEuN/PYwp8d6vxXbvh5L
         l8XBj5nzLmKAELVl34SlsMBzO9iSvDTETRz7C87uJL3sSTVoU/UyV4DZZhG0bXKjuIZt
         Q/Wq19I36gFO7hplnDpuKkFOGsoPqyJ1xlr1rxFkrNiHch5lonpVY74rzkBQGh+iyHLm
         MWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688687785; x=1691279785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnXWtVOLq2cNUHw/WdqqgS2x7oe3d4wm7IeGzzcAThk=;
        b=L4trAQmP/h/YhsGp1bz2i1di+HdhBnpHNXZ+NLgxHduuuuzoOmyrJyF2g9TBbraA4z
         z9zwn8rmobXEfL+P5vPsgMGzfyzIVlpHbYSfiEaFB4Pr3P7lhvmQY5RE9REHPeWidCQp
         T0+YkcaZERuzyZQA2jgSJIlg2PmevCXX51DQEWh5N98z37SQTARHOOY9GrW43v/40oRV
         RROqIioQCtyi58fWzTYN0w8+wejvqouJVQY2eduCtStui17IO+5m86Ft+dJAl+1EpbOe
         ewy1kt9u6LdoB7jFftZ7WtQ4go0dITk6a/cpmaLUsgvBwQ2+xlY/JrNydVKC13WUxQ+c
         rYCw==
X-Gm-Message-State: ABy/qLbV3t+mfyn8EEF59kcevtDdo5Vv37YvESw4SKXV79HS8mh4S3Ge
        hrQjp0CkI5wDY9SRtWdspWiPMQ==
X-Google-Smtp-Source: APBJJlFNRSchbur5eT8fqD4aKEhWFuO8ec2dvOejYvABwuGPLReD8I2FksZLB3206k2OhsKjtcQ08g==
X-Received: by 2002:a05:6870:b625:b0:1b3:cd5c:d9ae with SMTP id cm37-20020a056870b62500b001b3cd5cd9aemr4165610oab.49.1688687785745;
        Thu, 06 Jul 2023 16:56:25 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b002639c4f81cesm367963pji.3.2023.07.06.16.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 16:56:25 -0700 (PDT)
Date:   Thu, 6 Jul 2023 16:56:23 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
Subject: Re: [RESEND PATCH v3 1/2] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
Message-ID: <ZKdUpzvyfy9f48MI@ghost>
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705190002.384799-2-charlie@rivosinc.com>
 <2084462d-b11d-7a48-3049-6bafbe81e7b4@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2084462d-b11d-7a48-3049-6bafbe81e7b4@ghiti.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 11:11:37AM +0200, Alexandre Ghiti wrote:
> Hi Charlie,
> 
> 
> On 05/07/2023 20:59, Charlie Jenkins wrote:
> > Make sv48 the default address space for mmap as some applications
> > currently depend on this assumption. The RISC-V specification enforces
> > that bits outside of the virtual address range are not used, so
> > restricting the size of the default address space as such should be
> > temporary.
> 
> 
> What do you mean in the last sentence above?
> 
Applications like Java and Go broke when sv57 was implemented because
they shove bits into the upper space of pointers. However riscv enforces
that all of the upper bits in the virtual address are equal to the most 
significant bit. "Temporary" may not have been the best word, but this change 
would be irrelevant if application developers were following this rule, if I
am understanding this requirement correctly. What this means to me is
that riscv hardware is not guaranteed to not discard the bits in the virtual 
address that are not used in paging.
> 
> >   A hint address passed to mmap will cause the largest address
> > space that fits entirely into the hint to be used. If the hint is less
> > than or equal to 1<<38, an sv39 address will be used. An exception is
> > that if the hint address is 0, then a sv48 address will be used.After
> > an address space is completely full, the next smallest address space
> > will be used.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >   arch/riscv/include/asm/elf.h       |  2 +-
> >   arch/riscv/include/asm/pgtable.h   | 13 +++++++++++-
> >   arch/riscv/include/asm/processor.h | 34 ++++++++++++++++++++++++------
> >   3 files changed, 40 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> > index 30e7d2455960..1b57f13a1afd 100644
> > --- a/arch/riscv/include/asm/elf.h
> > +++ b/arch/riscv/include/asm/elf.h
> > @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> >    * the loader.  We need to make sure that it is out of the way of the program
> >    * that it will "exec", and that there is sufficient room for the brk.
> >    */
> > -#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
> > +#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
> >   #ifdef CONFIG_64BIT
> >   #ifdef CONFIG_COMPAT
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 75970ee2bda2..752e210c7547 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -57,18 +57,29 @@
> >   #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
> >   #endif
> > +
> >   /*
> >    * Roughly size the vmemmap space to be large enough to fit enough
> >    * struct pages to map half the virtual address space. Then
> >    * position vmemmap directly below the VMALLOC region.
> >    */
> >   #ifdef CONFIG_64BIT
> > +#define VA_BITS_SV39 39
> > +#define VA_BITS_SV48 48
> > +#define VA_BITS_SV57 57
> > +
> > +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> > +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> > +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> > +
> >   #define VA_BITS		(pgtable_l5_enabled ? \
> > -				57 : (pgtable_l4_enabled ? 48 : 39))
> > +				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
> >   #else
> >   #define VA_BITS		32
> >   #endif
> > +#define DEFAULT_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
> 
> 
> Maybe rename DEFAULT_VA_BITS into MMAP_VA_BITS? Or something similar?
> 
> 
> > +
> >   #define VMEMMAP_SHIFT \
> >   	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
> >   #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index 94a0590c6971..468a1f4b9da4 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -12,20 +12,40 @@
> >   #include <asm/ptrace.h>
> > -/*
> > - * This decides where the kernel will search for a free chunk of vm
> > - * space during mmap's.
> > - */
> > -#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
> > -
> > -#define STACK_TOP		TASK_SIZE
> >   #ifdef CONFIG_64BIT
> > +#define DEFAULT_MAP_WINDOW	(UL(1) << (DEFAULT_VA_BITS - 1))
> >   #define STACK_TOP_MAX		TASK_SIZE_64
> > +
> > +#define arch_get_mmap_end(addr, len, flags) \
> > +	((addr) >= VA_USER_SV57 ? STACK_TOP_MAX :   \
> > +	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
> > +						 VA_USER_SV48 : \
> > +						 VA_USER_SV39)
> > +
> > +#define arch_get_mmap_base(addr, base) \
> > +	(((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) ?   \
> 
> 
> So IIUC, a user must pass a hint larger than the max address of the mode the
> user wants right? Shouldn't the user rather pass an address that is larger
> than the previous mode? I mean if the user wants a 56-bit address, he should
> just pass an address above 1<<47 no?
> 
The rationale is that the hint address provided to mmap should signify
all of the bits that the user is okay with being used for paging.
Meaning that if they pass in 1<<50, they are okay with the first 51 bits
being used in paging. The largest address space that fits within 51 bits
is sv48, so that will be used. To use sv57, 1<<56 or larger will need to
be used.
> 
> > +		 VA_USER_SV57 - (DEFAULT_MAP_WINDOW - base) : \
> > +	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
> > +		 VA_USER_SV48 - (DEFAULT_MAP_WINDOW - base) : \
> > +	  (addr == 0) ? \
> > +		 base : \
> > +		 VA_USER_SV39 - (DEFAULT_MAP_WINDOW - base))
> > +
> 
> 
> Can you turn that into a function or use if/else statement? It's very hard
> to understand what happens there.
> 
Yes, I can use statement expressions.
> And riscv selects ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT which means the base
> is at the top of the address space (minus the stack IIRC). But if
> rlimit_stack is set to infinity (see mmap_base()
> https://elixir.bootlin.com/linux/latest/source/mm/util.c#L412), mmap_base is
> equal to TASK_UNMAPPED_BASE. Does that work in that case? It seems like
> this: VA_USER_SV39 - (DEFAULT_MAP_WINDOW - base)) would be negative right?
> 
> You should also add a rlimit test.
> 
That is a good point. I think a better alternative will be to do 
base + (VA_USER_SV39 - DEFAULT_MAP_WINDOW). This will also work with the
other address spaces by swapping out the 39 with 48 and 57.
> 
> >   #else
> > +#define DEFAULT_MAP_WINDOW	TASK_SIZE
> >   #define STACK_TOP_MAX		TASK_SIZE
> >   #endif
> >   #define STACK_ALIGN		16
> > +
> > +#define STACK_TOP		DEFAULT_MAP_WINDOW
> > +
> > +/*
> > + * This decides where the kernel will search for a free chunk of vm
> > + * space during mmap's.
> > + */
> > +#define TASK_UNMAPPED_BASE	PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
> > +
> >   #ifndef __ASSEMBLY__
> >   struct task_struct;
