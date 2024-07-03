Return-Path: <linux-kselftest+bounces-13130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5D926385
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE541C214A7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85117B424;
	Wed,  3 Jul 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XedO6SOC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF8118C08;
	Wed,  3 Jul 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017389; cv=none; b=Y46P7DHjy3XcqDLA3jRyeL52GNU4fOMTc9IGaX5o+9Bg+5/7ptJYBLwdx+dvnoQCeMMnA/wB9n+ygpSIhXRkhG3DeljcMREwxB323yDHrt+lUOjDTGy1s6tFYWog+o7ZBv+qiM06+C929AoecanFUjjuacgvCENr67d5gghtq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017389; c=relaxed/simple;
	bh=0FRQ/R/L7Gbr+E5NMPB583fDoSDZ+fMcFqkwqezzyfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6dkUzR6YPa4UZ6QDJCF5Qt3/X8WkS6dPm3bdusbc/hXyeFmF193/O4oCQrsSgZQnYaz0IpPfq86h3feeZv45luXqdcY913OE+uoJXf1ROu2Ihlxuf33/fpKzB+HIDE9GB4G3qnQovp9u76uvI67GFLhqHTQK+bD4pEstHcxut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XedO6SOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72812C2BD10;
	Wed,  3 Jul 2024 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720017388;
	bh=0FRQ/R/L7Gbr+E5NMPB583fDoSDZ+fMcFqkwqezzyfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XedO6SOC064WlD2AAR0roKkRMad5NWj+aUN3DQmnvW/HYoyZmxgXCAzgtENP6rlhI
	 85KCzyuwI7Fb/du6Ne9/B2/MTPHqnCOALJxyz3ST1/fVmJDyqFIYNZcs/af/Sk4g6K
	 MI7YjtLkcJMsJPUlPk464hFjVNW3y8eHxn7/GYb0=
Date: Wed, 3 Jul 2024 16:36:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Roman Kagan <rkagan@amazon.de>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	linux-kselftest@vger.kernel.org, nh-open-source@amazon.com,
	linux-mm@kvack.org, David Woodhouse <dwmw@amazon.co.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 3/3] drivers/misc: add test driver and selftest for
 proclocal allocator
Message-ID: <2024070305-dining-giggly-587b@gregkh>
References: <20240621201501.1059948-1-rkagan@amazon.de>
 <20240621201501.1059948-4-rkagan@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621201501.1059948-4-rkagan@amazon.de>

On Fri, Jun 21, 2024 at 10:15:01PM +0200, Roman Kagan wrote:
> Introduce a simple driver for functional and stress testing of proclocal
> kernel allocator.  The driver exposes a device node /dev/proclocal-test,
> which allows userland programs to request creation of proclocal areas
> and to obtain their addresses as seen by the kernel, and in addition to
> read and write kernel memory at arbitrary address content (simplified
> /dev/kmem good enough to access proclocal allocations under selftest
> responsibility).
> 
> The driver is not meant for use with production kernels, as it exposes
> internal kernel pointers and data.

Then you MUST taint the kernel and throw up huge warnings whenever it is
loaded, otherwise distros will build this in and end up running it.


> 
> Also add a basic selftest that uses this driver.
> 
> Signed-off-by: Roman Kagan <rkagan@amazon.de>
> ---
>  drivers/misc/Makefile                         |   1 +
>  tools/testing/selftests/proclocal/Makefile    |   6 +
>  drivers/misc/proclocal-test.c                 | 200 ++++++++++++++++++
>  .../selftests/proclocal/proclocal-test.c      | 150 +++++++++++++
>  drivers/misc/Kconfig                          |  15 ++
>  tools/testing/selftests/proclocal/.gitignore  |   1 +
>  6 files changed, 373 insertions(+)
>  create mode 100644 tools/testing/selftests/proclocal/Makefile
>  create mode 100644 drivers/misc/proclocal-test.c
>  create mode 100644 tools/testing/selftests/proclocal/proclocal-test.c
>  create mode 100644 tools/testing/selftests/proclocal/.gitignore
> 
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 153a3f4837e8..33c244cee92d 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -69,3 +69,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_PROCLOCAL_TEST)	+= proclocal-test.o
> diff --git a/tools/testing/selftests/proclocal/Makefile b/tools/testing/selftests/proclocal/Makefile
> new file mode 100644
> index 000000000000..b93baecee762
> --- /dev/null
> +++ b/tools/testing/selftests/proclocal/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_GEN_PROGS := proclocal-test
> +CFLAGS += -O2 -g -Wall $(KHDR_INCLUDES)
> +
> +include ../lib.mk
> diff --git a/drivers/misc/proclocal-test.c b/drivers/misc/proclocal-test.c
> new file mode 100644
> index 000000000000..9b3d0ed9b2f9
> --- /dev/null
> +++ b/drivers/misc/proclocal-test.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 Amazon.com, Inc. or its affiliates. All rights reserved.
> + * Author: Roman Kagan <rkagan@amazon.de>
> + *
> + * test driver for proclocal memory allocator
> + */
> +
> +#include <linux/compat.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/workqueue.h>
> +#include <linux/file.h>
> +#include <linux/secretmem.h>
> +
> +struct proclocal_test_alloc {
> +	u64 size;
> +	u64 ptr;

This structure is not defined properly to cross the user/kernel boundry :(

> +};
> +
> +#define PROCLOCAL_TEST_ALLOC _IOWR('A', 0x10, struct proclocal_test_alloc)

ioctl definitions belong in a .h file for userspace to be able to see
them.

> +
> +#define BOUNCE_BUF_SIZE PAGE_SIZE

Then why not just use PAGE_SIZE everywhere?  Less characters and we all
know what that is.

Stopped reviewing here, sorry.

greg k-h

