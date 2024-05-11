Return-Path: <linux-kselftest+bounces-10065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADD8C2CC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 00:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369A11F21759
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F20171E76;
	Fri, 10 May 2024 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qPmXjhQw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261E13B597
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715381521; cv=none; b=XgywaSLTBlwsV9v3gZlSPwKtds9Vq5Ptgef22tPnO3OCskTXoYw5J8PxOW+DA7tevueR6IHkOmPIXgOvPxgQr/ptMm5LPV6bbdDAa3YfpSawxMpnV/MU/GTCdfLx8z2PjNg94uomAXGKyhL1Gsv8FcdIfNuPGzceqhjc7HbU6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715381521; c=relaxed/simple;
	bh=gyUchS7+ZVNWUlskKBfd8Sepi8WXhIJmK8R3fJPVtFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuBGnaKN8XWLb5e9KwHO/Z4GmFANp/xO85Mmzl49Xrvz7AnPwMXOMBmh32mvMc51AUY8LkuWD2dedGm4Inw4CS/TpqNXOZ/1osL8XfIOqqOV96P5/aEVSIM586PVE/F5uHNpYxL+W0L3RulIaWLs7pRB6hfwMpgC1Kx5nTsUxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qPmXjhQw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2014256a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715381518; x=1715986318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMbbgJzCaBy4mQmI2cQucFpA9UtNe/7h1nzGeBGSfRc=;
        b=qPmXjhQwP0zR5n4rQz//fvf8GX9I16woaxE1pYG+Z42wsTlcsKkf8srTkplYQSNb93
         vY7q9rgmRjC5dzau3GIxzHJD3uqJFS4P0Pwoh2Bo/84vzUL5U/raDxS3Ve3Eb4QG+rpB
         cw6tFq+n2RN4o1nN7lVLVdFNlxOBpYC7f6MsSJXmpF1IjzeE1Xh58fMUTMmp0XQ29MES
         kjrlLMpIMQa4cYh2N/e6HPxEfzZu6ps89EhNobEmGc63db4Z7eSornZZPpqJ839bwMjn
         WvZuublnPHoDQzWb8OSBHnl/2yjimqixD1RF/nfkAcIqGHLoDdk7Mx/nchV5cR86sN2c
         w1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715381518; x=1715986318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMbbgJzCaBy4mQmI2cQucFpA9UtNe/7h1nzGeBGSfRc=;
        b=rrCc/8gOnPa+edOIFjYUbSSC2WIyLC55LhvnBAnd902+uUI4+3EnPYOxU6QRk1YJUO
         m1ZPbfUvRmtKO2JyCWb/uYxcf1LSF7jikH3E1R0Z+RhtxKYcxtkqKTx8KHI38DYHIVqK
         QtZzepPYJM5qex6BBNHg+zHwdd1Owy45N6FWrDWCztbwR+Ess1aCq8Luithy8FxnvT/h
         vaQ7HCu4mx5h7AnHd2pNCaHu/4eW5xP7YZzFi9YhLdGyNjKfFfOqQtKcgvt7oP1hxxvh
         vTrjiqWpfOPat/hjxcFrIB8d5jItxkQqhLlglxX9g1Jqh0RVoW6mEc0gZP1umsuK1cra
         MIXA==
X-Forwarded-Encrypted: i=1; AJvYcCXfmbCkxjYdSxq7gIeWhc2tkgi8sIyQOLYgEYU2Iw8vNu4OkzTxdbsqzI1GGg+YkHutxW4ENlZxiiI7ccxB+FbbgFez7WcdmhcriA1xKDn4
X-Gm-Message-State: AOJu0Yz+qejt1dKQ2GABihvdJ7rq8KFaL78eCkERF0OOZ8oEryJyRpUz
	n1dY9e5WU8Po7Fxwl5o1otY4aPk++5QMPvJ+rXWqtd665Yn9mOiP5ooaLD1XdDQ=
X-Google-Smtp-Source: AGHT+IERwBJ/HGGrfgcaUUxkgUQ2q7nsPpLNAHxyqmyy/ZTgRKVDYn6DWzAegoGcnw2mJ8/WwGXNmQ==
X-Received: by 2002:a17:90b:1a87:b0:2b4:e4d2:c72b with SMTP id 98e67ed59e1d1-2b6cc4502dcmr4308614a91.2.1715381517564;
        Fri, 10 May 2024 15:51:57 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30caesm37597025ad.160.2024.05.10.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:51:56 -0700 (PDT)
Date: Fri, 10 May 2024 15:51:51 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 07/29] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Message-ID: <Zj6lB7Ae7MSdpT5c@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-8-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-8-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:34:55PM -0700, Deepak Gupta wrote:
> Carves out space in arch specific thread struct for cfi status and shadow
> stack in usermode on riscv.
> 
> This patch does following
> - defines a new structure cfi_status with status bit for cfi feature
> - defines shadow stack pointer, base and size in cfi_status structure
> - defines offsets to new member fields in thread in asm-offsets.c
> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>   (S --> U)
> 
> Shadow stack save/restore is gated on feature availiblity and implemented
> using alternative. CSR can be context switched in `switch_to` as well but
> soon as kernel shadow stack support gets rolled in, shadow stack pointer
> will need to be switched at trap entry/exit point (much like `sp`). It can
> be argued that kernel using shadow stack deployment scenario may not be as
> prevalant as user mode using this feature. But even if there is some
> minimal deployment of kernel shadow stack, that means that it needs to be
> supported. And thus save/restore of shadow stack pointer in entry.S instead
> of in `switch_to.h`.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/processor.h   |  1 +
>  arch/riscv/include/asm/thread_info.h |  3 +++
>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  4 ++++
>  arch/riscv/kernel/entry.S            | 26 ++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+)
>  create mode 100644 arch/riscv/include/asm/usercfi.h
> 
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 6c5b3d928b12..f8decf357804 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,6 +14,7 @@
>  
>  #include <asm/ptrace.h>
>  #include <asm/hwcap.h>
> +#include <asm/usercfi.h>
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index a503bdc2f6dd..f1dee307806e 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -57,6 +57,9 @@ struct thread_info {
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>  	unsigned long envcfg;
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status       user_cfi_state;
> +#endif
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	void			*scs_base;
>  	void			*scs_sp;
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
> new file mode 100644
> index 000000000000..4fa201b4fc4e
> --- /dev/null
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2024 Rivos, Inc.
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +#ifndef _ASM_RISCV_USERCFI_H
> +#define _ASM_RISCV_USERCFI_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +struct cfi_status {
> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> +	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
> +	unsigned long shdw_stk_size; /* size of shadow stack */
> +};
> +
> +#endif /* CONFIG_RISCV_USER_CFI */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_RISCV_USERCFI_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index a03129f40c46..5c5ea015c776 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -44,6 +44,10 @@ void asm_offsets(void)
>  #endif
>  
>  	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
> +#ifdef CONFIG_RISCV_USER_CFI
> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
> +	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
> +#endif
>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 9d1a305d5508..7245a0ea25c1 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -60,6 +60,20 @@ SYM_CODE_START(handle_exception)
>  
>  	REG_L s0, TASK_TI_USER_SP(tp)
>  	csrrc s1, CSR_STATUS, t0
> +	/*
> +	 * If previous mode was U, capture shadow stack pointer and save it away
> +	 * Zero CSR_SSP at the same time for sanitization.
> +	 */
> +	ALTERNATIVE("nop; nop; nop; nop",
> +				__stringify(			\
> +				andi s2, s1, SR_SPP;	\
> +				bnez s2, skip_ssp_save;	\
> +				csrrw s2, CSR_SSP, x0;	\
> +				REG_S s2, TASK_TI_USER_SSP(tp); \
> +				skip_ssp_save:),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
>  	csrr s2, CSR_EPC
>  	csrr s3, CSR_TVAL
>  	csrr s4, CSR_CAUSE
> @@ -141,6 +155,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	 * structures again.
>  	 */
>  	csrw CSR_SCRATCH, tp
> +
> +	/*
> +	 * Going back to U mode, restore shadow stack pointer
> +	 */
> +	ALTERNATIVE("nop; nop",
> +				__stringify(					\
> +				REG_L s3, TASK_TI_USER_SSP(tp); \
> +				csrw CSR_SSP, s3),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
> +
>  1:
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>  	move a0, sp
> -- 
> 2.43.2
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


