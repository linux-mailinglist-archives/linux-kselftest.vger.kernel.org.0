Return-Path: <linux-kselftest+bounces-28059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1909A4C3C9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1341170EB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04FE212FA1;
	Mon,  3 Mar 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hDZyA60H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22A78F3E
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013246; cv=none; b=f/g2mFK4BcV2Z3S0sFj8TKQaHyIrsWwWx9CC6wLtn7q1U4kMzkoS4HJj/obYJoN2Z+DqXXjuczPfvPrLLVdmPMtWdjXisB6f+7CIN+iFQjRQ95vXXKBL4KBB5T6YHDwV6ScS9I7BpQnqsPZTokIVdMsaLymWrvpj9yuk40hdtyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013246; c=relaxed/simple;
	bh=YK3vQOatiZKte940Yh6vGjcxz6PX8lovXmywTS7ON9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkFv5jQGSBt3y4IHlD7p9NBmfTqSVeSZkyyxSglAA3cY3YlOgzl83asHjZ2NegGFvxMhXFLe9YZffCuTSNAXi5ZCrc3tTPEj6ZiyAluPnsKSz5cnWK06HCLPGTwMaSpvEb319mAddvnDtloQjJwgxlRI2ELeVrVlk8V8N1rGnMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hDZyA60H; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4b410e48bso6862043a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 06:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741013243; x=1741618043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UjbM+V8Y3WsTK62memOwRHcpDks/OOOXgm2wXjSL9fA=;
        b=hDZyA60HVlnotgdjMdInMw8DCjEbKcBazu95V9LJz7AQycTHQQovUJHDY175AvXJ+H
         b4UZaKVzUEEmwUNZRAgXZykQgOCSfiM2wYHFWTTbOcYQbWu9ukbWSXipDQdiC4nBf6lX
         Xqi56tCp8fcL+kTM7hTzIGykVZt00J8/PjTJbpM2+u3qd02oXN1Ua9ewKDqjN+vjvwyQ
         5j6+PW4ju81yd1HgMd0NHF/0Nv5SttQaY5FDAekCj92UTx+CJbq6PwsHsxI1BiN2/50+
         s/hv2rFfP6vcDqFiKsURqbmOZlJFjpWEjGiUwB9wogI7frly84aFTHMKo8O+Pq7wxKSs
         wWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741013243; x=1741618043;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjbM+V8Y3WsTK62memOwRHcpDks/OOOXgm2wXjSL9fA=;
        b=RcWJ3HTtfFpn14NF319cvgBSubFCXfxHoehs7wD3TpH5ziRRuYhxoH9O0cWJNcIoEm
         mv7FahMOLDB612cyr632wUzsy1oYm28poFNtpreNEGPTvjs6iLHmGuD3LIPvrQeG4yQE
         Kzmfh4pwxPTkFlv+BFdbcV328mkaUWiEkljDPTXn3eiWTehEkjsdus3KLrfCOBn/xPej
         sqBiWlBMi4C6yDRDb1zcTIRBcsE6fxUCQRbJJvbtWFyqzPj7BFFDnwDISRVutULEoptz
         khBjSzlfONtXR86Cf3oqO2okt8ksgPmCeDh2jq2gQZGdjevvkNVlBhyEZa1el9Chwe/o
         +pzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvZAWOQkSnWXeAgPoNEh2NPd/2q6gayS/Ts6gujKKvUanhDJ1Blq2Gwe10F+jsiuqM8wZMXbG8KmVYdHZlTjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXGa44zyG4qhbw5MAHjMmuAqYIA5slnmPZR3AkDkITLpgxtRDM
	d3/XbbMq6p/vOyHLtsqyQ8mL9Z+NjwRCrqL8ZeYjOhqPlNQSI00WzU7ZYev8VDc=
X-Gm-Gg: ASbGncu+mPHsLTl3BSYi2qCslAU/ug33ZFTbHnUWQ2OKLUcFJxNvKrnPEudfqvcqxfI
	jBf2P9itMz65pHus/MIZSH+FZQkjQCn51zDHF2jfdi4XqazsVZ7eJgNH8fup+6ww5QmAj4W4S9T
	J/myqIsSTecdu6Hd+Kdo6c0WVVG8+yIRv/Eg0zRJEfgjosM0cHfix9HQ7hpn4nVIc6uaOM6MVAk
	KY/GrQu6icvj55i+inEoLWrBsOSlvXE8HKjWaC7gBWsYubpf+Bvsdpfd20o55XUnNgw42jxoDYo
	uIyMc0mqgFJt16EbpelnUhH3oTFzkcNq/wYgWhN3tI0b/MpNcCT+QFF302yQS8/3iXOVOquhDv1
	vfQQCXHk=
X-Google-Smtp-Source: AGHT+IHnsFe6vMwt658Orcv6r4zc6wGaqIvSA7uQHKo5p/cRGfjOeudZncUeFojjjSO1eyVXVb2uMA==
X-Received: by 2002:a05:6402:5c8:b0:5df:6de2:1e38 with SMTP id 4fb4d7f45d1cf-5e4d6b0ca3dmr14243645a12.17.1741013242803;
        Mon, 03 Mar 2025 06:47:22 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d41:ca07:21a5:f110? ([2001:67c:2fbc:1:4d41:ca07:21a5:f110])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4a81asm6850258a12.9.2025.03.03.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:47:22 -0800 (PST)
Message-ID: <26dbc569-4566-4f6c-9294-5129befbc6ff@openvpn.net>
Date: Mon, 3 Mar 2025 15:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 09/25] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
 <20250227-b4-ovpn-v20-9-93f363310834@openvpn.net> <Z8HVZm_eQwNR_r1A@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z8HVZm_eQwNR_r1A@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 16:25, Sabrina Dubroca wrote:
> (I'm still reviewing how everything fits together, but one small thing
> here:)
> 
> 2025-02-27, 02:21:34 +0100, Antonio Quartulli wrote:
>> +static void ovpn_udp_close(struct sock *sk, long timeout)
>> +{
>> +	struct ovpn_socket *sock;
>> +	struct ovpn_priv *ovpn;
>> +
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_sk_user_data(sk);
>> +	if (!sock || !sock->ovpn) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +	ovpn = sock->ovpn;
>> +	rcu_read_unlock();
>> +
>> +	if (ovpn->mode == OVPN_MODE_P2P)
>> +		ovpn_peer_release_p2p(ovpn, sk,
>> +				      OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT);
>> +	sock->udp_prot->close(sk, timeout);
>> +}
>> +
>> +static void ovpn_udp_build_protos(struct proto *new_prot,
>> +				  const struct proto *orig_prot)
>> +{
>> +	memcpy(new_prot, orig_prot, sizeof(*new_prot));
>> +	new_prot->close = ovpn_udp_close;
>> +}
> 
> Could you set ->encap_destroy in udp_tunnel_sock_cfg, instead of
> making up your own struct proto? It should allow to do basically the
> same thing, but with less code in ovpn:
> 
> ->close = udp_lib_close -> sk_common_release -> sk_prot->destroy = udp_destroy_sock -> encap_destroy

Oh, this is very nice.
I'll give it a go and stick to encap_destroy if no issue arise.

Cheers,

> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


