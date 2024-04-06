Return-Path: <linux-kselftest+bounces-7342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E489ACF5
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 22:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34EFB21212
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 20:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41DB4D121;
	Sat,  6 Apr 2024 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kDs/Du7x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E571EA6E;
	Sat,  6 Apr 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712436964; cv=none; b=ZTRNpzj6jVp3CzCNTLkh7+Gy9N5lr4ft8c9RcDhvE2VlT0iZYiTk6yJ0WU2pclmg0xP4U5dbG/LmJDaS8FaYiACIHaB0aatYu73Y4XJ2dcNz+I4kwDJMoZhG6Z8QUa5zwAd/VyYrNdxQbUqPQYDN9EaVUNxJtRJcn80V0R7ChQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712436964; c=relaxed/simple;
	bh=RKEPmxAfGQ9ElrL6ASH/zBKs0qwrt9MPyF81X9oxe9M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NRp0z33EJoPcMNQhwjIFSWmyhZqm3ddL3b+cSdes+Gftug+gIDL+M0GJ3WSqo5ODdKyuNs6ekCZxEhDgusNd1xgrIpTPdXlVj9PPqWhsJknKJ28ONxWMTVpuLnSd1fnXaEKEG0zbC1p6F1tVdEkPpwsAQcRedjAddDWz8yqXHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kDs/Du7x; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712436960;
	bh=RKEPmxAfGQ9ElrL6ASH/zBKs0qwrt9MPyF81X9oxe9M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kDs/Du7x48ukSJM6R1c8KCdOVE6tvfxC5Ufm32Fo47l9cuq+uktDApxQLWkHrYMx1
	 sn7CLCuEbuOb/rU054J6WEdINLkzAr99ox1IoXDxyQw2v3Rct8xfFO/BL3iBOreKpw
	 x+1jgBFraUZzOcxm5wHq7g2PZo+rzGz9AYMhac++DyBt8/SQOAD3paqnrVC1aetKjx
	 Vis30SVlya5USHtVNs1KwCLwiwwQgvSPtXvYTSvn0nxtUkjbXlGdPOXugwK+qrwPcY
	 udqB9IbG3LG0AW3O56sEX2DeVPD7a1MKw1xOyAjCVhNDhAurB6k+ntKzZyRe+Txclz
	 FlzNnVMsGSyrg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 110B43780894;
	Sat,  6 Apr 2024 20:55:55 +0000 (UTC)
Message-ID: <ac0743c0-616c-45e6-815f-c46fb03c329d@collabora.com>
Date: Sun, 7 Apr 2024 01:56:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, yan@daynix.com,
 andrew@daynix.com
Subject: Re: [PATCH] net: change maximum number of UDP segments to 128
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240406082513.78692-1-yuri.benditovich@daynix.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240406082513.78692-1-yuri.benditovich@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/24 1:25 PM, Yuri Benditovich wrote:
> Earlier commit fc8b2a619469378 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> added check of potential number of UDP segment vs UDP_MAX_SEGMENTS
> in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> 
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com

> ---
>  include/linux/udp.h                  | 2 +-
>  tools/testing/selftests/net/udpgso.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..7e75ccdf25fe 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -108,7 +108,7 @@ struct udp_sock {
>  #define udp_assign_bit(nr, sk, val)		\
>  	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
>  
> -#define UDP_MAX_SEGMENTS	(1 << 6UL)
> +#define UDP_MAX_SEGMENTS	(1 << 7UL)
>  
>  #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
>  
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
> index 1d975bf52af3..85b3baa3f7f3 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -34,7 +34,7 @@
>  #endif
>  
>  #ifndef UDP_MAX_SEGMENTS
> -#define UDP_MAX_SEGMENTS	(1 << 6UL)
> +#define UDP_MAX_SEGMENTS	(1 << 7UL)
>  #endif
>  
>  #define CONST_MTU_TEST	1500

-- 
BR,
Muhammad Usama Anjum

