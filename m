Return-Path: <linux-kselftest+bounces-33391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DCCABD424
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222C01611F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6AA26A0AE;
	Tue, 20 May 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcpQIk3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37DD213245
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747735436; cv=none; b=ZYW+4SZprX3Z3C/GIME3xWgp2rGfPtuzD0WOgYjade+NT3oH4NOQSI/xfPCRniYeyPYNPrlUbMR01VsZHAPoyEqlwZNdJAvl9WT5heJoSUt8th68DYn2h3sh7SzNviANi+ADa969/tGGOobHndo55gWvn6N9uIClGyTfxLsLa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747735436; c=relaxed/simple;
	bh=oQct3z7yZTuJFGbn3XS7mhPXI0W7KRCAKQLxbHABIwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zu1tCKQYX9pW1vbBHpTvGGGFpDImw1gDaEMDCIYLUVj7D56ofbDd92fspUuyGJ/NqhyOC/RpWEjANmFi1y+xctRt/oXDr4BUX0jRhctlmzLApmOmUMKp9/h7hv6Ewmb3sjACPHSV/i/owh5aQS4+IfY6HXmyu+tKeVeOIMivxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcpQIk3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747735434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9eLw6MuYmnUA5oO55uYzH8GiosQdp8/A6eA7en/wS5A=;
	b=HcpQIk3U/cHsru8Tdmq5Ks6hTZQld8VPZvLkspwinkHVnQjgMtfaeqMAh+fro/0+tGtY52
	4VArwMWxh1pGnaYi8taeWgAcVdU0zvWB7y9HB7IZxQ7FYysZRKNMmiN7F67iAxtTWOSglV
	cHrsHC6/DAasENu9c5npatV7lzWcw4Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-lL1vr9GIMvS6PVMymzIX5A-1; Tue, 20 May 2025 06:03:52 -0400
X-MC-Unique: lL1vr9GIMvS6PVMymzIX5A-1
X-Mimecast-MFC-AGG-ID: lL1vr9GIMvS6PVMymzIX5A_1747735432
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a35c8a7fd9so2119223f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 03:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747735431; x=1748340231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9eLw6MuYmnUA5oO55uYzH8GiosQdp8/A6eA7en/wS5A=;
        b=Lp/9ZLUjog8Y2aCVKjSmsaUgsuUPOF4bk3Gk6Fzuf4inayoNRzQb54aLLQNq3o2gBq
         OrkqAv5pxOFuMsDUnTUXP2s1/HoHymHYzE0XfGE9QCMpKDj7yHd+lRhe0wWhy+KIppsd
         jhwl2e5zSIwXmc2GSMQ2ac1r5iJt89lC0DqeLmkKJSI0AfYcVwllloGgkJVQXV3Ha0hH
         i5NSkkomlWHK+P0HT+jlP90KV2LlZVE90Ry74XLt7cTAidx1IjVxQfgc3vVmPU6uDLM+
         l7HszaHBci46GD8gNozJWWZ891970romRU4lt+jdSrWnNIIQhwdpNlltT+KQG3RJgEMu
         xJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWEB7bUG7O4N6pGxDbaOiMdk7kzhA1fPvGVgSig4cdxfNsKnjahtLcZDTXys+XImrcpQupAFg6Aal+2Nscqqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySrAegYbsgb8a2emFpZZry33nC25WZPFVdweodu6hGhVGj3cx
	DZT8cRx8CQ9tIwiQgaBVL6S4UTG95MjMTN94HEDfd7VQk2yeRI+PeI4ivch9SZ34Gvi04Ze3Egu
	Zu+UK/+y0wmDEp3lUn7BPbsDRZlTeoU0hXf42CgB4OXpagtJLnF4e4TMwaGrqiuZqDAbTKQ==
X-Gm-Gg: ASbGncuS5GzWyMXidE7iVCKE3ZtL3/d1sFCHqVea4wN5QcIidmaD5Df4zWKSTLOAL6s
	2enXBqFdVsYBJfxqSsExE2+g6Gxc7yxcdYC0xQV8t9N4K6IUufnW1jktm8qf92A1t4M9+z1W4sA
	6EHCriAP+QqFkn0KAVkJ8adlERsQZnbjAGP3M012gMe48KXAxGhgqq+M6//DKekk+dwhSmGDH70
	NQJIF50wd3MuRAXE2tpkBZr0CAihR/c1YH+Qqk8OWf1TIWlUmNBg4rZDgULl/4YXFhOThxaV7CQ
	qVkjfl5AJyF11mV1+LedtyCAV2j0bAdN4DNtS1EDXfjzVajMdYcvs48l+RQ=
X-Received: by 2002:a05:6000:184d:b0:3a0:b56a:c256 with SMTP id ffacd0b85a97d-3a35caa324bmr12946143f8f.28.1747735431514;
        Tue, 20 May 2025 03:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjzsI2YT2/DVLY0cAmO5haVByJwMdMBzlDD2Iap/r36gCGHKYF7umijA2JUWL0evKqNRnT8w==
X-Received: by 2002:a05:6000:184d:b0:3a0:b56a:c256 with SMTP id ffacd0b85a97d-3a35caa324bmr12946075f8f.28.1747735430967;
        Tue, 20 May 2025 03:03:50 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db? ([2a0d:3344:244f:5710:ef42:9a8d:40c2:f2db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a361b04236sm14646668f8f.28.2025.05.20.03.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 03:03:50 -0700 (PDT)
Message-ID: <5cd44751-19df-4356-a485-a7ba18a05482@redhat.com>
Date: Tue, 20 May 2025 12:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 14/15] tcp: accecn: try to fit AccECN option
 with SACK
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
 <20250514135642.11203-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250514135642.11203-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and try to fit AccECN option there
> by reduction the number of SACK blocks. But never go below
> two SACK blocks because of AccECN option.
> 
> As AccECN option is often not put to every ACK, the space
> hijack is usually only temporary.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  net/ipv4/tcp_output.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b630923c4cef..d9d3cc8dbb5b 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -982,8 +982,21 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
>  		opts->num_accecn_fields--;
>  		size -= TCPOLEN_ACCECN_PERFIELD;
>  	}
> -	if (opts->num_accecn_fields < required)
> +	if (opts->num_accecn_fields < required) {
> +		if (opts->num_sack_blocks > 2) {
> +			/* Try to fit the option by removing one SACK block */
> +			opts->num_sack_blocks--;
> +			size = tcp_options_fit_accecn(opts, required,
> +						      remaining +
> +						      TCPOLEN_SACK_PERBLOCK,
> +						      max_combine_saving);

How deep is the recursion level, worst case? In any case please try to
avoid recursion entirely. Possibly a 'goto' statement would help.

/P


