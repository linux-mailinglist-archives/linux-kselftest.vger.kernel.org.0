Return-Path: <linux-kselftest+bounces-42362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23189BA099D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64373AA844
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0960305E18;
	Thu, 25 Sep 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Uq19cwaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1C3054CE;
	Thu, 25 Sep 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817727; cv=none; b=RD2z7ssP1ovDFhagwcq3WpRu65FUNMAZRZRQUY1fC+wQw1PRIW0OUkQ2CIbJIas+e0rXapVtW9oTcrgm0YGi9+FXNzQvaI1vK8soGiImPP9/ORGVruTgG8pWAM4r89IYiwTFNeUI2vr4kB05TxbylLkiZM6o5vEzs6E5nt4hPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817727; c=relaxed/simple;
	bh=ViftyZNJLwL+w43YF2pKIJLCB+qRR8fKArxSDZUl458=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKrOKE7FRbvs6u31dKMuAkBpF1+LXMgdfspPpLH9c/BSfanva2GPuOiHTTbD5OfU/k6Kbd+PCPTpKxLM+NltrRIhrHViBDNZ/IHXt4M19CalAzz3w8GYETWn6JCk1bjNizka15VrC5s6qrtglkUo1ZIhuWXQGSVcODXIYd+PSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Uq19cwaR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817723;
	bh=ViftyZNJLwL+w43YF2pKIJLCB+qRR8fKArxSDZUl458=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq19cwaR8MNLNlnMZiQ/x32HF5WWgKHLRObfDyvuEuTzGRcJ88eLayfIB4O2kkbv4
	 EX67BIPp6RGg9Orbsm5ZMVm0m/HXmjHM2O62YDyPxgG4qfvzydL2Dt9P6vXLXFBpbd
	 j9C8/0tJhURuk6CvyrVL7zFnM5iLGyi8vTuSNep4=
Date: Thu, 25 Sep 2025 18:28:41 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 11/12] tools/nolibc: add ptrace support
Message-ID: <b2f2a592-da69-4fdb-8d84-8354895b3295@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-12-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924142059.527768-12-benjamin@sipsolutions.net>

On 2025-09-24 16:20:58+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Add ptrace support, as it will be useful in UML.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> ---
> v3:
> - Only use variardic for ptrace and not for sys_ptrace
> ---
>  tools/include/nolibc/Makefile                |  1 +
>  tools/include/nolibc/nolibc.h                |  1 +
>  tools/include/nolibc/sys/ptrace.h            | 44 ++++++++++++++++++++
>  tools/testing/selftests/nolibc/nolibc-test.c |  2 +
>  4 files changed, 48 insertions(+)
>  create mode 100644 tools/include/nolibc/sys/ptrace.h

(...)

> diff --git a/tools/include/nolibc/sys/ptrace.h b/tools/include/nolibc/sys/ptrace.h
> new file mode 100644
> index 000000000000..5d1e52965878
> --- /dev/null
> +++ b/tools/include/nolibc/sys/ptrace.h
> @@ -0,0 +1,44 @@
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
> + */
> +static __attribute__((unused))
> +long sys_ptrace(int op, pid_t pid, void *addr, void *data)
> +{
> +	return my_syscall4(__NR_ptrace, op, pid, addr, data);
> +}
> +
> +static __attribute__((unused))
> +ssize_t ptrace(int op, pid_t pid, ...)
> +{
> +	ssize_t ret;
> +	va_list args;
> +
> +	va_start(args, pid);
> +	ret = __sysret(sys_ptrace(op, pid,
> +				  va_arg(args, void *),
> +				  va_arg(args, void *)));
> +	va_end(args);

My understanding of the last discussion was not to use varargs here
either. Instead I wanted to stick to the prototype from the manpage.

> +
> +	return ret;
> +}
> +
> +#endif /* _NOLIBC_SYS_PTRACE_H */

(...)

