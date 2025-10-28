Return-Path: <linux-kselftest+bounces-44193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98290C15E64
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 298184E9AAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 16:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637D305E31;
	Tue, 28 Oct 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcRPyPBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438D7081E;
	Tue, 28 Oct 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669665; cv=none; b=kp1ZZL9WYuWcv56tCE3hhXuzj1EDJVzRw0Z8oIbZKj9jHtSgnJ65WoV3ReLnGGuIx/tYJK+wUO5vYvtUAQYA4Cx4od6GIB2AdasnoaVJ1Q0te+78lD8Yk+20cEH9/aJBpT7H3ecvRuIsXX9LkdrFeryFd3vTxFNqgdyHm+waT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669665; c=relaxed/simple;
	bh=R6EqvPPGUzfa/LHCSbVi9wWH6TxJb6kPWE0xNt3lVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkUUjBbtXXKJCj9qBj+1p89cJocexVfQOEjVCvBDdegcAVC+kRbNGx/KPKY/sCOdFk/+Ms87COThRabm8lN8af76SHM8XBXOdkhRkPXfSOxOYg/+NAmxZFmNnm9Kq7l/23837RGSJxL/8Jh8T/v349x1ELulIVyRyYtIc1h+r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcRPyPBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ECEC4CEFF;
	Tue, 28 Oct 2025 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761669663;
	bh=R6EqvPPGUzfa/LHCSbVi9wWH6TxJb6kPWE0xNt3lVUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcRPyPBJsWNL4ulwib1TPrTANoVykXmKtYl0rPKtYohQprUFdg52mVaR5UXvyMEJ4
	 h/ZSHblJnSlOFs6EvRzVS8EzlJR17iKrIbhMDxOTYzKzipgBrDEdZ6Ujcirjr+rf1K
	 eT9bHYu2SreZZKDifzCrR5+Rlb4UrfZOCKuLCurIpRfbU02UdXzdaFx7AtC+2cE9TA
	 K6GA7urIBn+2WQrt/keODjiHvLRGdjRmGx37JVe+Q5rCkGVpigkSv+FgM8sRg5OiWe
	 AxXOvzLAafrNr4U9/n3cwpZk89J0D19vJqkNn3Djvd/OeMSWCUvROiJx3LZSttkhly
	 RZRH+FVoXCr/A==
Date: Tue, 28 Oct 2025 16:40:58 +0000
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
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
Message-ID: <aQDyGhMehBxVL1Sy@horms.kernel.org>
References: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>

On Sun, Oct 26, 2025 at 11:16:49PM +0530, Ankit Khushwaha wrote:
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
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
>  tools/testing/selftests/net/netfilter/sctp_collision.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/netfilter/sctp_collision.c b/tools/testing/selftests/net/netfilter/sctp_collision.c
> index 21bb1cfd8a85..91df996367e9 100644
> --- a/tools/testing/selftests/net/netfilter/sctp_collision.c
> +++ b/tools/testing/selftests/net/netfilter/sctp_collision.c
> @@ -9,7 +9,8 @@
>  int main(int argc, char *argv[])
>  {
>  	struct sockaddr_in saddr = {}, daddr = {};
> -	int sd, ret, len = sizeof(daddr);
> +	int sd, ret;
> +	socklen_t len = sizeof(daddr);
>  	struct timeval tv = {25, 0};
>  	char buf[] = "hello";

Hi Ankit,

Please preserve reverse xmas tree order - longest line to shortest - for
local variable declarations in Networking code.

In this case, I think that would be as follows (completely untested).

	struct sockaddr_in saddr = {}, daddr = {};
	socklen_t len = sizeof(daddr);
	struct timeval tv = {25, 0};
	char buf[] = "hello";
	int sd, ret;

...

-- 
pw-bot: changes-requested

