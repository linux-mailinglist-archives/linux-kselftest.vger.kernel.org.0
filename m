Return-Path: <linux-kselftest+bounces-34301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13286ACE1A6
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AD5173DA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F5617A30A;
	Wed,  4 Jun 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbfQiirm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA41624DD
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051630; cv=none; b=Z+tl64mJ2+JcJWpw7pOUKmQKJEKTqIpwL2DroGPpoDDhnVMrFe5V3vjXkkGO6YwWzn2YW0eTvLUGgPgX0ncBj1O9xPF93BU0JtP+TmF3Gwm07g8Hs7M1rSNlUEmkoIrrwdcJzGnbsJji3hpptYllftFuqgHGHnp1lnuZTUmxyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051630; c=relaxed/simple;
	bh=8YVewl89jcSngH4G2pqcfiA0O5Eh3Vz36To17LF0ZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrgW6LY7xaNohIcRTNzbmI5p/isxUkhJElA5L+jJq7Fg90HJSDJZMGl43Jnl6uIbeKzZC8kHlpf3IBKyPGUI/BV0WtYgGN6NuS/IIMg/yViI+JG1gM1gsxQoj0UnOKHqqBWP2eUxLJqfqyIFD2zVZ/kS+G/gAtZzlu5VegpBZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fbfQiirm; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Jun 2025 17:40:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749051624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dI/AoEAVyJNWcNlrDjkugKkhwJPVG0BOgGP9jAFrfqo=;
	b=fbfQiirm2dH4KzJS4fXyXhNU4gNDoqcV6B7acQ5h9awVJHKMgRa3o9R9EjZ6tAUOFDOrtE
	35edXtdIHyYdvm3cl8aHCJw5CXM4OwmTQwoxbNdbDT+3OcvF1U0OiIQPokd4DlTpHvp9LM
	6o1EqURT/8fTjw9L2VCd9o97aB/b6x0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v2] riscv: sbi: Add SBI Debug Triggers Extension tests
Message-ID: <20250604-b598bc8ab654038c642397a1@orel>
References: <20250603195931.831463-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603195931.831463-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

Hi Jesse,

Thanks for this patch, but please see the README of the repository,
section "Patches", where we ask that a 'kvm-unit-tests' patch prefix is
used. Also please see the RISCV section of the MAINTAINERS file for where
to send the patches. You got the kvm-riscv list, but I'd appreciate a CC
to my linux.dev account provided there as well.

I'm just taking a quick review pass to look for superficial stuff, since
I think others such as Himanshu will look at it from a "does it cover the
spec" perspective.

On Tue, Jun 03, 2025 at 12:59:31PM -0700, Jesse Taube wrote:
> Add tests for the DBTR SBI extension.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - Call report_prefix_pop before returning
>  - Disable compressed instructions in exec_call, update related comment
>  - Remove extra "| 1" in dbtr_test_load
>  - Remove extra newlines
>  - Remove extra tabs in check_exec
>  - Remove typedefs from enums
>  - Return when dbtr_install_trigger fails
>  - s/avalible/available/g
>  - s/unistall/uninstall/g
> ---
>  lib/riscv/asm/sbi.h |  28 ++
>  lib/riscv/sbi.c     |  58 ++++
>  riscv/Makefile      |   1 +
>  riscv/sbi-dbtr.c    | 751 ++++++++++++++++++++++++++++++++++++++++++++
>  riscv/sbi-tests.h   |   1 +
>  riscv/sbi.c         |   1 +
>  6 files changed, 840 insertions(+)
>  create mode 100644 riscv/sbi-dbtr.c
> 
> diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> index a5738a5c..ce19ab89 100644
> --- a/lib/riscv/asm/sbi.h
> +++ b/lib/riscv/asm/sbi.h
> @@ -51,6 +51,7 @@ enum sbi_ext_id {
>  	SBI_EXT_SUSP = 0x53555350,
>  	SBI_EXT_FWFT = 0x46574654,
>  	SBI_EXT_SSE = 0x535345,
> +	SBI_EXT_DBTR = 0x44425452,
>  };
>  
>  enum sbi_ext_base_fid {
> @@ -125,6 +126,17 @@ enum sbi_ext_fwft_fid {
>  
>  #define SBI_FWFT_SET_FLAG_LOCK			BIT(0)
>  
> +enum sbi_ext_dbtr_fid {
> +	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
> +	SBI_EXT_DBTR_SETUP_SHMEM,
> +	SBI_EXT_DBTR_TRIGGER_READ,
> +	SBI_EXT_DBTR_TRIGGER_INSTALL,
> +	SBI_EXT_DBTR_TRIGGER_UPDATE,
> +	SBI_EXT_DBTR_TRIGGER_UNINSTALL,
> +	SBI_EXT_DBTR_TRIGGER_ENABLE,
> +	SBI_EXT_DBTR_TRIGGER_DISABLE,
> +};

I think we can put these and all the dbtr function wrappers below in
riscv/sbi-dbtr.c, as I doubt we'll use them outside their test cases.

> +
>  enum sbi_ext_sse_fid {
>  	SBI_EXT_SSE_READ_ATTRS = 0,
>  	SBI_EXT_SSE_WRITE_ATTRS,
> @@ -282,6 +294,22 @@ static inline bool sbi_sse_event_is_global(uint32_t event_id)
>  	return !!(event_id & SBI_SSE_EVENT_GLOBAL_BIT);
>  }
>  
> +struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1);
> +struct sbiret sbi_debug_set_shmem(void *shmem);
> +struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
> +				      unsigned long shmem_phys_hi,
> +				      unsigned long flags);
> +struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
> +				      unsigned long trig_count);
> +struct sbiret sbi_debug_install_triggers(unsigned long trig_count);
> +struct sbiret sbi_debug_update_triggers(unsigned long trig_count);
> +struct sbiret sbi_debug_uninstall_triggers(unsigned long trig_idx_base,
> +					   unsigned long trig_idx_mask);
> +struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
> +					unsigned long trig_idx_mask);
> +struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
> +					 unsigned long trig_idx_mask);

We won't need these once we've moved the function wrappers.

> +
>  struct sbiret sbi_sse_read_attrs_raw(unsigned long event_id, unsigned long base_attr_id,
>  				     unsigned long attr_count, unsigned long phys_lo,
>  				     unsigned long phys_hi);
> diff --git a/lib/riscv/sbi.c b/lib/riscv/sbi.c
> index 2959378f..39c0d3bd 100644
> --- a/lib/riscv/sbi.c
> +++ b/lib/riscv/sbi.c
> @@ -32,6 +32,64 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  	return ret;
>  }
>  
> +struct sbiret sbi_debug_num_triggers(unsigned long trig_tdata1)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS, trig_tdata1, 0, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_set_shmem(void *shmem)
> +{
> +	phys_addr_t p = virt_to_phys(shmem);
> +
> +	return sbi_debug_set_shmem_raw(lower_32_bits(p), upper_32_bits(p), 0);
> +}
> +
> +struct sbiret sbi_debug_set_shmem_raw(unsigned long shmem_phys_lo,
> +				      unsigned long shmem_phys_hi,
> +				      unsigned long flags)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM, shmem_phys_lo,
> +			 shmem_phys_hi, flags, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_read_triggers(unsigned long trig_idx_base,
> +				      unsigned long trig_count)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_READ, trig_idx_base,
> +			 trig_count, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_install_triggers(unsigned long trig_count)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_INSTALL, trig_count, 0, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_update_triggers(unsigned long trig_count)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UPDATE, trig_count, 0, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_uninstall_triggers(unsigned long trig_idx_base,
> +					   unsigned long trig_idx_mask)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_UNINSTALL, trig_idx_base,
> +			 trig_idx_mask, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_enable_triggers(unsigned long trig_idx_base,
> +					unsigned long trig_idx_mask)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_ENABLE, trig_idx_base,
> +			 trig_idx_mask, 0, 0, 0, 0);
> +}
> +
> +struct sbiret sbi_debug_disable_triggers(unsigned long trig_idx_base,
> +					 unsigned long trig_idx_mask)
> +{
> +	return sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIGGER_DISABLE, trig_idx_base,
> +			 trig_idx_mask, 0, 0, 0, 0);
> +}

When moving these, they'll of course become static, but I don't mind
keeping the sbi_ prefix since that's consistent with the other wrappers
and the names in the spec.

> +
>  struct sbiret sbi_sse_read_attrs_raw(unsigned long event_id, unsigned long base_attr_id,
>  				     unsigned long attr_count, unsigned long phys_lo,
>  				     unsigned long phys_hi)
> diff --git a/riscv/Makefile b/riscv/Makefile
> index 11e68eae..55c7ac93 100644
> --- a/riscv/Makefile
> +++ b/riscv/Makefile
> @@ -20,6 +20,7 @@ all: $(tests)
>  $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-asm.o
>  $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-fwft.o
>  $(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-sse.o
> +$(TEST_DIR)/sbi-deps += $(TEST_DIR)/sbi-dbtr.o
>  
>  all_deps += $($(TEST_DIR)/sbi-deps)
>  
> diff --git a/riscv/sbi-dbtr.c b/riscv/sbi-dbtr.c
> new file mode 100644
> index 00000000..fe323f0f
> --- /dev/null
> +++ b/riscv/sbi-dbtr.c
> @@ -0,0 +1,751 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SBI DBTR testsuite
> + *
> + * Copyright (C) 2025, Rivos Inc., Jesse Taube <jesse@rivosinc.com>
> + */
> +
> +#include <asm/io.h>

Looks pretty light for the #include list... I prefer we try to add the
appropriate includes for everything we use. We don't have to be perfect,
but I think a best effort is better than the minimalist approach.

> +
> +#include "sbi-tests.h"
> +
> +#define INSN_LEN(insn)			((((insn) & 0x3) < 0x3) ? 2 : 4)

Clement just introduced this in the dbltrp test too. Let's add it to
lib/riscv/asm/processor.h instead as RV_INSN_LEN()

> +
> +#if __riscv_xlen == 64
> +#define SBI_DBTR_SHMEM_INVALID_ADDR	0xFFFFFFFFFFFFFFFFUL
> +#elif __riscv_xlen == 32
> +#define SBI_DBTR_SHMEM_INVALID_ADDR	0xFFFFFFFFUL
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif

No need for the #if, just use

#define SBI_DBTR_SHMEM_INVALID_ADDR -1UL

but, we've been giving the users the ability to define invalid addresses
themselves (see get_invalid_addr() in riscv/sbi.c). We can export that
function (along with get_highest_addr()) and then put their prototypes
in riscv/sbi-tests.h.

> +
> +#define RV_MAX_TRIGGERS		32
> +
> +#define SBI_DBTR_TRIG_STATE_MAPPED		BIT(0)
> +#define SBI_DBTR_TRIG_STATE_U			BIT(1)
> +#define SBI_DBTR_TRIG_STATE_S			BIT(2)
> +#define SBI_DBTR_TRIG_STATE_VU			BIT(3)
> +#define SBI_DBTR_TRIG_STATE_VS			BIT(4)
> +#define SBI_DBTR_TRIG_STATE_HAVE_HW_TRIG	BIT(5)
> +
> +#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT		8
> +#define SBI_DBTR_TRIG_STATE_HW_TRIG_IDX(trig_state)	(trig_state >> SBI_DBTR_TRIG_STATE_HW_TRIG_IDX_SHIFT)
> +
> +#define SBI_DBTR_TDATA1_TYPE_SHIFT		(__riscv_xlen - 4)
> +
> +#define SBI_DBTR_TDATA1_MCONTROL6_LOAD_BIT	BIT(0)
> +#define SBI_DBTR_TDATA1_MCONTROL6_STORE_BIT	BIT(1)
> +#define SBI_DBTR_TDATA1_MCONTROL6_EXECUTE_BIT	BIT(2)
> +#define SBI_DBTR_TDATA1_MCONTROL6_U_BIT		BIT(3)
> +#define SBI_DBTR_TDATA1_MCONTROL6_S_BIT		BIT(4)
> +#define SBI_DBTR_TDATA1_MCONTROL6_SELECT_BIT	BIT(21)
> +#define SBI_DBTR_TDATA1_MCONTROL6_VS_BIT	BIT(23)
> +#define SBI_DBTR_TDATA1_MCONTROL6_VU_BIT	BIT(24)
> +
> +#define SBI_DBTR_TDATA1_MCONTROL_LOAD_BIT	BIT(0)
> +#define SBI_DBTR_TDATA1_MCONTROL_STORE_BIT	BIT(1)
> +#define SBI_DBTR_TDATA1_MCONTROL_EXECUTE_BIT	BIT(2)
> +#define SBI_DBTR_TDATA1_MCONTROL_U_BIT		BIT(3)
> +#define SBI_DBTR_TDATA1_MCONTROL_S_BIT		BIT(4)
> +#define SBI_DBTR_TDATA1_MCONTROL_SELECT_BIT	BIT(19)
> +
> +enum McontrolType {
> +	SBI_DBTR_TDATA1_TYPE_NONE =		(0UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_LEGACY =		(1UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_MCONTROL =		(2UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_ICOUNT =		(3UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_ITRIGGER =		(4UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_ETRIGGER =		(5UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_MCONTROL6 =	(6UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_TMEXTTRIGGER =	(7UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_RESERVED0 =	(8UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_RESERVED1 =	(9UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_RESERVED2 =	(10UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_RESERVED3 =	(11UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_CUSTOM0 =		(12UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_CUSTOM1 =		(13UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_CUSTOM2 =		(14UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +	SBI_DBTR_TDATA1_TYPE_DISABLED =		(15UL << SBI_DBTR_TDATA1_TYPE_SHIFT),
> +};
> +
> +enum Tdata1Value {
> +	VALUE_NONE =	0,
> +	VALUE_LOAD =	BIT(0),
> +	VALUE_STORE =	BIT(1),
> +	VALUE_EXECUTE =	BIT(2),
> +};
> +
> +enum Tdata1Mode {
> +	MODE_NONE =	0,
> +	MODE_M =	BIT(0),
> +	MODE_U =	BIT(1),
> +	MODE_S =	BIT(2),
> +	MODE_VU =	BIT(3),
> +	MODE_VS =	BIT(4),
> +};
> +
> +struct sbi_dbtr_data_msg {
> +	unsigned long tstate;
> +	unsigned long tdata1;
> +	unsigned long tdata2;
> +	unsigned long tdata3;
> +};
> +
> +struct sbi_dbtr_id_msg {
> +	unsigned long idx;
> +};
> +
> +/* SBI shared mem messages layout */
> +struct sbi_dbtr_shmem_entry {
> +	union {
> +		struct sbi_dbtr_data_msg data;
> +		struct sbi_dbtr_id_msg id;
> +	};
> +};
> +
> +static bool dbtr_handled;
> +
> +// Expected to be leaf function as not to disrupt frame-pointer

nit: Use /* */

> +static __attribute__((naked)) void exec_call(void)
> +{
> +	// skip over nop when triggered instead of ret.

same nit

> +	asm volatile (".option push\n"
> +		      ".option arch, -c\n"
> +		      "nop\n"
> +		      "ret\n"
> +		      ".option pop\n");
> +}
> +
> +static void dbtr_exception_handler(struct pt_regs *regs)
> +{
> +	dbtr_handled = true;
> +
> +	/* Reading *epc may cause a fault, skip over nop */
> +	if ((void *)regs->epc == exec_call) {
> +		regs->epc += 4;
> +		return;
> +	}
> +
> +	/* WARNING: Skips over the trapped intruction */
> +	regs->epc += INSN_LEN(readw((void *)regs->epc));
> +}
> +
> +static bool do_save(void *tdata2)
> +{
> +	bool ret;
> +
> +	writel(0, tdata2);
> +
> +	ret = dbtr_handled;
> +	dbtr_handled = false;
> +
> +	return ret;
> +}
> +
> +static bool do_load(void *tdata2)
> +{
> +	bool ret;
> +
> +	readl(tdata2);
> +
> +	ret = dbtr_handled;
> +	dbtr_handled = false;
> +
> +	return ret;
> +}
> +
> +static bool do_exec(void)
> +{
> +	bool ret;
> +
> +	exec_call();
> +
> +	ret = dbtr_handled;
> +	dbtr_handled = false;
> +
> +	return ret;
> +}
> +
> +static unsigned long gen_tdata1_mcontrol(enum Tdata1Mode mode, enum Tdata1Value value)
> +{
> +	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
> +
> +	if (value & VALUE_LOAD)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_LOAD_BIT;
> +
> +	if (value & VALUE_STORE)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_STORE_BIT;
> +
> +	if (value & VALUE_EXECUTE)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_EXECUTE_BIT;
> +
> +	if (mode & MODE_M)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_U_BIT;
> +
> +	if (mode & MODE_U)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_U_BIT;
> +
> +	if (mode & MODE_S)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL_S_BIT;
> +
> +	return tdata1;
> +}
> +
> +static unsigned long gen_tdata1_mcontrol6(enum Tdata1Mode mode, enum Tdata1Value value)
> +{
> +	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
> +
> +	if (value & VALUE_LOAD)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_LOAD_BIT;
> +
> +	if (value & VALUE_STORE)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_STORE_BIT;
> +
> +	if (value & VALUE_EXECUTE)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_EXECUTE_BIT;
> +
> +	if (mode & MODE_M)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_U_BIT;
> +
> +	if (mode & MODE_U)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_U_BIT;
> +
> +	if (mode & MODE_S)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_S_BIT;
> +
> +	if (mode & MODE_VU)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VU_BIT;
> +
> +	if (mode & MODE_VS)
> +		tdata1 |= SBI_DBTR_TDATA1_MCONTROL6_VS_BIT;
> +
> +	return tdata1;
> +}
> +
> +static unsigned long gen_tdata1(enum McontrolType type, enum Tdata1Value value, enum Tdata1Mode mode)
> +{
> +	switch (type) {
> +	case SBI_DBTR_TDATA1_TYPE_MCONTROL:
> +		return gen_tdata1_mcontrol(mode, value);
> +	case SBI_DBTR_TDATA1_TYPE_MCONTROL6:
> +		return gen_tdata1_mcontrol6(mode, value);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static bool dbtr_install_trigger(struct sbi_dbtr_shmem_entry *shmem, void *tdata2,
> +				 unsigned long tdata1)
> +{
> +	struct sbiret sbi_ret;
> +	bool ret;
> +
> +	shmem->data.tdata1 = tdata1;
> +	shmem->data.tdata2 = (unsigned long)tdata2;
> +
> +	sbi_ret = sbi_debug_install_triggers(1);
> +	ret = sbiret_report_error(&sbi_ret, SBI_SUCCESS, "sbi_debug_install_triggers");
> +	if (ret)
> +		install_exception_handler(EXC_BREAKPOINT, dbtr_exception_handler);
> +
> +	return ret;
> +}
> +
> +static bool dbtr_uninstall_trigger(void)
> +{
> +	struct sbiret ret;
> +
> +	install_exception_handler(EXC_BREAKPOINT, NULL);
> +
> +	ret = sbi_debug_uninstall_triggers(0, 1);
> +	return sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_uninstall_triggers");
> +}
> +
> +static unsigned long dbtr_test_num_triggers(void)
> +{
> +	struct sbiret ret;
> +	//sbi_debug_num_triggers will return trig_max in sbiret.value when trig_tdata1 == 0

/**/ and maybe don't break the variable declaration list.

> +	unsigned long tdata1 = 0;
> +
> +	// should be atleast one trigger.

/**/

> +	ret = sbi_debug_num_triggers(tdata1);
> +	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
> +
> +	if (ret.value == 0)
> +		report_fail("sbi_debug_num_triggers: Returned 0 triggers available");
> +	else
> +		report_pass("sbi_debug_num_triggers: Returned %lu triggers available", ret.value);
> +
> +	return ret.value;
> +}
> +
> +static enum McontrolType dbtr_test_type(unsigned long *num_trig)
> +{
> +	struct sbiret ret;
> +
> +	//sbi_debug_num_triggers will return trig_max in sbiret.value when trig_tdata1 == 0

/**/ and maybe don't break the variable declaration list.

> +	unsigned long tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL6;
> +
> +	ret = sbi_debug_num_triggers(tdata1);
> +	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
> +	if (ret.value > 0) {
> +		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol6 triggers available",
> +			    ret.value);
> +		*num_trig = ret.value;
> +		return tdata1;
> +	}
> +
> +	tdata1 = SBI_DBTR_TDATA1_TYPE_MCONTROL;
> +
> +	ret = sbi_debug_num_triggers(tdata1);
> +	sbiret_report_error(&ret, SBI_SUCCESS, "sbi_debug_num_triggers");
> +	*num_trig = ret.value;
> +	if (ret.value > 0) {
> +		report_pass("sbi_debug_num_triggers: Returned %lu mcontrol triggers available",
> +			    ret.value);
> +		return tdata1;
> +	}
> +
> +	report_fail("sbi_debug_num_triggers: Returned 0 mcontrol(6) triggers available");
> +
> +	return SBI_DBTR_TDATA1_TYPE_NONE;
> +}
> +

The rest looked good (from a superficial perspective). Nice!

Thanks,
drew

