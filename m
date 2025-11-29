Return-Path: <linux-kselftest+bounces-46733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E0C9465E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 19:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 608074E07D1
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BC30F55A;
	Sat, 29 Nov 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZfUbP+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F67822B8D0;
	Sat, 29 Nov 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439994; cv=none; b=uHLXTFFboSubJwUfcNFzl39jqMe/GD4zT5ctRFIkdTKJpm6XGZFjzbcrzwU1f33c9v0KNqYX/UuBfsOxzNrz09H7NzBhrKsUhK2LHJAoJIltuvdOMBwccaOlFCx0GIPCk7a1US9ehkDH6WdSVI4Iswly2gdKCsHvsysJRZdWQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439994; c=relaxed/simple;
	bh=42tzrt0dPQlEozR73wF9tTz1fZg9k5oEYTbXNvSV2Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7/dze4eMBFFa6Q6jYqHADoTP2Ee8LmYMDcJqnccos+PNd+aRsX5GoLMt68tdTgrQ0Ve3OZES6GTvgaSz1TTR6Vp3kKws+TA886IOwk4823qp+KufVW9ieLRQYkwyFJyXA8y/A1vo+7zz5ntwNy7i69Q/qJKWg8McBCaiWK65kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZfUbP+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE09C4CEF7;
	Sat, 29 Nov 2025 18:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764439994;
	bh=42tzrt0dPQlEozR73wF9tTz1fZg9k5oEYTbXNvSV2Zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XZfUbP+lUUlRaHrCg56ZiWX3Io7EljOf3UHGrnQmZf6FRzr6GqWkdjVozwimmGZwA
	 6iYSqXxu/zdK4he9vvpjkb81cozT79MAZi6s0ZHNiI5C5pOE7sFpMKpFlLhZrVCytC
	 KrITYUFCaHBX9NBd7hu8bkovwSnrKvTN4FZCJyARdvSHVGZN4V9SWhShkoylwv9lgk
	 HJQMnKgVfuOSnVLufnzOsRhszboTSuzfn7p+hApe1958pKb7J/dHZGffzUOjwUAJi9
	 yVpjx66CRIW/d1e8Qvptsk7vimOCK917lbttfx2n5f0+3FFieQ5jhWqMsBDNSSsZS/
	 0+2G9Y6Gjehdw==
Message-ID: <632d57cf-becd-4d09-bb21-0e3db6776c49@kernel.org>
Date: Sat, 29 Nov 2025 19:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ankit,

On 29/11/2025 05:38, Ankit Khushwaha wrote:
> Compiler reports potential uses of uninitialized variables in
> mptcp_connect.c when xerror() is called from failure paths.
> 
> mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
>       uninitialized whenever 'if' condition is false
>       [-Wsometimes-uninitialized]
> 
> xerror() terminates execution by calling exit(), but it is not visible
> to the compiler & assumes control flow may continue past the call.
> 
> Annotate xerror() with __noreturn so the compiler can correctly reason
> about control flow and avoid false-positive uninitialized variable
> warnings.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> changelog:
> v2: 
> - annotate 'xerror()' with __noreturn
> - remove defining 'raw_addr' to NULL

Thank you for the new version!

Note: this patch can target 'net' instead of 'net-next'.

> ---
>  tools/testing/selftests/net/mptcp/Makefile        | 4 ++++
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_inq.c     | 3 ++-
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 3 ++-

Good idea to fix the other tools too!

>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index 15d144a25d82..4c94c01b893a 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -35,3 +35,7 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
>  EXTRA_CLEAN := *.pcap
> 
>  include ../../lib.mk
> +
> +$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
> +$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
> +$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include

Small detail: I think you can simply append the "main" CFLAGS at the top
of the file instead of adding specific rules per tool.

Note: because the CFLAGS variable is already long, please split it like
it is done in tools/testing/selftests/net/Makefile.

While at it, do you mind adding __noreturn to die_perror() in
mptcp_diag.c mptcp_inq.c mptcp_sockopt.c as well please?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


