Return-Path: <linux-kselftest+bounces-26974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890DFA3C223
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 15:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC33162836
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A541DFE32;
	Wed, 19 Feb 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRSNdgHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE831DA4E;
	Wed, 19 Feb 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975298; cv=none; b=Yc/iUXO3QMaTys/sx6xvGSJZ0Q4HkC6TBkKWLdl5o58r3SUZuRG4s/ip/bcSOizyk7RITPExeMlfFciCRvjJ5l43QMt3XCI974Zmddzu2qg9yLKyj+Ay15EZrtdQOvP6pbVG9SduI3VrVosdNwCnmCn9GxzxUg28FIpzK4lv24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975298; c=relaxed/simple;
	bh=9Etpmf5e22Xbdm4JlYWVaFCYjn0kXB5K0jMskE7II08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bopdIVg9P/qnF+wtKlcaeXqpZWUK3gTgWyFfVCe4UxDBU9ED5u/aQ+js17prPt/3DNNmOxx8MUgs3MUq4Hw1l7mLkTgjs4eyKPV3TB+RS106Sbz6zutcyrqLQ+dROOAqUvtRZK+NcN+4KQOwmRo0NLm/M21TTmYYCiawJyoRbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRSNdgHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C1FC4CED1;
	Wed, 19 Feb 2025 14:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739975298;
	bh=9Etpmf5e22Xbdm4JlYWVaFCYjn0kXB5K0jMskE7II08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRSNdgHS5lUos3u0kxJn5EdfIZ713GGq46yD5lCZiUqXEWiw6mjzsrp7qO5b03esn
	 o0XJuWKQc9hai/KjvKDBGODJWjQSuuYcYUSkHkAIxtZwfsBG/L0agJON57ZMPvtsjD
	 E+XlIEVSFzGLor9wEFOnOZkXuwniFlPyKXS1av8S0o3tL3odomtiX7g75U5LTCA5tT
	 hivCDJevYZB/pndz3G/wydIK1uOno2XWeSsANU0A7Tlzh3q7HfoVbb5JEjYYaROGGt
	 thzoXw6vftNlltbzAfNNyelG1e3X6QyWJ7gM4IzjCI5bmA7OVBBXJFHabND6BSnoAK
	 q+kjpleJfSjJg==
Date: Wed, 19 Feb 2025 16:28:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH net] xfrm_output: Force software GSO only in tunnel mode
Message-ID: <20250219142812.GG53094@unreal>
References: <20250219105248.226962-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219105248.226962-1-cratiu@nvidia.com>

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
> ---
>  net/xfrm/xfrm_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

