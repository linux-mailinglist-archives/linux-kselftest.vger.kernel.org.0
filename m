Return-Path: <linux-kselftest+bounces-30361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7B6A8094E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3747B364F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985AA26B2DB;
	Tue,  8 Apr 2025 12:45:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1926A08B;
	Tue,  8 Apr 2025 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116338; cv=none; b=SfD1POkLO+1sk6iMdXTJJxhfDtk052qvutJhlo8JcIDy98Jg9lumzrsW8wXu0hjsZKi4GwTP2Ve4N8kfAaamZVvQyStVA6v8PiKFfThW+D9iuH+PtW+ENd5uQdiOiyn57i8fhsWjNA3JQN5vsygzjx4qlKPCgJNib6aXtBVtiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116338; c=relaxed/simple;
	bh=XsDdFxw2/94hD3jA90zPjew2cMEKPvGv+xMalZkkkLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5IvnCMuD3t0g2Qn6UZR+37ixrd5EJh2M1Z+BI4V6EqQOdzSb+2ZnoL72kh85IDRQlhett5dbOJeuft6wxRVaVmfEdbsyBox208nE7Yw9H8h7JOJzuwNyhzDBRIkk2K8vPAo+Y0EFCJPyZdOhjs+ppA2GwEetuXS764nPBau3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2F944340A;
	Tue,  8 Apr 2025 12:45:25 +0000 (UTC)
Message-ID: <4f6a0c65-7c3a-4457-8b0b-cd39f40931c8@ghiti.fr>
Date: Tue, 8 Apr 2025 14:45:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 24/28] arch/riscv: compile vdso with landing pad
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-24-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-24-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdefuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeetgffgkeefteduhefgjeekjeelieejtdekvefhfffhudetkeejhfeuhefgtdekteenucffohhmrghinhepghhnuhdrphhrohhpvghrthihpdgsohhothhlihhnrdgtohhmpdhflhhushhhpghitggrtghhvgdrshgspdhgvghttghpuhdrshgspdhrthgpshhighhrvghtuhhrnhdrshgspdhshihspghhfihprhhosggvrdhssgenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegsudgurgemudeitgegmehfrgefkeemjeeigedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegsudgurgemudeitgegmehfrgefkeemjeeigedvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegsudgurgemudeitgegmehfrgefkeemjeeigedvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtt
 hhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> From: Jim Shu <jim.shu@sifive.com>
>
> user mode tasks compiled with zicfilp may call indirectly into vdso (like
> hwprobe indirect calls). Add landing pad compile support in vdso. vdso
> with landing pad in it will be nop for tasks which have not enabled
> landing pad.
> This patch allows to run user mode tasks with cfi eanbled and do no harm.
>
> Future work can be done on this to do below
>   - labeled landing pad on vdso functions (whenever labeling support shows
>     up in gnu-toolchain)
>   - emit shadow stack instructions only in vdso compiled objects as part of
>     kernel compile.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/Makefile                   |  5 +++-
>   arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++++++++
>   arch/riscv/kernel/vdso/Makefile       | 12 ++++++++++
>   arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
>   arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
>   arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
>   arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
>   7 files changed, 76 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 13fbc0f94238..eca94246cda6 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -88,9 +88,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
>   # Check if the toolchain supports Zabha
>   riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
>   
> +KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +export KBUILD_BASE_ISA
> +
>   # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
>   # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
> -KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> +KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
>   
>   KBUILD_AFLAGS += -march=$(riscv-march-y)
>   
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> index 44b1457d3e95..a058ea5e9c58 100644
> --- a/arch/riscv/include/asm/assembler.h
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -80,3 +80,47 @@
>   	.endm
>   
>   #endif	/* __ASM_ASSEMBLER_H */
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
> +.macro vdso_lpad
> +lpad 0
> +.endm
> +#else
> +.macro vdso_lpad
> +.endm
> +#endif
> +
> +/*
> + * This macro emits a program property note section identifying
> + * architecture features which require special handling, mainly for
> + * use in assembly files included in the VDSO.
> + */
> +#define NT_GNU_PROPERTY_TYPE_0  5
> +#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
> +
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
> +
> +#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
> +#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
> +	(GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
> +#endif
> +
> +#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
> +.macro emit_riscv_feature_1_and, feat = GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
> +	.pushsection .note.gnu.property, "a"
> +	.p2align        3
> +	.word           4
> +	.word           16
> +	.word           NT_GNU_PROPERTY_TYPE_0
> +	.asciz          "GNU"
> +	.word           GNU_PROPERTY_RISCV_FEATURE_1_AND
> +	.word           4
> +	.word           \feat
> +	.word           0
> +	.popsection
> +.endm
> +#else
> +.macro emit_riscv_feature_1_and, feat = 0
> +.endm
> +#endif
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 9a1b555e8733..daa10c2b0dd1 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -13,12 +13,18 @@ vdso-syms += flush_icache
>   vdso-syms += hwprobe
>   vdso-syms += sys_hwprobe
>   
> +ifdef CONFIG_RISCV_USER_CFI
> +LPAD_MARCH = _zicfilp
> +endif
> +
>   # Files to link into the vdso
>   obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
>   
>   ccflags-y := -fno-stack-protector
>   ccflags-y += -DDISABLE_BRANCH_PROFILING
>   ccflags-y += -fno-builtin
> +ccflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
> +asflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
>   
>   ifneq ($(c-gettimeofday-y),)
>     CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
> @@ -40,6 +46,12 @@ endif
>   CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>   CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
>   
> +# Disable profiling and instrumentation for VDSO code
> +GCOV_PROFILE := n
> +KCOV_INSTRUMENT := n
> +KASAN_SANITIZE := n
> +UBSAN_SANITIZE := n


So I looked into this and it seems it is not needed. All the profilers 
above only add their corresponding "clags" if the object 
"is-kernel-object" 
(https://elixir.bootlin.com/linux/v6.14-rc6/source/scripts/Makefile.lib#L147) 
which is not the case for hwprobe.c since it is not added to obj-y.


> +
>   # Force dependency
>   $(obj)/vdso.o: $(obj)/vdso.so
>   
> diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vdso/flush_icache.S
> index 8f884227e8bc..e4c56970905e 100644
> --- a/arch/riscv/kernel/vdso/flush_icache.S
> +++ b/arch/riscv/kernel/vdso/flush_icache.S
> @@ -5,11 +5,13 @@
>   
>   #include <linux/linkage.h>
>   #include <asm/unistd.h>
> +#include <asm/assembler.h>
>   
>   	.text
>   /* int __vdso_flush_icache(void *start, void *end, unsigned long flags); */
>   SYM_FUNC_START(__vdso_flush_icache)
>   	.cfi_startproc
> +	vdso_lpad
>   #ifdef CONFIG_SMP
>   	li a7, __NR_riscv_flush_icache
>   	ecall
> @@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
>   	ret
>   	.cfi_endproc
>   SYM_FUNC_END(__vdso_flush_icache)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/getcpu.S
> index 9c1bd531907f..5c1ecc4e1465 100644
> --- a/arch/riscv/kernel/vdso/getcpu.S
> +++ b/arch/riscv/kernel/vdso/getcpu.S
> @@ -5,14 +5,18 @@
>   
>   #include <linux/linkage.h>
>   #include <asm/unistd.h>
> +#include <asm/assembler.h>
>   
>   	.text
>   /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
>   SYM_FUNC_START(__vdso_getcpu)
>   	.cfi_startproc
> +	vdso_lpad
>   	/* For now, just do the syscall. */
>   	li a7, __NR_getcpu
>   	ecall
>   	ret
>   	.cfi_endproc
>   SYM_FUNC_END(__vdso_getcpu)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
> index 3dc022aa8931..e82987dc3739 100644
> --- a/arch/riscv/kernel/vdso/rt_sigreturn.S
> +++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
> @@ -5,12 +5,16 @@
>   
>   #include <linux/linkage.h>
>   #include <asm/unistd.h>
> +#include <asm/assembler.h>
>   
>   	.text
>   SYM_FUNC_START(__vdso_rt_sigreturn)
>   	.cfi_startproc
>   	.cfi_signal_frame
> +	vdso_lpad
>   	li a7, __NR_rt_sigreturn
>   	ecall
>   	.cfi_endproc
>   SYM_FUNC_END(__vdso_rt_sigreturn)
> +
> +emit_riscv_feature_1_and
> diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vdso/sys_hwprobe.S
> index 77e57f830521..f1694451a60c 100644
> --- a/arch/riscv/kernel/vdso/sys_hwprobe.S
> +++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
> @@ -3,13 +3,17 @@
>   
>   #include <linux/linkage.h>
>   #include <asm/unistd.h>
> +#include <asm/assembler.h>
>   
>   .text
>   SYM_FUNC_START(riscv_hwprobe)
>   	.cfi_startproc
> +	vdso_lpad
>   	li a7, __NR_riscv_hwprobe
>   	ecall
>   	ret
>   
>   	.cfi_endproc
>   SYM_FUNC_END(riscv_hwprobe)
> +
> +emit_riscv_feature_1_and
>

