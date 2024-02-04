Return-Path: <linux-kselftest+bounces-4116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F280848D43
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B653A1F21CE7
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 11:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABF2134F;
	Sun,  4 Feb 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY/WEtGX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE82208E;
	Sun,  4 Feb 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047817; cv=none; b=fHiWY+7b7Zs3RikbUbtlAo13XXvfMXvXN4mr4DQxEQ/ezvfzQacm2U6420PLiV+rL9vxDVS2+41x6FprIBQGMHZx6RypxuxiVfKP81L/k9PJI/ZWoX15+YJqsJe/5LlNk9PJEJJv3Xh0f4yFUTp0xuIEhSKtXBD6d+H5K4PbnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047817; c=relaxed/simple;
	bh=4MfqGCuyTV/WsAyZLhKLgr6v3KIUjtNQFKaYShJa5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNlJLv5n50kKawFOK7kyT90GGb2KKqwavivynQhPtFlcmR4wL7aR0Gy7quMBSh77wlFuHIVPcr3RsNVidqDin+dIvt6YNLmgKZqeFp0nvo/3IMdwR5xkJ5e/HRW0VaX3CHab9uCwecG4oLm6AkBoiIo68RW+g3yttKAY6ZSPLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY/WEtGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE05C433C7;
	Sun,  4 Feb 2024 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707047817;
	bh=4MfqGCuyTV/WsAyZLhKLgr6v3KIUjtNQFKaYShJa5D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY/WEtGXriFjgcbMxABWAI4nFRroyGqI2w96wGZ9ydXf9+uL8mdZqzi+dGzo4Lf9A
	 bQTQ7bhibCdYAIAU9P2v7NgeMdVO2JwRrFhz1EBhCZUkivhQ9ale4dK+SQyCpL9ltY
	 vR1mZgXbXe+c3RC+Ef75Wj5FDvuvJPWzVIoPSwilsDgWUUgAw1PPqmbAFE2GJZaVjR
	 PP958f8YXAXj91IZo569uUsbJsm+M2tLGiEKOfBTSY1pvkOSxezO/kp6V8/0P83l5H
	 bue5JvBedmel6vfTkGxy4W5d7RMgyQqSAvKOxlpcl9IC1nTWZ+O5BlMlkpjEXbZ/bW
	 gwK2DWtg278SA==
Date: Sun, 4 Feb 2024 12:56:41 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
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
Subject: Re: [PATCH RFT v3 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <Zb97eROjky1DIaiv@kernel.org>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231120-clone3-shadow-stack-v3-1-a7b8ed3e2acc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-clone3-shadow-stack-v3-1-a7b8ed3e2acc@kernel.org>

On Mon, Nov 20, 2023 at 11:54:29PM +0000, Mark Brown wrote:
> Since multiple architectures have support for shadow stacks and we need to
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/x86/Kconfig   | 1 +
>  fs/proc/task_mmu.c | 2 +-
>  include/linux/mm.h | 2 +-
>  mm/Kconfig         | 6 ++++++
>  4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..14b7703a9a2b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
>  	depends on AS_WRUSS
>  	depends on X86_64
>  	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_USER_SHADOW_STACK
>  	select X86_CET
>  	help
>  	  Shadow stack protection is a hardware feature that detects function
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..f0a904aeee8e 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
>  	};
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 418d26608ece..10462f354614 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
>  
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  /*
>   * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
>   * support core mm.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..6713bb3b0b48 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
>  	bool
>  	depends on !STACK_GROWSUP
>  
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).

The whitespace looks suspicious, I think there should be a leading tab.
Otherwise

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> 
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.

