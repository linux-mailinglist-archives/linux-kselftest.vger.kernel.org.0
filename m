Return-Path: <linux-kselftest+bounces-28183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF241A4D586
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 08:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632B23A94B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3ED1F9F72;
	Tue,  4 Mar 2025 07:59:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1A61F8BC5;
	Tue,  4 Mar 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075170; cv=none; b=rhZA17ELPU89k2ZdAElVNp1hekPC0NT9kq8KNFIL/KhKtAsW2bbVylpeR8n1T1z0oOjyk+KOqYI6cOJZJbp78CIDeVAJ+nlhMF969D6/8mO8U/hW/8WlMYU2tb5WPcpRZAK6icPTbGnF4ZjzQObC3xVMjjuKGRg6GelCH9wp5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075170; c=relaxed/simple;
	bh=Nabd75DYqiDSzGCMHIZ7qTgGtVKvqbVvwK98tZlQKAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Cyj962WFSDOxTORmFzseXUYoABW7vhDvWPXv63nyKHRck1H9LWVQSJUrSenKxWSuLp/PA37u/kXlnPIVTg5B9PyWeTtLHsoaWfVyx1ppWwv6+FYZp+T/S/9XxVTQ131D0b36s96mb0MmXEm+AU8iknTseg0weii4lp5VIPpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5247xNcc010207;
	Tue, 4 Mar 2025 08:59:23 +0100
Date: Tue, 4 Mar 2025 08:59:23 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 25/32] tools/nolibc: allow different write callbacks in
 printf
Message-ID: <20250304075923.GC9911@1wt.eu>
References: <20250304-nolibc-kselftest-harness-v1-0-adca7cd231e2@linutronix.de>
 <20250304-nolibc-kselftest-harness-v1-25-adca7cd231e2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304-nolibc-kselftest-harness-v1-25-adca7cd231e2@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 04, 2025 at 08:10:55AM +0100, Thomas Weiﬂschuh wrote:
> Decouple the formatting logic from the writing logic to later enable
> writing straight to a buffer in sprintf().
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/include/nolibc/stdio.h | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 262d0da4da9062e0c83b55661b2509f36548cf88..434fbaddae7a216159fecf618da85889d631dff7 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -208,13 +208,15 @@ char *fgets(char *s, int size, FILE *stream)
>  }
>  
>  
> -/* minimal vfprintf(). It supports the following formats:
> +/* minimal printf(). It supports the following formats:
>   *  - %[l*]{d,u,c,x,p}
>   *  - %s
>   *  - unknown modifiers are ignored.
>   */
> -static __attribute__((unused, format(printf, 2, 0)))
> -int vfprintf(FILE *stream, const char *fmt, va_list args)
> +typedef int (*_printf_cb)(intptr_t state, const char *buf, size_t size);

Keep in mind these ones will appear in the application, so you'd rather
appropriate the type name by prefixing it with "nolibc" as we've done in
a few macros and internal structs.

> +static __attribute__((unused, format(printf, 3, 0)))
> +int _printf(_printf_cb cb, intptr_t state, const char *fmt, va_list args)
       ^^^^^^^
Here as well, since it's not meant to be exposed to the application.

> +static int _fprintf_cb(intptr_t state, const char *buf, size_t size)

Likewise here I think.

Willy

