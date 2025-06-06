Return-Path: <linux-kselftest+bounces-34417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14491ACFE85
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 10:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C857A4FB0
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C82284662;
	Fri,  6 Jun 2025 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ib1Pd6/q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D387219317
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Jun 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749199721; cv=none; b=gkTuP+MzAbu8taxutU3WDylrHmHQR3xzWsy8hCY0MFVZkQkiymLJp60SL1Eq3vQrj/bOAEy0sWVl9Y4O+R1o5VhFJNrt7LVlBHQvRgP4/tEd7eRSyakErMTuMZHn5NrIxmDi4BufZwg12mSpuk4f7x6ELshQBnDx50UZk7nH94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749199721; c=relaxed/simple;
	bh=rhpFpuyN7zh3nq9+tih0BO5vmVh66kWrJLMHFpty9uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/dJq9GBqsuYCxip0BmMG6RAffxCVH78/6DSjaTe80lCici1EEJ6Jupln7BIv/94jVojGx/olIa6mAXg/R09h9gWSTGb1v7oHJiLUYv0iryWIoIW4/h7YW3V6E/ZiK5zAjPPGw9D67RIoIch0bxAveY10OiXoXW6ogx3g/MNatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ib1Pd6/q; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 6 Jun 2025 10:48:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749199717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y0ncs7BntoLmuGjS33PPF7FAyz1oiPPPcRfIV0w5m8=;
	b=Ib1Pd6/qGTY380nEHOlMndskLTkkdMiTv3zcj2QyRFSWXWjgCG6sHcIw0NJVA4j1I5PePi
	VSL16V3jHFtLhDE2zVtrPwdn7kBC+13ztukljn65fDsNFgojEFZzSWyvFG2sRFDs4McZfu
	LlT81dtXkToPhuGk5Syujhj6KM5SDgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Himanshu Chauhan <hchauhan@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [kvm-unit-tests PATCH v3 2/2] riscv: sbi: Add SBI Debug Triggers
 Extension tests
Message-ID: <20250606-1b7c5285a3c731597f970c1d@orel>
References: <20250605161806.1206850-1-jesse@rivosinc.com>
 <20250605161806.1206850-2-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605161806.1206850-2-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 05, 2025 at 09:18:06AM -0700, Jesse Taube wrote:
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
> V2 -> V3:
>  - Change SBI_DBTR_SHMEM_INVALID_ADDR to -1UL
>  - Move all dbtr functions to sbi-dbtr.c
>  - Move INSN_LEN to processor.h
>  - Update include list
>  - Use C-style comments
> ---
>  lib/riscv/asm/sbi.h |   1 +
>  riscv/Makefile      |   1 +
>  riscv/sbi-dbtr.c    | 811 ++++++++++++++++++++++++++++++++++++++++++++
>  riscv/sbi-tests.h   |   1 +
>  riscv/sbi.c         |   1 +
>  5 files changed, 815 insertions(+)
>  create mode 100644 riscv/sbi-dbtr.c
> 
> diff --git a/lib/riscv/asm/sbi.h b/lib/riscv/asm/sbi.h
> index a5738a5c..78fd6e2a 100644
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
> index 00000000..a4bfa41e
> --- /dev/null
> +++ b/riscv/sbi-dbtr.c
> @@ -0,0 +1,811 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SBI DBTR testsuite
> + *
> + * Copyright (C) 2025, Rivos Inc., Jesse Taube <jesse@rivosinc.com>
> + */
> +
> +#include <asm/io.h>
> +#include <bitops.h>
> +#include <asm/processor.h>
> +
> +#include "sbi-tests.h"

Still missing at least libcflat.h (report_*). I'm not a big fan of
libcflat.h (a collection of random stuff...), but until somebody
gets around to dividing it up correctly, then pretty much every
unit test file will need it.

> +
> +#define SBI_DBTR_SHMEM_INVALID_ADDR	(-1UL)

I was going to complain that my suggestion to use get_invalid_addr() was
ignored, but now I see that SBI_DBTR_SHMEM_INVALID_ADDR isn't used at all?

Thanks,
drew

