Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5F9749806
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjGFJLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjGFJLr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:11:47 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74561BD2;
        Thu,  6 Jul 2023 02:11:43 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 237FEFF810;
        Thu,  6 Jul 2023 09:11:37 +0000 (UTC)
Message-ID: <2084462d-b11d-7a48-3049-6bafbe81e7b4@ghiti.fr>
Date:   Thu, 6 Jul 2023 11:11:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v3 1/2] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705190002.384799-2-charlie@rivosinc.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230705190002.384799-2-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Charlie,


On 05/07/2023 20:59, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. The RISC-V specification enforces
> that bits outside of the virtual address range are not used, so
> restricting the size of the default address space as such should be
> temporary.


What do you mean in the last sentence above?


>   A hint address passed to mmap will cause the largest address
> space that fits entirely into the hint to be used. If the hint is less
> than or equal to 1<<38, an sv39 address will be used. An exception is
> that if the hint address is 0, then a sv48 address will be used.After
> an address space is completely full, the next smallest address space
> will be used.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/riscv/include/asm/elf.h       |  2 +-
>   arch/riscv/include/asm/pgtable.h   | 13 +++++++++++-
>   arch/riscv/include/asm/processor.h | 34 ++++++++++++++++++++++++------
>   3 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index 30e7d2455960..1b57f13a1afd 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>    * the loader.  We need to make sure that it is out of the way of the program
>    * that it will "exec", and that there is sufficient room for the brk.
>    */
> -#define ELF_ET_DYN_BASE		((TASK_SIZE / 3) * 2)
> +#define ELF_ET_DYN_BASE		((DEFAULT_MAP_WINDOW / 3) * 2)
>   
>   #ifdef CONFIG_64BIT
>   #ifdef CONFIG_COMPAT
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 75970ee2bda2..752e210c7547 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -57,18 +57,29 @@
>   #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
>   #endif
>   
> +
>   /*
>    * Roughly size the vmemmap space to be large enough to fit enough
>    * struct pages to map half the virtual address space. Then
>    * position vmemmap directly below the VMALLOC region.
>    */
>   #ifdef CONFIG_64BIT
> +#define VA_BITS_SV39 39
> +#define VA_BITS_SV48 48
> +#define VA_BITS_SV57 57
> +
> +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
> +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
> +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
> +
>   #define VA_BITS		(pgtable_l5_enabled ? \
> -				57 : (pgtable_l4_enabled ? 48 : 39))
> +				VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
>   #else
>   #define VA_BITS		32
>   #endif
>   
> +#define DEFAULT_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)


Maybe rename DEFAULT_VA_BITS into MMAP_VA_BITS? Or something similar?


> +
>   #define VMEMMAP_SHIFT \
>   	(VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>   #define VMEMMAP_SIZE	BIT(VMEMMAP_SHIFT)
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 94a0590c6971..468a1f4b9da4 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,20 +12,40 @@
>   
>   #include <asm/ptrace.h>
>   
> -/*
> - * This decides where the kernel will search for a free chunk of vm
> - * space during mmap's.
> - */
> -#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
> -
> -#define STACK_TOP		TASK_SIZE
>   #ifdef CONFIG_64BIT
> +#define DEFAULT_MAP_WINDOW	(UL(1) << (DEFAULT_VA_BITS - 1))
>   #define STACK_TOP_MAX		TASK_SIZE_64
> +
> +#define arch_get_mmap_end(addr, len, flags) \
> +	((addr) >= VA_USER_SV57 ? STACK_TOP_MAX :   \
> +	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
> +						 VA_USER_SV48 : \
> +						 VA_USER_SV39)
> +
> +#define arch_get_mmap_base(addr, base) \
> +	(((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) ?   \


So IIUC, a user must pass a hint larger than the max address of the mode 
the user wants right? Shouldn't the user rather pass an address that is 
larger than the previous mode? I mean if the user wants a 56-bit 
address, he should just pass an address above 1<<47 no?


> +		 VA_USER_SV57 - (DEFAULT_MAP_WINDOW - base) : \
> +	 ((((addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) ? \
> +		 VA_USER_SV48 - (DEFAULT_MAP_WINDOW - base) : \
> +	  (addr == 0) ? \
> +		 base : \
> +		 VA_USER_SV39 - (DEFAULT_MAP_WINDOW - base))
> +


Can you turn that into a function or use if/else statement? It's very 
hard to understand what happens there.

And riscv selects ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT which means the 
base is at the top of the address space (minus the stack IIRC). But if 
rlimit_stack is set to infinity (see mmap_base() 
https://elixir.bootlin.com/linux/latest/source/mm/util.c#L412), 
mmap_base is equal to TASK_UNMAPPED_BASE. Does that work in that case? 
It seems like this: VA_USER_SV39 - (DEFAULT_MAP_WINDOW - base)) would be 
negative right?

You should also add a rlimit test.


>   #else
> +#define DEFAULT_MAP_WINDOW	TASK_SIZE
>   #define STACK_TOP_MAX		TASK_SIZE
>   #endif
>   #define STACK_ALIGN		16
>   
> +
> +#define STACK_TOP		DEFAULT_MAP_WINDOW
> +
> +/*
> + * This decides where the kernel will search for a free chunk of vm
> + * space during mmap's.
> + */
> +#define TASK_UNMAPPED_BASE	PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
> +
>   #ifndef __ASSEMBLY__
>   
>   struct task_struct;
