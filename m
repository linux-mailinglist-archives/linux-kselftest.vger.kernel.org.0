Return-Path: <linux-kselftest+bounces-48233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD31CF5BC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 22:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F50D30581E0
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81175311C0C;
	Mon,  5 Jan 2026 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYjLYk6T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E9311942
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650205; cv=none; b=Hxuthwd1DpByiIBqsSSTgy9Hx4WM7+3lHBxFJOYNbmgTC7BEpy/KTlfKfkLS3xQZlgFPIDz2+sopmQGFeTxupvbKHVp+KUZtgmFEE0SuMmhVkN+eOf0zcHuVvA+oQXdJwDbcLB9ovME0mHAXfHJNWfbqkBHL9UKFPFEuO/gCq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650205; c=relaxed/simple;
	bh=n5AEGPfY/J2s2Xsr++RQ6MPnAJKhMStGlZe2hzKbfw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WyYKLQzSmnq02ByTUwFtCwMkciiDrJRX4vs1JiwQqazmMQAWcyIR1YzIrOFMlDVUbiS7OpIUiGuEw5k9tgMQxrG/S6BIMV+MfWdEECYUjy876iXyePn1eps77muzHPHZ0YHAdwcIGFETsTtu0l9OeA+KH66OGyBWV8NJizLc0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYjLYk6T; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso124282f8f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 13:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767650201; x=1768255001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJdwe8k5Q1P9Ro2cKEv2Zqzqwu7CMlTZRcFtklLBD2I=;
        b=EYjLYk6TyprWsplJ6AUUC1Rr/6puYbwU3EJer16kegw5r8UNpjhKQnAdosmUwuGYob
         Wf46X9nhSXFo2ePZ2q5bKFA3aBkOnYHngF4pz2W2kg+Ivxo/xqK4P47w9nFB1ARWqhUz
         GFlhs3bWsI86FzSCpYFLF9HwWNjyyt2szsC4/LeBxBTAfFpbiQw9J82y6FQBVwjm1DpX
         YOkgudxDLnRKdaABAqMlc90RDrCSz7xzTD9SIC4t/IFhLq9fFfoQ1Tw7s6IYmiRbo2yy
         l4hdAd0U6eLhnjt9zf6JSI79ecY4zjZY/ZQod18AeSaBwwr7drYnhBeJ//SRfDuCbp+P
         azdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650201; x=1768255001;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJdwe8k5Q1P9Ro2cKEv2Zqzqwu7CMlTZRcFtklLBD2I=;
        b=s1XYQiWaHdTKKHJyNvgXOqSsbHb65cYQ9HXXM5APzZ4sTde/6Js/HZPKltGN0qMDfy
         iIXaj4Zw1i1DEYaf2WFTbZkldLFkLSajRXXeGHLr9zpuGnmGVbGq/0+Ayb4/peEHOVkP
         1XymCSA2+e3nc2jhOui+76Vy59mFkxJG5Qc9l7ReiCwzKaiAzjxTzd05TIjKAi+p2F22
         vnJJmkZzIwCAdYrEUd9CxgB/eE1FNB8ya6WzMCHrJoO8vKv01QNu6bAnJ7B08hRDlkf6
         eRQygTqIEQv/3g0WpOWjH0r8oEaMnZm4ddXUvK8E9+DQ2eSrjD/G4hYFZ2y9P4+FQBFq
         p4xg==
X-Forwarded-Encrypted: i=1; AJvYcCVfZEcMg03ojasMuT3VH0+ZGZAuUJVjZeiJl81XfMxZS62wqpJZZRfE3W1cVG0V6dswjTjXwh2jxgUVPZ4BdFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyQ440Fc7WZahtjybIpUP/fCU1iePv7VQWFQtRrVPoHK2fGbIb
	kmVwHoFZKKm1FoPclbQ/A5uA5RjIybLvsh1FGEMJbtfLMIFI0MINBXWz
X-Gm-Gg: AY/fxX5ya6lupYGoGi8AbVmvmRMGp0HDnDI0PKLgRKpzg++cXYde4AN9gLVuz/+xFCh
	N6COwo694TqTaN3xRl6Ijj7cpsZ0T+c8ugSHnyR9aqEy6ANvo0MvJNcMIfe9zzFLU+4oUs8x0Dk
	VWkIQPaDZjrhCyADerPrOGF5joYOfFwvjjc0vnCcesf2tBEsouVPBxTiZfsQAD5oQaXqqdIXPFC
	WQpMmV1nYXrgifI1SL315XMaqFqfwLszFtGRrBEwWg01LQUQEDIyloHfvkcx9uHc1Ne2BrJpbnD
	P74/7Ez5v4lcly6ljxpxZWhsCLHEIM6xKknHXydeShTqqrJyRqVNE9KUE+6qyxJbqNlxgwsfIGz
	MmyXy9b1d/IJxl670ST9Bx+D9NhOQfMPgBLaG+TJno9f7VrIswduY7YUaBxiLuwGI4m9FRbgsPx
	5czwe4WD/FFLM87Hml0arFL4uOTOaG576qy+w+0wGMbS946I8lkNfA2Wzu5wsXedm4hb4fcne9n
	zJEVQ3vdJ5be7xArQ==
X-Google-Smtp-Source: AGHT+IHGWTXHufgkP5TAITSLOGuyx2/59UaIQV+tU5VX31oNq624podr7P03+PmlN9fNaGkmmRpKrQ==
X-Received: by 2002:a05:6000:288d:b0:431:8ff:206b with SMTP id ffacd0b85a97d-432bca18e08mr1359809f8f.2.1767650201395;
        Mon, 05 Jan 2026 13:56:41 -0800 (PST)
Received: from [172.28.5.111] (static-qvn-qvu-073125.business.bouyguestelecom.com. [89.81.73.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5eesm675521f8f.34.2026.01.05.13.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 13:56:41 -0800 (PST)
Message-ID: <333ab7ce-55f4-4f19-a1a9-b3c86621e892@gmail.com>
Date: Mon, 5 Jan 2026 22:56:40 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv6: preserve insertion order for same-scope
 addresses
To: Yumei Huang <yuhuang@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: sbrivio@redhat.com, david@gibson.dropbear.id.au, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org
References: <20260104032357.38555-1-yuhuang@redhat.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260104032357.38555-1-yuhuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 04:23, Yumei Huang wrote:
> IPv6 addresses with the same scope are returned in reverse insertion
> order, unlike IPv4. For example, when adding a -> b -> c, the list is
> reported as c -> b -> a, while IPv4 preserves the original order.
> 
> This behavior causes:
> 
> a. When using `ip -6 a save` and `ip -6 a restore`, addresses are restored
>     in the opposite order from which they were saved. See example below
>     showing addresses added as 1::1, 1::2, 1::3 but displayed and saved
>     in reverse order.
> 
>     # ip -6 a a 1::1 dev x
>     # ip -6 a a 1::2 dev x
>     # ip -6 a a 1::3 dev x
>     # ip -6 a s dev x
>     2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>         inet6 1::3/128 scope global tentative
>         valid_lft forever preferred_lft forever
>         inet6 1::2/128 scope global tentative
>         valid_lft forever preferred_lft forever
>         inet6 1::1/128 scope global tentative
>         valid_lft forever preferred_lft forever
>     # ip -6 a save > dump
>     # ip -6 a d 1::1 dev x
>     # ip -6 a d 1::2 dev x
>     # ip -6 a d 1::3 dev x
>     # ip a d ::1 dev lo
>     # ip a restore < dump
>     # ip -6 a s dev x
>     2: x: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
>         inet6 1::1/128 scope global tentative
>         valid_lft forever preferred_lft forever
>         inet6 1::2/128 scope global tentative
>         valid_lft forever preferred_lft forever
>         inet6 1::3/128 scope global tentative
>         valid_lft forever preferred_lft forever
>     # ip a showdump < dump
>      if1:
>          inet6 ::1/128 scope host proto kernel_lo
>          valid_lft forever preferred_lft forever
>      if2:
>          inet6 1::3/128 scope global tentative
>          valid_lft forever preferred_lft forever
>      if2:
>          inet6 1::2/128 scope global tentative
>          valid_lft forever preferred_lft forever
>      if2:
>          inet6 1::1/128 scope global tentative
>          valid_lft forever preferred_lft forever
> 
> b. Addresses in pasta to appear in reversed order compared to host
>     addresses.
> 
> The ipv6 addresses were added in reverse order by commit e55ffac60117
> ("[IPV6]: order addresses by scope"), then it was changed by commit
> 502a2ffd7376 ("ipv6: convert idev_list to list macros"), and restored by
> commit b54c9b98bbfb ("ipv6: Preserve pervious behavior in
> ipv6_link_dev_addr()."). However, this reverse ordering within the same
> scope causes inconsistency with IPv4 and the issues described above.
> 
> This patch aligns IPv6 address ordering with IPv4 for consistency
> by changing the comparison from >= to > when inserting addresses
> into the address list. Also updates the ioam6 selftest to reflect
> the new address ordering behavior. Combine these two changes into
> one patch for bisectability.
> 
> Fixes: e55ffac60117 ("[IPV6]: order addresses by scope")
> Link: https://bugs.passt.top/show_bug.cgi?id=175
> Suggested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Yumei Huang <yuhuang@redhat.com>
> ---
>   net/ipv6/addrconf.c                  | 2 +-
>   tools/testing/selftests/net/ioam6.sh | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 40e9c336f6c5..ca998bf46863 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
>   	list_for_each(p, &idev->addr_list) {
>   		struct inet6_ifaddr *ifa
>   			= list_entry(p, struct inet6_ifaddr, if_list);
> -		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
> +		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
>   			break;
>   	}
>   
> diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
> index 845c26dd01a9..b2b99889942f 100755
> --- a/tools/testing/selftests/net/ioam6.sh
> +++ b/tools/testing/selftests/net/ioam6.sh
> @@ -273,8 +273,8 @@ setup()
>     ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
>     ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
>   
> -  ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
>     ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
> +  ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
>     ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
>     ip -netns $ioam_node_alpha link set lo up &>/dev/null
>     ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \

For tools/testing/selftests/net/ioam6.sh:

Acked-by: Justin Iurman <justin.iurman@gmail.com>

