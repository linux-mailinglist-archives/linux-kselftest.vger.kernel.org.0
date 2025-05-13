Return-Path: <linux-kselftest+bounces-32903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF58AB5694
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03007B3D11
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED92BCF69;
	Tue, 13 May 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOpM7Izy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3262BCF49
	for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144523; cv=none; b=UGzi7Snu5iwnlvpngnbmjjBTfUChUBVNzUtU/mzPcCwH1teUuXHpCXjyDXbMirVIVY/aSvyeoQY+TNy/WrfO8cbI9ckntYewmYSWx0fjXcvnJuaEFKYwd6z5JxVvltmSYP0B7ThBKz7mRLye3mXQHerX+kC/YJdz65h3aMjkzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144523; c=relaxed/simple;
	bh=k8MO0qQYf2yjnXq8zGlgq6trmVTpsGIo34uVN9tvwMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPGZVng+hlCqqaq71hmXgRxJ2rBO7ACDe52h8+L2KQzjlmjb1925nPziNw3kwayHZRJkU2l/dXrZD6T7LrxBrgDvoicTYkDi9GDwFONs5Ht1ChL+npZavqaNSN7Zb+yYwOunKvAMYiCLM1c67dR6iAgJFn0TGXvR7m1EY1BaH1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOpM7Izy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747144519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
	b=aOpM7IzybmBrpA3d/D3cB0iUZylkn152A/3vBpyRooEEIXBSKv9yjx/660y9mjxkdQMD5n
	fTLduBMijHy0Y3RHA2ztJb2USndTfMZQJWTp7wYHTu6KHq46vlyO3PiZ7IO61WqmYqpCai
	DFs2iVYce0F1yfRhEEXcsaxIlkEB1x8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-IWev-VtYPBWOT0k72NldLA-1; Tue, 13 May 2025 09:55:18 -0400
X-MC-Unique: IWev-VtYPBWOT0k72NldLA-1
X-Mimecast-MFC-AGG-ID: IWev-VtYPBWOT0k72NldLA_1747144517
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a1f7204d72so2393331f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 May 2025 06:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747144517; x=1747749317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mDXk/1z60Kt8lR+wZMc16OkBv5Hh1LoZwzwZnjv5+0=;
        b=LmGYEnwfMtX/Fv8CquWmzquLTYHhAHg+zZ4OBHOjYpvZvCNdikZ1zrosxn/mUlm5xG
         UNJCEYrhYLo49Mi0GuKSbaO3+3cz+cBnXGr20DEch5f9vkKlZJ5HTd3Pei1ZDskWGMTg
         Yn4RUmCGIbe4lmdjQgnHaOAFksMfuxbYJmYMH7ewbFHL4Ae7EV4NOIvnPUgy+BaqIpdM
         gqjwKNwfKaw6/MWtyqLBuNVNdwB9FdQwkv7P5ilAtAPy58LmG11MEp2+tijnwJUFKHfe
         +FqZboqKmux7ajMDr6jM8iBJoyoQ8Xb9Du2EiHdWGCGjSU3dKkbY7Sjr7bjaooP8piRV
         EnbA==
X-Forwarded-Encrypted: i=1; AJvYcCX5E7DyYqBZYNe6r/7EjLK5yzmyOUGyqlzj661STjZrdw8No25VKM5/e7fsHpUCKN5IDyPJAUheX8yMlA/p0nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTf2kBHN02hfAQXqscHnin45FHug8IyRU7bQ1V3mPdGLeVQK2
	5v50/gl5f2jitWYNQBmlxZp6AYjhJG8iAL0Qs6a0+4IGwM0ee9gg6H+dkohkKiAxH30cVddNnZs
	lQlxTVAQJMP1H5aZEZZA1w4SRdvUq/zR+5vCj5ZQP81x4KygzQ6+Ny1t+Sgx68yrUAA==
X-Gm-Gg: ASbGncvAfhXr0+5eDrfuWctmUwW2pLuuEbb1N32JXo/CjYZGRvzU1UPEG983t75DISN
	x3fbgP/bW4T+XOdaHj2ZlNlJmdNij8s4wqhb4P7GKTHREeLaN9QQYQYv2Z9qAHtfSche8kJOqQ4
	PRcPpZiPXcyU3pnDjz5/S8ciQXGt1cJ9OsB+Zevz8iHL//BXxM30YxyCCfU8rpRqJE6ZS7lUEZ1
	KjFAm5qb5tsrtV7hGSjKnBsX9axIOTyT/sjgY6Pr+tIOgVdsZEl/94VS1Shzw4IcqVB6wL2zSgt
	bIzk09sKcH3C8i27dkA=
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324322f8f.7.1747144517309;
        Tue, 13 May 2025 06:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/3P787hez5DUCbzjfJPJODBbn5DQDvgAda7uo/wL13u5mlBuNcHOROPQYLGn7Nvk65To4cg==
X-Received: by 2002:a5d:598e:0:b0:39c:2688:612b with SMTP id ffacd0b85a97d-3a1f64277femr15324275f8f.7.1747144516860;
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde0esm16586527f8f.18.2025.05.13.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 06:55:16 -0700 (PDT)
Message-ID: <39e06f51-621a-4d17-a4dd-17287e260e18@redhat.com>
Date: Tue, 13 May 2025 15:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 04/15] tcp: AccECN core
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org,
 kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509211820.36880-5-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:18 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -5098,7 +5100,8 @@ static void __init tcp_struct_check(void)
>  	/* 32bit arches with 8byte alignment on u64 fields might need padding
>  	 * before tcp_clock_cache.
>  	 */
> -	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
> +	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 96 + 4);

This looks inconsistent with the pahole output in the commit message
(the groups looks 95 bytes wide, comprising the holes)

[...]
> @@ -382,11 +393,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
>  {
>  	struct tcp_sock *tp = tcp_sk(sk);
>  
> -	if (tcp_ecn_mode_rfc3168(tp)) {
> +	if (!tcp_ecn_mode_any(tp))
> +		return;
> +
> +	INET_ECN_xmit(sk);
> +	if (tcp_ecn_mode_accecn(tp)) {
> +		tcp_accecn_set_ace(th, tp);
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
> +	} else {
>  		/* Not-retransmitted data segment: set ECT and inject CWR. */
>  		if (skb->len != tcp_header_len &&
>  		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
> -			INET_ECN_xmit(sk);

The above chunk apparently changes the current behaviour for
!tcp_ecn_mode_accecn(), unconditionally setting ECN, while before ECN
was set only for non retrans segments.

/P


