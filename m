Return-Path: <linux-kselftest+bounces-33384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6B7ABD385
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6C18A5F69
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA011268FD9;
	Tue, 20 May 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqBQ3zdi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AE269B0B
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733674; cv=none; b=JP28ZoBuks8ekbM+Jglm5T7JXdsYGoXW/2sYTNhFrf9oGFYKKfQ07u48s8lXJfBHy41UyT/iEX4gttPEROT0O03+ozpC0akY4dwfIrHE16ypTF3Qbl39gwS3fyEpLwZM9dHuJUjTtAdV84DUWMrOIu97eBUO9DCcQxZX4Qp3xgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733674; c=relaxed/simple;
	bh=PCd7B2CKJamE+lIGpi1n0g7Z4216i/A7aPBeHZSzo10=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S5agaMEzzpyWt2FyfqskU/KbYn0u0+RZE2u+iwOszrlEZrH9H086l+l1kWJWKtYjByl7s5IgNqYn3bXn1kCTSGpM+g1fedeNse/VSWuqWyGz/2IVoB/K3NswhsKI2K7xxohkvD8OCTesXRmn5SOPUAhmBrL/8zdkk+/Cvi573y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqBQ3zdi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747733672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
	b=CqBQ3zdiaNNuBS59/THA7LgUSYr7VNe0qPGf5aMPz+Ym+k008NhhIWctWGUwGtm2r7HWRa
	J+86sDW7S6kD+APKUUeWSg6LdKiB+yJKheFrOcHU7hrAo2yJaloChygOEnHbE8Pv/S9y5A
	xj1Ci0tzEavi7Bu7Y00jcOxwtLXc/nc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ACWBP_CZNimPunhGNUug1Q-1; Tue, 20 May 2025 05:34:31 -0400
X-MC-Unique: ACWBP_CZNimPunhGNUug1Q-1
X-Mimecast-MFC-AGG-ID: ACWBP_CZNimPunhGNUug1Q_1747733670
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a36c58ef62so1303702f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 02:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733670; x=1748338470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NE/+J7lqNQA/ShV5FIY+NGVs5/A/4r4zhgGDuUCRS4=;
        b=t6SA/DoAMCUNaiI2ZcBx6FrN8ENg3gcj7seEg6fWhS9Ul6K9RU9dJOI2g9lpryZaTk
         vMwuYUPx+A2GIL+eKyoG1GHsuravYJr/6mNN4eWiKD0Snbs5ee0QUxd8dfNmPZcT8uPP
         /WgmK6tEbjhYa/AiOIr9bxAy4dCei778l0DpfLHbAuflafJNH+R3hiEHlgjHsx3UbZCG
         a2VD1D2vn01lVXc8RyiZukpS0k7ToF9OjdXxYpxI6kOIBVoAshwPTdP5ktxHeIXdm+o9
         7F0EmqvyFHct0WFG22caIkk7x+9jaGZpWJmtM4kNLPnBxsiytNtOvYY5GW0SHMr+Ww9s
         LwAA==
X-Forwarded-Encrypted: i=1; AJvYcCWPREy61vJbgaJrjJN4HtCytNx3gW6GYS2LmE7TaT7laZlsjmAD6GtJdRSvVK8qcLf+X5kO7HFbYGH1q3vKSsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5JUPC2ORFWurhzOyQCUwgj4RsnzUMClGITl1f3BaEHs/zKIx
	6281b53Obd4buh4gbfIpbtpOMqHrF7kPFbNqS8vj1D7cFk3PK++j5N/ItTK/yoxLCsApucmshJ8
	7xqCr+ZEINQqaOaAud1+1QGuwlfWyNWPje0Ue5nOJEndHHEkqcPJUAy6rQJVIz0KRzm1Sgw==
X-Gm-Gg: ASbGnctZcIqHzbT0MnUQE4cB4RLJy0BnNNmyagFSvQkLzyug5TfykX+Uvti4An9X5PV
	DzqI8TAfPYlM3gtOkSf6/+ckhM0c5NMhbSZbA4eNeVaG3h7MgjbFIM6IcIciya8embx6m1G0pc0
	RlmgLAXcsnrRb6gQrCjnjEBIfp/rG8Y8Y2zkhCSudeuvLtn64LHqw7NZSn84MbXpKGCoHAnQoM0
	O+fA2rjZAp0Wji4VFWkK+DOlqu16w+yinw40XDLc85zGC48XKMQO+DaFoL8N3PMH+pSRNOuhfy6
	Canm7dVAnLoWUVrvX52Zr4DWzxZ24ZsYhsh+X4VMgpOPgDebQCWNrB2/3xU=
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068872f8f.34.1747733669694;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuVkjVQJ2eOY0GRr+yrteefyL9sA1r4XDiPPnflkR/rXOi3fp9tCEjol8O9cOiuqNwVG19PQ==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6cf3:9d63 with SMTP id ffacd0b85a97d-3a36cf39e6bmr7068828f8f.34.1747733669229;
        Tue, 20 May 2025 02:34:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a84csm15787427f8f.31.2025.05.20.02.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:34:28 -0700 (PDT)
Message-ID: <14d6af16-c93d-4b38-b748-76c894c0cdf2@redhat.com>
Date: Tue, 20 May 2025 11:34:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 08/15] tcp: sack option handling improvements
To: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-9-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
> 
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_output.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index d0f0fee8335e..d7fef3d2698b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1092,17 +1092,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>  	if (unlikely(eff_sacks)) {
>  		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> -		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
> -					 TCPOLEN_SACK_PERBLOCK))
> -			return size;
> -
> -		opts->num_sack_blocks =
> -			min_t(unsigned int, eff_sacks,
> -			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> -			      TCPOLEN_SACK_PERBLOCK);
> -
> -		size += TCPOLEN_SACK_BASE_ALIGNED +
> -			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
> +					TCPOLEN_SACK_PERBLOCK)) {
> +			opts->num_sack_blocks =
> +				min_t(unsigned int, eff_sacks,
> +				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
> +				      TCPOLEN_SACK_PERBLOCK);
> +
> +			size += TCPOLEN_SACK_BASE_ALIGNED +
> +				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
> +		}
> +	} else {
> +		opts->num_sack_blocks = 0;
>  	}

AFAICS here opts->num_sack_blocks is still uninitialized when:

    eff_acks != 0 &&
    remaining < (TCPOLEN_SACK_BASE_ALIGNED + TCPOLEN_SACK_PERBLOCK)

/P


