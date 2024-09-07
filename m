Return-Path: <linux-kselftest+bounces-17440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E496FF1C
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 04:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCC08B24018
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 02:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C45DDD9;
	Sat,  7 Sep 2024 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdddIEfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0EA93D;
	Sat,  7 Sep 2024 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725674752; cv=none; b=ZuBYSE9MkG6TaG/v5kA1JSHVuFfgHBbVGrscSic3wuafAawstAi2XLuUiNgKfQMPKZE0yq/gbiY4Lnhy76Y3IvbVH+gSsSN/iWsbnnyDke9nMYY5clxX8UxCdVFgwf8wdypYBlChINqSQn0GQYgCyduWgjQ4zjJnVcUKnP3hPko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725674752; c=relaxed/simple;
	bh=rIIJ66Btf0/S4uXzK+bKHvP4AW8rj0OAUyQFtmKPrGQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rPiKpbuAcgh8CP7oqLCUIS1H/snDDpZzqaVutxlV7x0Tkl9xujmuFc2V3/EWpqCqUHvY7vWdXypv7k76eNz5RASAoOues9H4/NLi1ZyXSCFartI2uaawtKnDkfHi96p+mXxIe+0TzYwdMupAeOiN2bACEFBkYk4wrdxyVNYvJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdddIEfl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-456855afe0fso14381031cf.3;
        Fri, 06 Sep 2024 19:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725674750; x=1726279550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNuRf41PkhMk6rEC1d89BfhoreluVxX6rNBvM1mU4Ls=;
        b=cdddIEflPBunilMaXnznTTDWRy1ra5uotOkbQqplDylY3b6m7RtD528lz7H61vxuFM
         Xt6rSUeOsV8kU1GMcZfmZ62NiuaIPvQH4rvTkdDvfTnhU0PULUgguksSOEK9UXkUmlXV
         R/wm23C5Fcps5UFY9xCbpIW5UZt30i++sNtzNyXXCVnf611NbMwVh2PUv7yzFpdGvUKe
         xSCfHA8G6JCc8aUdb1rMWo1DaXR2AVrcNs+ogJhqXQQpaJxCmiyr8OVirZDJggfTfdn4
         ycH6rip1CpueboxxFfqIbRlmUTSLzUX+cV9ESDlH3u109G68TKKo036L62yoPXrMCFxI
         PSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725674750; x=1726279550;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNuRf41PkhMk6rEC1d89BfhoreluVxX6rNBvM1mU4Ls=;
        b=bDdAUo55VxCyXdKSq/V9fUqTKeu3MBZSJr5XWFUtN3grgFmC2z/2Y0sq55hvzcEK0E
         uzh+opl8JAHkXFLSdm45mreVNb7f/wCSOhYPiSzFImzA26rFqBq0+EOtxB3jRaMLJwHP
         QDMeg2mPeSX48zgXazhrlum2YYUfzZ/77rHbjd3bJvyHGZbLO8y67hurJP2TPP+k9385
         g1ypwTrAKEIoO5YzD6YYo/ywR9AP0iOIJEV6m9w0GKdx7AT88Z+8nY6A7prpLA69+Ah7
         8Xoe2a0T4dc5NiS4sddotbrIQNJh3PGU0wLo5AaSLZSOgvmGPm8/OrcD7jc37o30gu9U
         /puQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJnJ1+fDbPs/25Cer3Z6LzqN7/quV29brgW+4Hq9Ok4+X/e7l/QJHMI9v1VfjStYiIvBS8Q84m@vger.kernel.org, AJvYcCVrLsh9O+OzBOhX5KMnSHvpmvc+aHmOW3gTJCvy4BrVhCxeXLRCF2zLVCyP4E3jYrFNv5sRBKrEqhQOL+k=@vger.kernel.org, AJvYcCWRyY2Ctwni69IVz7rc1vXaDiYjn7K01RMGFkEXKwiYyF8+91MDcVo/oDeaclRdu+2jqj0u4jsNlPrhJCwfGoLQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJN2MZ83JUrWtjfiRLOd1lKL3Ffbrf8TnUiHBeYOVs+QD+XKSx
	+JC7SqYN0Fm4OrjAnSwNuu2rZm/HufSEZyW/bFIQH7gBLSN2cgLP
X-Google-Smtp-Source: AGHT+IEThUx4A+kGc9bMpBczdqdcL8d6Wub3sWEOK/0CwwXfKU1W+aGPinin4wUQe/0o5b+y/ucngw==
X-Received: by 2002:ac8:5803:0:b0:456:811c:4ecd with SMTP id d75a77b69052e-4580c675320mr47866681cf.4.1725674749609;
        Fri, 06 Sep 2024 19:05:49 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e87ec5sm795431cf.37.2024.09.06.19.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 19:05:49 -0700 (PDT)
Date: Fri, 06 Sep 2024 22:05:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sean Anderson <sean.anderson@linux.dev>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 linux-kernel@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, 
 Sean Anderson <sean.anderson@linux.dev>
Message-ID: <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240906210743.627413-1-sean.anderson@linux.dev>
References: <20240906210743.627413-1-sean.anderson@linux.dev>
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Sean Anderson wrote:
> Padding is not included in UDP and TCP checksums. Therefore, reduce the
> length of the checksummed data to include only the data in the IP
> payload. This fixes spurious reported checksum failures like
> 
> rx: pkt: sport=33000 len=26 csum=0xc850 verify=0xf9fe
> pkt: bad csum

Are you using this test as receiver for other input?

The packet builder in the test doesn't generate these, does it?

Just trying to understand if this is a bug fix or a new use for
csum.c as receiver.

> Technically it is possible for there to be trailing bytes after the UDP
> data but before the Ethernet padding (e.g. if sizeof(ip) + sizeof(udp) +
> udp.len < ip.len). However, we don't generate such packets.

More likely is that L3 and L4 length fields agree, as both are
generated at the sender, but that some trailer is attached in the
network. Such as a timestamp trailer.
 
> Fixes: 91a7de85600d ("selftests/net: add csum offload test")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> Found while testing for this very bug in hardware checksum offloads.
> 
>  tools/testing/selftests/net/lib/csum.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> index b9f3fc3c3426..e0a34e5e8dd5 100644
> --- a/tools/testing/selftests/net/lib/csum.c
> +++ b/tools/testing/selftests/net/lib/csum.c
> @@ -654,10 +654,16 @@ static int recv_verify_packet_ipv4(void *nh, int len)
>  {
>  	struct iphdr *iph = nh;
>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
> +	uint16_t ip_len;
>  
>  	if (len < sizeof(*iph) || iph->protocol != proto)
>  		return -1;
>  
> +	ip_len = ntohs(iph->tot_len);
> +	if (ip_len > len || ip_len < sizeof(*iph))
> +		return -1;
> +
> +	len = ip_len;
>  	iph_addr_p = &iph->saddr;
>  	if (proto == IPPROTO_TCP)
>  		return recv_verify_packet_tcp(iph + 1, len - sizeof(*iph));
> @@ -669,16 +675,22 @@ static int recv_verify_packet_ipv6(void *nh, int len)
>  {
>  	struct ipv6hdr *ip6h = nh;
>  	uint16_t proto = cfg_encap ? IPPROTO_UDP : cfg_proto;
> +	uint16_t ip_len;

nit: payload_len, as it never includes sizeof ipv6hdr

>  	if (len < sizeof(*ip6h) || ip6h->nexthdr != proto)
>  		return -1;
>  
> +	ip_len = ntohs(ip6h->payload_len);
> +	if (ip_len > len - sizeof(*ip6h))
> +		return -1;
> +
> +	len = ip_len;
>  	iph_addr_p = &ip6h->saddr;
>  
>  	if (proto == IPPROTO_TCP)
> -		return recv_verify_packet_tcp(ip6h + 1, len - sizeof(*ip6h));
> +		return recv_verify_packet_tcp(ip6h + 1, len);
>  	else
> -		return recv_verify_packet_udp(ip6h + 1, len - sizeof(*ip6h));
> +		return recv_verify_packet_udp(ip6h + 1, len);
>  }
>  
>  /* return whether auxdata includes TP_STATUS_CSUM_VALID */
> -- 
> 2.35.1.1320.gc452695387.dirty
> 



