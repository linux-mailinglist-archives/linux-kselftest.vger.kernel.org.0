Return-Path: <linux-kselftest+bounces-42360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D3BA0931
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A944E60A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8FA3054CE;
	Thu, 25 Sep 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KIJFo2If"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E7B21E091;
	Thu, 25 Sep 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817374; cv=none; b=NsHL84Z7KDXLtpWp10h3G6Cdw4IUxb7bYaT7s7dXq/0UiVmwCQIovWZ5/pt0ryP5UpS8eIk4NvbYcCFhBnV42m7B/19ZyHmfCoA0E80hCmX2y/7TpCkr410vtsBioN9HZTBxELScwXyUsmDFjoQo7G0fIeLlh/dyBcdPEkVJovc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817374; c=relaxed/simple;
	bh=RBud7OQ2jUtgpnGtQOxRUyC0yTtZ3Qj+k8iRs6JRHF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO7dUWZp2JgV1GXdQUt2ehLakEA4j+8baSoU/ISiOq3Fwvgpszs5civewW845bQq8jNS2vsz5jPinfzyFGxt4oBeK+MgKP8x8AANjcjWqElrMJYalwewumsCJAYNBlndseSZvuDzh2lWPphFFz6gzixCNAE6ZXYmtpKVe8EuwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KIJFo2If; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758817370;
	bh=RBud7OQ2jUtgpnGtQOxRUyC0yTtZ3Qj+k8iRs6JRHF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIJFo2IfVAzMVX89HOCJZv2LL3LS5hSk+uiTr4b8yKvAj/Is0C8uoHcDKeAeyCOxA
	 pu9rQFPJRaS5SF8col0S2MA05VlzA8fxsDFZDer1lNawV9crvU9bAjq2XV7KNnAmg2
	 g7ZR6ENvI9ZUhj7d9BtN8kX4qHGy5Tp52+z3UD+Y=
Date: Thu, 25 Sep 2025 18:22:49 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v3 03/12] tools/nolibc/stdio: let perror work when
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <8428cee5-d739-44a7-8253-93f663f9e969@t-8ch.de>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
 <20250924142059.527768-4-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250924142059.527768-4-benjamin@sipsolutions.net>

On 2025-09-24 16:20:50+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> simply print the message with "unknown error" rather than the integer
> value of errno.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> 
> ---
> v3:
> - Change the message instead of removing perror entirely
> ---
>  tools/include/nolibc/stdio.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 7630234408c5..724d05ce6962 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -600,7 +600,11 @@ int sscanf(const char *str, const char *format, ...)
>  static __attribute__((unused))
>  void perror(const char *msg)
>  {
> +#ifdef NOLIBC_IGNORE_ERRNO
> +	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
> +#else
>  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
> +#endif
>  }
>  
>  static __attribute__((unused))
> -- 
> 2.51.0
> 

