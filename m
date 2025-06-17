Return-Path: <linux-kselftest+bounces-35195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FB2ADC6E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55951894EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307A2C0322;
	Tue, 17 Jun 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCs/pUdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8882BEC3B
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153469; cv=none; b=j4iTbLJflMyBJ3B5FvgG+vjk6B7IabgeXJjRujS94ddzR4tpJQkOPv292BW33TLU8/eGTOr0BTKAFfvOrDSUtEOXDJGpubCU+M2q+eM7KsuAK8XiuPMTQNH8JH+3l6X0HTl4RvgRACiAEzoKxPRTQgjk9HhvN7ekJa3wFyMMAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153469; c=relaxed/simple;
	bh=e4uRqKiHK+914gVeOIiVV3X3FcUt9r0rHl937hvIjjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aJ0NVT43T8iWDYMfbAqOZTSHJj7WkqwmEuUlCxrhd55ghYbyNeuxUAYFfeTi2w6ddnjynFiOIl06W9/zgYPUtpQlczMpukYO7evQzQHAdufOVjEKD5dTkSC8UsUBQg+nrjqHmiGLpDNZxg80C5r6KeEw110xXvBgDoRA0CBXj8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCs/pUdh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750153467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
	b=cCs/pUdhImH4fxLei2j9yHRWmRaGP4T3JYRHvGN8sd7rz07yJh405z3HKC+l4Mfj41sBI8
	eVA1up3WTVFBq/bHtZwnRqRxlnirhdT22UJBoet5zmQsGg5w+yQBY/tVEC72Ty843W7s4N
	FBYfh6QniblkCNKDSQWAEX/D5rwG9AQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-RAQWRO7CO9Op848acr_hVw-1; Tue, 17 Jun 2025 05:44:25 -0400
X-MC-Unique: RAQWRO7CO9Op848acr_hVw-1
X-Mimecast-MFC-AGG-ID: RAQWRO7CO9Op848acr_hVw_1750153464
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451deff247cso32087545e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 02:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153464; x=1750758264;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzL8BCb5z5mTe8AmKnSvyMsKdN+ktV9EKzPlxxLDauM=;
        b=SPVtmp915+AJJPAlB8Qhl/lhSqvOfqgRMiBQOgLTkGNDNkiQFJu8oEHkgUJhQ5t/g3
         owTJGttVg8CnlJX9Ro9jwG7rpmPzlTrLgycjTHCAuo5EzXp9nymgXbYnaLJ6Fcqw5X6A
         ibFtVOn4qNAZUQHxjoD2svNyuXhU+JlBwrG74Qp9+umS4rNyTJH7OrDphYjoJUdt7xXe
         2z28JjDotDMbpo08M9euTjpAJvSR0nTYEnO80hCzwjrFgAr3aE8ogk0uMyQy44gP0wYM
         lgsEy/8/YGWiTRa/jJyiLDLgWNZYPzIT8qAOqtMMaiqr5l/3VBnAog1rVC6SR8ZCvphV
         am+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8WjOJLS475yUNlMtn/DDKMYPbYkgPveR6VR+DVouDFKtB+z9uZYAYAVNNxwsWfd7XZHSLZ7Tp01iHDeCPhHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfn2fSxb8gijOW7hx/6y1URQrTBpm0440fkHeHTEhYMjzYhMWI
	YSKlx8sz4RP4PSKwmeUbxK5A3fXNacJMxCahEDOqZ/DlHugQxuRLQYDkTmSqBdW0vhNwZh0u3bG
	/4joIoEceG4uHLBq9C07PTxt8w8SpGhHjjM2T7GhqzZhF6B7w2XNljAyXQtKNmIDVVGfSxA==
X-Gm-Gg: ASbGncu6GuzDlcTBRZTmShsXkYIiXXkIFNRJoBDMmodgRbn8yqRQP068R2ZEMX6xBAT
	evaRTdc9i3f0wNmlWFUAWVBwqx75EmfeILW1TIa5uNejPQ5Zolt2Lj95HYj3KJl84p5u9R/YMau
	UFE9F9vuEvjz0SYgmWiyOxFEX6Lr9PHwPGU58d23DBBMSfNLAJWqqxjdUOp5I9li54CkDWqCWnI
	xuukXa2ClqcxtftsTdWRRsbMe1jFSk4CYI1NFMFVvoT2LqqB3whdGK8oqBhougzfp67SAE2gEZH
	om6PkfeA7yp+wCO0nKfmG7ju4b12i3TnMzqwCrNFR2x0K6vLEDhbGRH5K/9GnrwspFmgwg==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597965f8f.11.1750153464164;
        Tue, 17 Jun 2025 02:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKE4/hdGNiZlnyMYBRWFUzYwIsk6LZeUq2PZYEGJVxcoKxTedoN7Csr9UGI1dlan0YwSjvcg==
X-Received: by 2002:a05:6000:4106:b0:3a5:7c5a:8c43 with SMTP id ffacd0b85a97d-3a57c5a8d11mr6597942f8f.11.1750153463754;
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13d009sm172188815e9.20.2025.06.17.02.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 02:44:23 -0700 (PDT)
Message-ID: <558d81d1-3cd0-41f8-87b1-aa7be05f2924@redhat.com>
Date: Tue, 17 Jun 2025 11:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] tcp: accecn: AccECN option failure
 handling
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250610125314.18557-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3de6641c776e..d7cdc6589a9c 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1087,6 +1087,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
>  	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
>  	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
>  		     tcp_ecn_mode_accecn(tp) &&
> +		     inet_csk(sk)->icsk_retransmits < 2 &&
>  		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
>  		     remaining >= TCPOLEN_ACCECN_BASE)) {
>  		u32 saving = tcp_synack_options_combine_saving(opts);

AFAICS here the AccECN option is allowed even on the first retransmit as
opposed of what enforced for synack packets and what stated in the
commit message. Why?

Either code change or code/commit message comment needed.

Thanks,

Paolo


