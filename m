Return-Path: <linux-kselftest+bounces-41990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B971EB8C482
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 11:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CA516B259
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 09:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71588283128;
	Sat, 20 Sep 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ltSH3R6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770427056B;
	Sat, 20 Sep 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360449; cv=none; b=DGUcE8xye63mh6l1z4s93Nldr5/hlhmtRwv79abdttGvUcgiyPeQfRiOVkpRQHz4O9qG9Mk1YCx8TDPbnxpCtV64LgME11SJsPlc3s3TDKeqNWroznKLv3dx/eC1axLWBHfMYDiAjp5f5PVFOX8oaLsiZXiEjogUlzbMpE+PRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360449; c=relaxed/simple;
	bh=z6nFBm/6KBHsni14dRJDIKagzxF52mvycFfafnL7LV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S69Db9Deo4saKSPwJU/ajAr8A+oEHHwziPwcZS7mt07xxBpljOKduyukXYD6nfVdtVQldZgGSdThtPxZDcnD+Nsj5iEDELeV7CZdyn5cLIydriTEAE5GrsbrqGBXHSEqmkfYccn9ogoigzpwujB+3NLtZ4xYlZ+oo+qVKg0yPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ltSH3R6a; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758360445;
	bh=z6nFBm/6KBHsni14dRJDIKagzxF52mvycFfafnL7LV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltSH3R6av551BbQt6pulW0ogU5VDIjQhgZtgt67XKFU+AnExhcUEA+6ZaKpO1ctfb
	 7Ju7J7ukHtTXVEq+aQanFmS7PAddtImfcNNxepeZqisfDq7dgSJnv4irflKsdKofkP
	 wy+T7iMxrverwhW+LWCxINdIF8gmPnJOHkL2OFKU=
Date: Sat, 20 Sep 2025 11:27:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 10/11] tools/nolibc: add ptrace support
Message-ID: <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-11-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919153420.727385-11-benjamin@sipsolutions.net>

On 2025-09-19 17:34:19+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add ptrace support, as it will be useful in UML.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/ptrace.h            | 52 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 +
>  4 files changed, 56 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/ptrace.h

(...)

> diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
> new file mode 100644
> index 000000000000..3119abdeeecb
> --- /dev/null
> +++ b/tools/include/nolibc/sys/ptrace.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * ptrace for NOLIBC
> + * Copyright (C) 2017-2021 Willy Tarreau <w@1wt.eu>
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +/* make sure to include all global symbols */
> +#include "../nolibc.h"
> +
> +#ifndef _NOLIBC_SYS_PTRACE_H
> +#define _NOLIBC_SYS_PTRACE_H
> +
> +#include "../sys.h"
> +#include "uio.h"
> +
> +
> +#include <linux/ptrace.h>
> +
> +/*
> + * long ptrace(int op, pid_t pid, void *addr, void *data);
> + *
> + * However, addr may also be an integer in some cases.

This comment is a bit confusing. It reads like it can be an integer as
in 'int' datatype. But the kernel expects an integer compatible with
'void *', so 'unsigned long'. I think we can drop the comment.

> + */
> +static __attribute__((unused))
> +long sys_vptrace(int op, pid_t pid, va_list args)
> +{
> +	return my_syscall4(__NR_ptrace, op, pid,
> +			   va_arg(args, void *), va_arg(args, void *));
> +}
> +
> +static __attribute__((unused))
> +ssize_t sys_ptrace(int op, pid_t pid, ...)

ptrace(2) does not document addr and data to be optional.
While it does acknowledge the fact that it is variadic on glibc,
users are still recommended to always supply all arguments.
I'd prefer to keep it simple and avoid the va_list.

> +{
> +	va_list args;
> +
> +	va_start(args, pid);
> +	return sys_vptrace(op, pid, args);
> +	va_end(args);
> +}
> +
> +static __attribute__((unused))
> +ssize_t ptrace(int op, pid_t pid, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, pid);
> +	return __sysret(sys_vptrace(op, pid, args));
> +	va_end(args);
> +}
> +
> +#endif /* _NOLIBC_SYS_PTRACE_H */

(...)

