Return-Path: <linux-kselftest+bounces-44076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7E6C0AFD4
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 19:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C3A3B4082
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787A258EDB;
	Sun, 26 Oct 2025 18:10:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A178262A6;
	Sun, 26 Oct 2025 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502213; cv=none; b=emRIoBN+XGHfZ/BUKL/sj+ih4913jwUnIw8ROMfN+T67ljBCnhP+Y8jugrZ611feAVNHexg7FyIzBG0Qn/MUU4qjmIdUhkGHLdsbdLV4mYL6kUksBrdKcyGKQ5HKRLDuOvUn9iWTaKTwfaYkYklf7iJuGPpfUfGWnFeEpGYGrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502213; c=relaxed/simple;
	bh=2ztvjpybYtP58LTxtTl9y4dSNNgOzBQTm2S20A0kB/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwQG3hxNnFATWvkqThlxo6sq0P7Vm2+pJOZYqtTdAfIDzMAQGlTO5w2SFXBb4fVdTqiLulanvi4lgHoQF0i6gusqbB5njrNA7nxZDG4P3Gh07sf+CpW8mOT+kuS7yBwx9ODIYoY+ljHPtLQzZ9zLC+MmU6HZwGgEzAsceT/floU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from [192.168.100.50] (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7792117E00AC;
	Sun, 26 Oct 2025 19:10:05 +0100 (CET)
Message-ID: <f7e2974c-5513-4a05-b136-9902ffc31dbc@gmail.com>
Date: Sun, 26 Oct 2025 23:09:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: net: fix socklen_t type mismatch in
 sctp_collision test
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
In-Reply-To: <20251026174649.276515-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 10:46 PM, Ankit Khushwaha wrote:
> Socket APIs like recvfrom(), accept(), and getsockname() expect socklen_t*
> arg, but tests were using int variables. This causes -Wpointer-sign 
> warnings on platforms where socklen_t is unsigned.
> 
> Change the variable type from int to socklen_t to resolve the warning and
> ensure type safety across platforms.
Yes, socklen_t must have 32 bits which would be possible by using unsigned
int or better socklen_t type.

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
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

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
>  


