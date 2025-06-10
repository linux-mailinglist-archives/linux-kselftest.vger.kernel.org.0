Return-Path: <linux-kselftest+bounces-34586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EBAD3921
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3426E163A1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9628A1F5;
	Tue, 10 Jun 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXXT663/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDC29553C;
	Tue, 10 Jun 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561673; cv=none; b=naT2j3lJQLFjiYrKlDPti1aP/R2cB0Awu9lJyjuW04r9Jpd2Hsw3wwOJLDYdmkFXdeb4gU1/N1kg1X0HncWDunFPoFOt2CdzmA3NR/nXPlxl4jhBkNodGhTyVxgFYNRD3KBOddUWlOILtWbToYoiNWBiCaEABqQ+1RHQd5sBHM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561673; c=relaxed/simple;
	bh=PHXnIq9DvbYMMAiqfb9kdye4N3LNNMsDCltUJ6z2pmc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=M00e5OWv+xTeG+sD+8t8EglUzzs6qPkAZwU6N9C63YqLYsg6T7k5laF8owT7/7nhhIrAkFdUS4AMMQoP64SyX8wnKtje0em2lMLUdHJBqbx749P6qxIGMNbFI4SGEhXuIR/wyOL5jIhRfNjSp/xyqCgFoAL15rHNjUOw4GBtHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXXT663/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e77831d68so51621317b3.2;
        Tue, 10 Jun 2025 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749561671; x=1750166471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqK/Pdx79AulxZE87TK3GYJJhMmOA+0kbCJDeCtjwXQ=;
        b=EXXT663/T8yg6QwubhaXBIFKO+aewtvBW7FE8UnEXL7ajtazYP4fxZyNWB4Qc1MFkn
         c2oKJHaKuh1/1qRZljEz9rRsS6uQawRX4ly/vrspz8AnI8GYBksC71fgoD2qvV2XBkZM
         fdxBNH8u1eppJj2kZtZJnQiRuSArErJq7Bb7zEBPFu0DnH3XbO0uRFu93rK94nSJlgFl
         Y2kc0IeNOeRDqZLwnDDyT4xXRT9jT/hgCLZX/DH8KQ+AL2nWVAJxmDfb4wZs8do4mRd/
         rkM8mDYaQrO+pjc4z6SB/pMwtBWbpIJlraJ+Xdk+LqIsAE6WIeM+Jj4QX+D4qKlNGO6P
         pP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561671; x=1750166471;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nqK/Pdx79AulxZE87TK3GYJJhMmOA+0kbCJDeCtjwXQ=;
        b=w4jJolvocrnaan/fo4BaqUq7o7gqYFsMzfCmZgzMR8jn1leFpKFF/9QqdusOoAt5gY
         JJBKte0H5gbaBMoPEdq0nicIpTwxrxvGxlH3Q+/a5cC0D9S9pKMr357wVrXfeZxwWGaH
         7cf73i4gwH38Tr856An9ojVlqabENNzHb2QB1RYwWesgj0j37Qum7NskkPYSLfiO9CSU
         rIiiH+00DhX4lfI2D4JtGWtgOhmoAWipuLLG5+FOvwI1UBtQxv3RAdUly1REO1qxcJK/
         vOfKopmeJ6pFokDeLKKqNCn3vCr6fL3TYbzBtTzabuAcZz0l+OAZrMggskV7q1mturQl
         1vGA==
X-Forwarded-Encrypted: i=1; AJvYcCV/OKRLHJlJagAKHjyZ2rl7dUu6b9kuEWSOEratpuIEa/7hM9bc1W52ISfM3PUYJE0Di+3TzY0y@vger.kernel.org, AJvYcCWLhPDtIzMCPVv++CZxGXFEf7wEQTJZkPqv3KBVqch1xqSySx/mSvKt6QgGK8/F89TNYNE=@vger.kernel.org, AJvYcCWP0Rc2l8cFrjc0edVxJG/wQhYYydx+g5Pt2c1T4WUytBMBr9jjRkR//Y1IGCpKuukenmJj/u/x2H5b7S21/kGY@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZM0wunA37rWHHzzyRZFaR15SA1VDmp0lS+akJThxZqe83El3
	ZUghyF9BgCHW7KJAmX7/CV/zdblocnrL4IRMzRUW+0EIlNjIHxV8nrOY
X-Gm-Gg: ASbGncuFb118css+7WavVjMBCpQho6r1csoViMffcvv2J9ULjdKvPgjClIc0/Hcd4v5
	zCXnV3xnNL7xOqiAPeerqBnTMLJthMxkVF/F6EQYYY5UZ+wnV/mqp6UanGKQhAF8+YExyAQJhaN
	wpI5/BTKEEFVR/z8laCSEvrzA4QXhufhjeRpb+tdYpz8UNys/HAiYUv0cgu+aV82BxVJByuWpJd
	0EfS/Etbd26VWpPZj87diCPoKA0+9C7Gvngy+OjvZJRP8Fuk9Jz3Ik3tlYlqLV0f6RoYk1tXKDw
	OtOXn3nN/v9ldIL0c3Dm9ZPXURgE6GadhK4uyFBwwdHj4VmtlKzQ0LoMiIjvOEhzUFnqcFycfAw
	Y9a0kyx4zrUb5/JWdcflnT9E1/QJturjZesQHj9RlrA==
X-Google-Smtp-Source: AGHT+IGz0NOsByVzKDDWHAu+pNwYUyitsWzgIpouRvSRsvxeGdftrTwG2Yu8Iv8RPDuXDpr/1jA0gw==
X-Received: by 2002:a05:690c:6d12:b0:70e:2d1a:82b8 with SMTP id 00721157ae682-710f772b158mr246129037b3.34.1749561670642;
        Tue, 10 Jun 2025 06:21:10 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710f98afb0esm16081257b3.3.2025.06.10.06.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:21:09 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:21:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 maze@google.com, 
 daniel@iogearbox.net, 
 Jakub Kicinski <kuba@kernel.org>, 
 stable@vger.kernel.org, 
 martin.lau@linux.dev, 
 john.fastabend@gmail.com, 
 eddyz87@gmail.com, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 willemb@google.com, 
 william.xuanziyang@huawei.com, 
 alan.maguire@oracle.com, 
 bpf@vger.kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 yonghong.song@linux.dev
Message-ID: <68483145957ee_3cd66f29430@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250610001245.1981782-1-kuba@kernel.org>
References: <20250610001245.1981782-1-kuba@kernel.org>
Subject: Re: [PATCH net v3 1/2] net: clear the dst when changing skb protocol
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski wrote:
> A not-so-careful NAT46 BPF program can crash the kernel
> if it indiscriminately flips ingress packets from v4 to v6:
> =

>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
>     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
>     process_backlog (net/core/dev.c:6186:4)
>     napi_poll (net/core/dev.c:6906:9)
>     net_rx_action (net/core/dev.c:7028:13)
>     do_softirq (kernel/softirq.c:462:3)
>     netif_rx (net/core/dev.c:5326:3)
>     dev_loopback_xmit (net/core/dev.c:4015:2)
>     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
>     NF_HOOK (./include/linux/netfilter.h:314:9)
>     ip_mc_output (net/ipv4/ip_output.c:400:5)
>     dst_output (./include/net/dst.h:459:9)
>     ip_local_out (net/ipv4/ip_output.c:130:9)
>     ip_send_skb (net/ipv4/ip_output.c:1496:8)
>     udp_send_skb (net/ipv4/udp.c:1040:8)
>     udp_sendmsg (net/ipv4/udp.c:1328:10)
> =

> The output interface has a 4->6 program attached at ingress.
> We try to loop the multicast skb back to the sending socket.
> Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
> and changes skb->protocol to v6. We enter ip6_rcv_core which
> tries to use skb_dst(). But the dst is still an IPv4 one left
> after IPv4 mcast output.
> =

> Clear the dst in all BPF helpers which change the protocol.
> Try to preserve metadata dsts, those may carry non-routing
> metadata.
> =

> Cc: stable@vger.kernel.org
> Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_sk=
b_adjust_room()")
> Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
> Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

