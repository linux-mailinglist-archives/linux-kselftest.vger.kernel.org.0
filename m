Return-Path: <linux-kselftest+bounces-42578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E9BA9855
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 16:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 915757A190D
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 14:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9573090E2;
	Mon, 29 Sep 2025 14:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbxDFyue"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA9D3074A9
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155546; cv=none; b=BalimMhogfsMI1HsuPm3UPQS+QaxmkD4M/2Y1/TJcsoE7J66GZGQTmPwfiZGg4f6kP9EseNi7FSqbHMu2q+QLdm6ZUGAPCLRBfthMjhdkt5+JE0kxJ3glhYrzZgUc/XVt1MYdTEastQnfe8FoBchxhI0yIEb06INiXgZmKbpe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155546; c=relaxed/simple;
	bh=Cqa9Uzqm9/s5VXEeXfESLlelcJ7lJBixKsxsE328zas=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VDTnaZsTk4z/35yeQqjtVhrekRV2rH3deJmoxZ+nps+MAPtW2nKhIe7hQZMaAvDkWmTyD3hiXtg83bSI93EW5rJn4OJHYKR5DTQYc+yr6GnLfJJGS7uzrJP+x78ILqep6Jvd9mktgApnzbm0z9lXGvJsu4QaqP/LVudf0sWgrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbxDFyue; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54a98bcdedeso529065e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155543; x=1759760343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8f8mS2/PsiKtRfA+cy/Ijq5MGOVS0C89p6V4QtDT26M=;
        b=SbxDFyueq+KFFxSnkeFszRWccwAMQyhNg3Ea8luK9S9Y1BM1SnkRcFKJsj889eM4xa
         bk2pz2/GrRIOP3Szuuz/199N8jbKGx5AX5d8jQYNhk7eYEOOhmrlARwyakUvu52Uk/0s
         +ykcPzlLMdTEQbR01LvqtP15Kl9wEm2KrmzoiL2KIU4ztsjwYdSWMCRoFtBQflkDqxU3
         F+m9pZL7zuqckzC+dNsrlYoMPVAkaZEHEx497NVmB+kLrvxZ+uFHM0TqygZ1XLwQhFIp
         UWGodqtaZge83fUexSHcJrmJ4M5epTko/U4SuXfRtg4H2+lVPpvZ3tA9laP/eSMgLsQD
         EiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155543; x=1759760343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8f8mS2/PsiKtRfA+cy/Ijq5MGOVS0C89p6V4QtDT26M=;
        b=OS6tFCYrp+4zugcDWujURJTfmP1XcOh8bQ8CXFdV1YhoED91u3tkXdVhI2L+aPuOWE
         DPg+gI2KrnXtPDIfhI9GpsjVKfBb6aMdc7Ex25TlQKatOW/BsTyZLRTJlzEgHdNz9Z/3
         8MXqJ/pDt+3MU0JAp7wZ47ahGDkMLYQc7C0fNtdep0ghNYZwYjRtM+CNPGPhtV6AQFeI
         F8ZPfmscV3zJI5zE2BNWVUxZVr8tVZECXFHelVdEcV4Dbt32N8phQSE0n++2M8GWxpeb
         hdmCDUZgVbgaFwv8Axq3ijmIiNcneIhVGx/sNasY9pBxSs8WO3vKmC9pW8wRHGydtHAb
         3H+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQxN+nRy4bKAisUp+DPGtzpZPQ6ojYRuWqi5tC5IUCQP22tflSUUw/+bc4SDvpdZ/4vgdGxkb83SY8kmnN11E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdzLzxk2wospgM+ik7dJr4ggPXd2gE/OZHYiLyR4MMaXChA/8
	rnZqRAbYa++3HQmeZX9W20aBnLIqnUTNdn9Oe5vCghOWy/iJ0H5HsiSa
X-Gm-Gg: ASbGncsL18/1H6Qn2nTS/eY07NpE4NoyB1u0QcuFn+CRt6xEl2qvK3rCh9GCx8d9Bl2
	vjgW8uWCbuXrRCTEu0INySjupTZY2wPV/SUaYXg4gEV60kt5K5MYh0XK9SlvSRdzS1NQervr94T
	LFTQ3ppPtDad4FvUljxZv9UFa0vgc9v3figbMUL4Fv8xmudW7ByrRxEDOy+KtK8xNRjYsdsoIOc
	i6J3QF8mdRgWE8gGR3y47Ig61Z6IloXGL4MZKvmkthL8j72Ox3Nb7hLKpWr71ds/c8ch6ZejeOb
	RBj3zffJSBTnyK9EGKGr/YR7BfAZVk5HvSwlon9V7eSthsD0DKCfSjfb2A5USvIXEwzg/Zk5ik1
	reHlrz2okyonWCOWncGLTatWcSPGpIoixrY8KOLHwC9zquJN5PYVW8GOdXswmtxGS7n0o1hOjAS
	K6Uee+
X-Google-Smtp-Source: AGHT+IHbGRPyI3TBsvsm/JH3bGpt2g5z5CYtKK6z0SBXiM2oKnumeml9UIrNcgYboy1D+yW+DlMLlA==
X-Received: by 2002:a05:6122:3117:b0:545:eb6c:c6bb with SMTP id 71dfb90a1353d-54bea300520mr5569540e0c.12.1759155543420;
        Mon, 29 Sep 2025 07:19:03 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-54c0c1ff0c0sm1330558e0c.11.2025.09.29.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:19:01 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:19:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sidharth Seela <sidharthseela@gmail.com>, 
 antonio@openvpn.net, 
 sd@queasysnail.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 kernelxing@tencent.com, 
 nathan@kernel.org, 
 nick.desaulniers+lkml@gmail.com, 
 morbo@google.com, 
 justinstitt@google.com
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 Sidharth Seela <sidharthseela@gmail.com>
Message-ID: <willemdebruijn.kernel.a37b90bf9586@gmail.com>
In-Reply-To: <20250929114356.25261-2-sidharthseela@gmail.com>
References: <20250929114356.25261-2-sidharthseela@gmail.com>
Subject: Re: [PATCH] selftest:net: Fix uninit pointers and return values
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

[PATCH net]

and a Fixes tag

Sidharth Seela wrote:
> Fix uninitialized character pointers, and functions that return
> undefined values. These issues were caught by running clang using LLVM=1
> option; and are as follows:
> --
> ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>  1587 |         if (!sock) {
>       |             ^~~~~
> ovpn-cli.c:1635:9: note: uninitialized use occurs here
>  1635 |         return ret;
>       |                ^~~
> ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
>  1587 |         if (!sock) {
>       |         ^~~~~~~~~~~~
>  1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1589 |                 goto err_free;
>       |                 ~~~~~~~~~~~~~~
>  1590 |         }
>       |         ~
> ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
>  1584 |         int mcid, ret;
>       |                      ^
>       |                       = 0
> ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>  2107 |         case CMD_INVALID:
>       |              ^~~~~~~~~~~
> ovpn-cli.c:2111:9: note: uninitialized use occurs here
>  2111 |         return ret;
>       |                ^~~
> ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
>  1939 |         int n, ret;
>       |                   ^

These two look legitimate.

>       |
> --
> txtimestamp.c:240:2: warning: variable 'tsname' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
>   240 |         default:

Does not need a fix. The default statement calls error() which exits the program.

>       |         ^~~~~~~
> txtimestamp.c:244:20: note: uninitialized use occurs here
>   244 |         __print_timestamp(tsname, &tss->ts[0], tskey, payload_len);
>       |                           ^~~~~~
> txtimestamp.c:220:20: note: initialize the variable 'tsname' to silence this warning
>   220 |         const char *tsname;
>       |                           ^
>       |                            = NULL
> --
> so_txtime.c:210:3: warning: variable 'reason' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
>   210 |                 default:
>       |                 ^~~~~~~

Same.

> so_txtime.c:219:27: note: uninitialized use occurs here
>   219 |                         data[ret - 1], tstamp, reason);
>       |                                                ^~~~~~
> so_txtime.c:177:21: note: initialize the variable 'reason' to silence this warning
>   177 |                 const char *reason;
>       |                                   ^
>       |
> --
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>

Agreed on all the occurrences and the ovpn fixes.

> ---
> 
> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> index 9201f2905f2c..20d00378f34a 100644
> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
> @@ -1581,7 +1581,7 @@ static int ovpn_listen_mcast(void)
>  {
>  	struct nl_sock *sock;
>  	struct nl_cb *cb;
> -	int mcid, ret;
> +	int mcid, ret = -1;
>  
>  	sock = nl_socket_alloc();
>  	if (!sock) {
> @@ -1936,7 +1936,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
>  {
>  	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
>  	char raddr[128], rport[10];
> -	int n, ret;
> +	int n, ret = -1;
>  	FILE *fp;
>  
>  	switch (ovpn->cmd) {
> diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
> index 8457b7ccbc09..b76df1efc2ef 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
>  	msg.msg_controllen = sizeof(control);
>  
>  	while (1) {
> -		const char *reason;
> +		const char *reason = NULL;

Since reason is a string that's printed, better to initialize it to a
string. Preferably in the case statement, e.g., "unknown errno".

>  
>  		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
>  		if (ret == -1 && errno == EAGAIN)
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index dae91eb97d69..bcc14688661d 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -217,7 +217,7 @@ static void print_timestamp_usr(void)
>  static void print_timestamp(struct scm_timestamping *tss, int tstype,
>  			    int tskey, int payload_len)
>  {
> -	const char *tsname;
> +	const char *tsname = NULL;
>  
>  	validate_key(tskey, tstype);
>  
> -- 
> 2.47.3
> 



