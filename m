Return-Path: <linux-kselftest+bounces-22752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE79E245C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12ADB46856
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E411F7579;
	Tue,  3 Dec 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N3kiKX9i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311D1F756B
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Dec 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237675; cv=none; b=Zr7PBPiBIm7tlf1RgAvll20rNGvPEk5DHvxm3clgfcvaKWBL2EOYWvKKB7V5utumQl6U/QXgU3wvbnJZ2n2aPzp4KyTGf5RcRaSB2Y/K7yLnoo+kKxtx/Ii6QLsNDKjzXC3jJAouPw3DmQoedhV6X2W7lLbhtLHS5793M2EPJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237675; c=relaxed/simple;
	bh=UQjRB/iiGNlLdWFTbEyxRMpgOYyShYMtFGUSVio+OHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4/1mc1qr/0CYep77LgFUf+Kw8GqHRFXC2HhOrE3Hd0CvDGQ8uNp3rWxCx0o0FWOR9xxCJZtqgrdxI7aUXQOwCdgcfDQAbfCjId0wwvxkkWG/6k+NttP1+5Gn8Hq1zi1eW0EwVSnz8adg4zMW/GWB67A3QwRjbWdN3yLHzFRd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N3kiKX9i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa549f2fa32so851650566b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2024 06:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733237671; x=1733842471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EPo5vhgAlRLo/paB/QgTHFTZuoAtooYyqQxA/gwq1FI=;
        b=N3kiKX9iOcAqos+NlSoaSMburskWHliksCaoXpKKtC+/UhGYbCJEiiL/2mgdJD1J0h
         c2Hen0/TxVrI2MRF5XBaPVpUjmbrDi/I6rlTVxZP0bGkOIz5hZl4EV6UTkQV3Qma6rIz
         cIcTdKKUJQ6pY785J636lvJ9lZzZAtrado45DbzPFJmeAvwWHkBM2K2mOUQE7XhZXGAH
         HPAuBnMT0o43lrl40SBw/n5fzm8SxPKqdUTRFtzmPMW0/ydCjHKE9RgC0jSs+splypC4
         x2UwManCyTDEAsbTyz+riAxmvpHdVTH38hrc6FvXgLHD26EtvQEEWxgS5aCQPee0jcCc
         izgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237671; x=1733842471;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPo5vhgAlRLo/paB/QgTHFTZuoAtooYyqQxA/gwq1FI=;
        b=WouxXdwbDugcxxKOOgryNYx1v1cJdj3GQCy8DOA+Kuogs3EA+K/x7usHjFufKwZfMo
         Jc0qOisjJuG07bVw9NIdcrBWIiWgYPFYb/uoqgchf3ZVRD8ttQ/Bqf9o31uAwGgY/onK
         WSvtEcp3Ng7yvxYL7HAp0u3r0dYbNjKKQhn6Sfas+i1GFujTSHzY0A0LPQy4S7Z4feaz
         2vQkN12tCLxmiumjElT3maB1kzYtysmMPTSdgD5Ari34K410ctjCcvfZACrT0WOWC19l
         QMYa08wkOBbJYZURrN09BrxA0putbRINWRPX68vcDk0jt39U+n+kG1ecuXdglwr3Raq/
         g3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjoYufLN4uOmaySWZo1HGeXi5/bpyuJQhYipZv3v4DzdkNbAQN/vFBla7hgWSoS/aHgw2c3gmGU53dZIe1RFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiubprvGc8og8YPzfg5cFtIC9RKWIsYobEFuXVAjaGrr8eyBd/
	hiyG40Hw3MJe36o4RFEgz9sIcMSlWbw/7kKaJXJs1qVF0eu8hwhJkTHR28Jte6k=
X-Gm-Gg: ASbGncudCv1v6USrrgonYbimTapqvXlF/kGAk+fgeKEN0So6qxrjMs87drygpPBwXF7
	cFhJBNvdJRS9h6NtjsjVmkVW5JpIOKNBhGDAlcJEOPRkj4XhghKBiOzG3IUjEfXpTzdc2Jotz4n
	pyy8kGNnyHtuvy8GK9jKXkfAFCWnRBnyBKS3328G99jsR+7Jlqxo0YBiwbrXwQK5oggUkZJFsLz
	iiLJtgZbWGnTnbHyUF58arr+xGy5WRPrUYnRJbkmA0i3B+v00wABvgUo75hRcxGFghutso3FJfY
	oPbM1IltTUiE
X-Google-Smtp-Source: AGHT+IFJGYTiaJyBkXpfaAcxdpCUi6aRICoEvqJpoe6f7aKKifkDK0+AYFyZ2Z56/DN0Nj7XpUN2gw==
X-Received: by 2002:a17:906:1db2:b0:aa5:451c:ce21 with SMTP id a640c23a62f3a-aa5f7eccd3emr207126266b.40.1733237671630;
        Tue, 03 Dec 2024 06:54:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:138c:c1e3:75bf:72b5? ([2001:67c:2fbc:1:138c:c1e3:75bf:72b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599953c69sm625987866b.187.2024.12.03.06.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:54:31 -0800 (PST)
Message-ID: <9950a359-4a3c-4c7f-a915-e96d55571c40@openvpn.net>
Date: Tue, 3 Dec 2024 15:55:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/22] ovpn: implement basic TX path (UDP)
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-7-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20241202-b4-ovpn-v12-7-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 16:07, Antonio Quartulli wrote:
[...]
> +/**
> + * ovpn_udp_output - transmit skb using udp-tunnel
> + * @peer: the destination peer
> + * @cache: dst cache
> + * @sk: the socket to send the packet over
> + * @skb: the packet to send
> + *
> + * rcu_read_lock should be held on entry.
> + * On return, the skb is consumed.
> + *
> + * Return: 0 on success or a negative error code otherwise
> + */
> +static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
> +			   struct sock *sk, struct sk_buff *skb)
> +{
> +	struct ovpn_bind *bind;
> +	int ret;
> +
> +	/* set sk to null if skb is already orphaned */
> +	if (!skb->destructor)
> +		skb->sk = NULL;
> +
> +	/* always permit openvpn-created packets to be (outside) fragmented */
> +	skb->ignore_df = 1;
> +
> +	rcu_read_lock();
> +	bind = rcu_dereference(peer->bind);
> +	if (unlikely(!bind)) {
> +		net_warn_ratelimited("%s: no bind for remote peer %u\n",
> +				     netdev_name(peer->ovpn->dev), peer->id);
> +		goto out;

I just saw on patchwork that this goto leads to returning ret 
uninitialized. It was reported by clang.

> +	}
> +
> +	switch (bind->remote.in4.sin_family) {
> +	case AF_INET:
> +		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
> +		break;
> +#endif
> +	default:
> +		ret = -EAFNOSUPPORT;
> +		break;
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +	return ret;

here.

Will fix this.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


