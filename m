Return-Path: <linux-kselftest+bounces-42148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A08B95852
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4874F16B75B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF711321449;
	Tue, 23 Sep 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGfj0ViC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B6313D48
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624742; cv=none; b=pInD5lHs7/4HXWdkTDMW51YoVY+8brbFBsnyzKfmsu8h/HGgU/KjAC5j2MY50vmmieyBBwHlKfeMRd19nfMnFCI1fbHCnbQNUHmCH4RwVHNKul+J5LukFDdLs+cmAqLsKdt/tfhBxC15nW1ixWqR6rxg/5fumYhWOR8odOS7db0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624742; c=relaxed/simple;
	bh=hSxoxIoAL3ZR7gXOu9nO0Er42gctGRFjyDjNWo272lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G15e7dUKT3VMlGN3Xu+PPmp4jQEYO6yToDuzNvivTc/Ymxf/rKU6vymh+APC4qiMhBE6y4lj/nKHtaU94bKZuPt+50L75hqIXxNngtgdIX89U1myq10LahX0Lzq7spR14z/wtGX6BydR8HKdrgzHJgOUzJaY+nzcmMVu5NSzXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGfj0ViC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758624740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBi14BEc0YNSpiPSHpvT8/L9ylbivoJiX6J27JD/LkQ=;
	b=iGfj0ViCncJVA8LPGM//tcPvWsXrs3arx6LwGkWHXE4g5kQaVRzD2ldz4O8iYcuWr3hUBu
	kPFLTI/981NYO4A4ILIIsug4mFqFbSr5vmKLUrzcJeeYaKVM8FsoFBUtZiWibGCrYzW4N1
	cby01ii+3KR8nV2luzwPHnCezI/wkHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-3GTNF7G3N8mQYzxmn_47ew-1; Tue, 23 Sep 2025 06:52:18 -0400
X-MC-Unique: 3GTNF7G3N8mQYzxmn_47ew-1
X-Mimecast-MFC-AGG-ID: 3GTNF7G3N8mQYzxmn_47ew_1758624738
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso45007245e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 03:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758624735; x=1759229535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBi14BEc0YNSpiPSHpvT8/L9ylbivoJiX6J27JD/LkQ=;
        b=UQP9HsSeGAIKcw7NdCwJvWUjgTi5WHILK05SYwuD3ezZUtfoOCT67m2BX+wXn1JWW/
         MjgaBtawRd/wN0oCtJOd7dqbUme1RxG5UaeC9+ZdVTD3xoK5xnWLGuK2sApYGSAQPhIn
         TJtesk4S+7nNGhvHbe3UqN5ZWy4NW8fr/Bk84kQvNyP/cClAuVsQXTflAs4kZ99TYD6x
         mP3q2RZu1wPd9kdEQtJARQe1xSBpxt8L/iOHDtsCErJyFrnge9W+vL4SL/tbFGBXj+cU
         qEX63OffnKfALJzwds4wO5BfGusJlCnN6PkVq9rvWCAKtjWSZcEqfjBeAFlKaIfSMwT3
         pFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWChSOIY5Ma9UnvMdt8GzPpm23QcK/8EMflHDVZJkcIJWHXoEKNjVRjiFq3ZEtImA83V3TWcRtmXpqgNwwb3HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0U9QIg5e+Ncn4qrBRz6hZU/3DqcmcgQiKLPOcRnFvNBSWRV4
	uZSOheKR99nsr8ApCkTHjOpDAyRldYeuHywL+VXLQ7APq4Mud2bUzD2Tkz256b27I4WnGuXVSGb
	aq4DiW/jD6jfR9owT85Ji/JWyhvup2Vz2ypJ+FaBUQFlFp6fFnfMG/lF43/gu25ypac0h1w==
X-Gm-Gg: ASbGncv52FimF31x5zD9FVVigVeNJYzU+HD/4GPsS3me4Z3fBJpL64xHon0jIC0WNl3
	ET5OEEZRV9faCMF4xFhAMmrL82TGcWuYkWDD4MEjSIw+EV4j0wbtfOHAgusldbYnLQJr8/PcTWb
	wD72NDem/CufRoeDa3AJ5FvOcjjrNHfe4VqK5JYAtyBWXs0aSu0iV9/inKXR5m9L2HlUpVB39ye
	yhGdzcMlAn6Q+T30TlrjM0hZ65vNfaKIYs9XF+zl1Qsq0X6/qS6CoRW3qPULpnbzRaxJSwzk5qX
	ZlHnBh8Xdfls+un/vHBxt/vl0iCqjBftdNdv5ufl2gRrdbhbTzBqI4M26RwJZHqZ9vdsffxYKbP
	Myvw9bhwyf/N8
X-Received: by 2002:a05:600c:4f09:b0:45f:27f7:e1 with SMTP id 5b1f17b1804b1-46e1dabf750mr20581505e9.25.1758624734907;
        Tue, 23 Sep 2025 03:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg+AcE0r3wdgfn7+K4PlihmQgG21I4ch1KULCsoxGgKaY3chx/4+0hgTLlrbPqOSnHHgaa9w==
X-Received: by 2002:a05:600c:4f09:b0:45f:27f7:e1 with SMTP id 5b1f17b1804b1-46e1dabf750mr20581015e9.25.1758624734372;
        Tue, 23 Sep 2025 03:52:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1cfb3df7sm11918245e9.4.2025.09.23.03.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 03:52:13 -0700 (PDT)
Message-ID: <03d6dba8-2586-4ae9-8a16-26b84cf206eb@redhat.com>
Date: Tue, 23 Sep 2025 12:52:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 13/14] tcp: accecn: stop sending AccECN opt
 when loss ACK w/ option
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
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250918162133.111922-14-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 6:21 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Is this really useful/triggers in practice?

AFAICS it will take effect only it the retransmission happens just after
an egress AccECN packet, i.e. will not trigger if the there are more
later non AccECN packets pending.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h   | 3 ++-
>  include/net/tcp_ecn.h | 1 +
>  net/ipv4/tcp_input.c  | 9 +++++++++
>  net/ipv4/tcp_output.c | 3 +++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 53a4a0da35cc..f3b72fb6fa76 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -295,7 +295,8 @@ struct tcp_sock {
>  	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
>  		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
>  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
> -		unused2:4;
> +		accecn_opt_sent:1,/* Sent AccECN option in previous ACK */
> +		unused2:3;
>  	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
>  		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
>  		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 8317c3f279c9..3eb450b4b648 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -401,6 +401,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
>  	tp->received_ce_pending = 0;
>  	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
>  	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +	tp->accecn_opt_sent = 0;
>  	tp->accecn_minlen = 0;
>  	tp->accecn_opt_demand = 0;
>  	tp->est_ecnfield = 0;
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index f250b4912a0b..6083260133e9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4804,6 +4804,7 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
>  
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
>  {
> +	struct tcp_sock *tp = tcp_sk(sk);

Minor nit: please leave an empty line after variable declaration.

/P


