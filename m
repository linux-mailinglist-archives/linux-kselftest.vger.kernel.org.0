Return-Path: <linux-kselftest+bounces-48281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59952CF723E
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 08:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D891F30A427F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0D30B53C;
	Tue,  6 Jan 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Fr0m8n6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B52E65D;
	Tue,  6 Jan 2026 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685615; cv=none; b=ufyj97q25Gxv2y7HL8EffCaaPolfpf/oXOnCx0CHulpMV8g3lsjgPSDReVyPDhxLSu10ZG14Lbp9XiV8k+oVcpJ8JqeTPkJOeT8S3kloI5g/PRiNX93HcbF5ohY/Efngok4Y8cUSzIZzGo/wwhJlW6D1Jx12nC/TKUaTL8MGZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685615; c=relaxed/simple;
	bh=pbwmhpckE/Bva8ZcgWJAR+eGRXjqU22E0YzLrCG/xVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVK35a7YJuLOo+PsEJGS7YCCtkYKREU8RhoMBqoR9DAI4pMOrrlhjeCd177WCLjC0xbIpun/JmJpdDkSYvhthhH0vjCzoHzLfBeT9M1amPmjQMXQNujNRYNy4hycyBtiY0wq3C07WBHhP2u2il9RY50t7iJhbE1962Lf74lSAE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Fr0m8n6P; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767685600; bh=zQXtyyI2PYr27yrlV0TQ/dcibbpe96U4emo5rjouWwE=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Fr0m8n6PxFfgVesGwM8926jjAVuffLHLxTY4eUXQkGtAYtSd49S1alV1266SdZFgc
	 6qcpQGyOL/4Fc9M06+Jewa63cYfKCs2V1KEhphVvAS3Zxz9ZfYj3GVQBVpV+IZQMCc
	 fD080VCavA8XZtvxobI9jN+1KJpGREJbpiXVpnuc=
Received: from [IPV6:2406:840:f992:3::a0c:323] ([240e:378:2201:1cd:d76:9bbc:bb82:5a0e])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BA2A60FB; Tue, 06 Jan 2026 15:46:34 +0800
X-QQ-mid: xmsmtpt1767685594t7zqkg8xe
Message-ID: <tencent_5F1B1F8D209B3699631D6E6C4C668848E306@qq.com>
X-QQ-XMAILINFO: MI0PymKx+wF7XlcnjzHNax13Eba/c2QZO2Rxz5Pk4OLqc6ja8DomkRGYkZpzyf
	 7pSqJztSUXNuhy0NvFBjndXJfcyxQW2HpezLqSlCKF/NKYMhM0TjoKniet3O6gLq2mJmWFZANrRT
	 euZkeHKaSMHjakNXM7NREXfkPT66sCaB+EezK4jCHPWE319m01XdxvMLtzPW8lYV2VoWC/vdyuap
	 hjponQ+Odp4nteUJQALjjZafJrTJK8FO4tGkTBNHz5Ok8hw+M7QCmxAmur4qrVb6roTWX7OIfby8
	 rh8WplPy7A2JUiTIB2ERJIiS7REcxaNLyuD7nYlFQGI3atwmIn08sJIAQTCtgtjSf7WWvfMAlWNb
	 kqzvJFewiodoo3uZuTrKY7rssbOt+PaRa3dq2Mvy2hCChDCWyW9C99276g1x7a8C0m4rsciYURrD
	 I6kZTVnFzuPnpg7cO8AOJOa8floxKSkYi/SxoagBdZqT2qHcQMlm/yqENKTPHs9AluGXtfzdz/tq
	 jxqg2CG076cuPb6g3MPfRlwvI5UAMk2vWLeEJ+40wXZN7iC2Sze0+n5Fh7f0Myo2kH0sVZxN0ppp
	 h9f8yWTC280m7B9GGEgK/itC00laHoy7bUXFrNFW1ie6iwDPw5sQTYa2AfP5kyHlXSOun5sKNoWR
	 SwlP7bmcRDDJ+oXiKPlNNKvk/AZzJzmFlERsELS7P8F2y9ZHidNUibJtzLXeDpA1O0XeoKodSJf2
	 do7bW82tlK/9yVoR6sv8vN1ZFfow8QlsbPnijQKyTId88Mof3Vbg9qe4kPQTS28V3jzuJuGZW2mv
	 U3uGxlKNwKgKTSKsRdNqzJjjG/nyo9e+48zzMaJXwwbjIGby1EmcbqGKoOO9n60vG/U02q+3K1PD
	 OvSlPjHXeZb2rInAvY+tKnn7N6A9rZtB3oYzSe3godlt4AzeVcl1ACNrLEtLaA1Z8A6EgTdxSDk9
	 wVUqsJS1tpMHbMOhiZ0y3DLErQM6ChE4IzBIbADHOD9JPzPSkm5cmwfI2wQXfUjlA9EZsOx+hIX9
	 lhRoRuxMvU7eAvz8ks
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <f80275c1-9093-4e6e-8d73-4bd6ca23e530@cyyself.name>
Date: Tue, 6 Jan 2026 15:46:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/6] RISC-V: Implement prctl call to set/get the
 memory consistency model
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Anup Patel <apatel@ventanamicro.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will@kernel.org>, Daniel Lustig <dlustig@nvidia.com>,
 Brendan Sweeney <turtwig@utexas.edu>, Andrew Waterman <andrew@sifive.com>,
 Brendan Sweeney <brs@berkeley.edu>, Andrea Parri <parri.andrea@gmail.com>,
 Hans Boehm <hboehm@google.com>
References: <20240209064050.2746540-1-christoph.muellner@vrull.eu>
 <20240209064050.2746540-5-christoph.muellner@vrull.eu>
Content-Language: en-US
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240209064050.2746540-5-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mullner,

Thanks for this work, although it has already lasted for about 2 years.

On 9/2/2024 14:40, Christoph Müllner wrote:
> We can use the PR_{S,G}ET_MEMORY_CONSISTENCY_MODEL prctl calls to change
> the memory consistency model at run-time if we have Ssdtso.
> This patch registers RISCV_WMO and RISCV_TSO as valid arguments
> for these prctl calls and implements the glue code to switch
> between these.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>   .../mm/dynamic-memory-consistency-model.rst   | 12 +++-
>   arch/riscv/include/asm/processor.h            |  7 ++
>   arch/riscv/kernel/Makefile                    |  1 +
>   arch/riscv/kernel/dtso.c                      | 67 +++++++++++++++++++
>   include/uapi/linux/prctl.h                    |  2 +
>   5 files changed, 88 insertions(+), 1 deletion(-)
>   create mode 100644 arch/riscv/kernel/dtso.c
> 
> diff --git a/Documentation/mm/dynamic-memory-consistency-model.rst b/Documentation/mm/dynamic-memory-consistency-model.rst
> index 1fce855a1fad..c8188c174e27 100644
> --- a/Documentation/mm/dynamic-memory-consistency-model.rst
> +++ b/Documentation/mm/dynamic-memory-consistency-model.rst
> @@ -73,4 +73,14 @@ Supported memory consistency models
>   This section defines the memory consistency models which are supported
>   by the prctl interface.
>   
> -<none>
> +RISC-V
> +------
> +
> +RISC-V uses RVWMO (RISC-V weak memory ordering) as default memory consistency
> +model. TSO (total store ordering) is another specified model and provides
> +additional ordering guarantees. Switching user-mode processes from RVWMO to TSO
> +is possible when the Ssdtso extension is available.
> +
> +* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO`: RISC-V weak memory ordering (default).
> +
> +* :c:macro:`PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO`: RISC-V total store ordering.
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index a8509cc31ab2..05e05fddc94d 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -184,6 +184,13 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
>   #define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
>   #define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
>   
> +#ifdef CONFIG_RISCV_ISA_SSDTSO
> +extern int dtso_set_memory_consistency_model(unsigned long arg);
> +extern int dtso_get_memory_consistency_model(void);
> +#define SET_MEMORY_CONSISTENCY_MODEL(arg)	dtso_set_memory_consistency_model(arg)
> +#define GET_MEMORY_CONSISTENCY_MODEL()		dtso_get_memory_consistency_model()
> +#endif /* CONIG_RISCV_ISA_SSDTSO */
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_RISCV_PROCESSOR_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..85f7291da498 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
>   obj-$(CONFIG_FPU)		+= fpu.o
>   obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
>   obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
> +obj-$(CONFIG_RISCV_ISA_SSDTSO)	+= dtso.o
>   obj-$(CONFIG_SMP)		+= smpboot.o
>   obj-$(CONFIG_SMP)		+= smp.o
>   obj-$(CONFIG_SMP)		+= cpu_ops.o
> diff --git a/arch/riscv/kernel/dtso.c b/arch/riscv/kernel/dtso.c
> new file mode 100644
> index 000000000000..591d5f9de0f5
> --- /dev/null
> +++ b/arch/riscv/kernel/dtso.c
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2024 Christoph Muellner <christoph.muellner@vrull.eu>
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/smp.h>
> +#include <linux/prctl.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/dtso.h>
> +
> +#include <trace/events/ipi.h>
> +
> +int dtso_set_memory_consistency_model(unsigned long arg)
> +{
> +	int cpu;
> +	unsigned long cur_model = get_memory_consistency_model(current);
> +	unsigned long new_model;
> +
> +	switch (arg) {
> +	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO:
> +		new_model = RISCV_MEMORY_CONSISTENCY_MODEL_WMO;
> +		break;
> +	case PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO:
> +		new_model = RISCV_MEMORY_CONSISTENCY_MODEL_TSO;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* No change requested. */
> +	if (cur_model == new_model)
> +		return 0;
> +
> +	/* Enabling TSO only works if DTSO is available. */
> +	if (new_model == PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO && !has_dtso())
> +		return -EINVAL;
> +
> +	/* Switching TSO->WMO is not allowed. */
> +	if (new_model == RISCV_MEMORY_CONSISTENCY_MODEL_WMO)
> +		return -EINVAL;
> +
> +	/* Set the new model in the task struct. */
> +	set_memory_consitency_model(current, new_model);
> +
> +	/*
> +	 * We need to reschedule all threads of the current process.
> +	 * Let's do this by rescheduling all CPUs.
> +	 * This is stricter than necessary, but since this call is
> +	 * not expected to happen frequently the impact is low.
> +	 */
> +	for_each_cpu(cpu, cpu_online_mask)
> +		smp_send_reschedule(cpu);
> +
> +	return 0;
> +}
> +
> +int dtso_get_memory_consistency_model(void)
> +{
> +	unsigned long cur_model = get_memory_consistency_model(current);
> +
> +	if (cur_model == RISCV_MEMORY_CONSISTENCY_MODEL_TSO)
> +		return PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO;
> +
> +	return PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO;
> +}
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 579662731eaa..20264bdc3092 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -308,5 +308,7 @@ struct prctl_mm_map {
>   
>   #define PR_SET_MEMORY_CONSISTENCY_MODEL		71
>   #define PR_GET_MEMORY_CONSISTENCY_MODEL		72
> +# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_WMO	1
> +# define PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO	2

Should we replace "PR_MEMORY_CONSISTENCY_MODEL_RISCV_TSO" with 
"PR_MEMORY_CONSISTENCY_MODEL_TSO", so that it can share the same key as 
Apple's TSO implementation [1]? RISC-V Ssdtso would make such prctl more 
likely to be accepted.

[1] https://lore.kernel.org/lkml/20240411-tso-v1-0-754f11abfbff@marcan.st/

Thanks,
Yangyu Chen

>   
>   #endif /* _LINUX_PRCTL_H */


