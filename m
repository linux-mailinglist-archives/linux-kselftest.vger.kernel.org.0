Return-Path: <linux-kselftest+bounces-34548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61618AD306E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 10:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D787118845D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 08:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E8121FF27;
	Tue, 10 Jun 2025 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nov2F1o5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822727FB27
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749544346; cv=none; b=YhArMVRo6TwbKiOfYXPX4lq9waBG2v9ZRNI161TXxCcWgijIkxpqJBqPlwzM9XpTKqj9aO1gbeLcOuLxrXcrcrwSiuw8mc/45ZI2exIzoAo6kmRtEQqv4VieGIgbzYvFLPNqdba7z9L+/5kg9aDEj9I5XQEeDryN7qX7UHTHxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749544346; c=relaxed/simple;
	bh=l8Y4r9MGAhL+1QYrflRZpR2G0HHOcBdF6gCSjvgujs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9yOo3YSgHtC4RwFWwfgWl3nX4dPgSuIgJCSuRBRfhjjU5PQgY/lMRbYMea0lZI/Z8NainUF2USQ0EpoXqNRI7ZnBy4JboKuOd3/M1U5vktoKkbIsSG0zjkpbPbn5ugspdnK8miWOhyBwkbYFtHarMVJ8se2MzR8atc2VeGju2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nov2F1o5; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Jun 2025 10:32:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749544339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXQheftAQ39YV+WhThrh+6a/P9QjNT7PuajEJay5IMQ=;
	b=nov2F1o5ZiG7xNJ6c3T5U9DOAfnyHrDeZWVGyGim4Z4GlUXYZH1tIzM8XmIOs41c3rT6p2
	ivX9zAWa+0QOk9oMGkI9JztqKAdg7+3QFVQddmdDiuvyztJ0WQwpyMoj/l02V3tPJno1HE
	kl3IlyvNigy8lG2VFF+ReKB0cRuC2bo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Jesse Taube <jesse@rivosinc.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v4] riscv: sbi: Add SBI Debug Triggers Extension tests
Message-ID: <20250610-c3dda7f117f889a8da55b092@orel>
References: <20250606194503.2857119-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606194503.2857119-1-jesse@rivosinc.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 06, 2025 at 12:45:03PM -0700, Jesse Taube wrote:
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
> V3 -> V4:
>  - Include libcflat.h
>  - Remove #define SBI_DBTR_SHMEM_INVALID_ADDR
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
> index 00000000..b254f84e
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
> +#include <libcflat.h>
> +
> +#include "sbi-tests.h"

The includes should have the asm/ headers grouped separately below the
non-asm, and we typically use alphabetic order because of OCD issues,
except for libcflat.h, which typically comes first, since it's a mess of
stuff, and the idea is to order from most general to most specific. So,

 #include <libcflat.h>
 #include <bitops.h>

 #include <asm/io.h>
 #include <asm/processor.h>

 #include "sbi-tests.h"

But don't respin for just this change. I'm still hoping we'll get more
reviews of the tests wrt the spec (which I haven't yet done). If we don't
get anymore reviews in a week or so then I'll find some time for it.

Thanks,
drew

