Return-Path: <linux-kselftest+bounces-35574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD0FAE315E
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 20:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3538B16EBBA
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7EB1F3BB0;
	Sun, 22 Jun 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C5m/xxEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA32260C;
	Sun, 22 Jun 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750617363; cv=none; b=dLuRFsGepysAwGRssFLdSAIPFuYN2HzjNKaRVQCYyWQNPTJX/NDF0kBu+Tt0FXqhny01dgU7zGNCN2vMRePxiVptdx6z56i1/tZlHI2ul0eN4UcChd2mHOCGyTMbaFJkExefAA/pFMwsXzapWJCijYg6WByzLF3ueGLNh14WA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750617363; c=relaxed/simple;
	bh=74GqlgIiDhynRlelDlhRCU5mMVYWtekqKF4X9s/IWjg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=giLCtkaysLWgutmpUbcNupW2nXh7W20c/bWPwC8bl+o9I8hk+25OJCaloftjJ/llkq2R8wLjR1PpbPto9GRsIwqjrGDC9aHy0/hlDEq74RURoOL5Uc+UvRDAeb3di89dy6lhwynMurpc6HkOsfi3s7B8nz6k3khuFfga9jgbH50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C5m/xxEt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08FEC4CEE3;
	Sun, 22 Jun 2025 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1750617363;
	bh=74GqlgIiDhynRlelDlhRCU5mMVYWtekqKF4X9s/IWjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C5m/xxEtnJ7Bc2jdWi+xj2YbFPfNwohpei3vh6LYGbIf8LnikSWdQ8NJJlVhwp9iK
	 XoJEpgrk5uWqYJLLzN7htW29EuwXaMNVJKBYW33Ku1ms5UXWKed7gtR799ta1j7eaF
	 W3PPbOUKNJWe7q3GoEurXpvYsCl2D2f74mR+5dOk=
Date: Sun, 22 Jun 2025 11:36:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Achill Gilgenast <fossdd@pwned.life>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [RESEND PATCH v2] kallsyms: fix build without execinfo
Message-Id: <20250622113602.48092b368afc5f1729b45cb6@linux-foundation.org>
In-Reply-To: <20250622014608.448718-1-fossdd@pwned.life>
References: <20250622014608.448718-1-fossdd@pwned.life>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Jun 2025 03:45:49 +0200 Achill Gilgenast <fossdd@pwned.life> wrote:

> Some libc's like musl libc don't provide execinfo.h since it's not part
> of POSIX. In order to fix compilation on musl, only include execinfo.h
> if available (HAVE_BACKTRACE_SUPPORT)
> 
> This was discovered with c104c16073b7 ("Kunit to check the longest symbol length")
> which starts to include linux/kallsyms.h with Alpine Linux' configs.
> 
> ...
>
> --- a/tools/include/linux/kallsyms.h
> +++ b/tools/include/linux/kallsyms.h
> @@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned long addr,
>  	return NULL;
>  }
>  
> +#ifdef HAVE_BACKTRACE_SUPPORT
>  #include <execinfo.h>
>  #include <stdlib.h>
>  static inline void print_ip_sym(const char *loglvl, unsigned long ip)

I'm not seeing anything in there which needs execinfo.h.  Can we simply
remove the inclusion?



