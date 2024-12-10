Return-Path: <linux-kselftest+bounces-23108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1D9EB6CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C99E28117F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 16:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6A22FE05;
	Tue, 10 Dec 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tspts45d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCF1B86DC;
	Tue, 10 Dec 2024 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849062; cv=none; b=SUb4iBbJ12CmZR5+EMqJdOT3JC0BAXD4jwKL4o1b7XAwBDY5jiQmH2wNIXyUD7TQRhgV/4ppFt+rH9m+T0Mtv8xZ+c+pHNQYvUz7JgBMGg7cLB3+3qAUvyCrnXBS/Wv8CMzG2+hypUVp+B+0aAHjuzqgUNceZbrIJacgNZyUuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849062; c=relaxed/simple;
	bh=pL8ZJf6GXK6oMHRfsGO0fPp3B7jVK/h5nmFZ5atz0w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbJ8WrSUTHY94dUGTRTCVcxZrf/rOarAbQDjVKThNSHcSRdMdBgx1kmlCpaUH3jFWbbd9mO2CMgR7Hsn6AVcjr5S2N9D8xW6Xt86ji6JbJqMiwNnXiBqrR3PQrM+MRy2oMOtVpK+7w2+DaASoRbGea1XDzqEzcuOCCkG7YkgdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tspts45d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3740AC4CED6;
	Tue, 10 Dec 2024 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733849061;
	bh=pL8ZJf6GXK6oMHRfsGO0fPp3B7jVK/h5nmFZ5atz0w0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tspts45dZ2XtIBHwDCtDiX6VT857lqbTF4tuIkXl+T0JfmYqQ19eHlZtMsIsbrjuz
	 wU5WRFVgM5VTToTyZLj0Yh51vlkjNphR2Gx2+kBhMhGAFH+zKx5loYzQHwfSngo8gx
	 dTircwlH/gOgERPVE6dn+CfAlR3p+sZBMCU3E5+/Z9fDE1SmhY4qe/FmRQiMjqxxi9
	 04pqTkmAEli8Ks+DWl4vS13MnEqqEeaqZ5m4Qsj/Fa4vmKiC6lhmSGEYhtgbb2reVy
	 Zf84jq/xMrkQYG7jaLzS5kz66xprd9dmLGDaAWfSMza93dsivSgGhygSMjaaxgZbag
	 BVfjelo4OCipg==
Date: Tue, 10 Dec 2024 16:44:17 +0000
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v14 08/22] ovpn: implement basic RX path (UDP)
Message-ID: <20241210164417.GA6554@kernel.org>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-8-ea243cf16417@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-b4-ovpn-v14-8-ea243cf16417@openvpn.net>

On Mon, Dec 09, 2024 at 09:53:17AM +0100, Antonio Quartulli wrote:
> Packets received over the socket are forwarded to the user device.
> 
> Implementation is UDP only. TCP will be added by a later patch.
> 
> Note: no decryption/decapsulation exists yet, packets are forwarded as
> they arrive without much processing.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index c0e7aa289ad3345fcd91e7c890f70961300c356f..975392fc39bc4c0107a07a53795afecd88d72c53 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -23,9 +23,83 @@
>  #include "bind.h"
>  #include "io.h"
>  #include "peer.h"
> +#include "proto.h"
>  #include "socket.h"
>  #include "udp.h"
>  
> +/**
> + * ovpn_udp_encap_recv - Start processing a received UDP packet.
> + * @sk: socket over which the packet was received
> + * @skb: the received packet
> + *
> + * If the first byte of the payload is DATA_V2, the packet is further processed,
> + * otherwise it is forwarded to the UDP stack for delivery to user space.
> + *
> + * Return:
> + *  0 if skb was consumed or dropped
> + * >0 if skb should be passed up to userspace as UDP (packet not consumed)
> + * <0 if skb should be resubmitted as proto -N (packet not consumed)
> + */
> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ovpn_priv *ovpn;
> +	struct ovpn_peer *peer;
> +	u32 peer_id;
> +	u8 opcode;
> +
> +	ovpn = ovpn_from_udp_sock(sk);
> +	if (unlikely(!ovpn)) {
> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
> +				    netdev_name(ovpn->dev));

Hi Antonio,

If we reach here then ovpn is NULL.
But the like above dereferences it.

Flagged by Smatch.

> +		goto drop_noovpn;
> +	}

...

-- 
pw-bot: changes-requested

