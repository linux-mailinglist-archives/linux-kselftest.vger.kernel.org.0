Return-Path: <linux-kselftest+bounces-139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24857EC76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EF0281258
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC8F39FEA;
	Wed, 15 Nov 2023 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FPVrVlhl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182A33CEE
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:36:17 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FCEC2
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:36:15 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b587bd1a63so463820b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700062574; x=1700667374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0JQketASqzwgW5yh7NMNjvO1ZuRMUYpVqc6VBhHaxI=;
        b=FPVrVlhl8YkzgE7Cwmy0jGTKvIEEvSWrlZF4nEjA2vZGJSxmasgx4As00PUvzEcXQH
         Ex2ZK91C49Ag7+uneUtIyDvJDnlts/0VTj03IWTIQBlG+haV3XDIxgq9F/RU73st2dNh
         uptZigAMx98kL/cu7r7TX9q+GiZsb+Lw1IG+k8D/XRhVQz3N4RZ5/D5zVwlup74FkD/u
         P+6BqJiDUmXfzMYgPUoEYKmq7AQzCAT+p2keJId4dj/8XIRrV+DFBvrqadiA+CrDuJgO
         WvGE25Xr8m90MG+qX0Ig0jn07Go0fi44aUJ9rxp2TmL/FDsuZ7tj3XVAVOeJ2IsxqCKH
         LwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062574; x=1700667374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0JQketASqzwgW5yh7NMNjvO1ZuRMUYpVqc6VBhHaxI=;
        b=Ud0M7YN1fuHq9AgUR/4NtGzEsI9MMTRQLG4n+jGBGEFffop4qdG1Voxy+zDLXrzg25
         kepl8EVoWlOel8HtqzIjSTXTq+7dIhRNuyiWZtnAcpumnumFBdw8I7MZw3F0uoSbM2dm
         j6Lk8nSfmLWc0PUaH+4o6RAChVKoZ4CM8xNfJSkBq5FvMLcLHPShrvK3DAXKCPAB9vMi
         zithwFKPVkYDdKgujZZG9B9S3fmm6hhyYs134iGqP/xda9ye3ZLASzT5UwDcQ2OcwJCo
         I9PLe/sYOvWwZKhylmz41gL7CAyMRu69S5ZzoXDO8/60bu8xhMXwaxPfREyOu/Eg2cUT
         DMNQ==
X-Gm-Message-State: AOJu0Ywrj/5LXBaHDddGe8DI/bCsBAU3YrMt1rcgDz+zEX3n1KRmZkNO
	gyJ4TdhYWD34O/f/nhnGzvXvQQ==
X-Google-Smtp-Source: AGHT+IFKhMp18lIOImTKiN9BWfXIKUWBbbJ4lD5DPClon4aeCgIp/6eCe2dME1/AeAMZcWKKNb+38A==
X-Received: by 2002:a05:6870:4301:b0:1e9:b50e:26dc with SMTP id w1-20020a056870430100b001e9b50e26dcmr3138752oah.12.1700062574434;
        Wed, 15 Nov 2023 07:36:14 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o187-20020a4a44c4000000b00581daa5c5fdsm721783ooa.29.2023.11.15.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 07:36:13 -0800 (PST)
Date: Wed, 15 Nov 2023 07:36:10 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <ZVTlarljj0nvVJVi@debug.ba.rivosinc.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>

On Tue, Nov 14, 2023 at 08:05:54PM +0000, Mark Brown wrote:
>Since multiple architectures have support for shadow stacks and we need to
>select support for this feature in several places in the generic code
>provide a generic config option that the architectures can select.
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Mark Brown <broonie@kernel.org>
>---
> arch/x86/Kconfig   | 1 +
> fs/proc/task_mmu.c | 2 +-
> include/linux/mm.h | 2 +-
> mm/Kconfig         | 6 ++++++
> 4 files changed, 9 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index 3762f41bb092..14b7703a9a2b 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
> 	depends on AS_WRUSS
> 	depends on X86_64
> 	select ARCH_USES_HIGH_VMA_FLAGS
>+	select ARCH_HAS_USER_SHADOW_STACK
> 	select X86_CET
> 	help
> 	  Shadow stack protection is a hardware feature that detects function
>diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>index ef2eb12906da..f0a904aeee8e 100644
>--- a/fs/proc/task_mmu.c
>+++ b/fs/proc/task_mmu.c
>@@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> 		[ilog2(VM_UFFD_MINOR)]	= "ui",
> #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>-#ifdef CONFIG_X86_USER_SHADOW_STACK
>+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> 		[ilog2(VM_SHADOW_STACK)] = "ss",
> #endif
> 	};
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 418d26608ece..10462f354614 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
> #endif
> #endif /* CONFIG_ARCH_HAS_PKEYS */
>
>-#ifdef CONFIG_X86_USER_SHADOW_STACK
>+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
> /*
>  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
>  * support core mm.
>diff --git a/mm/Kconfig b/mm/Kconfig
>index 89971a894b60..b8638da636e1 100644
>--- a/mm/Kconfig
>+++ b/mm/Kconfig
>@@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
> 	bool
> 	depends on !STACK_GROWSUP
>
>+config ARCH_HAS_USER_SHADOW_STACK
>+	bool
>+	help
>+	  The architecture has hardware support for userspace shadow call
>+          stacks (eg, x86 CET, arm64 GCS, RISC-V Zisslpcfi).

Minor correction for future version.RISC-V choose to split extension [1, 2].
It's now:

Zicfiss - CFI using shadow stack
Zicfilp - CFI using landing pad

So for shadow stack purposes, we can start saying "RISC-V Zicfiss"

[1] - https://lists.riscv.org/g/tech-ss-lp-cfi/message/55
[2] - https://github.com/riscv/riscv-cfi/pull/126

>+
> source "mm/damon/Kconfig"
>
> endmenu
>
>-- 
>2.30.2
>

