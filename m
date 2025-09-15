Return-Path: <linux-kselftest+bounces-41467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207EB5734B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EDD3B935C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C732D8771;
	Mon, 15 Sep 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="f1ZBdQBE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8320126A;
	Mon, 15 Sep 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925848; cv=none; b=hhrDzoez0kRUehzEFHC8gTFxag8RblsnKm9aMN6+dyt4QuElQXvzPaFUGk7SZ0xBiBkOuhoGiJCl1N7MmtPvQAUrOi+32RPC0WZqP60ASda22g9c/BiKYVE3tZ4frhxzXVHtjr8JnRYMZP0SeV2EE4IyH0a+PMTy7ecqJzXSbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925848; c=relaxed/simple;
	bh=W7YV6hJok7RI7aIC5/O+0Zf8j9sxTcMFC7JXs2vghfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgE/2+fnnRMb6uyr7+O7C5cqKrS118Px4XS6FBkgGx8U+Bu0XC877rWfVrXKKtFKn78vIoIFhjFtNR5knCKDJMxW/JyYiHjn0AVzXVyukG+JiRYgjcXIqQp4EHPdryqJpmj0lTQ37fSqdPOJSidbwk412jC/3z7sF2J9x+ePi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=f1ZBdQBE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757925843;
	bh=W7YV6hJok7RI7aIC5/O+0Zf8j9sxTcMFC7JXs2vghfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1ZBdQBEYc3/z2O/Aj+4tZn08J9dct6xRNwTUZo6NBfL7W5Eu9vMbnnEYKHU/liah
	 M70KnmXBRAKkLsBCRhodgQkoXeQ1LCgOJDfJoj+2dsBv72++lHE/wT4QrO1xQVhZgg
	 slLFoTtS1TKdfVYKF0nu5gqqKFyKsVgYj2AIaFWI=
Date: Mon, 15 Sep 2025 10:44:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 3/9] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <58366c48-99b6-430a-a05c-51a2a5e044a7@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-4-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-4-benjamin@sipsolutions.net>

On 2025-09-15 09:11:09+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
> the perror function does not make any sense then and cannot compile.
> 
> Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
>  tools/include/nolibc/stdio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
> index 7630234408c5..c512159b8374 100644
> --- a/tools/include/nolibc/stdio.h
> +++ b/tools/include/nolibc/stdio.h
> @@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
>  	return ret;
>  }
>  
> +#ifndef NOLIBC_IGNORE_ERRNO
>  static __attribute__((unused))
>  void perror(const char *msg)
>  {
>  	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
>  }
> +#endif
>  
>  static __attribute__((unused))
>  int setvbuf(FILE *stream __attribute__((unused)),
> -- 
> 2.51.0
> 

