Return-Path: <linux-kselftest+bounces-44323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B9C1C481
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B2518850CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7C2F549E;
	Wed, 29 Oct 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6Woaoc4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87922D24B4;
	Wed, 29 Oct 2025 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756620; cv=none; b=fLyqJBIUSfwzjhySHK8lDfWOkJm05MwhrWrH83cnPlDJ+NQVnNe9a953f1XfNyC3rQIighhrPpQ9/G3cDBNftAjLHbLskynNiv5ozcF50lRTfXoF7K8l/4Rg/C23M9Oasc0P6Zr6y6Q8rxnKQgHanIj1N5XX7zQM1T2j7Q2RCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756620; c=relaxed/simple;
	bh=hYRW+X8pMcb2ZzVrrEksNmJaTmIrkeo60sx4OKvUG/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+PgV/PiCUp0oSvQllIwPavzUItF2sC/zCOQGB0Q5gN6YrN2aqgNDnUJA+8o7tSvkx1KS3G2SoE5eyT28yY5FhaCinWOIfOlzDSf3729i+FQBloGKz5jas00F3/Nd8Bit9EJRKxdhn9Fe/vGSqscmPZPK0ystpbvPnUPS2y65m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6Woaoc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76D7C4CEF8;
	Wed, 29 Oct 2025 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756619;
	bh=hYRW+X8pMcb2ZzVrrEksNmJaTmIrkeo60sx4OKvUG/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6Woaoc4Cq9YOMkKIKv2HpuqXctdbQekZkN35NcSt4n5u61/TX//refZ5Fl0ZfxPq
	 rvlicEr42rRJWnckoASNCLBFdHLsHL9rD+DphTWfa/VaRLsba7cTXq3qjwB84wDmtZ
	 VUPeLMyN84QltryqfVHceXniiOOimw9pKgtojngcalu6rc+VtqJcjcRyWef1o1+DkP
	 Kdnc6ZqT/KdUchdG2390Fp4Ls337BjjTde0EnKkC8HyR6xDSTr5S2LBtHQcfgQQHpw
	 wdXPi49mF7OeFM2mZWkAo7iVbX0H84m7e5FPsQy7y4mpiTr7Mih21f5rXCgxw9pjCL
	 zZhRS5gb6Sy9g==
Date: Wed, 29 Oct 2025 16:50:14 +0000
From: Simon Horman <horms@kernel.org>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v2] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQJFxrzPh-87QU5K@horms.kernel.org>
References: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028172947.53153-1-ankitkhushwaha.linux@gmail.com>

On Tue, Oct 28, 2025 at 10:59:47PM +0530, Ankit Khushwaha wrote:
> Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
> arg, but tests were using int variables. This causes -Wpointer-sign 
> warnings on platforms where socklen_t is unsigned.
> 
> Change the variable type from int to socklen_t to resolve the warning and
> ensure type safety across platforms.
> 
> warning fixed:
> 
> sctp_collision.c:62:70: warning: passing 'int *' to parameter of 
> type 'socklen_t *' (aka 'unsigned int *') converts between pointers to 
> integer types with different sign [-Wpointer-sign]
>    62 |                 ret = recvfrom(sd, buf, sizeof(buf), 
> 									0, (struct sockaddr *)&daddr, &len);
>       |                                                           ^~~~
> /usr/include/sys/socket.h:165:27: note: passing argument to 
> parameter '__addr_len' here
>   165 |                          socklen_t *__restrict __addr_len);
>       |                                                ^
> 
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

