Return-Path: <linux-kselftest+bounces-23174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DAC9ECB37
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 12:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DBD1888F43
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32A238E27;
	Wed, 11 Dec 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VQUAmmY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA2C1D5CC1
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733916629; cv=none; b=VI2uWvyyAIgEQJpOJwlcxyfKj/AUshZNwYiUjtMYJW1nOBiVw374bZVU8QIE1MWhNvdX4K7lhNcJdv+m6xzF23Qmrxt+Zyd7XDnUvV6CAwOiPzdYaoAOrmgb1IEmmiVIXvJ4b0/QpxM7cbFIEhMBmIDg1SGflo3Ff3V3gpE8Xwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733916629; c=relaxed/simple;
	bh=6W6L1Tf7yGGcjpTjBsl9mm8DEo+CIikh1VszU7Yey94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmX/74b5cdcmZ3aY7Kdo/aWMaqA2+hYVUOFgVEBSOiy9/HiqYjQzDqYaNRNzPFALK30UZG33/8RPSpTYB0hYXspgFXCIfb8kfuSQdmzr1c0mtlIdTQtUy/C8MaUDxKl0agaVtAFHwhJEkflXnhWrWo/h4EI1Vv4Dnl8rE0shveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VQUAmmY4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434f30ba149so23533545e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 03:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733916625; x=1734521425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KtC2aVUCNmOY4NznYrw0YczTb2jM6dFjZfPdIjwCXqw=;
        b=VQUAmmY4FooY7NVQZESSYAGZYQu3PscHFQFRw7+xtFL6IFU4lr7YLfo7FrN9oqhHH5
         iiVnZ5372m1VGTyXOh7YjMbqS3ttIYc5rb382h2OLt9V8JLlBAal6lfNWNW14t4cZLDG
         W981BIQcGPZAgp1jtt/u6FuORnj0Z9//Unl9bwvGLaQRwSWZJl3HyS9G2ilPb/P7ZeYY
         cm8Lx+cWfu4S081EL5UavfN5yrfqEAzuMSgE91FH+w2TE2N4qGOx7oIOzqMml+kYB7c8
         oKrmvBnErIhwILYcq8GU3TjG88r/7hfqEbNop2v38daY98RKNwoxgkFB9/DjflhjcO3T
         Wtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733916625; x=1734521425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtC2aVUCNmOY4NznYrw0YczTb2jM6dFjZfPdIjwCXqw=;
        b=TF6/NIG4w13K+xR9xeVjAfUATr5MsEBfEXRlkrHnPAiHopskCVH3tATUvcoesHTeQ9
         +2vbXiGrIMZoPCAMhpXypRJ1UlC8TwrXwUrrOLruMfu0g1peIX6W3Newswb7aUbj+V3R
         kUN/kPyhuPmLRscCcSX5oh41qTSVH0nAceGldQmu8pwD8WOUzzPdC0OIefOeLXgFaDIW
         QfDfrJmDpfMIYo3jl/WmXYO65pf9pWEi/tDVb0iy5YV2D0GN70Os69fr4L5e0yUnUV0e
         1zMDgz44h6BJa80lJzdkMX+v7S7KuirapCW+43HiuyXSxkexIU217iTtr9Aidxfwocrx
         7YuA==
X-Forwarded-Encrypted: i=1; AJvYcCVGFkYDIMm5ES3WPTjXz41EtCXY1W0z8/rLzE95IsBlG9hVqrKkIWVgHKDopdd9HFHgDNWnk70Qyf5kuuyAUMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQyluV1DF4j8sIWrWC5mG6RUrx1qsAzNFiTQsFrivwfEI75Rp
	H1kht8djBxIFBBi3y7UoWiDEg+lbK0yHDU9ctGhayVPdpQXWUoNJNB08RkQ42QU=
X-Gm-Gg: ASbGncsPHLWZWI4nGgJOu/w/3zYZCoyRdBxhyGSy2IVfOO+s6kUqotPiVK5wdCH7t0Y
	rpvdYWsJwoLsJZtsjzQVL53bDgeyppn4CRbjYeMPqexlzq53dTxK6xMU5Ox9YJk7X31sfclf6A4
	gjgNOyXGzpWB0gbcLLBb/1X2u87qULBQIrWsiHPYOpETGKE9063GP92tlsAIbMxBJzINN35IGL2
	ZLPihDQ22Hohj3HNDBV4qoYkvxSUZTenDcESuu4UV+Lp2CYEXzQEihWzEEp89/LVHRcZK93UZPR
	zUTwWyIDYjg20g==
X-Google-Smtp-Source: AGHT+IGLUWsPSz7V+CdPs+HV+wwsBw5mLiGqfQuj+VwFhr00V+HqhtsmBDClS6l0UCkdvIEgUbHgQg==
X-Received: by 2002:a05:600c:3552:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-4361c360e94mr22357895e9.10.1733916625186;
        Wed, 11 Dec 2024 03:30:25 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f6e8:f722:d96d:abb? ([2001:67c:2fbc:1:f6e8:f722:d96d:abb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b577sm262182715e9.3.2024.12.11.03.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 03:30:24 -0800 (PST)
Message-ID: <5a3d1c9b-f000-45c1-afd3-c7a10d2a50e8@openvpn.net>
Date: Wed, 11 Dec 2024 12:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 17/22] ovpn: implement peer
 add/get/dump/delete via netlink
To: Xiao Liang <shaw.leon@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
 <20241209-b4-ovpn-v14-17-ea243cf16417@openvpn.net>
 <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CABAhCOSJCoZFuevjcwvdJ+==TpGEJZPmvvHfT=U3Kf_-Ob+BnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xiao and thanks for chiming in,

On 11/12/2024 04:08, Xiao Liang wrote:
> On Mon, Dec 9, 2024 at 6:48 PM Antonio Quartulli <antonio@openvpn.net> wrote:
> [...]
>> +/**
>> + * ovpn_nl_peer_modify - modify the peer attributes according to the incoming msg
>> + * @peer: the peer to modify
>> + * @info: generic netlink info from the user request
>> + * @attrs: the attributes from the user request
>> + *
>> + * Return: a negative error code in case of failure, 0 on success or 1 on
>> + *        success and the VPN IPs have been modified (requires rehashing in MP
>> + *        mode)
>> + */
>> +static int ovpn_nl_peer_modify(struct ovpn_peer *peer, struct genl_info *info,
>> +                              struct nlattr **attrs)
>> +{
>> +       struct sockaddr_storage ss = {};
>> +       struct ovpn_socket *ovpn_sock;
>> +       u32 sockfd, interv, timeout;
>> +       struct socket *sock = NULL;
>> +       u8 *local_ip = NULL;
>> +       bool rehash = false;
>> +       int ret;
>> +
>> +       if (attrs[OVPN_A_PEER_SOCKET]) {
> 
> Similar to link attributes in other tunnel drivers (e.g. IFLA_GRE_LINK,
> IFLA_GRE_FWMARK), user-supplied sockets could have sockopts
> (e.g. oif, fwmark, TOS). Since some of them may affect encapsulation
> and routing decision, which are supported in datapath? And do we need
> some validation here?

Thanks for pointing this out.
At the moment ovpn doesn't expect any specific socket option.
I haven't investigated how they could be used and what effect they would 
have on the packet processing.
This is something we may consider later.

At this point, do you still think I should add a check here of some sort?

> 
> [...]
>> +static int ovpn_nl_send_peer(struct sk_buff *skb, const struct genl_info *info,
>> +                            const struct ovpn_peer *peer, u32 portid, u32 seq,
>> +                            int flags)
>> +{
>> +       const struct ovpn_bind *bind;
>> +       struct nlattr *attr;
>> +       void *hdr;
>> +
>> +       hdr = genlmsg_put(skb, portid, seq, &ovpn_nl_family, flags,
>> +                         OVPN_CMD_PEER_GET);
>> +       if (!hdr)
>> +               return -ENOBUFS;
>> +
>> +       attr = nla_nest_start(skb, OVPN_A_PEER);
>> +       if (!attr)
>> +               goto err;
>> +
>> +       if (nla_put_u32(skb, OVPN_A_PEER_ID, peer->id))
>> +               goto err;
>> +
> 
> I think it would be helpful to include the netns ID and supported sockopts
> of the peer socket in peer info message.

Technically the netns is the same as where the openvpn process in 
userspace is running, because it'll be it to open the socket and pass it 
down to ovpn.
Therefore I am not sure there is any value in echoing back the netns ID. 
Wouldn't you agree?

Regarding sockopts, as mentioned above, this is somewhat unsupported for 
now, so I Am not sure we have anything to send back.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


