Return-Path: <linux-kselftest+bounces-31868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC768AA08FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A491B6048E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611492C10B6;
	Tue, 29 Apr 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5C6YxeT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379A2C10AC
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924242; cv=none; b=mcaLUANRftlM5+TL4g5CbHlwc0COYdOaNsaQYeTFFd0+LvhiwXwluSC+KTtF3ZW2jn+bosINy+/Z3N9ICeSCVjL9sxOVyKsj2Qni9HTPPPYOUfomsfuJ2iPkSX4aiyxliz6RD+kT17m8VWIwVEHId6KDPaxlCKt9tItU5u8ZN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924242; c=relaxed/simple;
	bh=E0OPxLkNygm8USuIrlqcZJClXsTtsoX726UOJ72djK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ueif4glpZNGliCdiLKy81Lo7CiTAeINtyHKPbbwqUBp/gT8qWS/bUSFLAwCVult1vhpM34ZDIxdX5ioF9jo47iwya7Yv+fE9HsYNmDLmPOvIcw88KN1qmak29vPAkEU2uZi8sTJvxq2+UBJHdErOYXWXnnPjc11xFlFlXdzP5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5C6YxeT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745924239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N32jCRGy40LR70yv+XWjgcmG1isI4rJ5byTryD47s3k=;
	b=e5C6YxeT+2smYXchneRxQdfSY9X6zlU3B7N9b/xccoSD4Bd+S2HX0V5IEcqegUYPKoEsxR
	zhkH2aDjkcyXQmPgMDp/RM61FcVw85hZLXHO3OozemjxOP83iQVNDJTz0OqUdbJYgh9EOf
	WK8lW0B4f8bsutm+eRKBqbokNSMBo90=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-GDFdSGpVP8K7YlcYaS8PaQ-1; Tue, 29 Apr 2025 06:57:18 -0400
X-MC-Unique: GDFdSGpVP8K7YlcYaS8PaQ-1
X-Mimecast-MFC-AGG-ID: GDFdSGpVP8K7YlcYaS8PaQ_1745924237
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3d175fe71so401739766b.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 03:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745924237; x=1746529037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N32jCRGy40LR70yv+XWjgcmG1isI4rJ5byTryD47s3k=;
        b=bTT1KiFOSblzlEGjgsToXF0d4S6ZqiHJVmIUBYzkHvJRSySOfjoDPlfYbXPfbyAeoQ
         18DSaisWingFPVsMNjvl/Pn+2XIMy2+CXsJS8gS20mpVK+z//FXmCiZixr8AFF4epX9i
         qfcGNvcbhp+L8XTShvwPcNcAmJhXQhkFP8Nfusv1oXyZNPVySrdV+4hwe2N3PRQrUVWm
         BrlZhy3+pDROuJ2U26eXs13OS9peM958Z3Zg1/MB+eJyCkgd+lJOpH2BOI7f1Dj2kZqC
         icV/3TGz+PFTvzrdjMHYNcPhtD6BrQ9TfZQJ5+9oH3ellqkuIXpzYW3D0RQtHFSB9MJG
         6WbA==
X-Forwarded-Encrypted: i=1; AJvYcCUTjauu7LPIZDaUMfTbdkx8EKdCkS7gcNgrAZqSBB0Tc9cirrIG90c4ogWGwoxtdDJ0bwgnOdSJRt1oEyLU9M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDXMCRN0BC7gYREsHHhKaT49GS/tm/R/lulRRKtU3I2//gV2C
	pjTVoh3dY8XP0e2DJlUiHDo5+suc/s6IhXgDITrf1s3P2kcyAGrY5hQXhopPUpPn7XxTSKjKMnP
	eh19+DacUsfspXbVhKFqAS9mbf9SbB2riqz9uTi+Bq8+5zTjHffwE9/256iObX2IXDA==
X-Gm-Gg: ASbGncv8xGvU31tcbignHz2GEIPGeUIKmKWVXjE9mOXqtnBd0RhglHQ8o2RXaXrqM+5
	QAL3agJIot7sqBBc0tw1CZn04vvAweYpSWL+TxqnvY5BNUW6YnyjsCnEeIg1yRLYZ/wx+pB24Bw
	V5w2+lOwOxtbaomYuks2l2IW1gKs676OJE+E3uQsiDZ9miz+BXYj/KO0CGFU2aS8OeaUYrGRmIj
	lVW1XiIOoKPGMcW8/+XAa9i3p7ydVUgB7iMXNz/HrqAksKsSuqTasqhmcam0eV3EpcTycFSbM4l
	futNa8N17wFRpoJ/+QcNjLCOzS+DuwDL54hrTWLLSS14ySMLf2RyXN7X4X8=
X-Received: by 2002:a17:907:2da3:b0:ace:3643:1959 with SMTP id a640c23a62f3a-acec4b404d3mr314485566b.7.1745924237089;
        Tue, 29 Apr 2025 03:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/jnW581mQ3SHUDuxVAhF02Euf5vxmHyY7s5LblelgJiI21k8fqSpEuo/N+KjPdIUHg6RjQQ==
X-Received: by 2002:a17:907:2da3:b0:ace:3643:1959 with SMTP id a640c23a62f3a-acec4b404d3mr314483466b.7.1745924236627;
        Tue, 29 Apr 2025 03:57:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897? ([2a0d:3344:2726:1910:4ca0:1e29:d7a3:b897])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec3d78514sm137841166b.131.2025.04.29.03.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 03:57:16 -0700 (PDT)
Message-ID: <2067a9f7-eba4-476d-a095-3d6301e14830@redhat.com>
Date: Tue, 29 Apr 2025 12:57:13 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 07/15] tcp: allow embedding leftover into
 option padding
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
 <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250422153602.54787-8-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
>  	return ptr;
>  }
>  
> +#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
> +
>  /* Write previously computed TCP options to the packet.
>   *
>   * Beware: Something in the Internet is very sensitive to the ordering of
> @@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			      struct tcp_out_options *opts,
>  			      struct tcp_key *key)
>  {
> +	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
>  	__be32 *ptr = (__be32 *)(th + 1);
>  	u16 options = opts->options;	/* mungable copy */
> +	int leftover_size = 2;
>  
>  	if (tcp_key_is_md5(key)) {
>  		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
> @@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  	}
>  
>  	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> -			       (TCPOPT_NOP << 16) |
> +		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK_PERM << 8) |
>  			       TCPOLEN_SACK_PERM);
> +		leftover_bytes = NOP_LEFTOVER;

Why? isn't leftover_bytes already == NOP_LEFTOVER?

>  	}
>  
>  	if (unlikely(OPTION_WSCALE & options)) {
> -		*ptr++ = htonl((TCPOPT_NOP << 24) |
> +		u8 highbyte = TCPOPT_NOP;
> +
> +		if (unlikely(leftover_size == 1))

How can the above conditional be true?

> +			highbyte = leftover_bytes >> 8;
> +		*ptr++ = htonl((highbyte << 24) |
>  			       (TCPOPT_WINDOW << 16) |
>  			       (TCPOLEN_WINDOW << 8) |
>  			       opts->ws);
> +		leftover_bytes = NOP_LEFTOVER;

Why? isn't leftover_bytes already == NOP_LEFTOVER?

>  	}
>  
>  	if (unlikely(opts->num_sack_blocks)) {
> @@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  			tp->duplicate_sack : tp->selective_acks;
>  		int this_sack;
>  
> -		*ptr++ = htonl((TCPOPT_NOP  << 24) |
> -			       (TCPOPT_NOP  << 16) |
> +		*ptr++ = htonl((leftover_bytes << 16) |
>  			       (TCPOPT_SACK <<  8) |
>  			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
>  						     TCPOLEN_SACK_PERBLOCK)));
> @@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
>  		}
>  
>  		tp->rx_opt.dsack = 0;
> +	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {

I really feel like I'm missing some code chunk, but I don't see any
possible value for leftover_bytes other than NOP_LEFTOVER

/P


