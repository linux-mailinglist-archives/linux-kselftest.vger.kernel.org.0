Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C77406DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 01:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjF0Xga (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 19:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjF0Xg3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 19:36:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E31FE5
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 16:36:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so1986849b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jun 2023 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687908987; x=1690500987;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2rRQjfAZRzBn1nTw9Qlx1rA3+sWwdfIHKIFqPq0xFE=;
        b=VmLbCzwx/HSoM66HuTJRlxp+eH3F/CACkgqayPBT7iQGdd9ftT4it4u3IXuZ45YA9y
         PlyzaOac4w1TOx6l2cS8MMY4pJU6lSiny/PNVXgY09O3tr7Hs9jv/0RLAncggAdz2U+e
         w6tDlJS2VEKVxucr7TKaE6ieRtzZy0ycZr+wtkHSU9bbEU9gxWIXF/tfCoyW7/c0DNHB
         2JP2eMlPEWwY8r0c7bIlGuiaVM1OBIVGxMkXKvoXkPKldhiN9vp57zcm73d75P4a0ic8
         T6jJkp/2jHnC8+MKCZjwWJ6xp/n4DIPBsxV9FKbM7yNklPqo6Mb2pXb5U8raJ06KDeez
         14lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687908987; x=1690500987;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2rRQjfAZRzBn1nTw9Qlx1rA3+sWwdfIHKIFqPq0xFE=;
        b=h1N4/6m2Cw93mqg8VNSSH6LlquTAyHIC0WtNNqs2sG9p9YRQ6PhA4rcA61UQ7wX0yd
         A7Yi5KQIwbdmw8gBPtWHjE8edsZdBPc9Me1kX8/WeIe43qO1A7mTU6wOjHSNY28tx80M
         NpVRoutqNljXpz+fubVYp+WmDvLAJc50JaiC7HMGkuFbanbtbcUy1/nQ9KwIi3n41wZL
         nVNDHMlUPNtZgpdwELaIP7RJY5m5hoAlG0TYaC66ISrUf1YkpgLDcm3mGMNLSQ7qnFAn
         wGLYDgHoaBc+3NkF7gIKeghFV705aX1FCbZmrZzgYydDPRLEUnRSY0Og322XPRWkoG26
         0RDw==
X-Gm-Message-State: AC+VfDw/3LolfoE0MoyWDL1DJOHRkdq9+tVNMiQxHipMiliSblCk64hX
        C/ROZQNdoeFpi7B43k3Ri9MMcA==
X-Google-Smtp-Source: ACHHUZ4ASNbeSGa3QRS2GbFuqbk5/0ZIWBTCzbjCARoIuFpZc5CiyZq3f2M3TQpRLYC3On5tc6h1kQ==
X-Received: by 2002:a05:6a00:2394:b0:668:73f5:dce0 with SMTP id f20-20020a056a00239400b0066873f5dce0mr22062433pfc.29.1687908987263;
        Tue, 27 Jun 2023 16:36:27 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id v1-20020a634641000000b00548fb73874asm6110698pgk.37.2023.06.27.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 16:36:26 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:36:26 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Jun 2023 16:36:24 PDT (-0700)
Subject:     Re: [PATCH 1/2] RISC-V: mm: Restrict address space for sv39,sv48,sv57
In-Reply-To: <473F7474-D7AA-4C9F-95A3-320F1741EC50@jrtc27.com>
CC:     charlie@rivosinc.com, alexghiti@rivosinc.com,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Bjorn Topel <bjorn@rivosinc.com>,
        anup@brainfault.org, Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, konstantin@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     jrtc27@jrtc27.com
Message-ID: <mhng-7914c1d2-d671-4cc4-ba90-f85acb7c8b50@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 27 Jun 2023 15:32:36 PDT (-0700), jrtc27@jrtc27.com wrote:
> On 27 Jun 2023, at 23:21, Charlie Jenkins <charlie@rivosinc.com> wrote:
>> 
>> Make sv39 the default address space for mmap as some applications
>> currently depend on this assumption.
>
> They are just plain wrong too. Sv48 was in even Priv v1.10 (the first
> spec where satp was named as such and contained the mode, rather than
> requiring M-mode’s help in configuring virtual memory), predating the
> ratified v1.11 spec. A 39-bit address space is pathetic and has
> implications for ASLR.
>
> I strongly suggest applications be forced to support at least Sv48,
> which is totally reasonable given the address space sizes used by other
> architectures. Sv57 is more disruptive to some runtimes, though ideally
> even that would be free for the kernel to use rather than committing to
> not using it for the default uABI.

Go and OpenJDK both broke when we expanded the VA width.  I don't like 
it either, but if the change breaks userspace then it's a regression and 
we have to live with the bug.

> Jess
>
>> The RISC-V specification enforces
>> that bits outside of the virtual address range are not used, so
>> restricting the size of the default address space as such should be
>> temporary. A hint address passed to mmap will cause the largest address
>> space that fits entirely into the hint to be used. If the hint is less
>> than or equal to 1<<38, a 39-bit address will be used. After an address
>> space is completely full, the next smallest address space will be used.
>> 
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> ---
>> arch/riscv/include/asm/elf.h       |  2 +-
>> arch/riscv/include/asm/pgtable.h   | 13 +++++++++-
>> arch/riscv/include/asm/processor.h | 41 +++++++++++++++++++++++++-----
>> 3 files changed, 47 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
>> index 30e7d2455960..1b57f13a1afd 100644
>> --- a/arch/riscv/include/asm/elf.h
>> +++ b/arch/riscv/include/asm/elf.h
>> @@ -49,7 +49,7 @@ extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
>>  * the loader.  We need to make sure that it is out of the way of the program
>>  * that it will "exec", and that there is sufficient room for the brk.
>>  */
>> -#define ELF_ET_DYN_BASE ((TASK_SIZE / 3) * 2)
>> +#define ELF_ET_DYN_BASE ((DEFAULT_MAP_WINDOW / 3) * 2)
>> 
>> #ifdef CONFIG_64BIT
>> #ifdef CONFIG_COMPAT
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 75970ee2bda2..e83912e97870 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -57,18 +57,29 @@
>> #define MODULES_END (PFN_ALIGN((unsigned long)&_start))
>> #endif
>> 
>> +
>> /*
>>  * Roughly size the vmemmap space to be large enough to fit enough
>>  * struct pages to map half the virtual address space. Then
>>  * position vmemmap directly below the VMALLOC region.
>>  */
>> #ifdef CONFIG_64BIT
>> +#define VA_BITS_SV39 39
>> +#define VA_BITS_SV48 48
>> +#define VA_BITS_SV57 57
>> +
>> +#define VA_USER_SV39 (UL(1) << (VA_BITS_SV39 - 1))
>> +#define VA_USER_SV48 (UL(1) << (VA_BITS_SV48 - 1))
>> +#define VA_USER_SV57 (UL(1) << (VA_BITS_SV57 - 1))
>> +
>> #define VA_BITS (pgtable_l5_enabled ? \
>> - 57 : (pgtable_l4_enabled ? 48 : 39))
>> + VA_BITS_SV57 : (pgtable_l4_enabled ? VA_BITS_SV48 : VA_BITS_SV39))
>> #else
>> #define VA_BITS 32
>> #endif
>> 
>> +#define DEFAULT_VA_BITS ((VA_BITS >= VA_BITS_SV39) ? VA_BITS_SV39 : VA_BITS)
>> +
>> #define VMEMMAP_SHIFT \
>> (VA_BITS - PAGE_SHIFT - 1 + STRUCT_PAGE_MAX_SHIFT)
>> #define VMEMMAP_SIZE BIT(VMEMMAP_SHIFT)
>> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
>> index 6fb8bbec8459..019dcd4ecae4 100644
>> --- a/arch/riscv/include/asm/processor.h
>> +++ b/arch/riscv/include/asm/processor.h
>> @@ -12,20 +12,47 @@
>> 
>> #include <asm/ptrace.h>
>> 
>> -/*
>> - * This decides where the kernel will search for a free chunk of vm
>> - * space during mmap's.
>> - */
>> -#define TASK_UNMAPPED_BASE PAGE_ALIGN(TASK_SIZE / 3)
>> -
>> -#define STACK_TOP TASK_SIZE
>> #ifdef CONFIG_64BIT
>> +#define DEFAULT_MAP_WINDOW (UL(1) << (DEFAULT_VA_BITS - 1))
>> #define STACK_TOP_MAX TASK_SIZE_64
>> +
>> +#define arch_get_mmap_end(addr, len, flags) \
>> + ((addr) == 0 || (addr) >= VA_USER_SV57 ? STACK_TOP_MAX :   \
>> + (((addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) ? \
>> + VA_USER_SV48 : \
>> + VA_USER_SV39)
>> +
>> +#define arch_get_mmap_base(addr, base) \
>> + (((addr >= VA_USER_SV57) && (VA_BITS >= VA_BITS_SV57)) ?   \
>> + base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
>> + (((addr) >= VA_USER_SV48) && (VA_BITS >= VA_BITS_SV48)) ? \
>> + base + VA_USER_SV48 - DEFAULT_MAP_WINDOW : \
>> + base)
>> +
>> #else
>> +#define DEFAULT_MAP_WINDOW TASK_SIZE
>> #define STACK_TOP_MAX TASK_SIZE
>> +
>> +#define arch_get_mmap_end(addr, len, flags) \
>> + ((addr) > DEFAULT_MAP_WINDOW ? STACK_TOP_MAX : DEFAULT_MAP_WINDOW)
>> +
>> +#define arch_get_mmap_base(addr, base) \
>> + ((addr > DEFAULT_MAP_WINDOW) ? \
>> + base + STACK_TOP_MAX - DEFAULT_MAP_WINDOW : \
>> + base)
>> +
>> #endif
>> #define STACK_ALIGN 16
>> 
>> +
>> +#define STACK_TOP DEFAULT_MAP_WINDOW
>> +
>> +/*
>> + * This decides where the kernel will search for a free chunk of vm
>> + * space during mmap's.
>> + */
>> +#define TASK_UNMAPPED_BASE PAGE_ALIGN(DEFAULT_MAP_WINDOW / 3)
>> +
>> #ifndef __ASSEMBLY__
>> 
>> struct task_struct;
>> -- 
>> 2.34.1
>> 
>> 
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
