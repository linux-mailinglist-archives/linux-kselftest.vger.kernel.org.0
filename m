Return-Path: <linux-kselftest+bounces-31896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9CFAA0B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05F63B1051
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A62C17A8;
	Tue, 29 Apr 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tretnmpq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5922BEC43
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928621; cv=none; b=BqP8smHaEqR2PjC8P/cZWn4SIb6nwHO7DKG3pJhiq8c0OP8S6mkLAcp+XeLnMhENv2RPwirvbiu7/jgyrXGdUXMm3rTap3stsAtwy15qLbHR1cpoANWoN6UYMmuRmEvAJhYFHdbs5CsK00dUiuHPsz+ri8Oxf2bYYSYxEBgXe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928621; c=relaxed/simple;
	bh=mb17IOCgVVpSucIMd87jlf64vKog/jviBeBcDvP1YQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pWZv0M7oky8J1O3FTN+2hrahWjmYgkqlVtqM5Hg/+FyKuK5857bSoYMlgqPFbh4U+EqRFXthMA3RLq0XmY6u7k7b9LPXzqgIJJWpMY4Y5k+pBoyxC+5KRxTgZEjVP/MkZ8NtYg8p/AqJ2LXxi8InNvbNkHwC1meBAlwoKrkp+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tretnmpq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745928615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnFM2K3257UGzeSI3eOkJDuCGJ4N6zCW6N/z7ul8q7U=;
	b=TretnmpqFq1XMF+BYxtVLWR25DOobVT2kG0SQhtYEg/gtHAfgCdnzP0tKXWhDpfvr9ff9l
	RvOA5Po/KUTWXsmlr9eedP+UusgfqDv6HV9oGSTspLYWl/NK4+aY/SZgIpVtf8e7Qq4N9t
	i/D/gE/sWki5eXWB0yFwFTPBPZXl8zE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-223GZ7c2Nuq2qOaBA7QL4w-1; Tue, 29 Apr 2025 08:10:12 -0400
X-MC-Unique: 223GZ7c2Nuq2qOaBA7QL4w-1
X-Mimecast-MFC-AGG-ID: 223GZ7c2Nuq2qOaBA7QL4w_1745928611
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb66d17be4so442940466b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 05:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745928611; x=1746533411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnFM2K3257UGzeSI3eOkJDuCGJ4N6zCW6N/z7ul8q7U=;
        b=Z5nGqwrh2my1V++O92aqkTgDrnk/viHtxSLKSlDcByotuTfXsn8gJqHfgUbb1szKh+
         bPZyUAizJaVRxlT9Mnq4nfUW9OrIbNkWnddkfvXcZ1oTEU+0hthHArrbPzUWQeOqkbe3
         3U9zuRQ677FXv8M2ofAznl5rw4mK15pgTObNhkZ7SY45FVRX2UmXzy37O7ApEJlT/ZXE
         O5sxICuAKF8+uj3WHg2L9wIQoQN1uvBKaMmgH8qS7mx5l9cmBBEeRnCuLRHbeNPQLwNv
         3f3f/EUZCxDelq8RwuM/hM2DbqScHqTtlj3sBgbiCpPsV2X69zL+RPB1wViGBVvOu58F
         G9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV/3r1VHh5e6oVTS3cDxEN7P0kig7z3N5ZnzN5+kcxAj4ksWie7a8smsZi16kcbM74SXQOSHheza6/JziD7WDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5t6H/t+R4Exxx1+8UiGEOwojKyCNm8SqdMXeXr1MrIKCmjPG
	tmdfaibsT7foShaaPPLhmjSFIEH4oQKa36ZaDl9BTrRvbFMfGfdeLlI4qsJyvODiSunmq7OROlZ
	sN5WozWlyXnj8GjJ1+ZTvG7r3szvZbAdCYiLKs5Ra4EuoFjDBNpm2381Opeaz+RElVQ==
X-Gm-Gg: ASbGnctCzn8Ca3sPP1v9oHjKxl2Jj7ZifgexP24l4tRo8PZlqwuOO9NYZNHtfdwcyrx
	o9CJWvAO2PCzDvbUN34PsY96J6zHXEHnu9C+9039fGrgV1qOMYNkIKT2NB5KdskXY8DT1zle1oh
	X/wgKSjZw0L2dFGJioumikQeLaPoOn9V246P45Wji4qkeEfm1u0yA39NHAEQAm3nKSxdi95lKJV
	rZW5ZqMZsSaNoUdTgeciyT4U3lH7KX0LOwCxG4Cxpxq6fE/Rb8dD/xzgHTQKk7dTTdg0wKf6197
	BqZufu9hO9n+0Sb/odJnrHlyDWR0ljjK8p4sdMFUKhrkQNfQJVa6u2a215c=
X-Received: by 2002:a17:907:3fa5:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-acec84b7f9amr291015266b.3.1745928611342;
        Tue, 29 Apr 2025 05:10:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhPtGWXOZLT3mFaQPhUAK8VlJ77Tme05C3lCQT5D5BXFTuMnjP5AuORU6+ROxdywsJiFjHLQ==
X-Received: by 2002:a17:907:3fa5:b0:ac3:3e40:e183 with SMTP id a640c23a62f3a-acec84b7f9amr291008666b.3.1745928610750;
        Tue, 29 Apr 2025 05:10:10 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41c736sm787561366b.12.2025.04.29.05.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 05:10:10 -0700 (PDT)
Message-ID: <0a5c7897-ed95-4198-9896-ddae64335083@redhat.com>
Date: Tue, 29 Apr 2025 14:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send control
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
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Instead of sending the option in every ACK, limit sending to
> those ACKs where the option is necessary:
> - Handshake
> - "Change-triggered ACK" + the ACK following it. The
>   2nd ACK is necessary to unambiguously indicate which
>   of the ECN byte counters in increasing. The first
>   ACK has two counters increasing due to the ecnfield
>   edge.
> - ACKs with CE to allow CEP delta validations to take
>   advantage of the option.
> - Force option to be sent every at least once per 2^22
>   bytes. The check is done using the bit edges of the
>   byte counters (avoids need for extra variables).
> - AccECN option beacon to send a few times per RTT even if
>   nothing in the ECN state requires that. The default is 3
>   times per RTT, and its period can be set via
>   sysctl_tcp_ecn_option_beacon.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h        |  3 +++
>  include/net/netns/ipv4.h   |  1 +
>  include/net/tcp.h          |  1 +
>  net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
>  net/ipv4/tcp.c             |  5 ++++-
>  net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c        |  1 +
>  net/ipv4/tcp_minisocks.c   |  2 ++
>  net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++--------
>  9 files changed, 90 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 0e032d9631ac..acb0727855f8 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -309,8 +309,11 @@ struct tcp_sock {
>  	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
>  		unused2:4;
>  	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
> +		prev_ecnfield:2,/* ECN bits from the previous segment */
> +		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
>  		est_ecnfield:2;/* ECN field for AccECN delivered estimates */
>  	u32	app_limited;	/* limited until "delivered" reaches this val */
> +	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */

AFAICS this field is only access in the tx path, while this chunk belong
to the tcp_sock_write_txrx group.

> @@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> +	{
> +		.procname	= "tcp_ecn_option_beacon",
> +		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dou8vec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_FOUR,

The number of new sysctl is concerning high, and I don't see any
documentation update yet.

> @@ -6291,9 +6294,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
>  
>  		if (payload_len > 0) {
>  			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
> +			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
> +
>  			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
>  			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
>  						  minlen);
> +
> +			/* Demand AccECN option at least every 2^22 bytes to
> +			 * avoid overflowing the ECN byte counters.
> +			 */
> +			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
> +			    ~((1 << 22) - 1)) {
> +				u8 opt_demand = max_t(u8, 1,
> +						      tp->accecn_opt_demand);
> +
> +				tp->accecn_opt_demand = opt_demand;
> +			}

I guess this explains the u32 values for such counters. Some comments in
the previous patch could be useful.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 3f3e285fc973..2e95dad66fe3 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
>  {
>  	net->ipv4.sysctl_tcp_ecn = 2;
>  	net->ipv4.sysctl_tcp_ecn_option = 2;
> +	net->ipv4.sysctl_tcp_ecn_option_beacon = 3;
>  	net->ipv4.sysctl_tcp_ecn_fallback = 1;

Human readable macros instead of magic numbers could help.

> @@ -1237,13 +1253,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>  
>  	if (tcp_ecn_mode_accecn(tp) &&
>  	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> -		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
> -		int remaining = MAX_TCP_OPTION_SPACE - size;
> -
> -		opts->ecn_bytes = tp->received_ecn_bytes;
> -		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
> -					       remaining,
> -					       saving);
> +		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
> +		    tp->accecn_opt_demand ||
> +		    tcp_accecn_option_beacon_check(sk)) {

Why a nested if here and just not expanding the existing one?

/P


