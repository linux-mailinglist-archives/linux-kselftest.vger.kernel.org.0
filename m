Return-Path: <linux-kselftest+bounces-42596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCECBAA3F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 19:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559A57A3B24
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64752248B8;
	Mon, 29 Sep 2025 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkX8GLM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC5221D9E
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759168688; cv=none; b=mVqfOhDSXhrrPYFYsLmoEffyWecojWVI1+XtozC40QqVnaYWEOMoAPVFTtbaJZggC1hLqdI7orgKoi8yOCSs12FYZI8pteeFRns+FzTHqPk984etY4YotpYFlv0wYiJyxluiEvCCT0nEdWA8zPsHj6pWl1NUaNaIvd5Yzx9LwR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759168688; c=relaxed/simple;
	bh=IHNM4NzgxnMmFEI01G6PNqPKsxoRpwq01Yb96j8WtNY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hyguBFM1+15dU4QdiVyP5VHQ74RoP5VTbCCdDwHHYiN/ibtAXrR6SCWQtfoSLfDE41TObgHlfjl+uoU97nCxj7Fa+anMxcQovmQi+BVLQZOElKO+4+G/fw39/lb6RuLC9e4h542aLgQzl4hoAh7RiciN8ulX6auGbJyWh6Oluf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkX8GLM7; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-54bbe260539so1998292e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 10:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759168684; x=1759773484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E908RI2gAqiHDeoOAT4Wxeq827Q7LIlIthXPPeqIu0Y=;
        b=LkX8GLM7m6ne5HW13zQelx3bju8VBtaWvcEbOoeo3G6TTmSLORGikHAOjeDvff++/X
         0NHMmTycJkxxKouyvTYsi8vlt4WmjR5+a5HdpJp28tK8YohNBrRGQD7pClWyYCbN4i9X
         mRbHtRwMY6mpgVwgKmaCR1eTZw+w2FXediTFaIF0WkQiXuvMAKqejPTQtc98OMquqoMn
         Dt++bjnYtU50bLpFrueLGnrI0bEBhN6OTbHG9449TWhQyHj9tad83XHHO3K8cTYT3Al9
         VzQYgvUMykXxiajVKByDhk3NN/PgtoYPOOUM7G03gg8MXQSX8RkHKZVhegP2oylxGvu0
         borA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759168684; x=1759773484;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E908RI2gAqiHDeoOAT4Wxeq827Q7LIlIthXPPeqIu0Y=;
        b=SS281V8BoHyLHVUFgJAl16CYwyzqoN/Q2d+Zh0P9gcTZP92gUy/fOQ34apG/z7lBKy
         rRbsB3ci2KjXbVIhexhEomiGgkR+lyFaoPzumpwiImIdlQ/f3bJrutL7fjFgfP4b2fsL
         eQpHDFz8x+SqZidw7NJndHnD1y0MFsDfKEMwRAa52RRo4YC7GNpvE7IjGgvXCib8fFMh
         KFBB+g0I0NRhZ1pWKR7XvSLH0SYXqpoIreiKY1RrqocBLf2GLrp/RB2QzmkOL35cvazG
         6hyhnxbNtVVNWCMtNbZLF0WWPKgtRWuxeWAm/h352uIBu4UPVg6uofA83YCwXZOfhpIl
         7Lig==
X-Forwarded-Encrypted: i=1; AJvYcCUoH0/yYi75Hzt32q6dnwHsfewA539samyI0CBX00xMbuirLv53LXjudFJMXxn1OXkw0HdwJtVrEQ1SwtB3Teg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7Z1YLYS8TiE6hZkPCAI6nG4K6CQNShQ89SEoH0MNh5b1HsS6
	Y7mfkZYSFjYJYSG6Xf7xhhDbNV8IzOfI5KVg0M8bvNe/cUYESxkltV1g
X-Gm-Gg: ASbGncushC5iXEwsFbW2Z1U9PT5/23oKr36fNzQ2IlqktuIuvVF6d3hVJdqETq0+7l4
	zNSZ39r0OhngH9UmTusXN8fz9eeg6ViSs7pM0Sh50omRMcv0tS9fN9DvsBhBw78Bw3I+LWFmql0
	W8DazYnC/N0A7hsnEHWvlkbx2eZ3cRHSD5KvfpPiTK2Hgar23LyLLz8toqy3XW9uztTBzf1WF23
	wGYEdjNLpu4L9QXZ61UjDaAHaiqB19nUA6XRZvUkNDr2yTgeHhC7c6DkEDnWHJ35EIkiJw4FP+q
	91KiFjEKGlWf6fcufd9RlH6GZJqMMvA67F+P8iTGllYqw+ewBfJFQrggYbzHoBQGMVND84m+L+j
	Z8stB7iKfWT/XfnUj1Ah5CyXTE++U6Yc2tJJUHMPH/+lpoFazNqHGdiVm2c2hNvklB1eNkezNFa
	llUg4j
X-Google-Smtp-Source: AGHT+IGafwY5OqbBwbdedlnM684zSTSo0B+nKhBzZY2UTklcPWu1hk4PiOcg/kKTTuj5OpcgO90zPg==
X-Received: by 2002:a05:6122:c95:b0:53c:6d68:1cdc with SMTP id 71dfb90a1353d-54bea1f5fcemr6937065e0c.14.1759168684281;
        Mon, 29 Sep 2025 10:58:04 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-916db3be313sm2499211241.20.2025.09.29.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 10:58:03 -0700 (PDT)
Date: Mon, 29 Sep 2025 13:58:02 -0400
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
 david.hunter.linux@gmail.com, 
 Sidharth Seela <sidharthseela@gmail.com>
Message-ID: <willemdebruijn.kernel.321e70874e73c@gmail.com>
In-Reply-To: <20250929160230.36941-2-sidharthseela@gmail.com>
References: <20250929160230.36941-2-sidharthseela@gmail.com>
Subject: Re: [PATCH v2] net: Fix uninit character pointer and return values
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Reminder: use the net prefix: [PATCH net v2]

Sidharth Seela wrote:
> Fix uninitialized character pointer, and functions that return
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
>       |
> --
> so_txtime.c:210:3: warning: variable 'reason' is used uninitialized whenever switch default is taken [-Wsometimes-uninitialized]
>   210 |                 default:
>       |                 ^~~~~~~
> so_txtime.c:219:27: note: uninitialized use occurs here
>   219 |                         data[ret - 1], tstamp, reason);
>       |                                                ^~~~~~
> so_txtime.c:177:21: note: initialize the variable 'reason' to silence this warning
>   177 |                 const char *reason;
>       |                                   ^
>       |

My previous response accidentally left a state comment. The main
feedback still held:

This default case calls error() and exits the program, so this cannot
happen.

> --
> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
> ovpn module")
> Fixes: ca8826095e4d4 ("selftests/net: report etf errors correctly")
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> 
> v2:
> 	- Use subsystem name "net".
> 	- Add fixes tags.
> 	- Remove txtimestamp fix as default case calls error.
> 	- Assign constant error string instead of NULL.
> --

End the commit with the Signed-off-by block. Either move changelog
above that, or below three (not two) dashes.
 
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
> index 8457b7ccbc09..5bf3c483069b 100644
> --- a/tools/testing/selftests/net/so_txtime.c
> +++ b/tools/testing/selftests/net/so_txtime.c
> @@ -174,7 +174,7 @@ static int do_recv_errqueue_timeout(int fdt)
>  	msg.msg_controllen = sizeof(control);
>  
>  	while (1) {
> -		const char *reason;
> +		const char *reason = "unknown errno";
>  
>  		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
>  		if (ret == -1 && errno == EAGAIN)
> -- 
> 2.47.3
> 



