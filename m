Return-Path: <linux-kselftest+bounces-23141-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12979EC2E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 04:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C27C5165D8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 03:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9853204F79;
	Wed, 11 Dec 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7ajyQOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7516F30C;
	Wed, 11 Dec 2024 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733886579; cv=none; b=OAHawm4ST1p8D9ee60ClwzsugoytZ4OWIXcDiKT9kkQ8GT/w1tpUHUj80CvU83vlloMmNmCD5tUg/EZXLFhVW+l8MRn9hTCF5MbcC6IOIGQAqKWOn34xyrNEYjR8eLG+UfrnjzJP87k92qYDPqa2GWBBABABtlNGTttImzPIlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733886579; c=relaxed/simple;
	bh=WmrUd5Nu2a7eyR1oMIbgS0v2IvziIaAtqv+1/FXypfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GccejTh0JJJPDMQTKZAOHW6aNovRMMdTpOpFuVeQP6dRQr2PeopOhNrqcH5EwE7bOFLHOAKSW9XYLRO+xMIIEstCvHGKC/7cQPkT88u0XnENyBibgNIORsMnm4vbJvcM0Fha/4sb4wxTfVThsbQv0G/PIgcu6/R2olZFNRwm1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7ajyQOf; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38637614567so1787361f8f.3;
        Tue, 10 Dec 2024 19:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733886576; x=1734491376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrvqNyhKC4J4j6+ceUZ/ULpbNEbVa+Y8QtWcj7x+I1k=;
        b=h7ajyQOffZmh9ww0ivtWKKy8vMYNHeHAMJFaXVLLu4r5L9kn42BHVvZJwaKsXM6dWP
         y6bjtg5jSEv6Vuj3oXrs+IQo+uUaC1tI51o2jePhJlmDKlj/a8Dp6UH22ImXXRKnVzI3
         qXPxLEEeexnsI+R/ENqR58CC6LGR9MBWpTKYdlYs9Pj5OtzQZlFgF9fPjXc+Pd48xov4
         C+KlTN+jcfI/XYs3tjySIzXZ4sa1RlxR0RSQ+rsYHAXJGCzCwcNsgIr48+SYRCFdyXzQ
         e2NZAls04TEMisZo0L5IN6krzssGkfFOM8S9wLwgX43MlH4kYjwnP7afWRM1uFjcwQGm
         Oqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733886576; x=1734491376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrvqNyhKC4J4j6+ceUZ/ULpbNEbVa+Y8QtWcj7x+I1k=;
        b=HYkdxNF3TZYxq0dH0839rQDUrwcEVhb3x3nfBM4oouXgMC1R5DZnSkIdYz5bpGGXy6
         83pdpTq+fzPmtjQHOlb02gEBcOnre0hNfiVzvoyl0Gw7jsI05BcTizReFMx0x2ddMaOi
         vhEX4INvBDbvY5kxRKy84dFddq+KOQrIywV9BUb7dDRas6l5CB2JppO/j6cMPMpF2mDC
         Xovw4rG6dsOBgtS78unQLGtBN1rblkNx7lLJKg0KY/DE/+yBHSuHVyDOLgXkqxKCN/od
         yH3UF4dBWjKZevOoOCJnl4RL/t10Pae+0OSGv/nxL51ZWy+CNH5BiUIDIlfLuYSsLp9W
         g1ig==
X-Forwarded-Encrypted: i=1; AJvYcCViJ7kOcp0Sqg3CMbEff0FyT4mlM9zrGjtJ/BLGqunhau2T0KRJia3SwMNaqhW3aYI4YEah5L36faslkleGgP8f@vger.kernel.org, AJvYcCXrzr6IZzuPc1aSzTTZdfnLO5g6UJeYfeVBSDhjsF+k1S4nwE/uP49jY5Af5CBOzgFPmhL4atSOaFkdFIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxjiy/urAIuH1OdV+Dy793RhHSQa8akR6VnyVNq0FGPZBqqHQU
	v2NZ9cbu3I9n+bmZKpB4k7gKuWdxoJPDjgvMdaH5cXvqDtDfAkeQKUgKjwl/miRAbDGBQCIYd41
	Hm/HkopWyG86wdA10NSq+lGtHBQ8=
X-Gm-Gg: ASbGnct5NouLhSwZ949Ckm0einvuMzfRPEgUYY6js4mmkYlCHUciebNN7y7Q9kfb+JP
	0y4+b7wLAg+7NopZoB3qvC5Jx8RCHRPIqNA==
X-Google-Smtp-Source: AGHT+IHtYGYEAAmYOf8dXiFVQC5xP/l+aAUTsx/Mqvp+fp0NoPDfS4GQ9TBCXwwLk8+JKMb0nNq5SQgzCMv7a2Qk7lk=
X-Received: by 2002:a5d:6486:0:b0:386:4a60:6650 with SMTP id
 ffacd0b85a97d-3864cec5bd0mr853962f8f.42.1733886576197; Tue, 10 Dec 2024
 19:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net> <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 11 Dec 2024 11:08:59 +0800
Message-ID: <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
Subject: Re: [PATCH net-next v14 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, 
	ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 6:48=E2=80=AFPM Antonio Quartulli <antonio@openvpn.n=
et> wrote:
[...]
> +/**
> + * ovpn_nl_peer_modify - modify the peer attributes according to the inc=
oming msg
> + * @peer: the peer to modify
> + * @info: generic netlink info from the user request
> + * @attrs: the attributes from the user request
> + *
> + * Return: a negative error code in case of failure, 0 on success or 1 o=
n
> + *        success and the VPN IPs have been modified (requires rehashing=
 in MP
> + *        mode)
> + */
> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info =
*info,
> +                              struct nlattr **attrs)
> +{
> +       struct sockaddr_storage ss =3D {};
> +       struct ovpn_socket *ovpn_sock;
> +       u32 sockfd, interv, timeout;
> +       struct socket *sock =3D NULL;
> +       u8 *local_ip =3D NULL;
> +       bool rehash =3D false;
> +       int ret;
> +
> +       if (attrs[OVPN_A_PEER_SOCKET]) {

Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LINK,
IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
(e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
and routing decision, which are supported in datapath? And do we need
some validation here?

[...]
> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info=
 *info,
> +                            const struct ovpn_peer *peer, u32 portid, u3=
2 seq,
> +                            int flags)
> +{
> +       const struct ovpn_bind *bind;
> +       struct nlattr *attr;
> +       void *hdr;
> +
> +       hdr =3D genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
> +                         OVPN_CMD_PEER_GET);
> +       if (!hdr)
> +               return -ENOBUFS;
> +
> +       attr =3D nla_nest_start(skb, OVPN_A_PEER);
> +       if (!attr)
> +               goto err;
> +
> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
> +               goto err;
> +

I think it would be helpful to include the netns ID and supported sockopts
of the peer socket in peer info message.

