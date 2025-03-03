Return-Path: <linux-kselftest+bounces-28077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C468EA4C898
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ECB1773AA
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346323C8DB;
	Mon,  3 Mar 2025 16:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijvmFAyU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE723C8D4;
	Mon,  3 Mar 2025 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019862; cv=none; b=Q/3kPL8NWDzpetPlXLlMoKqvums3oA8RvNXhjg/E2pIrPGKLLwUJDFRrpcw899YdsVDnVPom6AOvK20VEA56EkOy2kJpcshG5EHX6SggiiAWG4YClKbHWVAAcvH1QHelKJVlZcOtEhggQFGJbOA9tV5HHNQcDwd2te1SRTqcUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019862; c=relaxed/simple;
	bh=wDHTqD18VJeK7bkhgbzWlBYq/asXp0P6f/1nzXKv+78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuIdwpDdKw5LsaKA96kE7KDTL6cWGuavibBeEosWLHJZj/dDSdBhq5Fnrw+S5iNPyRhTXTI6aHRXb+qUYUrLw+KDr28bi0W8Q8vSJbjcUoEkQ+te7V0xWPVPriP2M20MPtDchwOHBKiScqHE4zAVjPonrnCH1OjG2Mp4tKRPMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijvmFAyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5788C4CED6;
	Mon,  3 Mar 2025 16:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019861;
	bh=wDHTqD18VJeK7bkhgbzWlBYq/asXp0P6f/1nzXKv+78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijvmFAyUUslcjV1ax8ZG8N6P7LJ5qri2oVMmR5muyymSwPK4OyFCR7mSJ+zrONlCf
	 8rW/XEGBGQD49Dsw8L0+xKH+TrmjecLu3C2Gp3VNDFwvThsbyJiYNUJt2RfyMWh172
	 VIbgILO8pHCB4f3jPUjTV4nXJvRWR9+EJs9rqzfbmMDp+HZH7yx2R4RNCUMXZ0W1rx
	 HvlhXj0maYz22CmjSyjpjgqmaYAdxco+6hZHgrxa0UAAUjOseBbJwSWx9e/uN3pdIB
	 aV4xp8D8/HiUswm4DP0uuCtc37ibLrtzAJ8Ksp5ddrMfksUVkiG0iWu8DayWyCymKG
	 iPPYlZr00/Rxw==
Date: Mon, 3 Mar 2025 08:37:37 -0800
From: Kees Cook <kees@kernel.org>
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org,
	sroettger@google.com, hch@lst.de, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
	johannes@sipsolutions.net, pedro.falcato@gmail.com,
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de,
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com,
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org,
	ardb@google.com, enh@google.com, rientjes@google.com,
	groeck@chromium.org, mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Subject: Re: [PATCH v8 1/7] mseal sysmap: kernel config and header change
Message-ID: <202503030834.C4ED5911A@keescook>
References: <20250303050921.3033083-1-jeffxu@google.com>
 <20250303050921.3033083-2-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303050921.3033083-2-jeffxu@google.com>

On Mon, Mar 03, 2025 at 05:09:15AM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Provide infrastructure to mseal system mappings. Establish
> two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> macro for future patches.
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  include/linux/mm.h | 10 ++++++++++
>  init/Kconfig       | 22 ++++++++++++++++++++++
>  security/Kconfig   | 21 +++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7b1068ddcbb7..8b800941678d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
>  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
>  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>  
> +
> +/*
> + * mseal of userspace process's system mappings.
> + */
> +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> +#define VM_SEALED_SYSMAP	VM_SEALED
> +#else
> +#define VM_SEALED_SYSMAP	VM_NONE
> +#endif
> +
>  #endif /* _LINUX_MM_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index d0d021b3fa3b..c90dd8778993 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
>  config ARCH_HAS_MEMBARRIER_SYNC_CORE
>  	bool
>  
> +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	bool
> +	help
> +	  Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  To enable this feature, the architecture needs to update their
> +	  special mappings calls to include the sealing flag and confirm
> +	  that it doesn't unmap/remap system mappings during the life
> +	  time of the process. The existence of this flag for an architecture
> +	  implies that it does not require the remapping of thest system

typo nit: "the" instead of "thest"

> +	  mappings during process lifetime, so sealing these mappings is safe
> +	  from a kernel perspective.
> +
> +	  After the architecture enables this, a distribution can set
> +	  CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config HAVE_PERF_EVENTS
>  	bool
>  	help
> diff --git a/security/Kconfig b/security/Kconfig
> index f10dbf15c294..5311f4a6786c 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
>  
>  endchoice
>  
> +config MSEAL_SYSTEM_MAPPINGS
> +	bool "mseal system mappings"
> +	depends on 64BIT
> +	depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> +	depends on !CHECKPOINT_RESTORE
> +	help
> +	  Apply mseal on system mappings.
> +	  The system mappings includes vdso, vvar, vvar_vclock,
> +	  vectors (arm compact-mode), sigpage (arm compact-mode), uprobes.

typo nits: "compat" instead of "compact".

> +
> +	  A 64-bit kernel is required for the memory sealing feature.
> +	  No specific hardware features from the CPU are needed.
> +
> +	  WARNING: This feature breaks programs which rely on relocating
> +	  or unmapping system mappings. Known broken software at the time
> +	  of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Therefore
> +	  this config can't be enabled universally.
> +
> +	  For complete descriptions of memory sealing, please see
> +	  Documentation/userspace-api/mseal.rst
> +
>  config SECURITY
>  	bool "Enable different security models"
>  	depends on SYSFS
> -- 
> 2.48.1.711.g2feabab25a-goog
> 

Perhaps akpm can fix these up directly instead of a v9 spin?

But otherwise, yes, reads well to me:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

