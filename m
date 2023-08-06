Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7056377143F
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 11:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHFJyE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 05:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFJyD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 05:54:03 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B408199A;
        Sun,  6 Aug 2023 02:53:57 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0277240005;
        Sun,  6 Aug 2023 09:53:51 +0000 (UTC)
Message-ID: <4c692993-86ab-fdce-8c78-f676cf90e861@ghiti.fr>
Date:   Sun, 6 Aug 2023 11:53:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/4] RISC-V: mm: Restrict address space for
 sv39,sv48,sv57
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
References: <20230727212647.4182407-1-charlie@rivosinc.com>
 <20230727212647.4182407-2-charlie@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230727212647.4182407-2-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 27/07/2023 23:26, Charlie Jenkins wrote:
> Make sv48 the default address space for mmap as some applications
> currently depend on this assumption. A hint address passed to mmap will
> cause the largest address space that fits entirely into the hint to be
> used. If the hint is less than or equal to 1<<38, an sv39 address will
> be used. An exception is that if the hint address is 0, then a sv48
> address will be used. After an address space is completely full, the next
> smallest address space will be used.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   arch/riscv/include/asm/elf.h       |  2 +-
>   arch/riscv/include/asm/pgtable.h   | 20 +++++++++++-
>   arch/riscv/include/asm/processor.h | 52 ++++++++++++++++++++++++++----
>   3 files changed, 66 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index c24280774caf..5d3368d5585c 100644
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
> index 75970ee2bda2..c76a1ef094a4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -63,8 +63,26 @@
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
> +
> +#ifdef CONFIG_COMPAT
> +#define MMAP_VA_BITS_64 ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
> +#define MMAP_MIN_VA_BITS_64 ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)


Here the condition is always true right?


> +#define MMAP_VA_BITS (test_thread_flag(TIF_32BIT) ? 32 : MMAP_VA_BITS_64)
> +#define MMAP_MIN_VA_BITS (test_thread_flag(TIF_32BIT) ? 32 : MMAP_MIN_VA_BITS_64)


I think you should use is_compat_task() here instead of 
test_thread_flag(TIF_32BIT). And what about introducing VA_BITS_SV32 
instead of hardcoding 32?


> +#else
> +#define MMAP_VA_BITS ((VA_BITS >= VA_BITS_SV48) ? VA_BITS_SV48 : VA_BITS)
> +#define MMAP_MIN_VA_BITS ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)


Ditto here.


> +#endif
>   #else
>   #define VA_BITS		32
>   #endif
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index c950a8d9edef..e810244ea951 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,19 +13,59 @@
>   
>   #include <asm/ptrace.h>
>   
> +#ifdef CONFIG_64BIT
> +#define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> +#define STACK_TOP_MAX		TASK_SIZE_64
> +
> +#define arch_get_mmap_end(addr, len, flags)	\
> +({	\
> +	unsigned long mmap_end;	\
> +	typeof(addr) _addr = (addr); \
> +	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))) \
> +		mmap_end = DEFAULT_MAP_WINDOW;	\


Wouldn't that prevent a sv57 system to allocate sv57 addresses when sv48 
is full unless explicitly asked?


> +	else if ((_addr) >= VA_USER_SV57)	\
> +		mmap_end = STACK_TOP_MAX;	\
> +	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48))	\
> +		mmap_end = VA_USER_SV48;	\
> +	else	\
> +		mmap_end = VA_USER_SV39;	\
> +	mmap_end;	\
> +})
> +
> +#define arch_get_mmap_base(addr, base) \
> +({ \
> +	unsigned long mmap_base; \
> +	typeof(addr) _addr = (addr); \
> +	typeof(base) _base = (base); \
> +	unsigned long rnd_gap = (_base) - DEFAULT_MAP_WINDOW; \
> +	if ((_addr) == 0 || (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))) \
> +		mmap_base = (_base); \
> +	else if (((_addr) >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) \
> +		mmap_base = VA_USER_SV57 + rnd_gap; \


Shouldn't it be mmap_base = VA_USER_SV57 - rnd_gap?


> +	else if ((((_addr) >= VA_USER_SV48)) && (VA_BITS >= VA_BITS_SV48)) \
> +		mmap_base = VA_USER_SV48 + rnd_gap; \
> +	else \
> +		mmap_base = VA_USER_SV39 + rnd_gap; \
> +	mmap_base; \
> +})
> +
> +#else
> +#define DEFAULT_MAP_WINDOW	TASK_SIZE
> +#define STACK_TOP_MAX		TASK_SIZE
> +#endif
> +#define STACK_ALIGN		16
> +
> +#define STACK_TOP		DEFAULT_MAP_WINDOW
> +
>   /*
>    * This decides where the kernel will search for a free chunk of vm
>    * space during mmap's.
>    */
> -#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
> -
> -#define STACK_TOP		TASK_SIZE
>   #ifdef CONFIG_64BIT
> -#define STACK_TOP_MAX		TASK_SIZE_64
> +#define TASK_UNMAPPED_BASE	PAGE_ALIGN((UL(1) << MMAP_MIN_VA_BITS) / 3)
>   #else
> -#define STACK_TOP_MAX		TASK_SIZE
> +#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
>   #endif
> -#define STACK_ALIGN		16
>   
>   #ifndef __ASSEMBLY__
>   
