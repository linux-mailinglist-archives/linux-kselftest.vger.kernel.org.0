Return-Path: <linux-kselftest+bounces-41469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E1B57395
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B303B6B4F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Sep 2025 08:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7B02F6191;
	Mon, 15 Sep 2025 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rBMdOFgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9062F617B;
	Mon, 15 Sep 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926222; cv=none; b=fhQu8nyH5jD4T2Ddrt/Lv+cFMPWhqayqMzKzEwvwIMHjEYo13cofPwTqWJD6y20MB59zWdhVxgB+IHgtmekoGp4+EJUdbnOFrgiiMhR8xOi48jhJexaUL7B/DCraZSUoZykVDdPWihenh5SvPqYQgk5dMWyza7Wiu2nUcBtZ2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926222; c=relaxed/simple;
	bh=8Abhke+wAvVYQkvLFpimTgcFAOpAqB5J5c1BWvnj6sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGEQ+CipaG8MAWJUNZiXlDjw3x4DDKDEEn42xtLjG9pECFZT1i+N26CXPtbNkCzateAv5sPzqrtWaRmjwAA2eVW6ziR4+O6la9l5FJqJMAbv92NB9hj+Rj/GD5uUlJJsiejgFmCU2sWTqU2bFJgTZa7hnTSCxQS3GlAMaEpqPl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rBMdOFgF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757926217;
	bh=8Abhke+wAvVYQkvLFpimTgcFAOpAqB5J5c1BWvnj6sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBMdOFgFALT5WBUoAQ3UCud5d0XBSQHOm5o/wLr6dqavwRynzE/b8lWzZJtGaBEW9
	 5cnjmGg7XyPtoDgqeOxq7odOl+cH7/3jWrloetMLDKPtisbhntuPKPnvsjiLR5GztA
	 YlI7LMu/EBnU+uOJG/sfCyyM261B2xHyAkJypUF8=
Date: Mon, 15 Sep 2025 10:50:17 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-kernel@vger.kernel.org, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 5/9] tools/nolibc: use __fallthrough__ rather than
 fallthrough
Message-ID: <6fff1ac0-2868-4377-b8a3-c10fe1a4c1f5@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-6-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915071115.1429196-6-benjamin@sipsolutions.net>

On 2025-09-15 09:11:11+0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Use the version of the attribute with underscores to avoid issues if
> fallthrough has been defined by another header file already.

Not a really big fan, but as the underscore variant is documented there
shouldn't be an issue.

Acked-by: Thomas Weißschuh <linux@weissschuh.net>

> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  tools/include/nolibc/compiler.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
> index 369cfb5a0e78..87090bbc53e0 100644
> --- a/tools/include/nolibc/compiler.h
> +++ b/tools/include/nolibc/compiler.h
> @@ -41,8 +41,8 @@
>  #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
>  #endif /* __nolibc_has_attribute(no_stack_protector) */
>  
> -#if __nolibc_has_attribute(fallthrough)
> -#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
> +#if __nolibc_has_attribute(__fallthrough__)
> +#  define __nolibc_fallthrough do { } while (0); __attribute__((__fallthrough__))
>  #else
>  #  define __nolibc_fallthrough do { } while (0)
>  #endif /* __nolibc_has_attribute(fallthrough) */
> -- 
> 2.51.0
> 

