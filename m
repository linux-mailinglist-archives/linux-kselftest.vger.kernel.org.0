Return-Path: <linux-kselftest+bounces-46684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994ABC90763
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 02:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261203AA8D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 01:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C21F239B;
	Fri, 28 Nov 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vo64VmI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176A2B9B7;
	Fri, 28 Nov 2025 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764291643; cv=none; b=eFGFI5iFsmfUPxn1M2rjIQ7M4zQx4oey5YFDoRkUlDNiaW0CKJfYacq/zoeGP0g4/W1l18+IqnLcOj0UIkjAygQVaszYTIzST+bKICYd7itLxSQMaleeDxWmrqA8ebFu9Z4Au1+6iacO+E8AF5F+Z6m4HAMtHKRwRiY6tH45GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764291643; c=relaxed/simple;
	bh=doQNQVjX5gzH9viI90sy1PNB8kPkhOLcK0JU7QzXtI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjEqkDoqrQT1YgOzA04fpOGUw79JVUrrPIK+wkOC36i/wHGfHXUqYNgo5mhzu6C98glAD8/Xsx2ZpbqOvaDcLuLN5gxFgOD8lJXqYu7jzTooqcOHTY4JqXWoFQ5PF+0xJHQ85EAZGsN/Vv0agRkpK4Vlh0AzRGOLq4AL0wnrofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vo64VmI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD7C4CEF8;
	Fri, 28 Nov 2025 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764291642;
	bh=doQNQVjX5gzH9viI90sy1PNB8kPkhOLcK0JU7QzXtI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vo64VmI/+0QOZAK742UfLnsbLT53foZdXeTVF9+zHsAT2N/tPYGhpUgQOqpGfJ2Rd
	 J/tN+rWvSE3meg9UvbQFiF3B5yY0NAmxfjM4XLQAUu0jt1V0V9zxUaE9JITETsyz/b
	 Ssgrq71t9qb9B8Q8B7r/z9JLbZCFmjMYRT5J22sXG3yxsygwcVv7ynNvyQMeMR+0ng
	 RLF6QwVOGbIZjNcrHXDNp4Fm2imTrVNmlmEsVoBFa3zkgQMjJRJp7EX8+bqkWI/YQH
	 ZFqKk3gMjhfq4Z6VSW+U6k+kLshVUPmJYkeJxRqkx6QWFCnMptQnBw/fSAollVizDm
	 izfGj0aCvy9tQ==
Date: Thu, 27 Nov 2025 17:00:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Shuah Khan <shuah@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>
Subject: Re: [PATCH] selftests: mptcp: initialize raw_addr to Null
Message-ID: <20251127170041.0613c50e@kernel.org>
In-Reply-To: <795a8f3c-eff7-46d9-9175-a4ebe3f9ffd8@kernel.org>
References: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
	<795a8f3c-eff7-46d9-9175-a4ebe3f9ffd8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 17:55:14 +0100 Matthieu Baerts wrote:
> I confirm this, I can reproduce the warning with Clang 21.
> 
> It is indeed a false positive, because the code does that:
> 
> 
>   if (addr.ss_family == AF_INET)
>           raw_addr = &(((struct sockaddr_in *)&addr)->sin_addr);
>   else if (addr.ss_family == AF_INET6)
>           raw_addr = &(((struct sockaddr_in6 *)&addr)->sin6_addr);
>   else
>           xerror("bad family");
> 
> 
> "xerror()" calls "exit(1)", so "raw_addr" is never used uninitialized.
> 
> I'm not sure why Clang 21 reports that now, and not before, but well,
> the modification you did in the selftests doesn't hurt:

I think annotating xerror with __noreturn is a better fix.
Including kselftest.h will be needed.
-- 
pw-bot: cr

