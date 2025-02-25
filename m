Return-Path: <linux-kselftest+bounces-27445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DC5A43DA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6437A5744
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B107203709;
	Tue, 25 Feb 2025 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YKOpJNmO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6033FB3B;
	Tue, 25 Feb 2025 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483031; cv=none; b=B0/FV5odRSIwhRtJ/q+QgadQh8Bt2B5IVVG6V97G5ry/pLPX3jV3fv72qgBeGHXCdmBONh5lFQmkXpeEW8gZInbXnoRBE0tNE0hURQGQW4WXJh1t6J20ziOVM9zLIU+fdwVLWUYp7fynz6culRexjQRjPT29ff7kUvlnmUv2btU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483031; c=relaxed/simple;
	bh=5JkI6I/KKcUKr71+ZMQ71+9ZZhUCqVTU9Aa6nTChzK4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF7HwwanPiDgYquDTcqa6MzP92215GmLVv4WAQr/ToyE5pYcovICjqdm/C1P4D5MnVXtJuZ0YZYTIfGgj9SCvScU7rQDZmPe552hpABM/UFwIKgz6jK6yD9UKqU7cTTQwRZLlgnFzFUwYP6FH+iHkKuR+I4Xi3FGWtX41He2O8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YKOpJNmO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DE94D20758;
	Tue, 25 Feb 2025 12:30:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cuqB9zGpxzzd; Tue, 25 Feb 2025 12:30:26 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2EFB020538;
	Tue, 25 Feb 2025 12:30:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2EFB020538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1740483026;
	bh=avFfv++348AjyeuAhp90vldguj68XpkUO6jKgW4t87c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YKOpJNmOh/laYuYlCmiLRjfJ1ybVjYbXFZJc7SMq6nHUtER9fktSWKhFez9ycHkfK
	 c4JYpvqov5B2ESpljJB+KApZ3tq9B7hAin8ANQarKBxSg55J223p3oFkOfdUTvhNPN
	 FPV5mPLFMP0ACLPUkzrQ3Wn2qpfQaqFasYJC6PtSHw650XjkscKUbJRE2UZUSs9T8f
	 7LvrcbVZaScLTmd1jeSvy/G/49E/ARC5liHrXUBNDBFu3+lDzaV92JGmTKL8a5JGs2
	 THCUP4u3PNlAIFRxHL9uCnM6wHgyU60wZ4vItRCNw8E4Vmy7VU6ebGpgNhfvlBtxl+
	 G98AWvIGBtzJg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Feb 2025 12:30:25 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 12:30:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 0CCFE3183EA6; Tue, 25 Feb 2025 12:30:25 +0100 (CET)
Date: Tue, 25 Feb 2025 12:30:24 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Eric Dumazet
	<edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>,
	"Yael Chemla" <ychemla@nvidia.com>
Subject: Re: [PATCH net] xfrm_output: Force software GSO only in tunnel mode
Message-ID: <Z72p0GAD8eSweiz7@gauss3.secunet.de>
References: <20250219105248.226962-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250219105248.226962-1-cratiu@nvidia.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 19, 2025 at 12:52:48PM +0200, Cosmin Ratiu wrote:
> The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
> mode. Unfortunately, it is slightly broader than necessary, as it also
> severely affects performance for Geneve + IPSec transport mode over a
> device capable of both HW GSO and IPSec crypto offload. In this case,
> xfrm_output unnecessarily triggers software GSO instead of letting the
> HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
> a back-2-back pair of NICs with MTU 1500, the performance was observed
> to be up to 6x worse when doing software GSO compared to leaving it to
> the hardware.
> 
> This commit makes xfrm_output only trigger software GSO in crypto
> offload cases for already encapsulated packets in tunnel mode, as not
> doing so would then cause the inner tunnel skb->inner_networking_header
> to be overwritten and break software GSO for that packet later if the
> device turns out to not be capable of HW GSO.
> 
> Taking a closer look at the conditions for the original bug, to better
> understand the reasons for this change:
> - vxlan_build_skb -> iptunnel_handle_offloads sets inner_protocol and
>   inner network header.
> - then, udp_tunnel_xmit_skb -> ip_tunnel_xmit adds outer transport and
>   network headers.
> - later in the xmit path, xfrm_output -> xfrm_outer_mode_output ->
>   xfrm4_prepare_output -> xfrm4_tunnel_encap_add overwrites the inner
>   network header with the one set in ip_tunnel_xmit before adding the
>   second outer header.
> - __dev_queue_xmit -> validate_xmit_skb checks whether GSO segmentation
>   needs to happen based on dev features. In the original bug, the hw
>   couldn't segment the packets, so skb_gso_segment was invoked.
> - deep in the .gso_segment callback machinery, __skb_udp_tunnel_segment
>   tries to use the wrong inner network header, expecting the one set in
>   iptunnel_handle_offloads but getting the one set by xfrm instead.
> - a bit later, ipv6_gso_segment accesses the wrong memory based on that
>   wrong inner network header.
> 
> With the new change, the original bug (or similar ones) cannot happen
> again, as xfrm will now trigger software GSO before applying a tunnel.
> This concern doesn't exist in packet offload mode, when the HW adds
> encapsulation headers. For the non-offloaded packets (crypto in SW),
> software GSO is still done unconditionally in the else branch.
> 
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is set in xfrm_output")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Applied, thanks Cosmin!

